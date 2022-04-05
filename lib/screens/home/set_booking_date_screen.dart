// ignore_for_file: file_names, always_specify_types
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/hourly_item.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:table_calendar/table_calendar.dart';

/// Set Booking Date Screen
class SetBookingDateScreen extends StatefulWidget {
  /// Constructor
  const SetBookingDateScreen({Key? key}) : super(key: key);

  @override
  _SetBookingDateScreenState createState() => _SetBookingDateScreenState();
}

class _SetBookingDateScreenState extends State<SetBookingDateScreen> {
  late DateTime _preSelectedDay = DateTime.now();
  late DateTime _prefocusedDay = DateTime.now();
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();

  bool isRefreshing = false;
  bool _didPickedDate = false;

  late List<bool> _isChecked;
  late List<int> _value;
  final TextEditingController numberTourist = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(AppListConstants.timeList.length, false);
    _value = List<int>.filled(AppListConstants.timeList.length, 0);
    numberTourist.text = _value[1].toString();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _preSelectedDay = screenArguments['selected_date'];
    _prefocusedDay = screenArguments['selected_date'];

    return Scaffold(
      backgroundColor: Colors.white,
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
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.setBookingDates),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed('/guide_rule');
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
                        _didPickedDate
                            ? '${_selectedDay.day}/${AppListConstants.calendarMonths.elementAt(_selectedDay.month - 1)}/ ${_selectedDay.year}'
                            : '${_preSelectedDay.day}/${AppListConstants.calendarMonths.elementAt(_preSelectedDay.month - 1)}/ ${_preSelectedDay.year}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryGreen,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        // inkwell color
                        child: const Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onTap: () {
                          setState(() {
                            _focusedDay =
                                _focusedDay.subtract(Duration(days: 7));
                          });
                        },
                      ),
                      Expanded(
                        child: TableCalendar(
                          locale: 'en',
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                                isRefreshing = true;
                                _didPickedDate = true;
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
                          currentDay:
                              _didPickedDate ? _selectedDay : _preSelectedDay,
                          headerVisible: false,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                          ),
                          daysOfWeekVisible: false,
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay:
                              _didPickedDate ? _focusedDay : _prefocusedDay,
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
                      InkWell(
                        // inkwell color
                        child: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onTap: () {
                          setState(() {
                            _focusedDay = _focusedDay.add(Duration(days: 7));
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (isRefreshing)
                    const SizedBox()
                  else
                    ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            AppListConstants.timeList.length,
                            (i) => HourlyItem(
                                  title: AppListConstants.timeList[i],
                                  boolVal: AppListConstants.timeListValues[i],
                                ))),
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
            onPressed: setBookingDates,
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
              AppTextConstants.submit,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setBookingDates() async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Map<String, dynamic> availabilityDateDetails = {
      'activity_package_id': screenArguments['id'],
      'availability_date': '',
      'slots': 0,
    };

    final dynamic response = await APIServices().request(
        AppAPIPath.createSlotAvailability, RequestType.POST,
        needAccessToken: true, data: availabilityDateDetails);

    final String activityAvailabilityId = response['id'];

    final Map<String, dynamic> availabilityDateHourDetails = {
      'activity_availability_id': activityAvailabilityId,
      'availability_date_hour': '',
      'slots': 0,
    };

    final dynamic response1 = await APIServices().request(
        AppAPIPath.createSlotAvailabilityHour, RequestType.POST,
        needAccessToken: true, data: availabilityDateHourDetails);

    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const MainNavigationScreen(
                  navIndex: 1,
                  contentIndex: 0,
                )));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isRefreshing', isRefreshing));
  }
}
