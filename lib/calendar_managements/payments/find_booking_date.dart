import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// widget for finding booking dates
Future<dynamic> findBookingDates(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return ScreenUtilInit(
            builder: () => SingleChildScrollView(
                child: Container(
              height: 726.h,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 42.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.withOpacity(0.2)),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Find Booking Dates',
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getMonths(name: 'January', data: 0),
                      getMonths(name: 'February', data: 0),
                      getMonths(name: 'March', data: 0),
                    ],
                  ),
                  SizedBox(
                    height: 27.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getMonths(name: 'April', data: 2),
                      getMonths(name: 'May', data: 1),
                      getMonths(name: 'June', data: 0),
                    ],
                  ),
                  SizedBox(
                    height: 27.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getMonths(name: 'July', data: 0),
                      getMonths(name: 'August', data: 3),
                      getMonths(name: 'September', data: 0),
                    ],
                  ),
                  SizedBox(
                    height: 27.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getMonths(name: 'October', data: 0),
                      getMonths(name: 'November', data: 0),
                      getMonths(name: 'December', data: 0),
                    ],
                  ),
                ],
              ),
            )),
            designSize: const Size(375, 812),
          );
        });
      });
}

/// widet for months
Widget getMonths({required String name, required int data}) {
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 38.h,
        width: 89.w,
        decoration: BoxDecoration(
            color: data >= 1 ? Colors.yellow : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12)),
        child: Stack(clipBehavior: Clip.none, children: <Widget>[
          Center(
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: data >= 1 ? FontWeight.w700 : FontWeight.w500),
            ),
          ),
          if (data >= 1)
          Positioned(
            right: -5,
            top: -7,
            child: Container(
              height: 28.h,
              width: 28.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              child: Center(
                  child: Text(
                '$data',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500),
              )),
            ),
          )
        ]),
      ),
    );
  });
}

