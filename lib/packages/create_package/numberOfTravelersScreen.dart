// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/packages/create_package/locationScreen.dart';
import 'package:guided/packages/create_package/subActivitiesScreen.dart';

class NumberOfTravelersScreen extends StatefulWidget {
  const NumberOfTravelersScreen({Key? key}) : super(key: key);

  @override
  _NumberOfTravelersScreenState createState() =>
      _NumberOfTravelersScreenState();
}

class _NumberOfTravelersScreenState extends State<NumberOfTravelersScreen> {
  final txtMinimum = TextEditingController();
  final txtMaximum = TextEditingController();

  int minimum = 1;
  int maximum = 1;

  @override
  void initState() {
    super.initState();

    txtMinimum.text = minimum.toString();
    txtMaximum.text = maximum.toString();
  }

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
                  HeaderText.headerText(
                      'Minimum & Maximum Number of Travelers'),
                  ConstantHelpers.spacing30,
                  const Text(
                    "Add a team or individuals to build your package",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GilRoy',
                      fontSize: 15,
                    ),
                  ),
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
                            padding: const EdgeInsets.all(11),
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
                                hintStyle: TextStyle(
                                  color: ConstantHelpers.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.2),
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Minimum",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            )
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
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
                        ),
                      )
                    ],
                  ),
                  ConstantHelpers.spacing30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              maximum = maximum - 1;
                              txtMaximum.text = maximum.toString();
                            });
                          },
                          child: Icon(Icons.remove,
                              color: ConstantHelpers.primaryGreen),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: ConstantHelpers.primaryGreen),
                            ),
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextField(
                              controller: txtMaximum,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: ConstantHelpers.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.2),
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Maximum",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              maximum = maximum + 1;
                              txtMaximum.text = maximum.toString();
                            });
                          },
                          child: Icon(Icons.add,
                              color: ConstantHelpers.primaryGreen),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: ConstantHelpers.primaryGreen),
                            ),
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
                        ),
                      )
                    ],
                  ),
                  ConstantHelpers.spacing20,
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
                  builder: (context) => const LocationScreen(),
                ),
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
