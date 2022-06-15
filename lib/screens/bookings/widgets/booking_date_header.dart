import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';

///Booking date Header
Widget bookingDateHeader(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: SvgPicture.asset('${AssetsPath.arrowWithTail}')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: Colors.black),
                ))
          ],
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 30.h),
            child: Text(
              AppTextConstants.myBookingDates,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
            )),
      ],
    );
