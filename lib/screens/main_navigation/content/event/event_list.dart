// ignore_for_file: prefer_const_literals_to_create_immutables, no_default_cases

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/event_model.dart';
import 'package:guided/models/home.dart';
import 'package:guided/screens/main_navigation/content/event/widget/event_features.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/utils/event.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Package List Screen
class EventList extends StatefulWidget {
  /// Constructor
  const EventList({Key? key}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList>
    with AutomaticKeepAliveClientMixin<EventList> {
  @override
  bool get wantKeepAlive => true;

  List<HomeModel> features = EventUtils.getMockEventFeatures();

  late Future<EventModelData> _loadingData;

  @override
  void initState() {
    super.initState();
    _loadingData = APIServices().getEventData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          height: 625.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FutureBuilder<EventModelData>(
                  future: _loadingData,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    Widget _displayWidget;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        _displayWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      default:
                        if (snapshot.hasError) {
                          _displayWidget = Center(
                              child: APIMessageDisplay(
                            message: 'Result: ${snapshot.error}',
                          ));
                        } else {
                          _displayWidget = buildEventResult(snapshot.data!);
                        }
                    }
                    return _displayWidget;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.chateauGreen,
        onPressed: () {
          Navigator.pushNamed(context, '/event_add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildEventResult(EventModelData eventData) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (eventData.eventDetails.isEmpty)
              Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 3) - 40),
                child: APIMessageDisplay(
                  message: AppTextConstants.noResultFound,
                ),
              )
            else
              for (EventDetailsModel detail in eventData.eventDetails)
                buildEventInfo(detail)
          ],
        ),
      );

  Widget buildEventInfo(EventDetailsModel details) => EventFeatures(
        id: details.id,
        name: details.title,
        badgeId: details.badgeId,
        description: details.description,
        starRating: 4.9,
        fee: double.parse(details.fee),
        path: AssetsPath.paddle,
        dateRange: '1-9',
        country: details.country,
        mainActivity: details.mainActivities,
        subactivities: details.subActivities,
        services: details.freeService,
        address: details.address,
        eventDate:
            '${details.eventDate!.month.toString().padLeft(2, '0')}. ${details.eventDate!.day.toString().padLeft(2, '0')}. ${details.eventDate!.year.toString().padLeft(2, '0')}',
        dateFormat:
            '${details.eventDate!.year.toString().padLeft(4, '0')}-${details.eventDate!.month.toString().padLeft(2, '0')}. ${details.eventDate!.day.toString().padLeft(2, '0')}',
        isPublished: details.isPublished,
      );
}
