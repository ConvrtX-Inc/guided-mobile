import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///Payment Detail
class PaymentDetail extends StatelessWidget {
  ///Constructor
  const PaymentDetail({
    required this.label,
    required this.content,
    Key? key}) : super(key: key);

  final String label;

  final String content;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: Colors.grey),
        ),
        SizedBox(
          height: 7.h,
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
