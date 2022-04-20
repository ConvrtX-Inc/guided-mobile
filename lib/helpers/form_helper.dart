// ignore_for_file: avoid_classes_with_only_static_members
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';

/// Utility for form helper
class FormHelper {
  /// Widget for form input field
  static Widget inputFieldWidget(BuildContext context, String keyName,
      Function onValidate, Function onSaved,
      {String initialValue = '',
      bool obscureText = false,
      String inputPlaceHolder = '',
      double separatorHeight = 16}) {
    return TextFormField(
      initialValue: initialValue,
      key: Key(keyName),
      obscureText: obscureText,
      obscuringCharacter: AppTextConstants.biggerBullet,
      validator: (String? val) {
        return onValidate(val);
      },
      onSaved: (String? val) {
        return onSaved(val);
      },
      style: TextStyle(color: AppColors.codGray, fontSize: 18.r),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
        hintText: keyName,
        hintStyle: TextStyle(
          color: AppColors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: Colors.grey, width: 0.2.w),
        ),
      ),
    );
  }
}
