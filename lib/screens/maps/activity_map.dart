import 'dart:async';
import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:guided/common/widgets/custom_date_range_picker.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/activity_availability_hours.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/available_date_model.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/screens/widgets/reusable_widgets/activity_package_basic_info.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/utils/map_utils.dart';
import 'package:guided/utils/services/geolocation_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;

///Activity Find Map Screen
class ActivityFindMap extends StatefulWidget {
  ///Constructor
  const ActivityFindMap({this.params, Key? key}) : super(key: key);

  final dynamic params;

  @override
  _ActivityFindMapState createState() => _ActivityFindMapState();
}

class _ActivityFindMapState extends State<ActivityFindMap> {
  Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final travellerMonthController = Get.put(TravellerMonthController());
  final List<Guide> guides = StaticDataService.getGuideList();
  final PageController page_indicator_controller = PageController();

  GoogleMapController? mapController;

  DetailsResponse placeDetails = DetailsResponse();

  TextEditingController _searchController = TextEditingController();

  List<Activity> activities = StaticDataService.getActivityForNearybyGuides();

  Activity selectedActivityFilter = Activity();

  List<ActivityPackage> activityPackages = [];

  List<ActivityPackage> filteredActivityPackages = [];

  ActivityPackage selectedPackage = ActivityPackage();

  bool showSelectedPackage = false;

  List<DateTime> activityAvailableDates = [];

  String startDate = '';

  String endDate = '';

  final List<AvailableDateModel> dates = AppListConstants().availableDates;

  final int currentMonth = DateTime.now().month;

  DateTime selectedDate = DateTime.now();

  double lat = 0;

  double lng = 0;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    setState(() {
      mapController = controller;
    });

    // debugPrint('Place Details::  ${placeDetails.result!.formattedAddress}');
  }

  @override
  void initState() {
    initializeDateFormatting('en', null);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        if (widget.params['placeDetails'] != '') {
          placeDetails = widget.params['placeDetails'];
        }
        activityPackages = widget.params['initialActivityPackages'];
        startDate = widget.params['startDate'];
        endDate = widget.params['endDate'];
      });

      // getCoordinates();
      addMarkers(activityPackages);

      if (startDate != '' &&
          endDate != '' &&
          widget.params['placeDetails'] == '') {
        getPackagesByDateRange();
      }
    });
    super.initState();
  }

  Future<void> getCoordinates() async {
    final Position coordinates = await GeoLocationServices().getCoordinates();
    setState(() {
      lat = coordinates.latitude;
      lng = coordinates.longitude;
    });
  }

  Future<void> addMarkers(List<ActivityPackage> activityPackages) async {
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

    setState(() {
      _markers.addAll(marks);
    });
  }

  void goToPlace() {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(placeDetails.result!.geometry!.location!.lat!,
            placeDetails.result!.geometry!.location!.lng!),
        zoom: 10)));
  }

  void filterActivities(Activity activity) {
    setState(() {
      _markers.clear();
      filteredActivityPackages = activityPackages
          .where((ActivityPackage element) =>
              element.mainBadge!.badgeName!.toLowerCase() ==
              activity.name.toLowerCase())
          .toList();
      selectedActivityFilter = activity;
    });
    if (filteredActivityPackages.isNotEmpty) {
      addMarkers(filteredActivityPackages);
      debugPrint(
          'Filtered ${filteredActivityPackages[0].mainBadge!.badgeName!}');
    }
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

  Future<void> getPackagesByDateRange() async {
    final List<ActivityPackage> res =
        await APIServices().getActivityByDateRange(startDate, endDate);

    if (res.isNotEmpty) {
      _markers.clear();
      await addMarkers(res);

      Future.delayed(
          Duration(milliseconds: 200),
          () => mapController?.animateCamera(CameraUpdate.newLatLngBounds(
              MapUtils.boundsFromLatLngList(
                  _markers.map((loc) => loc.position).toList()),
              1)));
    }
    setState(() {
      filteredActivityPackages = res;
      selectedDate = DateTime.now();
      startDate = '';
      endDate = '';
    });

    showActivitiesBottomSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: widget.params['placeDetails'] is DetailsResponse &&
                          placeDetails.result!.id != ''
                      ? LatLng(placeDetails.result!.geometry!.location!.lat!,
                          placeDetails.result!.geometry!.location!.lng!)
                      : LatLng(lat, lng),
                  zoom: 10,
                ),
                markers: Set<Marker>.of(_markers),
                onMapCreated: _onMapCreated,
              )),
        ),
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.w, 20.h, 15.w, 20.h),
              child: GestureDetector(
                onTap: showDatePickerBottomSheet,
                // onTap: showActivitiesBottomSheet,
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
                          image:
                              AssetImage('assets/images/png/calendar_icon.png'),
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
                  controller: _searchController,
                  readOnly: true,
                  onTap: () async {
                    final dynamic result =
                        await Navigator.of(context).pushNamed('/search_place');

                    if (result != null && result is DetailsResponse) {
                      debugPrint('Has Details');
                      setState(() {
                        placeDetails = result;
                        _searchController = TextEditingController(
                            text: placeDetails.result!.formattedAddress);
                      });
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(fontSize: 16.sp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.all(18),
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
                        onTap: goToPlace,
                        child: Container(
                          // margin: EdgeInsets.only(right: 10.w),
                          margin: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 6.w),
                          height: 32.h,
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
                      )),
                ),
              ),
            ),
          ],
        ),
        Positioned(top: 95, right: 0, left: 0, child: overlapped(activities)),
        if (showSelectedPackage)
          Positioned(
              bottom: 100,
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
              filterActivities(activities[i]);
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

                      updateState(() {
                        startDate = args.value.startDate.toString();
                        endDate = args.value.startDate.toString();
                      });
                    },
                    onSubmitted: startDate.isNotEmpty && endDate.isNotEmpty
                        ? () {
                            Navigator.of(context).pop();
                            getPackagesByDateRange();
                          }
                        : null,
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

  void showActivitiesBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // half screen on load
          maxChildSize: 1, // full screen on scroll
          minChildSize: 0.25,

          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    child: Align(
                      child: Image.asset(
                        AssetsPath.horizontalLine,
                        width: 60.w,
                        height: 5.h,
                      ),
                    ),
                  ),
                  if (filteredActivityPackages.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          '${filteredActivityPackages.length} nearby activities',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  Expanded(
                      child: filteredActivityPackages.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              controller: scrollController,
                              itemCount: filteredActivityPackages.length,
                              itemBuilder: (BuildContext context, int index) {
                                return buildActivityPackageListItem(
                                    filteredActivityPackages[index]);
                              },
                            )
                          : const Center(
                              child: Text('No Nearby Activities Found'),
                            ))
                ],
              ),
            );
          },
        );
      },
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
}
