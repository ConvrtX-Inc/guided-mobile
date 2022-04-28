import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';

/// Main Content Loading Screen
class MainContentSkeleton extends StatelessWidget {
  /// Constructor
  const MainContentSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(22.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SkeletonText(
              height: 200,
              width: 900,
            ),
            SizedBox(
              height: 20.h,
            ),
            const SkeletonText(
              height: 200,
              width: 900,
            ),
            SizedBox(
              height: 20.h,
            ),
            const SkeletonText(
              height: 200,
              width: 900,
            ),
            SizedBox(
              height: 20.h,
            ),
            const SkeletonText(
              height: 200,
              width: 900,
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal
class MainContentSkeletonHorizontal extends StatelessWidget {
  /// Constructor
  const MainContentSkeletonHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SkeletonText(
              height: 200,
              width: 200,
            ),
            SizedBox(
              width: 10.h,
            ),
            const SkeletonText(
              height: 200,
              width: 200,
            ),
            SizedBox(
              width: 10.h,
            ),
            const SkeletonText(
              height: 200,
              width: 200,
            ),
            SizedBox(
              width: 10.h,
            ),
            const SkeletonText(
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}

/// Main Content Loading Screen
class MainContentSkeletonRequest extends StatelessWidget {
  /// Constructor
  const MainContentSkeletonRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(22.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SkeletonText(
              height: 200,
              width: 900,
            ),
            SizedBox(
              height: 20.h,
            ),
            const SkeletonText(
              height: 200,
              width: 900,
            ),
            SizedBox(
              height: 20.h,
            ),
            const SkeletonText(
              height: 200,
              width: 900,
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
