import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

///Skeleton Text
class SkeletonText extends StatelessWidget {
  ///Constructor
  const SkeletonText({
    this.height = 20,
    this.width = 20,
    this.radius = 100,
    this.shape = BoxShape.rectangle,
    Key? key}) : super(key: key);

  final double height;

  final double width;

  final BoxShape shape;

  final double radius;
  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      curve: Curves.linear,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius:shape != BoxShape.circle ? BorderRadius.circular(10.0) : null,
            shape:  shape,
            color: Colors.grey[300]),
      ),
    );
  }
}
