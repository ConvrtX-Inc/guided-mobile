import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';

///Widget for BorderedTextfield
class BorderedTextField extends StatelessWidget {
  ///Constructor
  const BorderedTextField(
      {required this.labelText,
      required this.hintText,
      this.borderColor = Colors.grey,
      this.controller,
      this.onChanged,
      this.onSaved,
      this.onValidate,
      this.maxLines,
      this.minLines = 1,
      this.showLabel = true,
      Key? key})
      : super(key: key);

  final String hintText;
  final Color borderColor;
  final String labelText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function? onSaved;
  final Function? onValidate;
  final bool showLabel;
  final dynamic maxLines;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (showLabel)
          Text(
            labelText,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          minLines: minLines,
          validator: (String? val) {
            if (onValidate != null) {
              return onValidate!(val);
            }
          },
          onSaved: (String? val) {
            if (onSaved != null) {
              return onSaved!(val);
            }
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: Colors.grey, width: 0.2.w),
            ),
          ),
        ),
      ],
    );
  }
}
