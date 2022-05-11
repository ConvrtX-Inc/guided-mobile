import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/hexColor.dart';

///Skeleton Text
class GoldenBadge extends StatelessWidget {
  ///Constructor
  const GoldenBadge({this.base64Image = '', Key? key}) : super(key: key);

  final String base64Image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 5, color: HexColor('#FFD700')),
          borderRadius: BorderRadius.circular(50.r)),
      child: Image.memory(
        base64.decode(base64Image.split(',').last),
        gaplessPlayback: true,
        width: 30.w,
        height: 30.h,
      ),
    );
  }
}
