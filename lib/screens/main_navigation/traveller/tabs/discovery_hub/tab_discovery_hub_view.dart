import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/discovery_hub.dart';
import 'package:guided/models/hub_outfitter.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:guided/screens/payments/confirm_payment.dart';
import 'package:guided/screens/payments/payment_failed.dart';
import 'package:guided/screens/payments/payment_method.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_bottom_sheet.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_payment_details.dart';
import 'package:guided/utils/event.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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

  @override
  void initState() {
    super.initState();

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
          ImageSlideshow(
            width: 375,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.white,
            indicatorBackgroundColor: Colors.grey[100],
            autoPlayInterval: 3000,
            isLoop: true,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: DecorationImage(
                      image: AssetImage(features[screenArguments['id']].img1),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage:
                              AssetImage(features[screenArguments['id']].path),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heartOutlined),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: DecorationImage(
                      image: AssetImage(features[screenArguments['id']].img2),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage:
                              AssetImage(features[screenArguments['id']].path),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heartOutlined),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: DecorationImage(
                      image: AssetImage(features[screenArguments['id']].img3),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage:
                              AssetImage(features[screenArguments['id']].path),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heartOutlined),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 10.h),
                child: Text(
                  features[screenArguments['id']].title,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, top: 10.h),
                child: Text(
                  features[screenArguments['id']].date,
                  style: TextStyle(
                      color: AppColors.doveGrey,
                      fontFamily: 'Gilroy',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.w, top: 15.h),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Row(children: <Widget>[
                    Image.asset(
                      '${AssetsPath.assetsPNGPath}/mark_chen.png',
                      width: 50.w,
                      height: 50.h,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Matt Parker',
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.green[900],
                            ),
                            Text(
                              '16 reviews',
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: AppColors.doveGrey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    ),
                  ]),
                ),
              ),
              // Image.asset(
              //   '${AssetsPath.assetsPNGPath}/phone_circle.png',
              //   width: 70.w,
              //   height: 70.h,
              // ),
            ],
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Text(
              features[screenArguments['id']].description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  height: 2),
            ),
          )),

          /// show this button if user is not yet subscribed
          if (features[screenArguments['id']].isPremium &&
              !hasPremiumSubscription &&
              PaymentConfig.isPaymentEnabled)
            Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 10.h, bottom: 12.h),
                child: CustomRoundedButton(
                    title: 'Know More About This Event',
                    onpressed: () => _showDiscoveryBottomSheet(
                        features[screenArguments['id']].img1)))
        ],
      ),
    );
  }

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

    UserSingleton.instance.user.user?.hasPremiumSubscription = true;
    setState(() {
      hasPremiumSubscription = true;
    });

    debugPrint(
        'subscription result ${result.successResponse} Has Subscription ${UserSingleton.instance.user.user?.hasPremiumSubscription} State Premium Subscription $hasPremiumSubscription');
  }
}
