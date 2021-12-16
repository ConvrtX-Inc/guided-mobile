// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/packages/create_package/location_screen.dart';

/// Number of traveler screen
class NumberOfTravelersScreen extends StatefulWidget {

  /// Constructor
  const NumberOfTravelersScreen({Key? key}) : super(key: key);

  @override
  _NumberOfTravelersScreenState createState() =>
      _NumberOfTravelersScreenState();
}

class _NumberOfTravelersScreenState extends State<NumberOfTravelersScreen> {
  final TextEditingController txtMinimum = TextEditingController();
  final TextEditingController txtMaximum = TextEditingController();

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
                      AppTextConstants.headerMinMax),
                  SizedBox(
                    height: 30.h
                  ),
                  Text(
                    AppTextConstants.addTeam,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GilRoy',
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
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
                                  color: AppColors.primaryGreen
                              ),
                            ),
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
                          child: Icon(
                              Icons.remove,
                              color: AppColors.primaryGreen
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: txtMinimum,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: AppColors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.2
                                  ),
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              AppTextConstants.minimum,
                              style: const TextStyle(
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
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: AppColors.primaryGreen
                              ),
                            ),
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
                          child: Icon(
                              Icons.add,
                              color: AppColors.primaryGreen
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              maximum = maximum - 1;
                              txtMaximum.text = maximum.toString();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: AppColors.primaryGreen
                              ),
                            ),
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
                          child: Icon(
                              Icons.remove,
                              color: AppColors.primaryGreen
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: txtMaximum,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: AppColors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 0.2.w
                                  ),
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              AppTextConstants.maximum,
                              style: const TextStyle(
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
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: AppColors.primaryGreen
                              ),
                            ),
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.green, // <-- Splash color
                          ),
                          child: Icon(
                              Icons.add,
                              color: AppColors.primaryGreen
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
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
              Navigator.of(context).pushNamed('/location');
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
    properties.add(DiagnosticsProperty<TextEditingController>('txtMaximum', txtMaximum));
    properties.add(IntProperty('minimum', minimum));
    properties.add(IntProperty('maximum', maximum));
  }
}