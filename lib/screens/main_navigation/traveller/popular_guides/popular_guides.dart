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
import 'package:guided/controller/traveller_controller.dart';
import 'dart:async';

import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  final List<Marker> _markers = <Marker>[];
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final travellerMonthController = Get.put(TravellerMonthController());
  final SwiperController _cardController = SwiperController();
  final List<Guide> guides = StaticDataService.getGuideList();
  final PageController page_indicator_controller = PageController();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    initializeDateFormatting('en', null);
    WidgetsBinding.instance?.addPostFrameCallback((_) => addMarker(context));
    super.initState();
  }

  Future<void> addMarker(BuildContext context) async {
    final List<Marker> markers = <Marker>[
      Marker(
        markerId: const MarkerId('marker1'),
        icon: await MarkerIcon.pictureAsset(
            assetPath: 'assets/images/png/hunting_marker.png',
            width: 150.w,
            height: 150.h),
        position: const LatLng(57.818582, -101.760181),
      ),
      Marker(
        markerId: const MarkerId('marker2'),
        icon: await MarkerIcon.pictureAsset(
            assetPath: 'assets/images/png/hunting_marker.png',
            width: 150.w,
            height: 150.h),
        position: const LatLng(57.874333, -101.725262),
      ),
      Marker(
        markerId: const MarkerId('marker3'),
        icon: await MarkerIcon.pictureAsset(
            assetPath: 'assets/images/png/hunting_marker.png',
            width: 150.w,
            height: 150.h),
        position: const LatLng(57.827880, -101.943505),
      ),
      Marker(
        markerId: const MarkerId('marker4'),
        icon: await MarkerIcon.pictureAsset(
            assetPath: 'assets/images/png/hunting_marker.png',
            width: 150.w,
            height: 150.h),
        position: const LatLng(57.775161, -101.879487),
      ),
    ];

    setState(() {
      _markers.addAll(markers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(57.818582, -101.760181),
            zoom: 10,
          ),
          markers: Set<Marker>.of(_markers),
          onMapCreated: _onMapCreated,
        ),
        SafeArea(
          child: Row(
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
                              // SizedBox(
                              //   height: 15.h,
                              // ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: EasyScrollToIndex(
                                        controller:
                                            _scrollController, // ScrollToIndexController
                                        scrollDirection: Axis
                                            .horizontal, // default Axis.vertical
                                        itemCount: AppListConstants
                                            .calendarMonths.length, // itemCount
                                        itemWidth: 95,
                                        itemHeight: 70,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              _scrollController
                                                  .easyScrollToIndex(
                                                      index: index);
                                              travellerMonthController
                                                  .setSelectedDate(index + 1);
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
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              index == 0
                                                                  ? 0.w
                                                                  : 0.w,
                                                              0.h,
                                                              10.w,
                                                              0.h),
                                                      width: 89,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(10),
                                                          ),
                                                          border: Border.all(
                                                              color: index ==
                                                                      travellerMonthController
                                                                              .selectedDate -
                                                                          1
                                                                  ? HexColor(
                                                                      '#FFC74A')
                                                                  : HexColor(
                                                                      '#C4C4C4'),
                                                              width: 1),
                                                          color: index ==
                                                                  travellerMonthController
                                                                          .selectedDate -
                                                                      1
                                                              ? HexColor(
                                                                  '#FFC74A')
                                                              : Colors.white),
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
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontFamily:
                                                                        AppTextConstants
                                                                            .fontPoppins),
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
                                  builder:
                                      (TravellerMonthController controller) {
                                    print(controller.currentDate);
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(
                                          20.w, 0.h, 20.w, 0.h),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: Sfcalendar(
                                        context,
                                        travellerMonthController.currentDate,
                                        ((value) {
                                          print(value);
                                        }),[]
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
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
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
                                              height: MediaQuery.of(context)
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
                                                      AssetsPath.horizontalLine,
                                                      width: 60.w,
                                                      height: 5.h,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20.w,
                                                            20.h,
                                                            20.w,
                                                            20.h),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Text(
                                                        '16 nearby guides',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20.w,
                                                                right: 20.w),
                                                        child: Stack(
                                                          children: <Widget>[
                                                            PageView.builder(
                                                              controller:
                                                                  page_indicator_controller,
                                                              itemCount:
                                                                  guides.length,
                                                              itemBuilder: (_,
                                                                  int index) {
                                                                return Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pushNamed('/checkAvailability');
                                                                      },
                                                                      child:
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
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                HexColor('#066028'),
                                                                            size:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            '16 review',
                                                                            style: TextStyle(
                                                                                color: HexColor('#979B9B'),
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "St. John's, Newfoundland",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 16
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                    Text(
                                                                      '\$50/ Person',
                                                                      style: TextStyle(
                                                                          color: HexColor(
                                                                              '#3E4242'),
                                                                          fontSize: 16
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                            Align(
                                                              child:
                                                                  SmoothPageIndicator(
                                                                      controller:
                                                                          page_indicator_controller,
                                                                      count: guides
                                                                          .length,
                                                                      effect:
                                                                          const ScrollingDotsEffect(
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
                          index: travellerMonthController.selectedDate - 1);

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
                      suffixIcon: Container(
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
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
