import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';

/// Main Content Loading Screen
class TimeLoading extends StatelessWidget {
  /// Constructor
  const TimeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(22.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            const SkeletonText(
              height: 30,
              width: 900,
              radius: 10,
            ),
          ],
        ),
      ),
    );
  }
}
