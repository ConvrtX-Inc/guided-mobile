// ignore_for_file: public_member_api_docs, use_named_constants, diagnostic_describe_all_properties, no_default_cases, unused_element

import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/models/popular_guide.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/popular_guides_list.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart' as show_avatar;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
  final travellerMonthController = Get.put(TravellerMonthController());
  final SwiperController _cardController = SwiperController();
  double latitude = 0.0;
  double longitude = 0.0;
  bool _hasLocationPermission = false;
  var result;
  @override
  void initState() {
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
    });
    getCurrentLocation();
    super.initState();
  }

  Future<void> getCurrentLocation() async {
    Position position = await _determinePosition();

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      _hasLocationPermission = true;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                        child: Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/png/green_house.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.w, 0.h, 15.w, 0.h),
                      child: TextField(
                        onSubmitted: (value) {
                          widget.onItemPressed('guides');
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
                            onPressed: () async {
                              result = showMaterialModalBottomSheet(
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
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.72,
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
                                        // SizedBox(
                                        //   height: 15.h,
                                        // ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20.w, 20.h, 20.w, 20.h),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Select date',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              Icons.chevron_left,
                                              color: HexColor('#898A8D'),
                                            ),
                                            Container(
                                                color: Colors.transparent,
                                                height: 80.h,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                                child: EasyScrollToIndex(
                                                  controller:
                                                      _scrollController, // ScrollToIndexController
                                                  scrollDirection: Axis
                                                      .horizontal, // default Axis.vertical
                                                  itemCount: AppListConstants
                                                      .calendarMonths
                                                      .length, // itemCount
                                                  itemWidth: 95,
                                                  itemHeight: 70,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        _scrollController
                                                            .easyScrollToIndex(
                                                                index: index);
                                                        travellerMonthController
                                                            .setSelectedDate(
                                                                index + 1);
                                                        DateTime dt = DateTime.parse(
                                                            travellerMonthController
                                                                .currentDate);

                                                        final DateTime
                                                            plustMonth =
                                                            DateTime(
                                                                dt.year,
                                                                index + 1,
                                                                dt.day,
                                                                dt.hour,
                                                                dt.minute);

                                                        final DateTime
                                                            setLastday =
                                                            DateTime(
                                                                plustMonth.year,
                                                                plustMonth
                                                                    .month,
                                                                1,
                                                                plustMonth.hour,
                                                                plustMonth
                                                                    .minute);
                                                        print(setLastday);
                                                        travellerMonthController
                                                            .setCurrentMonth(
                                                          setLastday.toString(),
                                                        );
                                                      },
                                                      child: Obx(
                                                        () => Stack(
                                                          children: <Widget>[
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        index ==
                                                                                0
                                                                            ? 0.w
                                                                            : 0.w,
                                                                        0.h,
                                                                        10.w,
                                                                        0.h),
                                                                width: 89,
                                                                height: 45,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius
                                                                                .all(
                                                                          Radius.circular(
                                                                              10),
                                                                        ),
                                                                        border: Border.all(
                                                                            color: index == travellerMonthController.selectedDate - 1
                                                                                ? HexColor(
                                                                                    '#FFC74A')
                                                                                : HexColor(
                                                                                    '#C4C4C4'),
                                                                            width:
                                                                                1),
                                                                        color: index ==
                                                                                travellerMonthController.selectedDate - 1
                                                                            ? HexColor('#FFC74A')
                                                                            : Colors.white),
                                                                child: Center(
                                                                    child: Text(
                                                                        AppListConstants
                                                                            .calendarMonths[index])),
                                                              ),
                                                            ),
                                                            Positioned(
                                                                right: 2,
                                                                top: 2,
                                                                child: index
                                                                        .isOdd
                                                                    ? Badge(
                                                                        padding:
                                                                            const EdgeInsets.all(8),
                                                                        badgeColor:
                                                                            AppColors.deepGreen,
                                                                        badgeContent:
                                                                            Text(
                                                                          '2',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w800,
                                                                              fontFamily: AppTextConstants.fontPoppins),
                                                                        ),
                                                                      )
                                                                    : Container()),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )),
                                            Icon(
                                              Icons.chevron_right,
                                              color: HexColor('#898A8D'),
                                            ),
                                          ],
                                        ),
                                        GetBuilder<TravellerMonthController>(
                                            id: 'calendar',
                                            builder: (TravellerMonthController
                                                controller) {
                                              print(controller.currentDate);
                                              return Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    20.w, 0.h, 20.w, 0.h),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4,
                                                child: Sfcalendar(
                                                  context,
                                                  travellerMonthController
                                                      .currentDate,
                                                  ((value) {
                                                    print(value);
                                                  }),
                                                ),
                                              );
                                            }),
                                        // SizedBox(
                                        //   height: 20.h,
                                        // ),
                                        SizedBox(
                                          width: 153.w,
                                          height: 54.h,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              showMaterialModalBottomSheet(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top: Radius.circular(20),
                                                    ),
                                                  ),
                                                  expand: false,
                                                  context: context,
                                                  backgroundColor: Colors.white,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SafeArea(
                                                      top: false,
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                        child: Column(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Align(
                                                              child:
                                                                  Image.asset(
                                                                AssetsPath
                                                                    .horizontalLine,
                                                                width: 60.w,
                                                                height: 5.h,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          20.w,
                                                                          20.h,
                                                                          20.w,
                                                                          20.h),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: Text(
                                                                  '16 nearby guides',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          20.w,
                                                                      right:
                                                                          20.w),
                                                              child: Swiper(
                                                                controller:
                                                                    _cardController,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        height:
                                                                            200.h,
                                                                        // width:
                                                                        //     315.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.transparent,
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(15.r),
                                                                          ),
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage(guides[index].featureImage),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Stack(
                                                                          children: <
                                                                              Widget>[
                                                                            Positioned(
                                                                              top: 0,
                                                                              right: 0,
                                                                              child: IconButton(
                                                                                icon: const Icon(Icons.favorite_border),
                                                                                onPressed: () {},
                                                                                color: HexColor('#ffffff'),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Container(
                                                                                transform: Matrix4.translationValues(-15, 0, 0),
                                                                                child: IconButton(
                                                                                  onPressed: () async {
                                                                                    await _cardController.previous();
                                                                                  },
                                                                                  icon: const Icon(
                                                                                    Icons.chevron_left,
                                                                                    size: 50,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: IconButton(
                                                                                onPressed: () async {
                                                                                  await _cardController.next();
                                                                                },
                                                                                icon: const Icon(
                                                                                  Icons.chevron_right,
                                                                                  size: 50,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            4.h,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Icon(
                                                                              Icons.star,
                                                                              color: HexColor('#066028'),
                                                                              size: 10,
                                                                            ),
                                                                            Text(
                                                                              '16 review',
                                                                              style: TextStyle(color: HexColor('#979B9B'), fontSize: 12.sp, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "St. John's, Newfoundland",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16.sp,
                                                                            fontWeight: FontWeight.w700),
                                                                      ),
                                                                      Text(
                                                                        '\$50/ Person',
                                                                        style: TextStyle(
                                                                            color:
                                                                                HexColor('#3E4242'),
                                                                            fontSize: 16.sp,
                                                                            fontWeight: FontWeight.normal),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                                autoplay: true,
                                                                itemCount:
                                                                    guides
                                                                        .length,
                                                                // pagination: const SwiperPagination(
                                                                //     builder:
                                                                //         SwiperPagination
                                                                //             .fraction),
                                                                // pagination: SwiperCustomPagination(builder:
                                                                //     (BuildContext
                                                                //             context,
                                                                //         SwiperPluginConfig
                                                                //             config) {
                                                                //   return Container();
                                                                // }),
                                                                // control: const SwiperControl(
                                                                //     color: Colors
                                                                //         .black),
                                                              ),
                                                            )),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            style: AppTextStyle.activeGreen,
                                            child: const Text(
                                              'Set Filter Date',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ).whenComplete(() {
                                _scrollController.easyScrollToIndex(index: 0);
                              });
                              Future.delayed(const Duration(seconds: 1), () {
                                _scrollController.easyScrollToIndex(
                                    index:
                                        travellerMonthController.selectedDate -
                                            1);

                                // setState(() {
                                //   selectedmonth = 7;
                                // });
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 0.h),
                child: _hasLocationPermission
                    ? nearbyActivities(context, activities)
                    : const CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0.h, 15.w, 0.h),
                child: _hasLocationPermission
                    ? popularGuidesNearYou(context, guides)
                    : const CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0.h, 15.w, 20.h),
                child: staticAdd(context),
              ),
            ],
          ),
        ),
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
              'Explore Nearby Activities/Packages',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: exploreNearbyActivities,
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
          height: MediaQuery.of(context).size.height * 0.26,
          child: FutureBuilder<List<ActivityPackage>>(
            future:
                APIServices().getActivityPackagesbyDescOrder(), // async work
            builder: (BuildContext context,
                AsyncSnapshot<List<ActivityPackage>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const MainContentSkeletonHorizontal();
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 20.h),
                              height: 180.h,
                              width: 168.w,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      checkAvailability(
                                          context, snapshot.data![index]);
                                    },
                                    child: Container(
                                      height: 112.h,
                                      width: 168.w,
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
                                            image: Image.memory(
                                          base64.decode(snapshot
                                              .data![index].coverImg!
                                              .split(',')
                                              .last),
                                          fit: BoxFit.cover,
                                          gaplessPlayback: true,
                                        ).image),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            bottom: 10,
                                            left: 20,
                                            child:
                                                FutureBuilder<BadgeModelData>(
                                              future: APIServices()
                                                  .getBadgesModelById(snapshot
                                                      .data![index]
                                                      .mainBadgeId!),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<dynamic>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  final BadgeModelData
                                                      badgeData = snapshot.data;
                                                  final int length = badgeData
                                                      .badgeDetails.length;
                                                  // return CircleAvatar(
                                                  //   backgroundColor:
                                                  //       Colors.transparent,
                                                  //   radius: 30,
                                                  //   backgroundImage: AssetImage(
                                                  //       activities[index].path),
                                                  // );
                                                  return Image.memory(
                                                    base64.decode(badgeData
                                                        .badgeDetails[0].imgIcon
                                                        .split(',')
                                                        .last),
                                                    width: 30,
                                                    height: 30,
                                                    gaplessPlayback: true,
                                                  );
                                                }
                                                if (snapshot.connectionState !=
                                                    ConnectionState.done) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.w),
                                                    child: Column(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 110.h,
                                                        ),
                                                        const SkeletonText(
                                                          width: 30,
                                                          height: 30,
                                                          shape:
                                                              BoxShape.circle,
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }
                                                return Container();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    snapshot.data![index].name!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w600),
                                  ),
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
                          });
                    } else {
                      return Center(
                          child: Text(
                        'No Nearby Activities',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal),
                      ));
                    }
                  }
              }
            },
          ),
        ),
      ],
    );
  }

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
                child: ListView(
                  children: List<Widget>.generate(
                    3,
                    (int index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: sideShow(index),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
              onTap: () {
                widget.onItemPressed('guides');
              },
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
          height: MediaQuery.of(context).size.height * 0.25,
          child: FutureBuilder<List<User>>(
              future: APIServices().getPopularGuides(), // async work
              builder:
                  (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const MainContentSkeletonHorizontal();
                  default:
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return GestureDetector(
                        onTap: _settingModalBottomSheet,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: List<Widget>.generate(snapshot.data!.length,
                              (int i) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 20.h),
                              height: 180.h,
                              width: 220.w,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 112.h,
                                    width: 220.w,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.r),
                                      ),
                                      image: DecorationImage(
                                        image:
                                            AssetImage(guides[1].featureImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          bottom: 0,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 30,
                                            backgroundImage:
                                                AssetImage(guides[1].path),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    snapshot.data![i].fullName ?? '',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w600),
                                  ),
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
                                                'assets/images/png/marker.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        '1 KM',
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
                          }),
                        ),
                      );
                    }
                }
              }),
        ),
      ],
    );
  }

  Widget staticAdd(BuildContext context) {
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
                image: const DecorationImage(
                  image: AssetImage('assets/images/png/adsImage.png'),
                  fit: BoxFit.cover,
                ),
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
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'You can be a guide and unlock\nnew opportunity by sharing your\nexperience',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: AppTextStyle.active,
                  //     child: const Text(
                  //       'Learn more',
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold, fontSize: 12),
                  //     ),
                  //   ),
                  // ),
                ],
              )),
        ],
      ),
    );
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
}
