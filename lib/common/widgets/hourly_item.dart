// ignore_for_file: prefer_if_elements_to_conditional_expressions, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_cart_and_payment/controllers/CartController.dart';
import 'package:guided/constants/app_colors.dart';

/// Hourly Class
class HourlyItem extends StatefulWidget {
  /// Constructor
  HourlyItem({required this.title, required this.boolVal});

  final List<String> title;
  final List<bool> boolVal;

  @override
  _HourlyItemState createState() => _HourlyItemState();
}

class _HourlyItemState extends State<HourlyItem> {
  // final CartController _CartController = Get.find();
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: CheckboxListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                widget.title[0],
                style: TextStyle(
                    fontSize: 14.sp,
                    color: widget.boolVal[0] == false
                        ? AppColors.osloGrey
                        : AppColors.deepGreen,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gilroy'),
              ),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                  width: 150,
                  child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: widget.boolVal[0] == true
                                      ? counter == 0
                                          ? AppColors.osloGrey
                                          : AppColors.deepGreen
                                      : AppColors.osloGrey),
                              color: Colors.white,
                              shape: BoxShape.circle),
                          child: IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: widget.boolVal[0] == true
                                    ? counter == 0
                                        ? AppColors.osloGrey
                                        : AppColors.primaryGreen
                                    : AppColors.osloGrey,
                                size: 15,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (widget.boolVal[0] == true) {
                                    if (counter != 0) {
                                      counter--;
                                    }
                                  }
                                  // _CartController.decrement(widget.price);
                                });
                              }),
                        ),
                        Container(
                          height: 40.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.osloGrey),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                            child: Text(
                              ' $counter',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: widget.boolVal[0] == true
                                      ? AppColors.deepGreen
                                      : AppColors.osloGrey),
                              color: Colors.white,
                              shape: BoxShape.circle),
                          child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: widget.boolVal[0] == true
                                    ? AppColors.primaryGreen
                                    : AppColors.osloGrey,
                                size: 15,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (widget.boolVal[0] == true) {
                                    counter++;
                                  }
                                  // _CartController.increment(widget.price);
                                });
                              }),
                        )
                      ],
                    ),
                  ]))
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
