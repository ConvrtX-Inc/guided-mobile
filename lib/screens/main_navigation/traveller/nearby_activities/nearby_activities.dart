// ignore_for_file: public_member_api_docs, use_named_constants

import 'package:card_swiper/card_swiper.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:guided/controller/traveller_controller.dart';
import 'dart:async';

import 'package:guided/models/activities_model.dart';

import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';

import 'package:guided/utils/services/static_data_services.dart';
import 'package:intl/date_symbol_data_local.dart';

/// PopularGuides
class NearbyActivitiesScreen extends StatefulWidget {
  final Function(String) onItemPressed;
  const NearbyActivitiesScreen({required this.onItemPressed, Key? key})
      : super(key: key);

  @override
  State<NearbyActivitiesScreen> createState() => _NearbyActivitiesScreenState();
}

class _NearbyActivitiesScreenState extends State<NearbyActivitiesScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final travellerMonthController = Get.put(TravellerMonthController());
  final SwiperController _cardController = SwiperController();
  final List<Activity> activities = StaticDataService.getActivityList();
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
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
                child: SizedBox(
                  height: 54.h,
                  child: FormBuilderDropdown(
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gilroy'),
                    dropdownColor: Colors.white,
                    name: 'activityFilter',
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      helperStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gilroy'),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                    // initialValue: 'Male',
                    allowClear: true,
                    hint: Text('Select Activity'),

                    items: activities
                        .map((activity) => DropdownMenuItem(
                              value: activity.name,
                              child: Text(activity.name),
                            ))
                        .toList(),
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
