import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/home.dart';
import 'package:guided/utils/home.dart';
import 'package:table_calendar/table_calendar.dart';

/// Settings Calendar Management Schedule Screen
class SettingsCalendarManagementSchedule extends StatefulWidget {

  /// Constructor
  const SettingsCalendarManagementSchedule({Key? key}) : super(key: key);

  @override
  _SettingsCalendarManagementScheduleState createState() => _SettingsCalendarManagementScheduleState();
}

class _SettingsCalendarManagementScheduleState extends State<SettingsCalendarManagementSchedule> {
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  bool isRefreshing = false;

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final List<HomeModel> customerRequests = HomeUtils.getMockCustomerRequests();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Transform.scale(
          scale: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 40.w,
              height: 40.h,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: AppColors.harp,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              style: AppTextStyle.tbStyle,
              child: Text(AppTextConstants.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.findBookingDates),
                  SizedBox(
                    height: 60.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.primaryGreen,
                          ),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        AppTextConstants.fullDateSample,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TableCalendar(
                          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                            setState(() {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                                isRefreshing = true;
                              });

                              Future.delayed(const Duration(milliseconds: 100),
                                      () {
                                    setState(() {
                                      isRefreshing = false;
                                    });
                                  });
                            });
                          },
                          calendarFormat: CalendarFormat.week,
                          currentDay: _selectedDay,
                          headerVisible: false,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                          ),
                          daysOfWeekVisible: false,
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
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (isRefreshing) const SizedBox() else
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: AppListConstants.timeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppListConstants.timeList[index][0],
                                style: TextStyle(
                                    color: AppColors.primaryGreen,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(24),
                                height: 100.h,
                                width: 150.w,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              blurRadius: 5,
                                              color: Colors.black.withOpacity(0.3),
                                              spreadRadius: 3)
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 18.r,
                                          backgroundColor: Colors.red,
                                          backgroundImage:
                                          NetworkImage(customerRequests[0].cRProfilePic),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 30.w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                blurRadius: 5,
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 3)
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 18.r,
                                            backgroundColor: Colors.red,
                                            backgroundImage:
                                            NetworkImage(customerRequests[1].cRProfilePic),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 60.w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                blurRadius: 5,
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 3)
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 18.r,
                                            backgroundColor: Colors.red,
                                            backgroundImage:
                                            NetworkImage(customerRequests[2].cRProfilePic),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: 60.h,
          child: ElevatedButton(
            onPressed: () {
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
              AppTextConstants.viewSchedule,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isRefreshing', isRefreshing));
  }
}