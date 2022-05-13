import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///Delete dialog
class DeleteDialog{
  void showDeleteDialog(
      { required BuildContext context, String title = '', String message = '',}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.r))),
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 75.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.deepGreen, width: 1.w),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Text(
                                AppTextConstants.ok,
                                style: TextStyle(
                                    color: AppColors.deepGreen,
                                    fontSize: 12.sp,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w700),
                              ))),
                    ),
                  ]),
              SizedBox(
                height: 20.h,
              ),
            ],
          );
        });
  }
}