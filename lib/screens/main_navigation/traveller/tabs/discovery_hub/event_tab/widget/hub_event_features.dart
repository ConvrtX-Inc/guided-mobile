// ignore_for_file: unnecessary_null_comparison, unused_local_variable, prefer_final_in_for_each, no_default_cases

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activity_event_destination_image_model.dart';
import 'package:guided/models/activity_event_destination_model.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/event_image_model.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/event_tab/widget/hub_event_slider_images.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Widget for home features
class HubEventFeatures extends StatefulWidget {
  /// Constructor
  const HubEventFeatures({
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
  State<HubEventFeatures> createState() => _HubEventFeaturesState();
}

class _HubEventFeaturesState extends State<HubEventFeatures> {
  late List<String> splitAddress;
  late List<String> splitSubActivities;
  late List<String> splitServices;
  bool isDateRangeClicked = false;
  late List<String> imageList;
  late List<String> imageIdList;
  late List<String> imageId;
  int activeIndex = 0;
  int imageCount = 0;
  @override
  void initState() {
    super.initState();
    splitAddress = widget._address.split(',');
    splitSubActivities = widget._subactivities.split(',');
    splitServices = widget._services.split(',');
    imageList = [];
    imageIdList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder<ActivityEventDestination>(
            future: APIServices().getEventDestinationDetails(widget._id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget _displayWidget;
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  _displayWidget = const MainContentSkeleton();
                  break;
                default:
                  if (snapshot.hasError) {
                    _displayWidget = Center(
                        child: APIMessageDisplay(
                      message: 'Result: ${snapshot.error}',
                    ));
                  } else {
                    _displayWidget = buildResult(snapshot.data!);
                  }
              }
              return _displayWidget;
            },
          ),
        ],
      ),
    );
  }

  Widget buildResult(ActivityEventDestination outfitterData) =>
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (outfitterData.activityEventDestinationDetails.isEmpty)
              Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 3) - 40),
                child: APIMessageDisplay(
                  message: AppTextConstants.noResultFound,
                ),
              )
            else
              for (ActivityEventDestinationDetailsModel detail
                  in outfitterData.activityEventDestinationDetails)
                buildInfo(detail)
          ],
        ),
      );

  Widget buildInfo(ActivityEventDestinationDetailsModel details) =>
      HubEventSliderImages(
          id: details.id,
          title: widget._name,
          price: widget._fee,
          date: widget._dateFormat,
          description: widget._description);
}
