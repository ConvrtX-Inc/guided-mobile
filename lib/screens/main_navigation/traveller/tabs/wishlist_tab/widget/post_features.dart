// ignore_for_file: no_default_cases

import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/package_destination_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/golden_badge.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/screens/widgets/reusable_widgets/white_border.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widget for home features
class PostFeatures extends StatefulWidget {
  /// Constructor
  const PostFeatures({
    String id = '',
    String mainBadgeId = '',
    String subBadgeId = '',
    String description = '',
    String services = '',
    String country = '',
    String address = '',
    String extraCost = '',
    String name = '',
    String imageUrl = '',
    int numberOfTouristMin = 0,
    int numberOfTourist = 0,
    String starRating = '',
    double fee = 0.0,
    String dateRange = '',
    bool isPublished = false,
    String firebaseCoverImg = '',
    String notIncluded = '',
    String fullName = '',
    String firebaseProfImg = '',
    bool? isFirstAid = false,
    Key? key,
  })  : _id = id,
        _mainBadgeId = mainBadgeId,
        _subBadgeId = subBadgeId,
        _description = description,
        _services = services,
        _country = country,
        _address = address,
        _extraCost = extraCost,
        _name = name,
        _imageUrl = imageUrl,
        _numberOfTouristMin = numberOfTouristMin,
        _numberOfTourist = numberOfTourist,
        _fee = fee,
        _starRating = starRating,
        _dateRange = dateRange,
        _isPublished = isPublished,
        _firebaseCoverImg = firebaseCoverImg,
        _notIncluded = notIncluded,
        _fullName = fullName,
        _firebaseProfImg = firebaseProfImg,
        _isFirstAid = isFirstAid,
        super(key: key);
  final String _id;
  final String _mainBadgeId;
  final String _subBadgeId;
  final String _description;
  final String _services;
  final String _country;
  final String _address;
  final String _extraCost;
  final String _name;
  final String _imageUrl;
  final int _numberOfTouristMin;
  final int _numberOfTourist;
  final String _starRating;
  final double _fee;
  final String _dateRange;
  final bool _isPublished;
  final String _firebaseCoverImg;
  final String _notIncluded;
  final String _fullName;
  final String _firebaseProfImg;
  final bool? _isFirstAid;

  @override
  State<PostFeatures> createState() => _PostFeaturesState();
}

class _PostFeaturesState extends State<PostFeatures>
    with AutomaticKeepAliveClientMixin<PostFeatures> {
  @override
  bool get wantKeepAlive => true;
  bool isDateRangeClicked = false;
  late List<String> splitSubActivitiesId;
  late List<String> splitAddress;
  List<String> splitId = [];
  List<DateTime> splitAvailabilityDate = [];
  int slots = 0;
  String dateStart = '';
  String dateEnd = '';
  DateTime now = DateTime.now();
  String address = '';
  String latitude = '';
  String longitude = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget._isPublished
        ? GestureDetector(
            onTap: navigatePackageDetails,
            child: Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                height: 200,
                width: 190,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: navigatePackageDetails,
                        child: ExtendedImage.network(
                          widget._firebaseCoverImg,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                        ),
                      ),
                    )),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {},
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
                          GestureDetector(
                            onTap: navigatePackageDetails,
                            child: Container(
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
                                                        .allMatches(
                                                            widget._name)
                                                        .length >
                                                    5
                                                ? 8.sp
                                                : 12.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<BadgeModelData>(
                      future:
                          APIServices().getBadgesModelById(widget._mainBadgeId),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          final BadgeModelData badgeData = snapshot.data;
                          final int length = badgeData.badgeDetails.length;
                          return Positioned(
                            left: 10,
                            bottom: 60,
                            child: WhiteBorderBadge(
                              base64Image: badgeData.badgeDetails[0].imgIcon,
                            ),
                          );
                        }
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Positioned(
                            left: 10,
                            bottom: 60,
                            child: SkeletonText(
                              width: 30,
                              height: 30,
                              shape: BoxShape.circle,
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    FutureBuilder<PackageDestinationModelData>(
                      future:
                          APIServices().getPackageDestinationData(widget._id),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        Widget _displayWidget;
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            _displayWidget = Container();
                            break;
                          default:
                            if (snapshot.hasError) {
                              _displayWidget = Container();
                            } else {
                              _displayWidget = Container();
                              PackageDestinationModelData
                                  packageDestinationData = snapshot.data!;

                              address = packageDestinationData
                                  .packageDestinationDetails[0].name;
                              latitude = packageDestinationData
                                  .packageDestinationDetails[0].latitude;
                              longitude = packageDestinationData
                                  .packageDestinationDetails[0].longitude;
                            }
                        }
                        return _displayWidget;
                      },
                    )
                  ],
                )),
          )
        : Container();
  }

  /// Navigate to Popular Guides Near You! View
  Future<void> navigatePackageDetails() async {
    final Map<String, dynamic> details = {
      'id': widget._id,
      'name': widget._fullName,
      'main_badge_id': widget._mainBadgeId,
      'description': widget._description,
      'image_url': widget._imageUrl,
      'number_of_tourist': widget._numberOfTourist,
      'star_rating': widget._starRating,
      'fee': widget._fee.toString(),
      'address': address,
      'package_id': widget._id,
      'profile_img': widget._firebaseProfImg,
      'package_name': widget._name,
      'is_first_aid': widget._isFirstAid,
      'firebase_cover_img': widget._firebaseCoverImg,
      'latitude': latitude,
      'longitude': longitude
    };

    await Navigator.pushNamed(context, '/popular_guides_view',
        arguments: details);
  }
}
