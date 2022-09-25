import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';

class FloatingModal extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const FloatingModal({Key? key, required this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(vertical: 24),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(24),
          child: child,
        ),
      ),
    );
  }
}

class ModalTitle extends StatelessWidget {
  final String title;

  const ModalTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ModalBackButtonWidget(),
        SizedBox(width: 20.w),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              fontFamily: 'Gilroy',
            ),
          ),
        ),
      ],
    );
  }
}
