// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/event_image_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widget for home features
class EventFeatures extends StatefulWidget {
  /// Constructor
  const EventFeatures({
    String id = '',
    String name = '',
    String badgeId = '',
    String description = '',
    double starRating = 0.0,
    double fee = 0.0,
    String mainActivity = '',
    String dateRange = '',
    String country = '',
    String address = '',
    String subactivities = '',
    String services = '',
    String eventDate = '',
    String path = '',
    String dateFormat = '',
    bool isPublished = false,
    Key? key,
  })  : _id = id,
        _name = name,
        _badgeId = badgeId,
        _description = description,
        _fee = fee,
        _starRating = starRating,
        _mainActivity = mainActivity,
        _dateRange = dateRange,
        _country = country,
        _address = address,
        _subactivities = subactivities,
        _services = services,
        _eventDate = eventDate,
        _path = path,
        _dateFormat = dateFormat,
        _isPublished = isPublished,
        super(key: key);

  final String _id;
  final String _name;
  final String _badgeId;
  final String _description;
  final double _starRating;
  final double _fee;
  final String _mainActivity;
  final String _dateRange;
  final String _country;
  final String _address;
  final String _subactivities;
  final String _services;
  final String _eventDate;
  final String _path;
  final String _dateFormat;
  final bool _isPublished;

  @override
  State<EventFeatures> createState() => _EventFeaturesState();
}

class _EventFeaturesState extends State<EventFeatures> {
  late List<String> splitAddress;
  late List<String> splitSubActivities;
  late List<String> splitServices;
  @override
  void initState() {
    super.initState();
    splitAddress = widget._address.split(',');
    splitSubActivities = widget._subactivities.split(',');
    splitServices = widget._services.split(',');
  }

  @override
  Widget build(BuildContext context) {
    return widget._isPublished
        ? Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder<EventImageModelData>(
                  future: APIServices().getEventImageData(widget._id),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    Widget _displayWidget = Container();

                    late EventImageModelData eventImage;

                    if (!snapshot.hasData) {
                      return _displayWidget = Container();
                    } else if (snapshot.hasData) {
                      eventImage = snapshot.data;
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    for (EventImageDetailsModel imageDetails
                        in eventImage.eventImageDetails) {
                      return GestureDetector(
                        onTap: () => navigateEventDetails(
                            context, imageDetails.snapshotImg),
                        child: Stack(
                          children: <Widget>[
                            ListTile(
                              title: imageDetails.activityEventId != null
                                  ? SizedBox(
                                      height: 200.h,
                                      child: Image.memory(
                                        base64.decode(
                                          imageDetails.snapshotImg
                                              .split(',')
                                              .last,
                                        ),
                                        fit: BoxFit.cover,
                                        gaplessPlayback: true,
                                      ),
                                    )
                                  : Container(
                                      height: 10.h,
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                    ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      widget._name,
                                      style: AppTextStyle.blackStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: <Widget>[
                                        const Icon(Icons.star_rate, size: 18),
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                widget._starRating.toString(),
                                                style: TextStyle(
                                                    color: HexColor('#181B1B'),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              const Text(
                                                '(67)',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '\$${widget._fee.toString().substring(0, widget._fee.toString().indexOf('.'))}',
                                          style: TextStyle(
                                              color: HexColor('#181B1B'),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FutureBuilder<BadgeModelData>(
                              future: APIServices()
                                  .getBadgesModelById(widget._badgeId),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  final BadgeModelData badgeData =
                                      snapshot.data;
                                  final int length =
                                      badgeData.badgeDetails.length;
                                  return Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 150.h,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          Image.memory(
                                            base64.decode(badgeData
                                                .badgeDetails[0].imgIcon
                                                .split(',')
                                                .last),
                                            gaplessPlayback: true,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 150.h,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          const CircularProgressIndicator()
                                        ],
                                      ),
                                    ],
                                  );
                                }
                                return Container();
                              },
                            ),
                            Positioned(
                              top: 10,
                              right: 15,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.duckEggBlue,
                                      border: Border.all(
                                        color: AppColors.duckEggBlue,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Row(
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
                                          widget._dateRange,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  AppColors.tropicalRainForest,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        primary:
                                            Colors.white, // <-- Button color
                                        onPrimary:
                                            Colors.grey, // <-- Splash color
                                      ),
                                      child: Icon(Icons.edit,
                                          size: 15,
                                          color: AppColors.tropicalRainForest),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return _displayWidget = Container();
                  },
                ),
              ],
            ),
          )
        : Container();
  }

  /// Navigate to Advertisement View
  Future<void> navigateEventDetails(
      BuildContext context, String snapshotImg) async {
    final Map<String, dynamic> details = {
      'id': widget._id,
      'title': widget._name,
      'badge_id': widget._badgeId,
      'description': widget._description,
      'main_activity': widget._mainActivity,
      'sub_activity': splitSubActivities,
      'services': splitServices,
      'country': widget._country,
      'street': splitAddress[0],
      'city': splitAddress[1],
      'province': splitAddress[2],
      'zip_code': splitAddress[3],
      'event_date': widget._eventDate,
      'price': widget._fee,
      'star_rating': widget._starRating,
      'path': widget._path,
      'date_format': widget._dateFormat,
      'snapshot_img': snapshotImg
    };

    await Navigator.pushNamed(context, '/event_view', arguments: details);
  }
}
