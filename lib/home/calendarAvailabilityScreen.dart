// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/home/setBookingDateScreen.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/packages/create_package/guideRulesScreen.dart';
import 'package:guided/packages/create_package/subActivitiesScreen.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarAvailabilityScreen extends StatefulWidget {
  const CalendarAvailabilityScreen({Key? key}) : super(key: key);

  @override
  _CalendarAvailabilityScreenState createState() =>
      _CalendarAvailabilityScreenState();
}

class _CalendarAvailabilityScreenState
    extends State<CalendarAvailabilityScreen> {
  final txtMinimum = TextEditingController();

  int minimum = 1;
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                  HeaderText.headerText('First Slot Availability'),
                  ConstantHelpers.spacing30,
                  SubHeaderText.subHeaderText(
                      'Editing your calendar is easy—just select a date to block or unblock it. You can always make changes after you publish.'),
                  ConstantHelpers.spacing40,
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TableCalendar(
                        onDaySelected: (selectedDay, focusedDay) {
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
                            color: HexColor("#ffc74a"),
                          ),
                          todayTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  HeaderText.headerText('Number of people'),
                  ConstantHelpers.spacing20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              minimum = minimum - 1;
                              txtMinimum.text = minimum.toString();
                            });
                          },
                          child: Icon(Icons.remove,
                              color: ConstantHelpers.primaryGreen),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: ConstantHelpers.primaryGreen),
                            ),
                            padding: const EdgeInsets.all(8),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextField(
                              controller: txtMinimum,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top: 10),
                                hintStyle: TextStyle(
                                  color: ConstantHelpers.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
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
                          child: Icon(Icons.add,
                              color: ConstantHelpers.primaryGreen),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: ConstantHelpers.primaryGreen),
                            ),
                            padding: const EdgeInsets.all(8),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
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
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SetBookingDateScreen()),
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
