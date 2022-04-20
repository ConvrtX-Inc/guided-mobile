import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

///
class ActivityBookingDetailsScreen extends StatefulWidget {
  ///
  const ActivityBookingDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ActivityBookingDetailsScreen> createState() =>
      _ActivityBookingDetailsScreenState();
}

class _ActivityBookingDetailsScreenState
    extends State<ActivityBookingDetailsScreen> {
  final List<Activity> activities = StaticDataService.getActivityList();
  final PageController page_indicator_controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 280.h,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                PageView.builder(
                  controller: page_indicator_controller,
                  itemCount: activities.length,
                  itemBuilder: (_, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 280.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image:
                                    AssetImage(activities[index].featureImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SmoothPageIndicator(
                      controller: page_indicator_controller,
                      count: activities.length,
                      effect: const ScrollingDotsEffect(
                        activeDotColor: Colors.white,
                        dotColor: Colors.white,
                        activeStrokeWidth: 2.6,
                        activeDotScale: 1.6,
                        maxVisibleDots: 5,
                        radius: 8,
                        spacing: 10,
                        dotHeight: 6,
                        dotWidth: 6,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 10.w, 0.h),
                      child: Container(
                        width: 44.w,
                        height: 44.h,
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
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.w, 20.h, 5.w, 0.h),
                      child: Container(
                        width: 44.w,
                        height: 44.h,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.share,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.w, 20.h, 20.w, 0.h),
                      child: Container(
                        width: 44.w,
                        height: 44.h,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Grassland Outfitting',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 20.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 15.h,
                    width: 15.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/png/marker.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Text(
                    'Toronto, Canada',
                    style: TextStyle(
                        color: HexColor('#979B9B'),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
