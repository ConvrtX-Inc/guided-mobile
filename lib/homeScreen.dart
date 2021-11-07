// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:guided/packages/create_package/createPackageScreen.dart';

import 'helpers/constant.dart';
import 'helpers/hexColor.dart';
import 'home/calendarAvailabilityScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          const Text("Temp Home Screens"),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: width,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreatePackageScreen()),
                  );
                },
                child: const Text(
                  'Create Package Screen',
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: width,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CalendarAvailabilityScreen()),
                  );
                },
                child: const Text(
                  'First Slot Availability',
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
        ],
      ),
    );
  }
}
