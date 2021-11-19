import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:guided/models/home.dart';
import 'package:guided/utils/home.dart';

class SettingsCalendarManagementSchedule extends StatefulWidget {
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

    final ButtonStyle tbStyle = TextButton.styleFrom(
      primary: Colors.black,
      textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600, fontFamily: ConstantHelpers.fontGilroy),
    );

    /// Sample only
    List<dynamic> timeList = [
      ["7:00 - 8:00 AM", true],
      ["9:00 - 10:00 AM", false],
      ["11:00 - 12:00 PM", false],
      ["12:00 - 1:00 PM", false],
      ["2:00 - 3:00 PM", false],
      ["4:00 - 5:00 PM", false],
      ["6:00 - 7:00 PM", false],
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Transform.scale(
          scale: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: ConstantHelpers.backarrowgrey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                  size: 25.0,
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
                  HeaderText.headerText(ConstantHelpers.findBookingDates),
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
                        ConstantHelpers.fullDateSample,
                        style: TextStyle(
                          fontSize: 16,
                          color: ConstantHelpers.primaryGreen,
                        ),
                      ),
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
                  ConstantHelpers.spacing20,
                  if (isRefreshing) const SizedBox() else
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: timeList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              timeList[index][0],
                              style: TextStyle(
                                color: ConstantHelpers.primaryGreen,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(24),
                              height: 100,
                              width: 150,
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
                                        radius: 18,
                                        backgroundColor: Colors.red,
                                        backgroundImage:
                                        NetworkImage(customerRequests[0].cRProfilePic),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 30,
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
                                          radius: 18,
                                          backgroundColor: Colors.red,
                                          backgroundImage:
                                          NetworkImage(customerRequests[1].cRProfilePic),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 60,
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
                                          radius: 18,
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
          height: 60,
          child: ElevatedButton(
            onPressed: () {
            },
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
    );
  }
}