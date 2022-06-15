import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';

///Skeleton List View for fake data
class SkeletonListView extends StatelessWidget {
  ///Constructor
  const SkeletonListView(
      {Key? key,
      this.itemCount = 5,
      this.avatarShape = BoxShape.circle,
      this.avatarHeight = 100,
      this.avatarWidth = 70})
      : super(key: key);

  final int itemCount;

  final BoxShape avatarShape;

  final double avatarHeight;

  final double avatarWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: SkeletonText(
            height: avatarHeight,
            width: avatarWidth,
            shape: avatarShape,
          ),
          title: SkeletonText(
            width: 200.w,
            height: 16.h,
          ),
          subtitle: SkeletonText(
            width: 100.w,
            height: 16.h,
          ),
        );
      },
    );
  }
}
