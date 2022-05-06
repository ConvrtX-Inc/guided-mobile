// ignore_for_file: unnecessary_null_comparison, unused_local_variable, prefer_final_in_for_each, no_default_cases, diagnostic_describe_all_properties

import 'package:flutter/material.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/activity_event_destination_model.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/event_tab/widget/hub_event_slider_images.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widget for home features
class HubEventFeatures extends StatefulWidget {
  /// Constructor
  const HubEventFeatures({
    String id = '',
    String name = '',
    String description = '',
    double fee = 0.0,
    String country = '',
    String address = '',
    String subactivities = '',
    String services = '',
    String dateFormat = '',
    Key? key,
  })  : _id = id,
        _name = name,
        _description = description,
        _fee = fee,
        _country = country,
        _address = address,
        _subactivities = subactivities,
        _services = services,
        _dateFormat = dateFormat,
        super(key: key);

  final String _id;
  final String _name;
  final String _description;
  final double _fee;
  final String _country;
  final String _address;
  final String _subactivities;
  final String _services;
  final String _dateFormat;

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
          description: widget._description,
          country: widget._country,
          address: widget._address);
}
