import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/app_text_style.dart';

///
class TravellerBookingDetailsScreen extends StatefulWidget {
  ///
  const TravellerBookingDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TravellerBookingDetailsScreen> createState() =>
      _TravellerBookingDetailsScreenState();
}

class _TravellerBookingDetailsScreenState
    extends State<TravellerBookingDetailsScreen> {
  final List<Activity> activities = StaticDataService.getActivityList();
  final PageController page_indicator_controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Divider(
                thickness: 2,
                color: HexColor('#ECEFF0'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35.r,
                    backgroundImage: const AssetImage(
                        '${AssetsPath.assetsPNGPath}/student_profile.png'),
                  ),
                ),
                title: Text(
                  'Ethan Hunt',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 14,
                      color: AppColors.deepGreen,
                    ),
                    Text(
                      '16 reviews',
                      style: TextStyle(
                          color: HexColor('#979B9B'),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 34.h,
                width: 79.w,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: AppColors.aquaHaze,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14.r,
                        backgroundImage: const AssetImage(
                            '${AssetsPath.assetsPNGPath}/activity_icon0.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: Text(
                        'Hunt',
                        style: TextStyle(
                            color: HexColor('#3E4242'),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Description',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Located northwest if Montreal in Quebec’s the Laurentian Mountains, Mont-Tremblant is best known for its skiing, specifically Mont Treamblent Ski Resort, which occupies the highest peak in ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.101,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.5, color: HexColor('#ECEFF0')),
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15.w, top: 8.h),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '\$60',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' / Person',
                            style: TextStyle(
                                color: AppColors.doveGrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Text(
                        '8 Jun 7:00-9:00',
                        style: TextStyle(
                            color: HexColor('#3E4242'),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 15.w),
                  width: 125.w,
                  height: 53.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/requestToBookScreen');
                    },
                    style: AppTextStyle.active,
                    child: const Text(
                      'Confirm',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ),
                // deepGreen
              ],
            ),
          ),
        ),
      ),
    );
  }
}
