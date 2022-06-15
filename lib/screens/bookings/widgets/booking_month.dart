import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';

///Widget For Booking Month
Widget bookingMonth(String month, int count, BuildContext context, bool alignMonthContainer) => Stack(
      children: <Widget>[
        if(alignMonthContainer)
          Align(
            child:  buildMonthContainer(month, count, context))
        else
          buildMonthContainer(month, count, context),
        if (count > 0)
          Positioned(
              right: 0,
              top: -4,
              child: ClipRect(
                child: Badge(
                  padding: const EdgeInsets.all(8),
                  badgeColor: AppColors.deepGreen,
                  badgeContent: Text(
                    '2',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppTextConstants.fontPoppins),
                  ),
                ),
              ))
      ],
    );

Widget buildMonthContainer(String month, int count, BuildContext context) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: count > 0 ? AppColors.lightningYellow : null,
          border: Border.all(
              color: count > 0 ? AppColors.lightningYellow : Colors.grey)),
      padding: EdgeInsets.all(8.w),
      width: MediaQuery.of(context).size.width,
      child: Text(
        month,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
      ),
    );
