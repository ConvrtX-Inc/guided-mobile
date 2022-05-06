// ignore_for_file: prefer_const_literals_to_create_immutables, no_default_cases

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/event_model.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/event_tab/widget/hub_event_features.dart';
import 'package:guided/screens/main_navigation/traveller/traveller_tabbar.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Package List Screen
class HubEventList extends StatefulWidget {
  /// Constructor
  const HubEventList({Key? key}) : super(key: key);

  @override
  _HubEventListState createState() => _HubEventListState();
}

class _HubEventListState extends State<HubEventList>
    with AutomaticKeepAliveClientMixin<HubEventList> {
  @override
  bool get wantKeepAlive => true;

  late Future<EventModelData> _loadingData;

  @override
  void initState() {
    super.initState();
    _loadingData = APIServices().getAllEventData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 20.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TravellerTabScreen()));
                      },
                      child: Container(
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
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.arrow_back,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Back To Category',
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 30.h),
                child: Text(
                  'My Events',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
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

  Widget buildEventInfo(EventDetailsModel details) => HubEventFeatures(
      id: details.id,
      name: details.title,
      description: details.description,
      fee: double.parse(details.fee),
      country: details.country,
      subactivities: details.subActivities,
      services: details.freeService,
      address: details.address,
      dateFormat:
          '${details.eventDate!.year.toString().padLeft(4, '0')}-${details.eventDate!.month.toString().padLeft(2, '0')}. ${details.eventDate!.day.toString().padLeft(2, '0')}');
}
