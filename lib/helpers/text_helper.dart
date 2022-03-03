// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';

/// Helper for text
class TextHelper {
  /// Widget for error text
  static Widget errorTextDisplay(
    String errorText,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: <Widget>[
          Text(
            AppTextConstants.biggerBullet,
            style: const TextStyle(color: Colors.red),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  ///Widget for no available data text
  static Widget noAvailableDataTextDisplay() {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Text(
        AppTextConstants.noAvailableData,
        style: const TextStyle(color: Colors.grey),
      ),
    ));
  }

  ///Widget for  an error occurred  text
  static Widget anErrorOccurredTextDisplay() {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Text(
        AppTextConstants.anErrorOccurred,
        style: const TextStyle(color: Colors.red),
      ),
    ));
  }
}
