// ignore_for_file: public_member_api_docs, use_named_constants, diagnostic_describe_all_properties, no_default_cases, unused_element

import 'dart:convert';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart' as show_avatar;
import 'package:guided/common/widgets/custom_date_range_picker.dart';
import 'package:guided/common/widgets/month_selector.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/payment_method_controller.dart';
import 'package:guided/controller/popular_guides_controller.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/available_date_model.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/models/paginated_data.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/user_list_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/popular_guides_list.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/widget/popular_guide_home_features.dart';
import 'package:guided/screens/payments/confirm_payment.dart';
import 'package:guided/screens/payments/payment_failed.dart';
import 'package:guided/screens/payments/payment_method.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_payment_details.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/geolocation_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:guided/utils/services/user_subscription_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;

/// TabHomeScreen
class TabHomeScreen extends StatefulWidget {
  final Function(String) onItemPressed;

  const TabHomeScreen({required this.onItemPressed, Key? key})
      : super(key: key);

  @override
  State<TabHomeScreen> createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen> {
  final List<Activity> activities = StaticDataService.getActivityList();
  final List<Guide> guides = StaticDataService.getGuideList();

  int selectedmonth = 0;
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final TravellerMonthController travellerMonthController =
      Get.put(TravellerMonthController());
  final PopularGuidesController popularGuidesController =
      Get.put(PopularGuidesController());
  final SwiperController _cardController = SwiperController();
  double latitude = 0.0;
  double longitude = 0.0;
  bool _hasLocationPermission = false;
  var result;
  List<String> userIds = [];
  late Future<UserListModel> _loadingData;

  List<ActivityPackage> nearbyActivityPackages = [];
  bool isLoadingPackages = true;

  final UserSubscriptionController _subscriptionController =
      Get.put(UserSubscriptionController());

  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());

  String startDate = '';

  String endDate = '';

  DateTime selectedDate = DateTime.now();

  final PaymentMethodController _paymentMethodController =
      Get.put(PaymentMethodController());

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final DateTime dt = DateTime.parse(travellerMonthController.currentDate);
      final int mon = dt.month;
      travellerMonthController.setSelectedDate(mon);

      DateTime currentDate =
          DateTime.parse(travellerMonthController.currentDate);

      final DateTime defaultDate = DateTime(currentDate.year, currentDate.month,
          1, currentDate.hour, currentDate.minute);

      travellerMonthController.setCurrentMonth(
        defaultDate.toString(),
      );

      await getProfileDetails();

