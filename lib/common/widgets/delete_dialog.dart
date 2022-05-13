import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/asset_path.dart';

///Delete dialog
class DeleteDialog {
  ///Show Delete dialog
  void show(
      {required BuildContext context,

      String iconPath = '',
      required Function onDeletePressed,
        String itemName = '',
      String deleteBtnText = 'Delete'}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.r))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset(
                        '${AssetsPath.assetsPNGPath}/close_btn.png',
                        height: 22.h,
                        width: 22.w,
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      AssetsPath.warning,
                      height: 38.h,
                      width: 38.w,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Are you sure you want to delete $itemName ?',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              actions: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () => onDeletePressed(),
                        child: Container(
                            width: 75.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.red, width: 1.w),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                                child: Text(
                              deleteBtnText,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w700),
                            ))),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: 75.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.w),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.grey,
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
        });
  }
}
