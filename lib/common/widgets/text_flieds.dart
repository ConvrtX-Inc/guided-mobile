import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String name;
  final FormFieldValidator<String>? validator;
  final String? label;
  final String? subLabel;
  final String? hintText;
  final int? maxLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final Widget? prefixIcon;

  AppTextField({
    required this.name,
    this.label,
    this.onTap,
    this.subLabel,
    this.validator,
    this.hintText,
    this.maxLines,
    this.maxLength,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        if (label != null) SizedBox(height: 15.h),
        if (subLabel != null)
          Text(
            subLabel!,
            style: const TextStyle(
            ),
          ),
        if (subLabel != null) SizedBox(height: 15.h),
        FormBuilderTextField(
          readOnly: onTap != null,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.grey,
            ),
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: Colors.grey, width: 0.2.w),
            ),
          ),
          name: name,
          validator: validator,
          maxLines: maxLines,
          maxLength: maxLength,
        ),
      ],
    );
  }
}
