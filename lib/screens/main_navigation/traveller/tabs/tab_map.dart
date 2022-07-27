// ignore_for_file: public_member_api_docs, use_named_constants

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:collection/collection.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:guided/common/widgets/custom_date_range_picker.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/activity_availability_hours.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/available_date_model.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:guided/screens/payments/confirm_payment.dart';
import 'package:guided/screens/payments/payment_failed.dart';
import 'package:guided/screens/payments/payment_method.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/screens/widgets/reusable_widgets/activity_package_basic_info.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_bottom_sheet.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_payment_details.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/utils/map_utils.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/geolocation_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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

  // final List<Activity> tourList = StaticDataService.getTourList();
  bool hideActivities = false;
  bool showBottomScroll = false;
  double activitiesContainer = 70;
  bool _isloading = true;
  List<int> _selectedActivity = [];
  late LatLng currentMapLatLong = LatLng(53.59, -113.60);
  List<ActivityPackage> _loadingData = [];
  List<ActivityPackage> _filteredActivity = [];
  final CardController _creditCardController = Get.put(CardController());
  final UserSubscriptionController _userSubscriptionController =
      Get.put(UserSubscriptionController());
  TextEditingController _searchController = TextEditingController();

  Activity selectedActivityFilter = Activity();

  DetailsResponse _selectedPlace = DetailsResponse();

  String startDate = '';

  String endDate = '';

  final List<AvailableDateModel> dates = AppListConstants().availableDates;

  int currentMonthScrollIndex = 0;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      mapController = controller;
    });
  }

  bool hasPremiumSubscription = false;
  ActivityPackage selectedPackage = ActivityPackage();

  bool showSelectedPackage = false;

  List<DateTime> activityAvailableDates = [];

  String currentAddress = '';

  final int currentMonth = DateTime.now().month;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    hasPremiumSubscription =
        UserSingleton.instance.user.user!.hasPremiumSubscription!;

    getCurrentAddress();
    getActivityPackages();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> getActivityPackages() async {
    final List<ActivityPackage> res = await APIServices().getActivityPackages();

    await addMarker(res);

    setState(() {
      _loadingData = res;
      _isloading = false;
    });
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
              onTap: () {
                debugPrint('Activity ${element.name}');

                activityAvailableDates.clear();

                if (showBottomScroll) {
                  setState(() {
                    showBottomScroll = false;
                  });
                }

                setState(() {
                  selectedPackage = element;
                  showSelectedPackage = true;
                });

                getActivityAvailableDates();
              },
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
    /* mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 17)
        //17 is new zoom level
        ));*/

    setState(() {
      // currentMapLatLong = LatLng(lat, long);

      _markers.addAll(marks);
    });
  }

  Future<void> goToPlace(DetailsResponse result) async {
    await mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(result.result!.geometry!.location!.lat!,
                result.result!.geometry!.location!.lng!),
            zoom: 5)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 23,
        backgroundColor: Colors.white,
        onPressed: () async {
          /* final Position location = await _userCurrentPosition();
          await mapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(location.latitude, location.longitude),
                  zoom: 17)
              //17 is new zoom level
              ));*/
          await getCurrentAddress();
        },
        child: const Icon(
          Icons.my_location,
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: buildMapTabUI(),
      ),
    );
  }

  Widget buildMapTabUI() => Stack(
        children: <Widget>[
          SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
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
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(const Radius.circular(10)),
              color: HexColor('#F8F7F6'),
            ),
            height: hideActivities
                ? MediaQuery.of(context).size.height * 0.24
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
                    buildSearchbar()
                  ],
                ),
                buildCurrentLocationDetails(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // height: activitiesContainer,
                  child: hideActivities
                      ? Container(margin: EdgeInsets.only(top: 20.h))
                      : Container(
                          margin: EdgeInsets.only(top: 40.h),
                          child: overlapped(activities),
                        ),
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
          buildFilteredActivities(),
          if (_isloading)
            Align(child: CircularProgressIndicator(color: AppColors.deepGreen)),
          if (showSelectedPackage)
            Positioned(
                bottom: 68,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ActivityPackageBasicInfo(
                    activityPackage: selectedPackage,
                    activityAvailableDates: activityAvailableDates,
                    onCloseButtonPressed: () {
                      setState(() {
                        showSelectedPackage = false;
                        selectedPackage = ActivityPackage();
                      });
                    },
                  ),
                ))
        ],
      );

  //FILTERED ACTIVITIES / SUGGESTIONS
  Widget buildFilteredActivities() => Positioned(
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
                    showBottomScroll ? Icons.expand_more : Icons.expand_less,
                    color: HexColor('#979B9B'),
                    size: 30,
                  ),
                ),
                if (showBottomScroll)
                  Expanded(
                    child: ListView(
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: List<Widget>.generate(_filteredActivity.length,
                          (int i) {
                        // final Activity? icon = activities.firstWhereOrNull(
                        //     (Activity element) =>
                        //         element.id == _filteredActivity[i].mainBadgeId);
                        // // final ActivityPackage? enable = _filteredActivity
                        // //     .firstWhereOrNull((ActivityPackage element) =>
                        // //         element.id == _loadingData[i].id);
                        // if (icon != null) {
                        //
                        // } else {
                        //   return Container();
                        // }
                        return InkWell(
                            onTap: () {
                              // Navigator.of(context)
                              //     .pushNamed('/discovery_map');
                              if (!hasPremiumSubscription &&
                                  PaymentConfig.isPaymentEnabled &&
                                  _filteredActivity[i].premiumUser!) {
                                _showDiscoveryBottomSheet(
                                    _filteredActivity[i].firebaseCoverImg!);
                              } else {
                                Navigator.of(context).pushNamed(
                                    '/activity_package_info',
                                    arguments: _filteredActivity[i]);
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          image: NetworkImage(
                                            _filteredActivity[i]
                                                .firebaseCoverImg!,
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 5,
                                          bottom: 5,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 12,
                                            backgroundImage: AssetImage(
                                                selectedActivityFilter.path),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }),
                    ),
                  )
                else
                  Container()
              ],
            )),
      );

  // GET CURRENT ADDRESS / LOCATION
  Future<void> getCurrentAddress() async {
    final Position coordinates = await GeoLocationServices().getCoordinates();
    final String address = await GeoLocationServices()
        .getAddressFromCoordinates(coordinates.latitude, coordinates.longitude);
    setState(() {
      currentAddress = address;
      currentMapLatLong = LatLng(coordinates.latitude, coordinates.longitude);
    });

    await mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentMapLatLong, zoom: 17)
        //17 is new zoom level
        ));
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

  void filterActivities(Activity activity) {
    debugPrint('Activity Selected: ${activity.name}');
    _markers.clear();
    setState(() {
      _filteredActivity = _loadingData
          .where((ActivityPackage element) =>
              element.mainBadge!.badgeName!.toLowerCase() ==
              activity.name.toLowerCase())
          .toList();
      selectedActivityFilter = activity;
    });
    if (_filteredActivity.isNotEmpty) {
      addMarker(_filteredActivity);
      debugPrint('Filtered ${_filteredActivity.length}');

      if (_searchController.text.isEmpty) {
        Future.delayed(
            Duration(milliseconds: 200),
            () =>
            mapController?.moveCamera(CameraUpdate.newLatLngBounds(
                  MapUtils.boundsFromLatLngList(_filteredActivity.map((e) => LatLng(
                      double.parse(e
                          .activityPackageDestination!.activityPackageDestinationLatitude!),double.parse(e
                      .activityPackageDestination!.activityPackageDestinationLongitude!)



                  )).toList()),
                  4.0,
                ),
                )


                /*mapController?.moveCamera(CameraUpdate.newLatLngBounds(
                MapUtils.boundsFromLatLngList(
                    _markers.map((loc) => loc.position).toList()),
                1))*/



        );
      }
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
              filterActivities(activities[i]);

              // setState(() {
              //   selectedActivityFilter = activities[i];
              // });

              /*   final List<ActivityPackage> filteredActivity = _loadingData
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
              }*/
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
                        color: selectedActivityFilter.name == activities[i].name
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
                      child: selectedActivityFilter.name == activities[i].name
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
              filterActivities(activities[i]);
              /*  final List<ActivityPackage> filteredActivity = _loadingData
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
              }*/
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
                        color: selectedActivityFilter.name == activities[i].name
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
                    child: selectedActivityFilter.name == activities[i].name
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

  //SEARCH BAR WIDGET
  Widget buildSearchbar() => Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.w, 0.h, 15.w, 0.h),
          child: TextField(
            readOnly: true,
            textInputAction: TextInputAction.search,
            onSubmitted: (String search) {
              if (search.isNotEmpty) {
                APIServices()
                    .searchActivity(search)
                    .then((List<ActivityPackage> value) {
                  final ActivityPackage? activity = value.firstOrNull;

                  if (activity != null) {
                    addMarker(value);
                    double lat = double.parse(activity
                        .activityPackageDestination!
                        .activityPackageDestinationLatitude!);
                    double long = double.parse(activity
                        .activityPackageDestination!
                        .activityPackageDestinationLongitude!);
                    mapController?.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: LatLng(lat, long), zoom: 17)
                        //17 is new zoom level
                        ));
                  }
                });
              }
            },
            onTap: () async {
              final dynamic result =
                  await Navigator.of(context).pushNamed('/search_place');

              if (result != null && result is DetailsResponse) {
                setState(() {
                  _searchController = TextEditingController(
                      text: result.result!.formattedAddress);
                  _selectedPlace = result;
                });
                await goToPlace(result);
              }
            },
            controller: _searchController,
            textAlign: TextAlign.left,
            style: TextStyle(overflow: TextOverflow.ellipsis),
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
              contentPadding: EdgeInsets.zero,
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
      );

  // CURRENT LOCATION
  Widget buildCurrentLocationDetails() => Row(
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
                        image: AssetImage('assets/images/png/marker.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      currentAddress,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  )
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

  // DISCOVERY BOTTOM SHEET
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
    String actionType = 'add';
    final DateTime startDate = DateTime.now();

    final DateTime endDate = GlobalMixin().getEndDate(startDate);

    UserSubscription subscriptionParams = UserSubscription(
        paymentReferenceNo: transactionNumber,
        name: subscriptionName,
        startDate: startDate.toString(),
        endDate: endDate.toString(),
        price: price);

    if (_userSubscriptionController.userSubscription.id.isNotEmpty) {
      subscriptionParams.id = _userSubscriptionController.userSubscription.id;
      actionType = 'update';
    }

    final APIStandardReturnFormat result = await APIServices()
        .addUserSubscription(subscriptionParams, paymentMethod, actionType);

    final jsonData = jsonDecode(result.successResponse);

    debugPrint('jsonData $jsonData');
    _userSubscriptionController
        .setSubscription(UserSubscription.fromJson(jsonData));

    UserSingleton.instance.user.user?.hasPremiumSubscription = true;
    setState(() {
      hasPremiumSubscription = true;
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

  Future<void> getActivityAvailableDates() async {
    final DateTime currentDate = DateTime.now();

    final List<ActivityHourAvailability> data = await APIServices()
        .getActivityHours(
            DateTime.now().toString(),
            DateTime(currentDate.year, currentDate.month + 1, 0).toString(),
            selectedPackage.id!);

    if (data.isNotEmpty) {
      data.forEach((element) {
        setState(() {
          final DateTime _date = DateTime.parse(element.availabilityDate!);
          if (_date.month == DateTime.now().month) {
            activityAvailableDates.add(_date);
          }
        });
      });
    }
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
            String _startDate = '';
            String _endDate = '';
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

                      updateState(() {
                        startDate = args.value.startDate.toString();
                        endDate = args.value.startDate.toString();
                        _startDate = args.value.startDate.toString();
                        _endDate = args.value.startDate.toString();
                      });
                    },
                    onSubmitted: startDate.isNotEmpty && endDate.isNotEmpty
                        ? () {
                            Navigator.of(context).pop();
                            getPackagesByDateRange();
                          }
                        : null,
                  ),
                  /* Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            if(currentMonthScrollIndex > 0){
                              setState(() {
                                currentMonthScrollIndex --;
                              });
                            }
                            _scrollController.easyScrollToIndex(index: currentMonthScrollIndex);
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            color: HexColor('#898A8D'),
                          )),
                      Container(
                          color: Colors.transparent,
                          height: 80.h,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: EasyScrollToIndex(
                            controller: _scrollController,
                            // ScrollToIndexController
                            scrollDirection: Axis.horizontal,
                            // default Axis.vertical
                            itemCount: dates.length,
                            // itemCount
                            itemWidth: 95,
                            itemHeight: 70,
                            itemBuilder: (BuildContext context, int index) {
                              return dates[index].month >= currentMonth
                                  ? InkWell(
                                      onTap: () {
                                        updateState(() {
                                          selectedDate = DateTime(
                                              selectedDate.year,
                                              dates[index].month);
                                          // _selectedDate =  DateTime(selectedDate.year, dates[index].month);
                                        });

                                        debugPrint(
                                            'Select Month ${selectedDate.toString()}');
                                      },
                                      child: Stack(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  index == 0 ? 0.w : 0.w,
                                                  0.h,
                                                  10.w,
                                                  0.h),
                                              width: 89,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  border: Border.all(
                                                      color: dates[index]
                                                                  .month ==
                                                              selectedDate.month
                                                          ? HexColor('#FFC74A')
                                                          : HexColor('#C4C4C4'),
                                                      width: 1),
                                                  color: dates[index].month ==
                                                          selectedDate.month
                                                      ? HexColor('#FFC74A')
                                                      : Colors.white),
                                              child: Center(
                                                  child: Text(
                                                      dates[index].monthName)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container();
                            },
                          )),

                      IconButton(
                          onPressed: () {
                            if(currentMonthScrollIndex < dates.length){
                              setState(() {
                                currentMonthScrollIndex ++;
                              });
                            }
                            _scrollController.easyScrollToIndex(index: currentMonthScrollIndex);
                          },
                          icon: Icon(
                            Icons.chevron_right,
                            color: HexColor('#898A8D'),
                          )),
                    ],
                  ),
                  SfDateRangePicker(
                    enablePastDates: false,
                    minDate: selectedDate,
                    maxDate: Indate.DateUtils.lastDayOfMonth(selectedDate),
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) {
                      if (args.value.startDate != null &&
                          args.value.endDate != null) {
                        debugPrint('Start Date ${args.value.startDate}');
                        debugPrint('End Date ${args.value}');

                        updateState(() {
                          startDate = args.value.startDate.toString();
                          endDate = args.value.startDate.toString();
                          _startDate = args.value.startDate.toString();
                          _endDate = args.value.startDate.toString();
                        });
                      }
                    },
                    selectionMode: DateRangePickerSelectionMode.range,
                    navigationMode: DateRangePickerNavigationMode.none,
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                      dayFormat: 'E',
                    ),
                    headerHeight: 0,
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      textStyle: TextStyle(color: HexColor('#3E4242')),
                      todayTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HexColor('#3E4242')),
                    ),
                    selectionShape: DateRangePickerSelectionShape.circle,
                    selectionTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    rangeSelectionColor: HexColor('#FFF2CE'),
                    todayHighlightColor: HexColor('#FFC74A'),
                    startRangeSelectionColor: HexColor('#FFC31A'),
                    endRangeSelectionColor: HexColor('#FFC31A'),
                  ),
                  SizedBox(
                    width: 153.w,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: _startDate.isNotEmpty && _endDate.isNotEmpty ? () {
                        Navigator.of(context).pop();
                        getPackagesByDateRange();
                      } : null,
                      style: AppTextStyle.activeGreen,
                      child: const Text(
                        'Set Filter Date',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),*/
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

  Future<void> getPackagesByDateRange() async {
    final List<ActivityPackage> res =
        await APIServices().getActivityByDateRange(startDate, endDate);

    if (res.isNotEmpty) {
      _markers.clear();
      await addMarker(res);

      setState(() {
        selectedDate = DateTime.now();
        startDate = '';
        endDate = '';
      });

      Future.delayed(
          Duration(milliseconds: 200),
          () => mapController?.animateCamera(CameraUpdate.newLatLngBounds(
              MapUtils.boundsFromLatLngList(
                  _markers.map((loc) => loc.position).toList()),
              1)));
    }
  }
}
