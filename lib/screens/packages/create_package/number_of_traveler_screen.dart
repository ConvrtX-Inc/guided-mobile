// ignore_for_file: file_names, cast_nullable_to_non_nullable
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';

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
  int maximum = 5;

  File? image1;

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

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
                  HeaderText.headerText(AppTextConstants.headerMinMax),
                  SizedBox(height: 30.h),
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
                              if (minimum != 1) {
                                minimum = minimum - 1;
                                txtMinimum.text = minimum.toString();
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: minimum == 1
                                  ? BorderSide(color: AppColors.grey)
                                  : BorderSide(color: AppColors.primaryGreen),
                            ),
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white,
                            onPrimary: Colors.green,
                          ),
                          child: Icon(Icons.remove,
                              color: minimum == 1
                                  ? AppColors.grey
                                  : AppColors.primaryGreen),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              enabled: false,
                              controller: txtMinimum,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: AppColors.grey,
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
                              if (minimum != maximum) {
                                minimum = minimum + 1;
                              }
                              txtMinimum.text = minimum.toString();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: BorderSide(color: AppColors.primaryGreen),
                            ),
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white,
                            onPrimary: Colors.green,
                          ),
                          child: Icon(Icons.add, color: AppColors.primaryGreen),
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
                              if (maximum != 1) {
                                if (maximum != minimum) {
                                  maximum = maximum - 1;
                                }
                                txtMaximum.text = maximum.toString();
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(
                              side: maximum == 1
                                  ? BorderSide(color: AppColors.grey)
                                  : BorderSide(color: AppColors.primaryGreen),
                            ),
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white,
                            onPrimary: Colors.green,
                          ),
                          child: Icon(Icons.remove,
                              color: maximum == 1
                                  ? AppColors.grey
                                  : AppColors.primaryGreen),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              enabled: false,
                              controller: txtMaximum,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: AppColors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.2.w),
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
                              side: BorderSide(color: AppColors.primaryGreen),
                            ),
                            padding: const EdgeInsets.all(11),
                            primary: Colors.white,
                            onPrimary: Colors.green,
                          ),
                          child: Icon(Icons.add, color: AppColors.primaryGreen),
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
            onPressed: () => navigateLocationScreen(context, screenArguments),
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigate to Number of Traveler
  Future<void> navigateLocationScreen(
      BuildContext context, Map<String, dynamic> data) async {
    final Map<String, dynamic> details = Map<String, dynamic>.from(data);
    details['minimum'] = txtMinimum.text;
    details['maximum'] = txtMaximum.text;

    await Navigator.pushNamed(context, '/location', arguments: details);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty<TextEditingController>('txtMinimum', txtMinimum))
      ..add(
          DiagnosticsProperty<TextEditingController>('txtMaximum', txtMaximum))
      ..add(IntProperty('minimum', minimum))
      ..add(IntProperty('maximum', maximum));
  }
}
