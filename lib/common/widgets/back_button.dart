import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
      width: 40.w,
      height: 40.h,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: AppColors.harp,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_sharp,
          color: Colors.black,
          size: 25,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ModalBackButtonWidget extends StatelessWidget {
  const ModalBackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
      width: 40.w,
      height: 40.h,
      padding: EdgeInsets.zero,
      child: IconButton(
        icon: const Icon(
          Icons.close,
          color: Colors.black,
          size: 25,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
