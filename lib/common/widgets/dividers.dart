import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizedBox extends StatelessWidget {
  final double? h;
  final double? w;
  final Widget? child;

  const AppSizedBox({Key? key, this.h, this.w, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h != null ? h!.h : null,
      width: w != null ? w!.w : null,
      child: child,
    );
  }
}
