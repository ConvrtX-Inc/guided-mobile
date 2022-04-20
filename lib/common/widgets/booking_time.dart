// ignore_for_file: prefer_if_elements_to_conditional_expressions, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_cart_and_payment/controllers/CartController.dart';
import 'package:guided/constants/app_colors.dart';

/// Hourly Class
class BookingTime extends StatefulWidget {
  /// Constructor
  BookingTime({required this.title, required this.boolVal});

  final List<String> title;
  final List<bool> boolVal;

  @override
  _BookingTimeState createState() => _BookingTimeState();
}

class _BookingTimeState extends State<BookingTime> {
  // final CartController _CartController = Get.find();
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: CheckboxListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.title[0],
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: widget.boolVal[0] == false
                          ? AppColors.osloGrey
                          : AppColors.deepGreen,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy'),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          onChanged: (bool? value) {
            setState(() {
              widget.boolVal[0] = value!;
            });
          },
          value: widget.boolVal[0],
        ),
      ),
    );
  }
}
