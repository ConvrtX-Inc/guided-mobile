import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/screens/calendar_managements/payments/find_booking_dates_with_time.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

/// widget for finding booking dates with calendar
Future<dynamic> findBookingDatesWithCalendar(BuildContext context) {
  late DateTime _focusedDay = DateTime.now();
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
          return Container(
            height: 726.h,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 42.h),
            child: SingleChildScrollView(
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
                    height: 45.h,
                  ),
                  SizedBox(
                    height: 56.h,
                    width: 311.w,
                    child: ElevatedButton(
                      onPressed: () {
                        findBookingDatesWithCalendar(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.primaryGreen,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        'November/2021',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Icon(Icons.arrow_back_ios),
                      SizedBox(
                        width: 250.w,
                        height: 70.h,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                getMonths(name: 'January', data: 0),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'February', data: 0),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'March', data: 0),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'April', data: 2),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'May', data: 1),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'June', data: 0),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'July', data: 0),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'August', data: 3),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'September', data: 0),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'October', data: 0),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'November', data: 0),
                                SizedBox(
                                  width: 5.w,
                                ),
                                getMonths(name: 'December', data: 0),
                              ],
                            )),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TableCalendar<dynamic>(
                        onDaySelected:
                            (DateTime selectedDay, DateTime focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay;
                          });
                        },
                        // currentDay: _selectedDay,
                        headerVisible: false,
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: _focusedDay,
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.brightSun,
                          ),
                          todayTextStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () {
                        findBookingDatesWithTime(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.silver,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        primary: AppColors.primaryGreen,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        'View Schedule',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
