// ignore_for_file: public_member_api_docs, use_named_constants, diagnostic_describe_all_properties

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/utils/services/static_data_services.dart';

/// Guide Profile
class GuideProfile extends StatefulWidget {
  const GuideProfile({Key? key}) : super(key: key);

  @override
  State<GuideProfile> createState() => _GuideProfileState();
}

class _GuideProfileState extends State<GuideProfile> {
  final List<Activity> activities = StaticDataService.getActivityList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.h,
              ),
              guideProfile1(),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 0.h),
                child: nearbyActivities(context, activities),
              ),
              guideProfile2(),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 0.h),
                child: nearbyActivities(context, activities),
              ),
              guideProfile3(),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 0.h),
                child: nearbyActivities(context, activities),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget guideProfile1() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: 50.w,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 1.w,
              ),
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: const <BoxShadow>[
                BoxShadow(blurRadius: 2, color: Colors.grey, spreadRadius: 2)
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60.r,
              backgroundImage: const AssetImage(
                  '${AssetsPath.assetsPNGPath}/student_profile.png'),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Card(
              elevation: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'Ethan Hunt',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Image(
                        image: AssetImage(AssetsPath.hunt),
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        height: 35.h,
                        child: Text(
                          'Hunt',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 17),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.mintGreen,
                              border: Border.all(color: AppColors.mintGreen),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r))),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(AppTextConstants.firstaid,
                                style: TextStyle(
                                    color: AppColors.deepGreen,
                                    fontFamily: 'Gilroy',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Image(
                          image: AssetImage(AssetsPath.forThePlanet),
                          width: 60,
                          height: 60,
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: AppColors.deepGreen,
                              size: 10,
                            ),
                            Text(
                              '16 reviews',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy',
                                  color: AppColors.osloGrey,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget guideProfile2() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: 50.w,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 1.w,
              ),
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: const <BoxShadow>[
                BoxShadow(blurRadius: 2, color: Colors.grey, spreadRadius: 2)
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60.r,
              backgroundImage: const AssetImage(
                  '${AssetsPath.assetsPNGPath}/john_kristen.png'),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Card(
              elevation: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'John Kristen',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Image(
                        image: AssetImage(AssetsPath.hunt),
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        height: 35.h,
                        child: Text(
                          'Hunt',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 17),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.mintGreen,
                              border: Border.all(color: AppColors.mintGreen),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r))),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(AppTextConstants.firstaid,
                                style: TextStyle(
                                    color: AppColors.deepGreen,
                                    fontFamily: 'Gilroy',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Image(
                          image: AssetImage(AssetsPath.forThePlanet),
                          width: 60,
                          height: 60,
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: AppColors.deepGreen,
                              size: 10,
                            ),
                            Text(
                              '16 reviews',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy',
                                  color: AppColors.osloGrey,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget guideProfile3() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: 50.w,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 1.w,
              ),
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: const <BoxShadow>[
                BoxShadow(blurRadius: 2, color: Colors.grey, spreadRadius: 2)
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60.r,
              backgroundImage:
                  const AssetImage('${AssetsPath.assetsPNGPath}/mark_chen.png'),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Card(
              elevation: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'Mark Chen',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Image(
                        image: AssetImage(AssetsPath.hunt),
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        height: 35.h,
                        child: Text(
                          'Hunt',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 17),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.mintGreen,
                              border: Border.all(color: AppColors.mintGreen),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r))),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(AppTextConstants.firstaid,
                                style: TextStyle(
                                    color: AppColors.deepGreen,
                                    fontFamily: 'Gilroy',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Image(
                          image: AssetImage(AssetsPath.forThePlanet),
                          width: 60,
                          height: 60,
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: AppColors.deepGreen,
                              size: 10,
                            ),
                            Text(
                              '16 reviews',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy',
                                  color: AppColors.osloGrey,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget nearbyActivities(BuildContext context, List<Activity> activities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Posts',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.26,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(activities.length, (int i) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                height: 180.h,
                width: 168.w,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 112.h,
                      width: 168.w,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.r),
                        ),
                        image: DecorationImage(
                          image: AssetImage(activities[i].featureImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              backgroundImage: AssetImage(activities[i].path),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      activities[i].name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 10.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/png/clock.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          activities[i].distance,
                          style: TextStyle(
                              color: HexColor('#696D6D'),
                              fontSize: 11.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
