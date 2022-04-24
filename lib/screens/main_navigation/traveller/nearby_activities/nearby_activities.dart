// ignore_for_file: public_member_api_docs, use_named_constants

import 'package:card_swiper/card_swiper.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'dart:async';

import 'package:guided/models/activities_model.dart';

import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';

import 'package:guided/utils/services/static_data_services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/asset_path.dart';
import '../../../../controller/nearbyActivies_controller.dart';
import '../../../../models/guide.dart';

/// PopularGuides
class NearbyActivitiesScreen extends StatefulWidget {
  final Function(String) onItemPressed;
  const NearbyActivitiesScreen({required this.onItemPressed, Key? key})
      : super(key: key);

  @override
  State<NearbyActivitiesScreen> createState() => _NearbyActivitiesScreenState();
}

class _NearbyActivitiesScreenState extends State<NearbyActivitiesScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final travellerMonthController = Get.put(TravellerMonthController());
  final SwiperController _cardController = SwiperController();
  final List<Activity> activities =
      StaticDataService.getActivityForNearybyGuides();
  final PageController page_indicator_controller = PageController();
  Activity selectedActivity = Activity();
  final List<Guide> guides = StaticDataService.getGuideList();
  final nearbyActivitiesController = Get.put(NearbyActivitiesController());
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    initializeDateFormatting(
      'en',
    );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 10.w, 20.h),
                child: Container(
                  width: 44.w,
                  height: 44.h,
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
              GetBuilder<NearbyActivitiesController>(
                id: 'nearbyrResult',
                builder: (NearbyActivitiesController controller) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
                    child: SizedBox(
                      height: 54.h,
                      child: FormBuilderDropdown<String>(
                        onChanged: (value) {
                          showModalGuides(guides);
                        },
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gilroy'),
                        dropdownColor: Colors.white,
                        name: 'activityFilter',
                        decoration: InputDecoration(
                          prefixIcon: controller.activity.value.path != ''
                              ? Image.asset(
                                  controller.activity.value.path,
                                  scale: 15,
                                )
                              : null,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.w),
                          helperStyle: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gilroy'),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.2.w),
                          ),
                        ),
                        // initialValue: 'Male',
                        allowClear: true,
                        hint: const Text('Select Activity'),

                        items: activities
                            .map(
                                (Activity activity) => DropdownMenuItem<String>(
                                      value: activity.name,
                                      child: Text(activity.name),
                                      onTap: () {
                                        nearbyActivitiesController
                                            .setActivity(activity);
                                        // setState(() {
                                        //   selectedActivity = activity;
                                        // });
                                      },
                                    ))
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    ));
  }

  void showActivityDetails(int index) {
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 0.h, 20.w, 0.h),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back))),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
                    child: Text(
                      'Explore Nearby Activities',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Align(
                    child: slideShow(index),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 15.h,
                            width: 15.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/png/marker.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(
                            'Toronto, Canada',
                            style: TextStyle(
                                color: HexColor('#979B9B'),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h),
                    child: Text(
                      'Sub Description of Activty : Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget nibh quis metus venenatis porta nec eget sem. Pellentesque nec suscipit libero. Cras sed turpis risus. Curabitur blandit at nulla pellentesque placerat. Fusce non dolor sagittis, laoreet nisi nec, fringilla lorem. Nam faucibus, augue eu scelerisque tempus, ante sapien bibendum ante, sit amet blandit felis est quis massa. Curabitur vel lectus a sapien porta convallis vitae quis augue.',
                      style: TextStyle(
                          color: HexColor('#979B9B'),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20.r,
                              backgroundImage: const AssetImage(
                                  '${AssetsPath.assetsPNGPath}/student_profile.png'),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'Mark Chen',
                            style: TextStyle(
                                color: HexColor('#181B1B'),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30.r,
                              backgroundImage: const AssetImage(
                                  '${AssetsPath.assetsPNGPath}/callguide.png'),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }

  void showModalGuides(List<Guide> guides) {
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
              height: MediaQuery.of(context).size.height * 0.5,
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
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        '16 nearby guides',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Stack(
                          children: <Widget>[
                            PageView.builder(
                              controller: page_indicator_controller,
                              itemCount: guides.length,
                              itemBuilder: (_, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.of(context)
                                        //     .pushNamed('/checkAvailability');
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          showActivityDetails(index);
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
                                              image: AssetImage(
                                                  guides[index].featureImage),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: IconButton(
                                                  icon: const Icon(
                                                      Icons.favorite_border),
                                                  onPressed: () {},
                                                  color: HexColor('#ffffff'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.star,
                                            color: HexColor('#066028'),
                                            size: 10,
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
                                    activeDotColor: Colors.white,
                                    dotColor: Colors.white,
                                    activeStrokeWidth: 2.6,
                                    activeDotScale: 1.6,
                                    radius: 8,
                                    spacing: 10,
                                    dotHeight: 6,
                                    dotWidth: 6,
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
  }

  Widget slideShow(int index) {
    final PageController pageIndicatorController =
        PageController(initialPage: index);
    return SizedBox(
      height: 244.h,
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
                                  left: 15,
                                  bottom: 15,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 20,
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
                  'Grasslands Outfitting',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                SizedBox(
                  width: 93.w,
                  height: 34.h,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.transparent,
                      onSurface: Colors.grey,
                      side: const BorderSide(),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      print('Pressed');
                    },
                    child: Text(
                      'Read more',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
