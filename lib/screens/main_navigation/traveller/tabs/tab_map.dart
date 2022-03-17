// ignore_for_file: public_member_api_docs, use_named_constants

import 'dart:math';

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
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// PopularGuides
class TabMapScreen extends StatefulWidget {
  const TabMapScreen({Key? key}) : super(key: key);

  @override
  State<TabMapScreen> createState() => _TabMapScreenState();
}

class _TabMapScreenState extends State<TabMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final travellerMonthController = Get.put(TravellerMonthController());
  final SwiperController _cardController = SwiperController();
  final List<Guide> guides = StaticDataService.getGuideList();
  final List<Activity> activities = StaticDataService.getActivityList();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
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
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(57.818582, -101.760181),
                zoom: 10,
              ),
              markers: Set<Marker>.of(_markers),
              onMapCreated: _onMapCreated,
              zoomControlsEnabled: false,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: HexColor('#F8F7F6'),
              ),
              height: MediaQuery.of(context).size.height * 0.32,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 10.h),
                        child: Container(
                          transform: Matrix4.translationValues(0, -5.h, 0),
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
                                onPressed: () async {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: 20.w,
                      ),
                      Flexible(
                        flex: 6,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          height: 44.h,
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10.w, right: 8.w),
                                height: 15.h,
                                width: 15.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/png/marker.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const Text(
                                "St. John's, Newfo...",
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          height: 44.h,
                          child: const Center(child: Text('Radius : 05')),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(activities.length, (int index) {
                        return Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(activities[index].path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const Spacer(),
                  const Align(
                    child: Icon(
                      Icons.expand_less,
                      // color: HexColor('#979B9B'),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.24,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5.h,
                      ),
                      Icon(
                        Icons.expand_more,
                        color: HexColor('#979B9B'),
                        size: 30,
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children:
                              List<Widget>.generate(activities.length, (int i) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 20.h),
                              height: 180.h,
                              width: 135.w,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Guided News Feed',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    height: 90.h,
                                    width: 135.w,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.r),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            activities[i].featureImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          bottom: 0,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 17,
                                            backgroundImage:
                                                AssetImage(activities[i].path),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget overlapped(List<Activity> activities) {
    final overlap = 27.0;
    final r = 15;
    final items = <Widget>[];
    double minus = 0;
    for (var i = 0; i < 10; i++) {
      if (i < 5) {
        items.add(
          CircleAvatar(
            child: FittedBox(
              child: Image.asset(activities[i].path),
              fit: BoxFit.cover,
            ),
            radius: r.toDouble() + i.toDouble() + 5,
          ),
        );
        minus = r.toDouble() + i.toDouble() + 5;
      } else {
        items.add(
          CircleAvatar(
            child: Text(i.toString()),
            backgroundColor:
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
            radius: minus - i.toDouble() + 5,
          ),
        );
      }
    }

    List<Widget> stackLayers = List<Widget>.generate(items.length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: items[index],
      );
    });

    return Stack(children: stackLayers);
  }
}
