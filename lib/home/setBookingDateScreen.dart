// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/packages/create_package/guideRulesScreen.dart';
import 'package:table_calendar/table_calendar.dart';

class SetBookingDateScreen extends StatefulWidget {
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // Sample only
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
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText.headerText('Set Booking Dates'),
                  ConstantHelpers.spacing30,
                  SizedBox(
                    width: width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GuideRulesScreen()),
                        );
                      },
                      child: Text(
                        '1/March/2021',
                        style: TextStyle(
                          fontSize: 16,
                          color: ConstantHelpers.primaryGreen,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: ConstantHelpers.primaryGreen,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.white,
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
                          headerVisible: true,
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
                              color: HexColor("#ffc74a"),
                            ),
                            todayTextStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ConstantHelpers.spacing20,
                  isRefreshing
                      ? const SizedBox()
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: timeList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: CheckboxListTile(
                                checkColor: Colors.white,
                                activeColor: ConstantHelpers.primaryGreen
                                    .withOpacity(0.9),
                                title: Text(timeList[index][0].toString(),
                                    style: TextStyle(
                                      color: ConstantHelpers.primaryGreen,
                                      fontSize: 15,
                                    )),
                                value: timeList[index][1],
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
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GuideRulesScreen()),
              );
            },
            child: const Text(
              'Next',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: HexColor("#C4C4C4"),
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              primary: ConstantHelpers.primaryGreen,
              onPrimary: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
