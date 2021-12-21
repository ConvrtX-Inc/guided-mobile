import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/main_navigation/settings/screens/calendar_management/settings_calendar_management_schedule.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

/// Setting Calendar Management Modal Screen
class SettingsCalendarManagementModal extends StatefulWidget {

  /// Constructor
  const SettingsCalendarManagementModal({Key? key}) : super(key: key);

  @override
  _SettingsCalendarManagementModalState createState() => _SettingsCalendarManagementModalState();
}

class _SettingsCalendarManagementModalState extends State<SettingsCalendarManagementModal> {
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  bool isRefreshing = false;

  final ScrollController _controller = ScrollController();
  final double _width = 100.0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    int recentIndexIncrease = 0;
    int recentIndexDecrease = 0;

    final ButtonStyle tbStyle = TextButton.styleFrom(
      primary: Colors.black,
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: AppTextConstants.fontGilroy
      ),
    );

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
              style: tbStyle,
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
                children: [
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
                        '9/April/2021',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      children: <Widget>[
                        InkWell( // inkwell color
                          child: const Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onTap: () {
                            var recentIndexDecreaseMinus =
                            recentIndexDecrease--;
                            _animateToIndex(recentIndexDecrease);
                          },
                        ),
                        Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 70.h,
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  child: ListView.builder(
                                      controller: _controller,
                                      itemCount: 12,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index) {
                                        recentIndexIncrease = index;
                                        recentIndexDecrease = index;
                                        return Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Badge(
                                            showBadge: AppListConstants.monthList[index][2] == false ? false : true,
                                            padding: const EdgeInsets.all(8),
                                            badgeColor: AppColors.tropicalRainForest,
                                            badgeContent: Text(
                                              AppListConstants.monthList[index][1],
                                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                            child: ElevatedButton(
                                              style: AppListConstants.monthList[index][1] == '' && AppListConstants.monthList[index][3] == false || AppListConstants.monthList[index][1] != '' && AppListConstants.monthList[index][3] == false? AppTextStyle.style : AppTextStyle.active,
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: Text(AppListConstants.monthList[index][0]),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell( // inkwell color
                          child: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onTap: () {
                            _animateToIndex(recentIndexIncrease);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 20.h
                  ),
                  Row(
                    children: [
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
                          calendarFormat: CalendarFormat.month,
                          currentDay: _selectedDay,
                          headerVisible: false,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                          ),
                          daysOfWeekVisible: true,
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
            onPressed: _settingModalBottomSheet,
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

  Future<void> _animateToIndex(i) => _controller.animateTo(_width * i,
      duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  void _settingModalBottomSheet() {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => const SettingsCalendarManagementSchedule(),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isRefreshing', isRefreshing));
  }
}