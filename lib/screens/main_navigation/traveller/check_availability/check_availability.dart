import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/hexColor.dart';

/// Check Availability
class CheckAvailability extends StatefulWidget {
  ///constructor
  const CheckAvailability({Key? key}) : super(key: key);

  @override
  State<CheckAvailability> createState() => _CheckAvailabilityState();
}

class _CheckAvailabilityState extends State<CheckAvailability> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.keyboard_backspace,
                        size: 30,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Clear',
                        style: TextStyle(
                            color: HexColor('#181B1B'),
                            fontSize: 15.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Select date',
                      style: TextStyle(
                          color: HexColor('#181B1B'),
                          fontSize: 27.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border:
                              Border.all(color: HexColor('#007749'), width: 1),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          'Booking History',
                          style: TextStyle(
                              color: HexColor('#007749'),
                              fontSize: 14.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Add your activity dates for exact pricing.',
                  style: TextStyle(
                      color: HexColor('#181B1B'),
                      fontSize: 14.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Jun 2021',
                      style: TextStyle(
                          color: HexColor('#181B1B'),
                          fontSize: 20.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\$60',
                      style: TextStyle(
                          color: HexColor('#181B1B'),
                          fontSize: 30.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
