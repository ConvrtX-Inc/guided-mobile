// ignore_for_file: unused_local_variable, unrelated_type_equality_checks

import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/activity_availability_hours_model.dart';
import 'package:guided/models/activity_availability_model.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widget for home features
class PackageFeatures extends StatefulWidget {
  /// Constructor
  const PackageFeatures({
    String id = '',
    String name = '',
    String mainBadgeId = '',
    String subBadgeId = '',
    String description = '',
    String imageUrl = '',
    int numberOfTouristMin = 0,
    int numberOfTourist = 0,
    double starRating = 5.0,
    double fee = 0.0,
    String dateRange = '',
    String services = '',
    String address = '',
    String extraCost = '',
    String country = '',
    bool isPublished = false,
    String firebaseCoverImg = '',
    String notIncluded = '',
    Key? key,
  })  : _id = id,
        _name = name,
        _mainBadgeId = mainBadgeId,
        _subBadgeId = subBadgeId,
        _description = description,
        _imageUrl = imageUrl,
        _numberOfTouristMin = numberOfTouristMin,
        _numberOfTourist = numberOfTourist,
        _fee = fee,
        _starRating = starRating,
        _dateRange = dateRange,
        _services = services,
        _address = address,
        _extraCost = extraCost,
        _country = country,
        _isPublished = isPublished,
        _firebaseCoverImg = firebaseCoverImg,
        _notIncluded = notIncluded,
        super(key: key);

  final String _id;
  final String _name;
  final String _mainBadgeId;
  final String _subBadgeId;
  final String _description;
  final String _imageUrl;
  final int _numberOfTouristMin;
  final int _numberOfTourist;
  final double _starRating;
  final double _fee;
  final String _dateRange;
  final String _services;
  final String _address;
  final String _extraCost;
  final String _country;
  final bool _isPublished;
  final String _firebaseCoverImg;
  final String _notIncluded;

  @override
  State<PackageFeatures> createState() => _PackageFeaturesState();
}

class _PackageFeaturesState extends State<PackageFeatures> {
  bool isDateRangeClicked = false;
  late List<String> splitSubActivitiesId;
  late List<String> splitAddress;
  List<String> splitId = [];
  List<DateTime> splitAvailabilityDate = [];
  int slots = 0;
  String dateStart = '';
  String dateEnd = '';
  DateTime now = DateTime.now();
  dynamic subActivities1;
  dynamic subActivities2;
  dynamic subActivities3;
  int count = 0;
  @override
  void initState() {
    super.initState();
    splitSubActivitiesId = widget._subBadgeId.split(',');
    splitAddress = widget._address.split(',');
    count = splitSubActivitiesId.length;
    getActivityAvailability(widget._id);
  }