      if (_subscriptionController.isSubscribeButtonClicked) {
        if (!UserSingleton.instance.user.user!.hasPremiumSubscription!) {
          showPaymentMethod();
        } else {
          navigateToSubscriptionDetails();
        }
        _subscriptionController.setSubscribeButtonClicked();
      }
    });
    getCurrentLocation();
    _loadingData = APIServices().getUserListData();
    super.initState();

    getNearbyActivities();
  }

  Future<void> getCurrentLocation() async {
    Position position = await GeoLocationServices().getCoordinates();

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      _hasLocationPermission = true;
    });
  }

  void showPaymentMethod() {
    paymentMethod(
        context: context,
        onCreditCardSelected: (CardModel card) {
          debugPrint('Payment Method:: ${card.cardNo}');
        },
        onContinueBtnPressed: (dynamic data) {
          String mode = '';
          if (data is CardModel) {
            mode = 'Credit Card';
          } else {
            mode = Platform.isAndroid ? 'Google Pay' : 'Apple Pay';
          }

          if (mode == 'Apple Pay') {
            debugPrint('Data $data');
            saveSubscription(data, 'Premium Subscription',
                PaymentConfig.premiumSubscriptionPrice.toString(), mode);
            paymentSuccessful(
                context: context,
                onBtnPressed: navigateToSubscriptionDetails,
                paymentDetails:
                    DiscoveryPaymentDetails(transactionNumber: data),
                paymentMethod: mode);

            /// Add Saving of Subscription here
          } else {
            final String transactionNumber =
                GlobalMixin().generateTransactionNumber();
            confirmPaymentModal(
                context: context,
                serviceName: 'Premium Subscription',
                paymentMethod: data,
                paymentMode: mode,
                price: PaymentConfig.premiumSubscriptionPrice,
                onPaymentSuccessful: () {
                  Navigator.of(context).pop();
                  saveSubscription(transactionNumber, 'Premium Subscription',
                      PaymentConfig.premiumSubscriptionPrice.toString(), mode);
                  //Save Subscription
                  paymentSuccessful(
                      context: context,
                      onBtnPressed: navigateToSubscriptionDetails,
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
          }
        },
        price: PaymentConfig.premiumSubscriptionPrice);
  }

  Future<void> saveSubscription(String transactionNumber,
      String subscriptionName, String price, String paymentMethod) async {
    String actionType = 'add';
    final DateTime startDate = DateTime.now();

    final DateTime endDate = GlobalMixin().getEndDate(startDate);

    UserSubscription subscriptionParams = UserSubscription(
        paymentReferenceNo: transactionNumber,
        name: subscriptionName,
        startDate: startDate.toString(),
        endDate: endDate.toString(),
        price: price);

    if (_subscriptionController.userSubscription.id.isNotEmpty) {
      subscriptionParams.id = _subscriptionController.userSubscription.id;
      actionType = 'update';
    }

    final APIStandardReturnFormat result = await APIServices()
        .addUserSubscription(subscriptionParams, paymentMethod, actionType);

    final jsonData = jsonDecode(result.successResponse);

    debugPrint('DATA FOR SUBSCRIPTION $jsonData');

    _subscriptionController
        .setSubscription(UserSubscription.fromJson(jsonData));

    UserSingleton.instance.user.user?.hasPremiumSubscription = true;
  }

  void navigateToSubscriptionDetails() {
    Navigator.pushNamed(context, '/subscription_details');
  }

  Future<void> getProfileDetails() async {
    final ProfileDetailsModel res = await APIServices().getProfileData();

    final bool hasPremiumSubscription =
        await UserSubscriptionServices().hasUserSubscription();

    String paymentMethod = res.defaultPaymentMethod != ''
        ? res.defaultPaymentMethod
        : PaymentConfig.bankCard;

    UserSingleton.instance.user.user = User(
        id: res.id,
        email: res.email,
        fullName: res.fullName,
        stripeCustomerId: res.stripeCustomerId,
        defaultPaymentMethod: paymentMethod,
        hasPremiumSubscription: hasPremiumSubscription);

    _profileDetailsController.setUserProfileDetails(res);

    _paymentMethodController.setDefaultPaymentMethod(paymentMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 20.h),
                child: Container(
                  height: 60.h,
                  width: 58.w,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.r),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      '${AssetsPath.assetsSVGPath}/home.svg',
                      color: AppColors.lightningYellow,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.w, 0.h, 15.w, 0.h),
                  child: TextField(
                    onSubmitted: (String value) async {
                      debugPrint('Query $value');
                      // widget.onItemPressed('guides');
                    },
                    readOnly: true,
                    onTap: () async {
                      final dynamic result = await Navigator.of(context)
                          .pushNamed('/search_place');

                      if (result != null && result is DetailsResponse) {
                        await Navigator.of(context)
                            .pushNamed('/activity_map', arguments: {
                          'placeDetails': result,
                          'initialActivityPackages': nearbyActivityPackages,
                          'startDate': startDate,
                          'endDate': endDate
                        });
                      }
                    },
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(fontSize: 16.sp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.all(22),
                      fillColor: Colors.white,
                      prefixIcon: IconButton(
                        icon: Image.asset(
                          'assets/images/png/search_icon.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                        onPressed: null,
                      ),
                      suffixIcon: IconButton(
                        icon: Image.asset(
                          'assets/images/png/calendar_icon.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                        // onPressed: null,
                        onPressed: showDatePickerBottomSheet,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 15.w, 0.h),
                    child: nearbyActivities(context, activities)),
                Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 15.w, 0.h),
                    child: popularGuidesNearYou(context, guides)),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0.h, 15.w, 20.h),
                  child: becomeAGuideAd(context),
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }

  Widget nearbyActivities(BuildContext context, List<Activity> activities) {
    //////
    ///
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppTextConstants.exploreNearbyActivities,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: exploreNearbyActivities,
              child: Text(
                AppTextConstants.seeAll,
                style: TextStyle(
                  color: HexColor('#3E4242'),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        buildNearbyActivitiesAndPackages()
      ],
    );
  }

  Widget buildNearbyActivitiesAndPackages() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.26,
        child: !isLoadingPackages
            ? nearbyActivityPackages.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: nearbyActivityPackages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 20.h),
                        // height: 180.h,
                        // width: 168.w,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                // checkAvailability(
                                //     context, snapshot.data![index]);
                                Navigator.of(context).pushNamed(
                                    '/activity_package_info',
                                    arguments: nearbyActivityPackages[index]);
                              },
                              child: Container(
                                height: 120.h,
                                width: 160.w,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.r),
                                  ),
                                  // image: DecorationImage(
                                  //   image: AssetImage(
                                  //       activities[index].featureImage),
                                  //   fit: BoxFit.cover,
                                  // ),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        // base64.decode(snapshot
                                        //     .data![index].coverImg!
                                        //     .split(',')
                                        //     .last),
                                        nearbyActivityPackages[index]
                                            .firebaseCoverImg!,
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    if (nearbyActivityPackages[index]
                                            .mainBadge !=
                                        null)
                                      Positioned(
                                        bottom: 10,
                                        left: 16,
                                        child: Image.memory(
                                          base64.decode(
                                              nearbyActivityPackages[index]
                                                  .mainBadge!
                                                  .imgIcon!
                                                  .split(',')
                                                  .last),
                                          width: 30,
                                          height: 30,
                                          gaplessPlayback: true,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                                width: 130.w,
                                child: Text(
                                  nearbyActivityPackages[index].name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600),
                                )),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 10.h,
                                  width: 10.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/png/clock.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  // snapshot.data![index].timeToTravel!,
                                  '0.0 hour drive',
                                  style: TextStyle(
                                      color: HexColor('#696D6D'),
                                      fontSize: 11.sp,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    })
                : const Center(
                    child: Text('Nothing to Display'),
                  )
            : const MainContentSkeletonHorizontal(),
      );

  void exploreNearbyActivities() {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      expand: false,
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) => SafeArea(
        top: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15.h,
              ),
              Align(
                child: Image.asset(
                  AssetsPath.horizontalLine,
                  width: 60.w,
                  height: 5.h,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  'Explore Nearby Activities',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  "Can't find anything nearby? Try using the map and discover what else is available.",
                  style: TextStyle(
                      color: AppColors.doveGrey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: nearbyActivityPackages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildActivityPackageListItem(
                        nearbyActivityPackages[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActivityPackageListItem(ActivityPackage activityPackage) =>
      GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed('/activity_package_info', arguments: activityPackage),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          margin: EdgeInsets.only(bottom: 16.h),
          child: Column(
            children: <Widget>[
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(activityPackage.firebaseCoverImg!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                        color: HexColor('#ffffff'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 30,
                        child: Image.memory(
                          base64.decode(activityPackage.mainBadge!.imgIcon!),
                          height: 35.h,
                          width: 35.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: <Widget>[
                  Text(
                    activityPackage.name!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 10.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.r),
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/png/clock.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 2.w,
                      // ),
                      Text(
                        '0.0 hour drive',
                        style: TextStyle(
                            color: HexColor('#696D6D'),
                            fontSize: 11.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget sideShow(int index) {
    final PageController pageIndicatorController =
        PageController(initialPage: index);
    return SizedBox(
      height: 250.h,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 200.h,
            child: Stack(
              children: <Widget>[
                PageView.builder(
                  controller: pageIndicatorController,
                  itemCount: activities.length,
                  itemBuilder: (_, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            widget.onItemPressed('nearbyActivities');
                          },
                          child: Container(
                            height: 200.h,
                            // width:
                            //     315.w,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                              image: DecorationImage(
                                image:
                                    AssetImage(activities[index].featureImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    onPressed: () {},
                                    color: HexColor('#ffffff'),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage(activities[index].path),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 2.8,
                  bottom: 20,
                  child: SmoothPageIndicator(
                      controller: pageIndicatorController,
                      count: activities.length,
                      effect: const ScrollingDotsEffect(
                        activeDotColor: Colors.white,
                        dotColor: Colors.white,
                        activeStrokeWidth: 2.6,
                        activeDotScale: 1.6,
                        maxVisibleDots: 5,
                        radius: 8,
                        spacing: 10,
                        dotHeight: 6,
                        dotWidth: 6,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              children: <Widget>[
                Text(
                  activities[index].name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Row(
                  children: <Widget>[
                    Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.r),
                        ),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/png/clock.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 2.w,
                    // ),
                    Text(
                      activities[index].distance,
                      style: TextStyle(
                          color: HexColor('#696D6D'),
                          fontSize: 11.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Navigate to Advertisement View
  Future<void> checkAvailability(
    BuildContext context,
    ActivityPackage package,
  ) async {
    final Map<String, dynamic> details = {
      'package': package,
    };

    await Navigator.pushNamed(context, '/checkActivityAvailabityScreen',
        arguments: details);
  }

  Widget popularGuidesNearYou(
    BuildContext context,
    List<Guide> guides,
  ) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Popular guides near you!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: _settingModalBottomSheet,
              child: Text(
                'See All',
                style: TextStyle(
                  color: HexColor('#3E4242'),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.23,
          child: FutureBuilder<UserListModel>(
            future: _loadingData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                final UserListModel userListData = snapshot.data;
                final int length = userListData.userDetails.length;
                if (userListData.userDetails.isEmpty) {
                  return const Center(
                    child: Text('Nothing to show here'),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return userListData.userDetails[index].isGuide
                            ? PopularGuideHomeFeatures(
                                id: userListData.userDetails[index].id,
                                fullName:
                                    userListData.userDetails[index].fullName,
                                firebaseProfImg:
                                    userListData.userDetails[index].firebaseImg,
                                latitude: latitude,
                                longitude: longitude)
                            : Container();
                      });
                }
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return const MainContentSkeletonHorizontal();
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget becomeAGuideAd(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: HexColor('#181B1B'),
        borderRadius: BorderRadius.all(
          Radius.circular(15.r),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width * 0.38,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
                image: DecorationImage(
                    image: AssetImage('assets/images/png/adsImage.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.grey.withOpacity(0.5), BlendMode.dstIn)),
              ),
            ),
          ),
          Positioned(
              top: 15,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Become a guide',
                    style: TextStyle(
                        color: AppColors.lightningYellow,
                        fontSize: 24.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'and unlock new opportunities \nby sharing your experience.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/become_a_guide'),
                      style: AppTextStyle.active,
                      child: const Text(
                        'Learn more',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  //
  Future<void> getNearbyActivities() async {
    final List<ActivityPackage> res =
        await APIServices().getActivityPackagesbyDescOrder();
    setState(() {
      nearbyActivityPackages = res;
      isLoadingPackages = false;
    });
  }

  void _settingModalBottomSheet() {
    show_avatar.showAvatarModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      expand: false,
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) => const PopularGuidesList(),
    );
  }

  void showDatePickerBottomSheet() {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      expand: false,
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) => SafeArea(
        top: false,
        child: StatefulBuilder(
          builder: (BuildContext context, updateState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.72,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    child: Image.asset(
                      AssetsPath.horizontalLine,
                      width: 60.w,
                      height: 5.h,
                    ),
                  ),
                  CustomDateRangePicker(
                    onDatesSelected:
                        (DateRangePickerSelectionChangedArgs args) {
                      debugPrint('Start Date ${args.value.startDate}');
                      debugPrint('End Date ${args.value}');

                      setState(() {
                        startDate = args.value.startDate.toString();
                        endDate = args.value.startDate.toString();
                      });
                    },
                    onSubmitted: () {
                      Navigator.of(context)
                          .popAndPushNamed('/activity_map', arguments: {
                        'placeDetails': '',
                        'initialActivityPackages': nearbyActivityPackages,
                        'startDate': startDate,
                        'endDate': endDate
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ).whenComplete(() {
      _scrollController.easyScrollToIndex(index: 0);
    });
  }
}
