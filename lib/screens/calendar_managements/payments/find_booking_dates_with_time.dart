import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:table_calendar/table_calendar.dart';

/// widget for finding booking dates with time
Future<dynamic> findBookingDatesWithTime(BuildContext context) {
  late DateTime _selectedDay = DateTime.now();
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
          return ScreenUtilInit(
            builder: () => Container(
              height: 788.h,
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
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                    Card(
                      child: TableCalendar<dynamic>(
                        onDaySelected:
                            (DateTime selectedDay, DateTime focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        headerStyle: HeaderStyle(
                            headerMargin: EdgeInsets.symmetric(vertical: 30.sp),
                            headerPadding:
                                EdgeInsets.symmetric(vertical: 15.sp),
                            titleTextStyle: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w400),
                            leftChevronVisible: false,
                            rightChevronVisible: false,
                            titleCentered: true,
                            formatButtonVisible: false,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: AppColors.primaryGreen,
                                ))),
                        daysOfWeekVisible: false,
                        calendarFormat: CalendarFormat.week,
                        currentDay: _selectedDay,
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
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: AppListConstants.timeList_.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(AppListConstants.timeList_[index].toString(),
                                style: TextStyle(
                                  color: AppColors.primaryGreen,
                                  fontSize: 15,
                                )),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColors.silver,
                            ),
                            borderRadius: BorderRadius.circular(18.r),
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
            ),
            designSize: const Size(375, 812),
          );
        });
      });
}

/// widget for months
Widget getMonths({required String name}) {
  bool selectedMonth = false;
  return InkWell(
    onTap: () {
      selectedMonth = true;
    },
    child: Container(
      height: 38.h,
      width: 89.w,
      decoration: BoxDecoration(
          color: selectedMonth == false
              ? Colors.grey.withOpacity(0.2)
              : Colors.green,
          borderRadius: BorderRadius.circular(12.r)),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}
