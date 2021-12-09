// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/packages/create_package/guide_rules_screen.dart';
import 'package:table_calendar/table_calendar.dart';

/// Set Booking Date Screen
class SetBookingDateScreen extends StatefulWidget {

  /// Constructor
  const SetBookingDateScreen({Key? key}) : super(key: key);

  @override
  _SetBookingDateScreenState createState() => _SetBookingDateScreenState();
}

class _SetBookingDateScreenState extends State<SetBookingDateScreen> {
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  bool isRefreshing = false;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
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
                  HeaderText.headerText(
                      AppTextConstants.setBookingDates
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/guide_rule');
                      },
                      style: ElevatedButton.styleFrom(
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
                        '1/March/2021', // Just an example
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
                    children: [
                      Expanded(
                        child: TableCalendar(
                          onDaySelected: (selectedDay, focusedDay) {
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
                          headerVisible: true,
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
                  if (isRefreshing) const SizedBox() else ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: AppListConstants.timeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: AppColors.primaryGreen
                              .withOpacity(0.9),
                          title: Text(
                              AppListConstants.timeList[index][0].toString(),
                              style: TextStyle(
                                color: AppColors.primaryGreen,
                                fontSize: 15,
                              )),
                          value: AppListConstants.timeList[index][1],
                          onChanged: (bool? value) {
                            setState(() {});
                          },
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
              Navigator.of(context).pushNamed('/guide_rule');
            },
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
              AppTextConstants.next,
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