  Future<void> getActivityAvailability(String activityPackageId) async {
    List<String> dateList = [];
    List<String> dayList = [];
    List<String> monthList = [];
    int tempInt;
    DateTime month = DateTime.now();
    final List<ActivityAvailability> resForm =
        await APIServices().getActivityAvailability(activityPackageId);
    if (resForm.isNotEmpty) {
      final List<ActivityAvailabilityHour> resForm1 =
          await APIServices().getActivityAvailabilityHour(resForm[0].id);
      slots = resForm1[0].slots;
    }
    for (int index = 0; index < resForm.length; index++) {
      splitId.add(resForm[index].id);
      splitAvailabilityDate
          .add(DateTime.parse(resForm[index].availability_date));

      dateList = resForm[index].availability_date.split('-');
      if (dateList[1] == month.month.toString().padLeft(2, '0')) {
        tempInt = int.parse(dateList[2]) - DateTime.now().day;
        if (tempInt >= 0) {
          dayList.add(dateList[2]);
        }
      }
    }

    if (dayList.isNotEmpty) {
      dayList.sort((a, b) => a.compareTo(b));
      setState(() {
        dateStart = dayList[0];
        dateEnd = dayList[dayList.length - 1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget._isPublished
        ? Container(
            margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
            height: 200,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: GestureDetector(
                  onTap: () {
                    navigatePackageDetails(context);
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ExtendedImage.network(
                        widget._firebaseCoverImg,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      )),
                )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        navigatePackageDetails(context);
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: <Color>[
                                  Colors.black.withOpacity(0.5),
                                  Colors.transparent
                                ])),
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget._name,
                                  style: TextStyle(
                                      fontSize: RegExp(r"\w+(\'\w+)?")
                                                  .allMatches(widget._name)
                                                  .length >
                                              5
                                          ? 10.sp
                                          : 14.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                '${widget._numberOfTouristMin} - ${widget._numberOfTourist} Traveller',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.star_rate, size: 18),
                              Expanded(
                                child: Text(
                                  widget._starRating.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Text(
                                '\$${widget._fee}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<BadgeModelData>(
                  future: APIServices().getBadgesModelById(widget._mainBadgeId),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      final BadgeModelData badgeData = snapshot.data;
                      final int length = badgeData.badgeDetails.length;
                      return Positioned(
                        left: 10,
                        bottom: 90,
                        child: Row(
                          children: <Widget>[
                            Image.memory(
                              base64.decode(badgeData.badgeDetails[0].imgIcon
                                  .split(',')
                                  .last),
                              gaplessPlayback: true,
                            )
                          ],
                        ),
                      );
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Positioned(
                        left: 10,
                        bottom: 90,
                        child: SkeletonText(
                          height: 30,
                          width: 30,
                          radius: 10,
                          shape: BoxShape.circle,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                Positioned(
                  top: 10,
                  right: 0,
                  child: Row(
                    children: <Widget>[
                      if (dateStart.isEmpty && dateEnd.isEmpty)
                        Container()
                      else
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isDateRangeClicked) {
                                setState(() {
                                  isDateRangeClicked = false;
                                });
                              } else {
                                isDateRangeClicked = true;
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.duckEggBlue,
                              border: Border.all(
                                color: AppColors.duckEggBlue,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: dateStart == dateEnd
                                ? Row(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        AssetsPath.homeFeatureCalendarIcon,
                                        height: 15,
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        dateStart,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.tropicalRainForest,
                                            fontSize: 12),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        AssetsPath.homeFeatureCalendarIcon,
                                        height: 15,
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '$dateStart-$dateEnd',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.tropicalRainForest,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      SizedBox(
                        width: 50,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            navigateEditPackageDetails(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.grey, // <-- Splash color
                          ),
                          child: Icon(Icons.edit,
                              size: 15, color: AppColors.tropicalRainForest),
                        ),
                      )
                    ],
                  ),
                ),
                if (isDateRangeClicked)
                  Positioned(
                    top: 50,
                    right: 20,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            navigateEditAvailability(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              children: const <Widget>[
                                Text(
                                  'Edit Availability',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(),
                for (int i = 0; i < splitSubActivitiesId.length; i++)
                  FutureBuilder<BadgeModelData>(
                    future: APIServices()
                        .getBadgesModelById(splitSubActivitiesId[i]),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        final BadgeModelData badgeData = snapshot.data;
                        final int length = badgeData.badgeDetails.length;
                        final BadgeDetailsModel badgeDetails =
                            badgeData.badgeDetails[0];
                        switch (i) {
                          case 0:
                            subActivities1 = badgeDetails;
                            break;
                          case 1:
                            subActivities2 = badgeDetails;
                            break;
                          case 2:
                            subActivities3 = badgeDetails;
                            break;
                        }
                      }
                      return Container();
                    },
                  )
              ],
            ))
        : Container();
  }

  /// Navigate to Advertisement View
  Future<void> navigatePackageDetails(BuildContext context) async {
    final Map<String, dynamic> details = {
      'id': widget._id,
      'name': widget._name,
      'main_badge_id': widget._mainBadgeId,
      'sub_badge_id': splitSubActivitiesId,
      'description': widget._description,
      'image_url': widget._firebaseCoverImg,
      'number_of_tourist_min': widget._numberOfTouristMin,
      'number_of_tourist': widget._numberOfTourist,
      'star_rating': widget._starRating,
      'fee': widget._fee,
      'date_range': widget._dateRange,
      'services': widget._services,
      'address': splitAddress,
      'country': widget._country,
      'extra_cost': widget._extraCost,
      'not_included': widget._notIncluded,
      'sub_activity_1': subActivities1,
      'sub_activity_2': subActivities2,
      'sub_activity_3': subActivities3,
      'count': count
    };

    await Navigator.pushNamed(context, '/package_view', arguments: details);
  }

  /// Navigate to Advertisement Edit
  Future<void> navigateEditPackageDetails(BuildContext context) async {
    final Map<String, dynamic> details = {
      'id': widget._id,
      'name': widget._name,
      'main_badge_id': widget._mainBadgeId,
      'sub_badge_id': splitSubActivitiesId,
      'description': widget._description,
      'image_url': widget._firebaseCoverImg,
      'number_of_tourist_min': widget._numberOfTouristMin,
      'number_of_tourist': widget._numberOfTourist,
      'star_rating': widget._starRating,
      'fee': widget._fee,
      'date_range': widget._dateRange,
      'services': widget._services,
      'address': splitAddress,
      'country': widget._country,
      'extra_cost': widget._extraCost,
      'not_included': widget._notIncluded,
      'sub_activity_1': subActivities1,
      'sub_activity_2': subActivities2,
      'sub_activity_3': subActivities3,
      'count': count
    };

    await Navigator.pushNamed(context, '/package_edit', arguments: details);
  }

  Future<void> navigateEditAvailability(BuildContext context) async {
    final Map<String, dynamic> details = {
      'id': splitId,
      'availability_date': splitAvailabilityDate,
      'count': splitAvailabilityDate.length,
      'package_id': widget._id,
      'number_of_tourist': widget._numberOfTourist,
      'slots': slots
    };

    await Navigator.pushNamed(context, '/calendar_availability',
        arguments: details);
  }
}
