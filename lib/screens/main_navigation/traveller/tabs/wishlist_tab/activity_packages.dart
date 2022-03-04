// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/wishlist_model.dart';
import 'package:guided/screens/packages/create_package/create_package_screen.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/utils/services/static_data_services.dart';

/// Package List Screen
class ActivityPackages extends StatefulWidget {
  /// Constructor
  const ActivityPackages({Key? key}) : super(key: key);

  @override
  _ActivityPackagesState createState() => _ActivityPackagesState();
}

class _ActivityPackagesState extends State<ActivityPackages> {
  /// Get features items mocked data
  List<Wishlist> features = StaticDataService.getWishListData();
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _slideshow1(),
            SizedBox(height: 30.h,),
            _slideshow2(),
          ],
        ),
      ),
    );
  }

  Widget _slideshow1() => Column(
        children: <Widget>[
          ImageSlideshow(
            width: 375,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.white,
            indicatorBackgroundColor: Colors.grey[100],
            autoPlayInterval: 3000,
            isLoop: true,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity1.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.hunt),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity2.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.paddle),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity3.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.hiking),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.star_rounded,
                  color: Colors.green[900],
                  size: 15,
                ),
                Text(
                  '16 review',
                  style: TextStyle(color: AppColors.osloGrey),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'St. John\'s, Newfoundland',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '\$50/Person',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      );

  Widget _slideshow2() => Column(
        children: <Widget>[
          ImageSlideshow(
            width: 375,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.white,
            indicatorBackgroundColor: Colors.grey[100],
            autoPlayInterval: 3000,
            isLoop: true,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity2.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.paddle),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity1.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.hunt),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity3.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.hiking),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.star_rounded,
                  color: Colors.green[900],
                  size: 15,
                ),
                Text(
                  '13 review',
                  style: TextStyle(color: AppColors.osloGrey),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Blue Lake Paddle Co.',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '\$25/Person',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      );
}
