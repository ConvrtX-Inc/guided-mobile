// ignore_for_file: public_member_api_docs, use_named_constants

import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/popular_guides_controller.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'dart:async';

import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:collection/collection.dart';

/// PopularGuides
class PopularGuides extends StatefulWidget {
  final Function(String) onItemPressed;
  const PopularGuides({required this.onItemPressed, Key? key})
      : super(key: key);

  @override
  State<PopularGuides> createState() => _PopularGuidesState();
}

class _PopularGuidesState extends State<PopularGuides> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  final List<Marker> _markers = <Marker>[];
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final travellerMonthController = Get.put(TravellerMonthController());
  final SwiperController _cardController = SwiperController();
  final List<Guide> guides = StaticDataService.getGuideList();
  final PageController page_indicator_controller = PageController();
  final popularGuidesController = Get.put(PopularGuidesController());
  List<ActivityPackage> _resultActivities = [];
  List<ActivityPackage> _filteredActivity = [];
  List<int> _selectedActivity = [];
  TextEditingController _searchController = new TextEditingController();
  final List<Activity> activities =
      StaticDataService.getActivityForNearybyGuides();
  LatLng currentMapLatLong = const LatLng(53.59, -113.60);
  bool _isloading = true;
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    initializeDateFormatting('en', null);
    // WidgetsBinding.instance?.addPostFrameCallback((_) => addMarker(context));
    APIServices()
        .searchActivity(popularGuidesController.searchKey)
        .then((List<ActivityPackage> value) {
      final ActivityPackage? activity = value.firstOrNull;

      if (activity != null) {
        addMarker(value);
        double lat = double.parse(activity
            .activityPackageDestination!.activityPackageDestinationLatitude!);
        double long = double.parse(activity
            .activityPackageDestination!.activityPackageDestinationLongitude!);
        mapController?.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lat, long), zoom: 17)
            //17 is new zoom level
            ));
      }
    });
    super.initState();
  }

  // Future<void> addMarker(BuildContext context) async {
  //   final List<Marker> markers = <Marker>[
  //     Marker(
  //       markerId: const MarkerId('marker1'),
  //       icon: await MarkerIcon.pictureAsset(
  //           assetPath: 'assets/images/png/hunting_marker.png',
  //           width: 150.w,
  //           height: 150.h),
  //       position: const LatLng(57.818582, -101.760181),
  //     ),
  //     Marker(
  //       markerId: const MarkerId('marker2'),
  //       icon: await MarkerIcon.pictureAsset(
  //           assetPath: 'assets/images/png/hunting_marker.png',
  //           width: 150.w,
  //           height: 150.h),
  //       position: const LatLng(57.874333, -101.725262),
  //     ),
  //     Marker(
  //       markerId: const MarkerId('marker3'),
  //       icon: await MarkerIcon.pictureAsset(
  //           assetPath: 'assets/images/png/hunting_marker.png',
  //           width: 150.w,
  //           height: 150.h),
  //       position: const LatLng(57.827880, -101.943505),
  //     ),
  //     Marker(
  //       markerId: const MarkerId('marker4'),
  //       icon: await MarkerIcon.pictureAsset(
  //           assetPath: 'assets/images/png/hunting_marker.png',
  //           width: 150.w,
  //           height: 150.h),
  //       position: const LatLng(57.775161, -101.879487),
  //     ),
  //   ];

  //   setState(() {
  //     _markers.addAll(markers);
  //   });
  // }

  Future<void> addMarker(List<ActivityPackage> activityPackages) async {
    final List<Marker> marks = <Marker>[];
    for (ActivityPackage element in activityPackages) {
      if (element.mainBadge != null) {
        final Activity? activity = activities
            .firstWhereOrNull((Activity a) => a.id == element.mainBadge!.id);

        if (activity != null) {
          double lat = double.parse(element
              .activityPackageDestination!.activityPackageDestinationLatitude!);
          double long = double.parse(element.activityPackageDestination!
              .activityPackageDestinationLongitude!);
          marks.add(
            Marker(
              markerId: MarkerId(element.id!),
              icon: await MarkerIcon.pictureAsset(
                  assetPath: activity.path, width: 80, height: 80),
              position: LatLng(lat, long),
            ),
          );
        }
      }
    }
    double lat = double.parse(activityPackages
        .first.activityPackageDestination!.activityPackageDestinationLatitude!);
    double long = double.parse(activityPackages.first
        .activityPackageDestination!.activityPackageDestinationLongitude!);
    // mapController?.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(target: LatLng(lat, long), zoom: 17)
    //     //17 is new zoom level
    //     ));
    setState(() {
      currentMapLatLong = LatLng(lat, long);
      _resultActivities = activityPackages;
      _isloading = false;
      _markers.addAll(marks);
    });
  }

  showActivityDetails(ActivityPackage activityPackage) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Text('Package ${activityPackage.name} ');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentMapLatLong,
            zoom: 12,
          ),
          markers: Set<Marker>.of(_markers),
          onMapCreated: _onMapCreated,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
        ),
        SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 10.w, 20.h),
                      child: Container(
                        width: 40.w,
                        height: 54.h,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {
                            widget.onItemPressed('home');
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.w, 20.h, 15.w, 20.h),
                      child: GestureDetector(
                        onTap: () {
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
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.72,
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

                                                    final DateTime plustMonth =
                                                        DateTime(
                                                            dt.year,
                                                            index + 1,
                                                            dt.day,
                                                            dt.hour,
                                                            dt.minute);

                                                    final DateTime setLastday =
                                                        DateTime(
                                                            plustMonth.year,
                                                            plustMonth.month,
                                                            1,
                                                            plustMonth.hour,
                                                            plustMonth.minute);

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
                                                              Alignment.center,
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    index == 0
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
                                                                            travellerMonthController.selectedDate -
                                                                                1
                                                                        ? HexColor(
                                                                            '#FFC74A')
                                                                        : Colors
                                                                            .white),
                                                            child: Center(
                                                                child: Text(
                                                                    AppListConstants
                                                                            .calendarMonths[
                                                                        index])),
                                                          ),
                                                        ),
                                                        Positioned(
                                                            right: 2,
                                                            top: 2,
                                                            child: index.isOdd
                                                                ? Badge(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(8),
                                                                    badgeColor:
                                                                        AppColors
                                                                            .deepGreen,
                                                                    badgeContent:
                                                                        Text(
                                                                      '2',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w800,
                                                                          fontFamily:
                                                                              AppTextConstants.fontPoppins),
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
                                                    .currentDate, ((value) {
                                              print(value);
                                            }), []),
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
                                              builder: (BuildContext context) {
                                                return SafeArea(
                                                  top: false,
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                    child: Column(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Align(
                                                          child: Image.asset(
                                                            AssetsPath
                                                                .horizontalLine,
                                                            width: 60.w,
                                                            height: 5.h,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  20.w,
                                                                  20.h,
                                                                  20.w,
                                                                  20.h),
                                                          child: Align(
                                                            alignment: Alignment
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
                                                              child: Stack(
                                                                children: <
                                                                    Widget>[
                                                                  PageView
                                                                      .builder(
                                                                    controller:
                                                                        page_indicator_controller,
                                                                    itemCount:
                                                                        guides
                                                                            .length,
                                                                    itemBuilder:
                                                                        (_, int index) {
                                                                      return Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.of(context).pushNamed('/checkAvailability');
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 200.h,
                                                                              // width:
                                                                              //     315.w,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.transparent,
                                                                                borderRadius: BorderRadius.all(
                                                                                  Radius.circular(15.r),
                                                                                ),
                                                                                image: DecorationImage(
                                                                                  image: AssetImage(guides[index].featureImage),
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
                                                                                ],
                                                                              ),
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
                                                                              children: <Widget>[
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
                                                                                color: Colors.black,
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.w700),
                                                                          ),
                                                                          Text(
                                                                            '\$50/ Person',
                                                                            style: TextStyle(
                                                                                color: HexColor('#3E4242'),
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                  Align(
                                                                    child: SmoothPageIndicator(
                                                                        controller: page_indicator_controller,
                                                                        count: guides.length,
                                                                        effect: const ScrollingDotsEffect(
                                                                          activeDotColor:
                                                                              Colors.white,
                                                                          dotColor:
                                                                              Colors.white,
                                                                          activeStrokeWidth:
                                                                              2.6,
                                                                          activeDotScale:
                                                                              1.6,
                                                                          maxVisibleDots:
                                                                              5,
                                                                          radius:
                                                                              8,
                                                                          spacing:
                                                                              10,
                                                                          dotHeight:
                                                                              6,
                                                                          dotWidth:
                                                                              6,
                                                                        )),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
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
                                    travellerMonthController.selectedDate - 1);

                            // setState(() {
                            //   selectedmonth = 7;
                            // });
                          });
                        },
                        child: Container(
                          height: 54.h,
                          width: 40.w,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                          ),
                          child: Center(
                            child: Container(
                              height: 20.h,
                              width: 20.w,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/png/calendar_icon.png'),
                                  fit: BoxFit.contain,
                                ),
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
                          controller: _searchController,
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
                            contentPadding: const EdgeInsets.all(20),
                            fillColor: Colors.white,
                            prefixIcon: IconButton(
                              icon: Image.asset(
                                'assets/images/png/search_icon.png',
                                width: 20.w,
                                height: 20.h,
                              ),
                              onPressed: null,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                if (_searchController.text.isNotEmpty) {
                                  APIServices()
                                      .searchActivity(_searchController.text)
                                      .then((List<ActivityPackage> value) {
                                    final ActivityPackage? activity =
                                        value.firstOrNull;

                                    if (activity != null) {
                                      addMarker(value);
                                      double lat = double.parse(activity
                                          .activityPackageDestination!
                                          .activityPackageDestinationLatitude!);
                                      double long = double.parse(activity
                                          .activityPackageDestination!
                                          .activityPackageDestinationLongitude!);
                                      mapController?.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                  target: LatLng(lat, long),
                                                  zoom: 17)
                                              //17 is new zoom level
                                              ));
                                    }
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.w),
                                height: 35.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: HexColor('#066028'),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'GO',
                                    style: TextStyle(
                                      color: HexColor('#ffffff'),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onSubmitted: (String search) {
                            if (search.isNotEmpty) {
                              APIServices()
                                  .searchActivity(search)
                                  .then((List<ActivityPackage> value) {
                                final ActivityPackage? activity =
                                    value.firstOrNull;

                                if (activity != null) {
                                  addMarker(value);
                                  double lat = double.parse(activity
                                      .activityPackageDestination!
                                      .activityPackageDestinationLatitude!);
                                  double long = double.parse(activity
                                      .activityPackageDestination!
                                      .activityPackageDestinationLongitude!);
                                  mapController?.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              target: LatLng(lat, long),
                                              zoom: 17)
                                          //17 is new zoom level
                                          ));
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // height: activitiesContainer,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: overlapped(activities),
                  ),
                ),
              ],
            )),
        Align(
            child:
                _isloading ? const CircularProgressIndicator() : Container()),
      ],
    ));
  }

  Widget overlapped(List<Activity> activities) {
    final overlap = 30.0;
    final r = 15;
    final items = <Widget>[];
    double minus = 0;
    for (var i = 0; i < activities.length; i++) {
      if (i < 5) {
        items.add(
          GestureDetector(
            onTap: () {
              final List<ActivityPackage> filteredActivity = _resultActivities
                  .where((ActivityPackage a) =>
                      a.mainBadge!.id == activities[i].id)
                  .toList();

              if (filteredActivity.isNotEmpty) {
                setState(() {
                  if (_selectedActivity.contains(i)) {
                    _selectedActivity.remove(i);
                    _filteredActivity.removeWhere(
                        (element) => element.mainBadgeId == activities[i].id);
                  } else {
                    _filteredActivity.addAll(filteredActivity);
                    _selectedActivity.add(i);
                  }
                });
              } else {
                setState(() {
                  if (_selectedActivity.contains(i)) {
                    _selectedActivity.remove(i);
                  } else {
                    _selectedActivity.add(i);
                  }
                });
              }

              final ActivityPackage? activity = _filteredActivity.firstOrNull;

              if (activity != null) {
                double lat = double.parse(activity.activityPackageDestination!
                    .activityPackageDestinationLatitude!);
                double long = double.parse(activity.activityPackageDestination!
                    .activityPackageDestinationLongitude!);
                mapController?.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: LatLng(lat, long), zoom: 17)
                    //17 is new zoom level
                    ));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: const Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedActivity.contains(i)
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: r.toDouble() + i.toDouble() + 5,
                      backgroundImage: ExactAssetImage(activities[i].path),
                    ),
                  ),
                  Positioned(
                      top: 2,
                      right: 8,
                      child: _selectedActivity.contains(i)
                          ? Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                size: 10.h,
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox()),
                ],
              ),
            ),
          ),
        );
        minus = r.toDouble() + i.toDouble() + 5;
      } else {
        items.add(
          GestureDetector(
            onTap: () {
              final List<ActivityPackage> filteredActivity = _resultActivities
                  .where((ActivityPackage a) =>
                      a.mainBadge!.id == activities[i].id)
                  .toList();

              if (filteredActivity.isNotEmpty) {
                setState(() {
                  if (_selectedActivity.contains(i)) {
                    _selectedActivity.remove(i);
                    _filteredActivity.removeWhere(
                        (element) => element.mainBadgeId == activities[i].id);
                  } else {
                    _filteredActivity.addAll(filteredActivity);
                    _selectedActivity.add(i);
                  }
                });
              } else {
                setState(() {
                  if (_selectedActivity.contains(i)) {
                    _selectedActivity.remove(i);
                  } else {
                    _selectedActivity.add(i);
                  }
                });
              }
              final ActivityPackage? activity = _filteredActivity.firstOrNull;

              if (activity != null) {
                double lat = double.parse(activity.activityPackageDestination!
                    .activityPackageDestinationLatitude!);
                double long = double.parse(activity.activityPackageDestination!
                    .activityPackageDestinationLongitude!);
                mapController?.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: LatLng(lat, long), zoom: 17)
                    //17 is new zoom level
                    ));
              }
              // mapController?.animateCamera(CameraUpdate.newCameraPosition(
              //     CameraPosition(
              //         target: LatLng(
              //             double.parse(_filteredActivity
              //                 .first
              //                 .activityPackageDestination!
              //                 .activitypackagedestinationLatitude!),
              //             double.parse(_filteredActivity
              //                 .first
              //                 .activityPackageDestination!
              //                 .activitypackagedestinationLongitude!)),
              //         zoom: 17)
              //     //17 is new zoom level
              //     ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: const Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedActivity.contains(i)
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      // backgroundColor:
                      //     Colors.primaries[Random().nextInt(Colors.primaries.length)],
                      radius: minus - i.toDouble() + 4,
                      backgroundImage: ExactAssetImage(activities[i].path),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 8,
                    child: _selectedActivity.contains(i)
                        ? Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 10.h,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    List<Widget> stackLayersLeft =
        List<Widget>.generate(items.getRange(0, 4).length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: items[index],
      );
    });
    List<Widget> stackLayersRight =
        List<Widget>.generate(items.getRange(5, 9).length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: items[5 + index],
      );
    });
    List<Widget> stackLayersCenter =
        List<Widget>.generate(items.getRange(5, 5).length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: items[5],
      );
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          transform: Matrix4.translationValues(15, 0, 0),
          child: Stack(
            children: stackLayersLeft,
          ),
        ),
        Align(
          child: items[4],
        ),
        Container(
          transform: Matrix4.translationValues(-15, 0, 0),
          child: Stack(
            children: stackLayersRight,
          ),
        ),

        // Positioned(child: items[4]),
      ],
    );
  }
}
