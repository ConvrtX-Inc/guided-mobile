import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/helpers/hexColor.dart';

/// Popular Guides Traveler Limit Schedules
class PopularGuidesTravelerLimitSchedules extends StatefulWidget {
  /// Constructor
  const PopularGuidesTravelerLimitSchedules({Key? key}) : super(key: key);

  @override
  State<PopularGuidesTravelerLimitSchedules> createState() =>
      _PopularGuidesTravelerLimitSchedulesState();
}

class _PopularGuidesTravelerLimitSchedulesState
    extends State<PopularGuidesTravelerLimitSchedules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: EdgeInsets.only(left: 0.w, top: 40.h, bottom: 17.h, right: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              'Traveler Limit',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cloud),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Center(
                child: Text(
                  '23/25',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              'Time',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cloud),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Center(
                child: Text(
                  '7:00 AM to 11:00 AM',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              'Date',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cloud),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Center(
                child: Text(
                  '12. 08. 2021',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              'Cost Per Person',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cloud),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Center(
                child: Text(
                  '\$90',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ))));
  }
}
