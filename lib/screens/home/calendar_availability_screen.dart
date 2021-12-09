// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/home/set_booking_date_screen.dart';
import 'package:table_calendar/table_calendar.dart';

/// Calendar Availability Screen
class CalendarAvailabilityScreen extends StatefulWidget {

  /// Constructor
  const CalendarAvailabilityScreen({Key? key}) : super(key: key);

  @override
  _CalendarAvailabilityScreenState createState() =>
      _CalendarAvailabilityScreenState();
}

class _CalendarAvailabilityScreenState
    extends State<CalendarAvailabilityScreen> {
  final TextEditingController txtMinimum = TextEditingController();

  int minimum = 1;
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();

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
                      AppTextConstants.headerAvailability
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SubHeaderText.subHeaderText(
                    AppTextConstants.subheaderAvailability
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
                      child: TableCalendar(
                        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay =
                                focusedDay; // update `_focusedDay` here as well
                          });
                        },
                        currentDay: _selectedDay,
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
                  HeaderText.headerText(
                    AppTextConstants.headerNumberOfPeople
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              minimum = minimum - 1;
                              txtMinimum.text = minimum.toString();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: AppColors.primaryGreen),
                            ),
                            padding: const EdgeInsets.all(8),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
                          child: Icon(
                              Icons.remove,
                              color: AppColors.primaryGreen),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: txtMinimum,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10.h),
                                hintStyle: TextStyle(
                                  color: AppColors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.2),
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              minimum = minimum + 1;
                              txtMinimum.text = minimum.toString();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: AppColors.primaryGreen),
                            ),
                            padding: const EdgeInsets.all(8),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
                          child: Icon(Icons.add,
                              color: AppColors.primaryGreen),
                        ),
                      )
                    ],
                  ),
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
              Navigator.of(context).pushNamed('/set_booking_date');
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
    properties.add(DiagnosticsProperty<TextEditingController>('txtMinimum', txtMinimum));
    properties.add(IntProperty('minimum', minimum));
  }
}
