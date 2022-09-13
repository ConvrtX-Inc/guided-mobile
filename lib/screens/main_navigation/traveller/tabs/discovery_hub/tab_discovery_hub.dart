// ignore_for_file: public_member_api_docs, use_named_constants, diagnostic_describe_all_properties

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/discovery_hub.dart';
import 'package:guided/models/newsfeed_model.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/widget/tab_discovery_hub_features.dart';
import 'package:guided/screens/main_navigation/traveller/traveller_tabbar.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/utils/event.dart';
import 'package:guided/utils/services/rest_api_service.dart';

class TabDiscoveryHub extends StatefulWidget {
  const TabDiscoveryHub({Key? key}) : super(key: key);

  @override
  State<TabDiscoveryHub> createState() => _TabDiscoveryHubState();
}

class _TabDiscoveryHubState extends State<TabDiscoveryHub> {
  List<DiscoveryHub> features = EventUtils.getMockDiscoveryHubFeatures();
  late Future<NewsFeedModel> _loadingData;

  @override
  void initState() {
    super.initState();
    _loadingData = APIServices().getNewsFeedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 0.h),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/discovery_hub_events');
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            height: 80.h,
                            width: 80.w,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/png/green_flag.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Events',
                            style: TextStyle(
                              color: AppColors.primaryGreen,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pushNamed(
                    //         context, '/discovery_hub_outfitter');
                    //   },
                    //   child: Column(
                    //     children: <Widget>[
                    //       SizedBox(
                    //         height: 9.h,
                    //       ),
                    //       Container(
                    //         height: 70.h,
                    //         width: 70.w,
                    //         padding: const EdgeInsets.all(10),
                    //         decoration: BoxDecoration(
                    //           color: Colors.transparent,
                    //           borderRadius: BorderRadius.all(
                    //             Radius.circular(15.r),
                    //           ),
                    //         ),
                    //         child: Center(
                    //           child: Container(
                    //             height: 70.h,
                    //             width: 70.w,
                    //             decoration: const BoxDecoration(
                    //               image: DecorationImage(
                    //                 image: AssetImage(
                    //                     'assets/images/png/red_shirt.png'),
                    //                 fit: BoxFit.contain,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 9.h,
                    //       ),
                    //       Text(
                    //         'Outfitter',
                    //         style: TextStyle(
                    //           color: AppColors.lightRed,
                    //           fontFamily: 'Gilroy',
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 16.sp,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Text(
                    'Discovery Hub',
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                FutureBuilder<NewsFeedModel>(
                  future: _loadingData,
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    Widget _displayWidget;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        _displayWidget = const MainContentSkeleton();
                        break;
                    // ignore: no_default_cases
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
                )
              ]),
        ),
      ),
    );
  }

  Widget buildResult(NewsFeedModel newsfeedData) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (newsfeedData.newsfeedDetails.isEmpty)
              Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 3) - 40),
                child: APIMessageDisplay(
                  message: AppTextConstants.noResultFound,
                ),
              )
            else
              for (NewsFeedDetailsModel detail in newsfeedData.newsfeedDetails)
                buildInfo(detail)
          ],
        ),
      );

  Widget buildInfo(NewsFeedDetailsModel details) => DiscoveryHubFeatures(
      id: details.id,
      title: details.title,
      mainBadgeId: details.mainBadgeId,
      description: details.description,
      date: details.newsDate,
      isPremium: details.isPremium);
}
