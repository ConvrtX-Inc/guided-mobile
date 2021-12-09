// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:guided/constants/app_texts.dart';

/// Create Availability Screen
class CreateAvailabilityScreen extends StatefulWidget {

  /// Constructor
  const CreateAvailabilityScreen({Key? key}) : super(key: key);

  @override
  _CreateAvailabilityScreenState createState() =>
      _CreateAvailabilityScreenState();
}

class _CreateAvailabilityScreenState extends State<CreateAvailabilityScreen> {
  bool _switchValue = true;
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppTextConstants.schedule,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                        width: 350.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.r)
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 15.w),
                              child: Text(
                                AppTextConstants.setYourSelfUnavailable,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Spacer(),
                            FlutterSwitch(
                              height: 22.h,
                              width: 40.w,
                              padding: 4,
                              toggleSize: 15,
                              borderRadius: 10.r,
                              activeColor: Colors.green,
                              value: _switchValue,
                              onToggle: (bool value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              },
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        width: 350.w,
                        height: 180.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.r)
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15.w,
                                        bottom: 11.h,
                                        top: 11.h,
                                        right: 15.w),
                                    hintText: AppTextConstants.whyOptional),
                                textInputAction: TextInputAction.done,
                                onChanged: (String value) {
                                  // _reviewText = value;
                                },
                                maxLength: 100,
                                style: const TextStyle(color: Colors.black),
                                maxLines: 6,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        width: 350.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 15.w),
                              child: Text(
                                AppTextConstants.returnDate,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Text(
                                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                ))),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime>('selectedDate', selectedDate));
  }
}
