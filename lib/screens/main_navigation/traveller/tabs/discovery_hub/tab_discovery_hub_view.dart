import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/discovery_hub.dart';
import 'package:guided/models/hub_outfitter.dart';
import 'package:guided/models/newsfeed_image_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:guided/screens/payments/confirm_payment.dart';
import 'package:guided/screens/payments/payment_failed.dart';
import 'package:guided/screens/payments/payment_method.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_bottom_sheet.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_payment_details.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/event.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TabDiscoveryHubView extends StatefulWidget {
  const TabDiscoveryHubView({Key? key}) : super(key: key);

  @override
  State<TabDiscoveryHubView> createState() => _TabDiscoveryHubViewState();
}

class _TabDiscoveryHubViewState extends State<TabDiscoveryHubView> {
  List<DiscoveryHub> features = EventUtils.getMockDiscoveryHubFeatures();
  final UserSubscriptionController _userSubscriptionController =
      Get.put(UserSubscriptionController());

  bool hasPremiumSubscription = false;
  late List<String> imageList;
  late List<String> imageIdList;
  int activeIndex = 0;
  int imageCount = 0;
  @override
  void initState() {
    super.initState();
    imageList = [];
    imageIdList = [];
    hasPremiumSubscription =
        UserSingleton.instance.user.user!.hasPremiumSubscription!;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(1.r))),
                      child: buildSlider(context, screenArguments['id'])),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          screenArguments['title'],
                          style: TextStyle(
                              fontSize: RegExp(r"\w+(\'\w+)?")
                                          .allMatches(screenArguments['title'])
                                          .length >
                                      5
                                  ? 10.sp
                                  : 18.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                            color: AppColors.osloGrey,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            screenArguments['availability_date'],
                            style: AppTextStyle.dateStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    screenArguments['description'],
                    style: AppTextStyle.descrStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),

          /// show this button if user is not yet subscribed
          if (screenArguments['is_premium'] &&
              !hasPremiumSubscription &&
              PaymentConfig.isPaymentEnabled)
            Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 10.h, bottom: 12.h),
                child: CustomRoundedButton(
                    title: 'Know More About This Event',
                    onpressed: () =>
                        _userSubscriptionController.userSubscription.id.isEmpty
                            ? _showDiscoveryBottomSheet(
                                features[screenArguments['id']].img1)
                            : null))
        ],
      ),
    );
  }

  Widget buildSlider(BuildContext context, String id) =>
      FutureBuilder<NewsfeedImageModel>(
        future: APIServices().getNewsfeedImageData(id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final NewsfeedImageModel newsfeedImage = snapshot.data;
            final int length = newsfeedImage.newsfeedImageDetails.length;
            imageCount = length;

            for (int i = 0; i < imageCount; i++) {
              imageList.add(
                  newsfeedImage.newsfeedImageDetails[i].firebaseSnapshotImg);
              imageIdList.add(newsfeedImage.newsfeedImageDetails[i].id);
            }

            return Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  CarouselSlider.builder(
                      itemCount: length,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: 300.h,
                        viewportFraction: 1,
                        onPageChanged:
                            (int index, CarouselPageChangedReason reason) =>
                                setState(() => activeIndex = index),
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        final NewsfeedImageDetails imgData =
                            newsfeedImage.newsfeedImageDetails[index];

                        return buildImage(imgData, index);
                      }),
                  if (length == 1) Container(),
                  if (length == 0)
                    GestureDetector(
                        onTap: () {
                          // navigateEventDetails(context, '');
                        },
                        child: SizedBox(
                          width: 300.w,
                          height: 300.h,
                          child: const Text(''),
                        ))
                  else
                    Positioned(
                      bottom: 10,
                      child: buildIndicator(length),
                    ),
                ],
              ),
            );
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const SkeletonText(
              height: 200,
              width: 900,
              radius: 10,
            );
          }
          return Container();
        },
      );

  Widget buildImage(NewsfeedImageDetails imgData, int index) => GestureDetector(
        onTap: () {
          // navigateEventDetails(context, imgData.firebaseSnapshotImg);
        },
        child: ExtendedImage.network(
          imgData.firebaseSnapshotImg,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        ),
      );

  Widget buildIndicator(int count) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: count,
        effect: SlideEffect(
            activeDotColor: Colors.white,
            dotColor: Colors.grey.shade800,
            dotHeight: 10.h,
            dotWidth: 10.w),
      );

  void _showDiscoveryBottomSheet(String backgroundImage) {
    showCupertinoModalBottomSheet(
        context: context,
        isDismissible: true,
        barrierColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext ctx) => DiscoveryBottomSheet(
              backgroundImage: backgroundImage,
              onSubscribeBtnPressed: () {
                const double price = 5.99;
                Navigator.of(ctx).pop();
                paymentMethod(
                    context: context,
                    onContinueBtnPressed: (dynamic data) {
                      String mode = '';
                      if (data is CardModel) {
                        mode = 'Credit Card';
                      } else {
                        mode = Platform.isAndroid ? 'Google Pay' : 'Apple Pay';
                      }
                      final String transactionNumber =
                          GlobalMixin().generateTransactionNumber();
                      confirmPaymentModal(
                          context: context,
                          serviceName: 'Discovery Subscription',
                          paymentMethod: data,
                          paymentMode: mode,
                          price: price,
                          onPaymentSuccessful: () {
                            Navigator.of(context).pop();
                            saveSubscription(transactionNumber,
                                'Premium Subscription', price.toString());

                            paymentSuccessful(
                                context: context,
                                paymentDetails: DiscoveryPaymentDetails(
                                    transactionNumber: transactionNumber),
                                paymentMethod: mode);
                          },
                          onPaymentFailed: () {
                            paymentFailed(
                                context: context,
                                paymentDetails: DiscoveryPaymentDetails(
                                    transactionNumber: transactionNumber),
                                paymentMethod: mode);
                          },
                          paymentDetails: DiscoveryPaymentDetails(
                              transactionNumber: transactionNumber));
                    },
                    price: price);
              },
              onSkipBtnPressed: () {
                Navigator.of(context).pop();
              },
              onCloseBtnPressed: () {
                Navigator.of(context).pop();
              },
              onBackBtnPressed: () {
                Navigator.of(context).pop();
              },
            ));
  }

  Future<void> saveSubscription(
      String transactionNumber, String subscriptionName, String price) async {
    final DateTime startDate = DateTime.now();

    final DateTime endDate = GlobalMixin().getEndDate(startDate);

    final UserSubscription subscriptionParams = UserSubscription(
        paymentReferenceNo: transactionNumber,
        name: subscriptionName,
        startDate: startDate.toString(),
        endDate: endDate.toString(),
        price: price);

    final APIStandardReturnFormat result =
        await APIServices().addUserSubscription(subscriptionParams);

    debugPrint('subscription result ${result.successResponse}');
  }
}
