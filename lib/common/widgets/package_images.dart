import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageImageWidget extends StatelessWidget {
  final String assetUrl;
  final bool clip;

  const PackageImageWidget({Key? key, required this.assetUrl, this.clip = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: clip
            ? SizedBox.fromSize(
                size: Size.fromHeight(196.h),
                child: Image.asset(assetUrl, fit: BoxFit.cover),
              )
            : Image.asset(assetUrl, fit: BoxFit.cover),
      ),
    );
  }
}
