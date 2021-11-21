import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/main_navigation/settings/screens/calendar_management/settings_calendar_management_schedule.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

class SettingsCalendarManagementModal extends StatefulWidget {
  const SettingsCalendarManagementModal({Key? key}) : super(key: key);

  @override
  _SettingsCalendarManagementModalState createState() => _SettingsCalendarManagementModalState();
}

class _SettingsCalendarManagementModalState extends State<SettingsCalendarManagementModal> {
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  bool isRefreshing = false;

  final _controller = ScrollController();
  var _width = 100.0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var recentIndexIncrease = 0;
    var recentIndexDecrease = 0;

    final ButtonStyle tbStyle = TextButton.styleFrom(
      primary: Colors.black,
      textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600, fontFamily: ConstantHelpers.fontGilroy),
    );

    /// Default button style
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        onPrimary: ConstantHelpers.lightgrey,
        side: BorderSide(width: 1.5, color: ConstantHelpers.lightgrey),
        textStyle: TextStyle( fontSize: 13, fontWeight: FontWeight.w800, fontFamily: ConstantHelpers.fontPoppins),
        fixedSize: const Size(108, 38),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    );

    /// Active button style
    final ButtonStyle active = ElevatedButton.styleFrom(
        primary: ConstantHelpers.activeDate,
        elevation: 0,
        shadowColor: Colors.transparent,
        onPrimary: Colors.black,
        side: BorderSide(width: 1.5, color: ConstantHelpers.activeDate),
        textStyle: TextStyle( fontSize: 13, fontWeight: FontWeight.w800, fontFamily: ConstantHelpers.fontPoppins),
        fixedSize: const Size(108, 38),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    );

    /// [<Month>, <# of Customer>, <hasScheduled>, <isSelected>]
    final List<dynamic> monthList = [
      ['January', '', false, false],
      ['February', '', false, false],
      ['March', '', false, false],
      ['April', '2', true, true],
      ['May', '1', true, false],
      ['June', '', false, false],
      ['July', '', false, false],
      ['August', '', false, false],
      ['September', '', false, false],
      ['October', '', false, false],
      ['November', '', false, false],
      ['December', '', false, false],
    ];

    return ScreenUtilInit(
        builder: () => Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: Transform.scale(
              scale: 0.8,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: ConstantHelpers.backarrowgrey,
                    borderRadius: BorderRadius.circular(10),
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
              children: [
                TextButton(
                  style: tbStyle,
                  child: Text(ConstantHelpers.cancel),
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
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText.headerText('Find Booking Dates'),
                      ConstantHelpers.spacing30,
                      ConstantHelpers.spacing30,
                      SizedBox(
                        width: width,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: ConstantHelpers.primaryGreen,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            primary: Colors.white,
                            onPrimary: Colors.white,
                          ),
                          child: Text(
                            '9/April/2021',
                            style: TextStyle(
                              fontSize: 16,
                              color: ConstantHelpers.primaryGreen,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
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
                                  children: [
                                    SizedBox(
                                      height: 70,
                                      width: width-120,
                                      child: ListView.builder(
                                          controller: _controller,
                                          itemCount: 12,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            recentIndexIncrease = index;
                                            recentIndexDecrease = index;
                                            return Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Badge(
                                                showBadge: monthList[index][2] == false ? false : true,
                                                padding: const EdgeInsets.all(8),
                                                badgeColor: ConstantHelpers.badgeColor,
                                                badgeContent: Text(
                                                  monthList[index][1],
                                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                ),
                                                child: ElevatedButton(
                                                  style: monthList[index][1] == '' && monthList[index][3] == false || monthList[index][1] != '' && monthList[index][3] == false? style : active,
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(monthList[index][0]),
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
                      ConstantHelpers.spacing20,
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
                                markersAutoAligned: true,
                                todayDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ConstantHelpers.calendarMonth,
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
              height: 60,
              child: ElevatedButton(
                onPressed: _settingModalBottomSheet,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: ConstantHelpers.buttonNext,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  primary: ConstantHelpers.primaryGreen,
                  onPrimary: Colors.white,
                ),
                child: Text(
                  ConstantHelpers.viewSchedule,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        designSize: const Size(375, 812)
    );
  }

  _animateToIndex(i) => _controller.animateTo(_width * i,
      duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  void _settingModalBottomSheet() {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SettingsCalendarManagementSchedule(),
    );
  }
}