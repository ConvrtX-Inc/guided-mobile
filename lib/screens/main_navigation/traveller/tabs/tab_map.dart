// ignore_for_file: public_member_api_docs, use_named_constants

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'dart:async';

import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:guided/screens/payments/confirm_payment.dart';
import 'package:guided/screens/payments/payment_failed.dart';
import 'package:guided/screens/payments/payment_method.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_bottom_sheet.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_payment_details.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../models/activity_package.dart';
import 'package:collection/collection.dart';

/// PopularGuides
class TabMapScreen extends StatefulWidget {
  const TabMapScreen({Key? key}) : super(key: key);

  @override
  State<TabMapScreen> createState() => _TabMapScreenState();
}

class _TabMapScreenState extends State<TabMapScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  final List<Marker> _markers = <Marker>[];
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final travellerMonthController = Get.put(TravellerMonthController());
  final SwiperController _cardController = SwiperController();
  final List<Guide> guides = StaticDataService.getGuideList();
  final List<Activity> activities =
      StaticDataService.getActivityForNearybyGuides();
  final List<Activity> tourList = StaticDataService.getTourList();
  bool hideActivities = false;
  bool showBottomScroll = true;
  double activitiesContainer = 70;
  bool _isloading = true;
  List<int> _selectedActivity = [];
  LatLng currentMapLatLong = const LatLng(53.59, -113.60);
  List<ActivityPackage> _loadingData = [];
  List<ActivityPackage> _filteredActivity = [];
  final CardController _creditCardController = Get.put(CardController());
  final UserSubscriptionController _userSubscriptionController =
      Get.put(UserSubscriptionController());
  TextEditingController _placeName = new TextEditingController();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      mapController = controller;
    });
  }

  bool hasPremiumSubscription = false;

  @override
  void initState() {
    APIServices().getActivityPackages().then((List<ActivityPackage> value) {
      print(value.length);
      addMarker(value);
    });

    // WidgetsBinding.instance?.addPostFrameCallback((_) => addMarker(context));
    super.initState();

/*    if (_creditCardController.cards.isEmpty) {
      getUserCards();
    }*/

    hasPremiumSubscription =
        UserSingleton.instance.user.user!.hasPremiumSubscription!;
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

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
    print(activityPackages
        .first.activityPackageDestination!.activityPackageDestinationLatitude!);
    print(activityPackages.first.activityPackageDestination!
        .activityPackageDestinationLongitude!);
    // mapController?.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(target: LatLng(lat, long), zoom: 17)
    //     //17 is new zoom level
    //     ));
    setState(() {
      currentMapLatLong = LatLng(lat, long);
      _loadingData = activityPackages;
      _isloading = false;
      _markers.addAll(marks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          final Position location = await _userCurrentPosition();
          await mapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(location.latitude, location.longitude),
                  zoom: 17)
              //17 is new zoom level
              ));
        },
        child: const Icon(
          Icons.my_location,
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(const Radius.circular(10)),
                color: HexColor('#F8F7F6'),
              ),
              height: hideActivities
                  ? MediaQuery.of(context).size.height * 0.23
                  : MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 10.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/traveller_tab');
                          },
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
                                        'assets/images/png/green_house_outlined.png'),
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
                            textInputAction: TextInputAction.search,
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
                            controller: _placeName,
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
                                onPressed: () {
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
                                            MediaQuery.of(context).size.height *
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
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                    width:
                                                        MediaQuery.of(context)
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
                                                                    index:
                                                                        index);
                                                            travellerMonthController
                                                                .setSelectedDate(
                                                                    index + 1);
                                                            DateTime dt =
                                                                DateTime.parse(
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
                                                                    plustMonth
                                                                        .year,
                                                                    plustMonth
                                                                        .month,
                                                                    1,
                                                                    plustMonth
                                                                        .hour,
                                                                    plustMonth
                                                                        .minute);

                                                            travellerMonthController
                                                                .setCurrentMonth(
                                                              setLastday
                                                                  .toString(),
                                                            );
                                                          },
                                                          child: Obx(
                                                            () => Stack(
                                                              children: <
                                                                  Widget>[
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets.fromLTRB(
                                                                        index ==
                                                                                0
                                                                            ? 0.w
                                                                            : 0.w,
                                                                        0.h,
                                                                        10.w,
                                                                        0.h),
                                                                    width: 89,
                                                                    height: 45,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: const BorderRadius.all(
                                                                          Radius.circular(
                                                                              10),
                                                                        ),
                                                                        border: Border.all(color: index == travellerMonthController.selectedDate - 1 ? HexColor('#FFC74A') : HexColor('#C4C4C4'), width: 1),
                                                                        color: index == travellerMonthController.selectedDate - 1 ? HexColor('#FFC74A') : Colors.white),
                                                                    child: Center(
                                                                        child: Text(
                                                                            AppListConstants.calendarMonths[index])),
                                                                  ),
                                                                ),
                                                                // Positioned(
                                                                //     right: 2,
                                                                //     top: 2,
                                                                //     child: index
                                                                //             .isOdd
                                                                //         ? Badge(
                                                                //             padding:
                                                                //                 const EdgeInsets.all(8),
                                                                //             badgeColor:
                                                                //                 AppColors.deepGreen,
                                                                //             badgeContent:
                                                                //                 Text(
                                                                //               '2',
                                                                //               style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w800, fontFamily: AppTextConstants.fontPoppins),
                                                                //             ),
                                                                //           )
                                                                //         : Container()),
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
                                            GetBuilder<
                                                    TravellerMonthController>(
                                                id: 'calendar',
                                                builder:
                                                    (TravellerMonthController
                                                        controller) {
                                                  print(
                                                      controller.selectedDates);
                                                  return Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20.w,
                                                              0.h,
                                                              20.w,
                                                              0.h),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.4,
                                                      child: Sfcalendar(
                                                        context,
                                                        travellerMonthController
                                                            .currentDate,
                                                        (List<DateTime> value) {
                                                          travellerMonthController
                                                              .selectedDates
                                                              .clear();
                                                          travellerMonthController
                                                              .setSelectedDates(
                                                                  value);
                                                        },
                                                      ));
                                                }),
                                            // SizedBox(
                                            //   height: 20.h,
                                            // ),
                                            SizedBox(
                                              width: 153.w,
                                              height: 54.h,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (travellerMonthController
                                                      .selectedDates
                                                      .isNotEmpty) {
                                                    Navigator.of(context).pop();
                                                    travellerMonthController
                                                        .selectedDates
                                                        .sort((DateTime a,
                                                                DateTime b) =>
                                                            a.compareTo(b));

                                                    APIServices()
                                                        .getActivityByDateRange(
                                                            formatDate(
                                                                travellerMonthController
                                                                    .selectedDates
                                                                    .first),
                                                            formatDate(
                                                                travellerMonthController
                                                                    .selectedDates
                                                                    .last))
                                                        .then((value) {
                                                      if (value.isNotEmpty) {
                                                        final ActivityPackage?
                                                            activity =
                                                            value.firstOrNull;
                                                        if (activity != null) {
                                                          addMarker(value);
                                                          double lat = double
                                                              .parse(activity
                                                                  .activityPackageDestination!
                                                                  .activityPackageDestinationLatitude!);
                                                          double long = double
                                                              .parse(activity
                                                                  .activityPackageDestination!
                                                                  .activityPackageDestinationLongitude!);
                                                          mapController?.animateCamera(
                                                              CameraUpdate.newCameraPosition(
                                                                  CameraPosition(
                                                                      target: LatLng(
                                                                          lat,
                                                                          long),
                                                                      zoom: 17)
                                                                  //17 is new zoom level
                                                                  ));
                                                        }
                                                      }
                                                    });
                                                  }
                                                },
                                                style: AppTextStyle.activeGreen,
                                                child: const Text(
                                                  'Set Filter Date',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ).whenComplete(() {
                                    _scrollController.easyScrollToIndex(
                                        index: 0);
                                  });
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    _scrollController.easyScrollToIndex(
                                        index: travellerMonthController
                                                .selectedDate -
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

                  FutureBuilder<List<Placemark>>(
                    future: _determinePosition(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Placemark>> snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              width: 20.w,
                            ),
                            Flexible(
                              flex: 6,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                ),
                                height: 44.h,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10.w, right: 8.w),
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
                                    if (snapshot.data!.isNotEmpty)
                                      Text(
                                          '${snapshot.data?.first.street} ${snapshot.data?.first.subLocality} ${snapshot.data?.first.locality}')
                                    else
                                      const Text(
                                        "St. John's, Newfo...",
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 10.w,
                            // ),
                            // Flexible(
                            //   flex: 3,
                            //   child: Container(
                            //     decoration: const BoxDecoration(
                            //       borderRadius: BorderRadius.all(Radius.circular(10)),
                            //       color: Colors.white,
                            //     ),
                            //     height: 44.h,
                            //     child: const Center(child: Text('Radius : 05')),
                            //   ),
                            // ),
                            SizedBox(
                              width: 15.w,
                            ),
                          ],
                        );
                      }
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Container();
                    },
                  ),

                  SizedBox(
                    height: hideActivities ? 20 : 40.h,
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: activitiesContainer,
                    child:
                        hideActivities ? Container() : overlapped(activities),
                  ),
                  // const Spacer(),
                  Align(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (hideActivities) {
                            hideActivities = false;
                            activitiesContainer = 70;
                          } else {
                            hideActivities = true;
                            activitiesContainer = 0;
                          }
                        });
                      },
                      child: Icon(
                        hideActivities ? Icons.expand_more : Icons.expand_less,
                        // color: HexColor('#979B9B'),
                        size: 30,
                      ),
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
                  height: showBottomScroll
                      ? MediaQuery.of(context).size.height * 0.24
                      : 40,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (showBottomScroll) {
                              showBottomScroll = false;
                            } else {
                              showBottomScroll = true;
                            }
                          });
                        },
                        child: Icon(
                          showBottomScroll
                              ? Icons.expand_more
                              : Icons.expand_less,
                          color: HexColor('#979B9B'),
                          size: 30,
                        ),
                      ),
                      if (showBottomScroll)
                        Expanded(
                          child: ListView(
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: List<Widget>.generate(
                                _filteredActivity.length, (int i) {
                              final Activity? icon = activities
                                  .firstWhereOrNull((Activity element) =>
                                      element.id ==
                                      _filteredActivity[i].mainBadgeId);
                              // final ActivityPackage? enable = _filteredActivity
                              //     .firstWhereOrNull((ActivityPackage element) =>
                              //         element.id == _loadingData[i].id);
                              if (icon != null) {
                                return InkWell(
                                    onTap: () {
                                      // Navigator.of(context)
                                      //     .pushNamed('/discovery_map');
                                      if (!hasPremiumSubscription &&
                                          PaymentConfig.isPaymentEnabled) {
                                        _showDiscoveryBottomSheet(
                                            _filteredActivity[i].coverImg!);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 20.h),
                                      height: 180.h,
                                      width: 135.w,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _filteredActivity[i].name!,
                                            overflow: TextOverflow.ellipsis,
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
                                                  image: Image.memory(
                                                base64.decode(
                                                    _filteredActivity[i]
                                                        .coverImg!
                                                        .split(',')
                                                        .last),
                                                fit: BoxFit.cover,
                                                gaplessPlayback: true,
                                              ).image),
                                              // image: DecorationImage(
                                              //   image: AssetImage(
                                              //       tourList[0].featureImage),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  left: 5,
                                                  bottom: 5,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    radius: 12,
                                                    backgroundImage:
                                                        AssetImage(icon.path),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              } else {
                                return Container();
                              }
                            }),
                          ),
                        )
                      else
                        Container()
                    ],
                  )),
            ),
            Align(
                child: _isloading
                    ? const CircularProgressIndicator()
                    : Container()),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    return formatted;
  }

  Future<Position> _userCurrentPosition() async {
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

  Future<List<Placemark>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    List<Placemark> places = [];
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

    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      return await placemarkFromCoordinates(
          position.latitude, position.longitude);
    } catch (e) {
      return places;
    }
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
              final List<ActivityPackage> filteredActivity = _loadingData
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
              final List<ActivityPackage> filteredActivity = _loadingData
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
                            price.toString(), mode);
                        paymentSuccessful(
                            context: context,
                            paymentDetails: DiscoveryPaymentDetails(
                                transactionNumber: data),
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
                            price: price,
                            onPaymentSuccessful: () {
                              Navigator.of(context).pop();
                              saveSubscription(
                                  transactionNumber,
                                  'Premium Subscription',
                                  price.toString(),
                                  mode);
                              //Save Subscription
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
                      }
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

  Future<void> saveSubscription(String transactionNumber,
      String subscriptionName, String price, String paymentMethod) async {
    final DateTime startDate = DateTime.now();

    final DateTime endDate = GlobalMixin().getEndDate(startDate);

    final UserSubscription subscriptionParams = UserSubscription(
        paymentReferenceNo: transactionNumber,
        name: subscriptionName,
        startDate: startDate.toString(),
        endDate: endDate.toString(),
        price: price);

    final APIStandardReturnFormat result = await APIServices()
        .addUserSubscription(subscriptionParams, paymentMethod);

    UserSingleton.instance.user.user?.hasPremiumSubscription = true;
    setState(() {
      hasPremiumSubscription = true;
    });
  }
}
