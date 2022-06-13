import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';

/// Class for text style design
class AppTextStyle {
  /// Returns oslo grey text style
  static TextStyle greyStyle = TextStyle(
      color: AppColors.osloGrey,
      fontFamily: AppTextConstants.fontGilroy,
      fontWeight: FontWeight.w200,
      fontSize: 12);

  /// Returns black text style
  static TextStyle txtStyle = TextStyle(
    color: Colors.black,
    fontFamily: AppTextConstants.fontGilroy,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );

  /// Returns a black semi bold text style
  static TextStyle semiBoldStyle = TextStyle(
      color: Colors.black,
      fontFamily: AppTextConstants.fontGilroy,
      fontWeight: FontWeight.w600,
      fontSize: 12);

  /// Returns description text style
  static TextStyle descrStyle = TextStyle(
      color: Colors.grey,
      fontFamily: AppTextConstants.fontGilroy,
      fontSize: 14,
      height: 1.5);

  /// Returns description style 1
  static TextStyle descrStyle1 = TextStyle(
      color: Colors.black,
      fontFamily: AppTextConstants.fontGilroy,
      fontSize: 14,
      height: 2);

  /// Returns underlined text style
  static TextStyle underlinedLinkStyle = TextStyle(
    color: AppColors.chateauGreen,
    fontFamily: AppTextConstants.fontGilroy,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );

  /// Returns black text style
  static TextStyle blackStyle = TextStyle(
      color: Colors.black,
      fontFamily: AppTextConstants.fontGilroy,
      fontSize: 12.sp,
      fontWeight: FontWeight.w600);

  /// Returns date text style
  static TextStyle dateStyle = TextStyle(
      color: AppColors.osloGrey,
      fontFamily: AppTextConstants.fontGilroy,
      fontWeight: FontWeight.w200,
      fontSize: 12.sp);

  /// Returns default styling
  static TextStyle defaultStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 12.sp,
      fontFamily: AppTextConstants.fontGilroy);

  /// Returns inactive styling
  static TextStyle inactive = TextStyle(
      color: AppColors.osloGrey,
      fontWeight: FontWeight.w600,
      fontSize: 12.sp,
      fontFamily: AppTextConstants.fontGilroy);

  /// Returns default styling
  static TextStyle activeStyle = TextStyle(
      color: AppColors.deepGreen,
      fontWeight: FontWeight.w600,
      fontSize: 12.sp,
      fontFamily: AppTextConstants.fontGilroy);

  /// Returns style button
  static ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      onPrimary: AppColors.osloGrey,
      side: BorderSide(width: 1.5, color: AppColors.osloGrey),
      textStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          fontFamily: AppTextConstants.fontPoppins),
      fixedSize: const Size(108, 38),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));

  /// Returns active style button
  static ButtonStyle active = ElevatedButton.styleFrom(
      primary: AppColors.lightningYellow,
      elevation: 0,
      shadowColor: Colors.transparent,
      onPrimary: Colors.black,
      // side: BorderSide(width: 1.5, color: AppColors.lightningYellow),
      textStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          fontFamily: AppTextConstants.fontPoppins),
      fixedSize: const Size(108, 38),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));

  /// Returns active style button
  static ButtonStyle activeGreen = ElevatedButton.styleFrom(
      primary: AppColors.deepGreen,
      elevation: 0,
      shadowColor: Colors.transparent,
      onPrimary: Colors.black,
      side: BorderSide(width: 1.5, color: AppColors.deepGreen),
      textStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          fontFamily: AppTextConstants.fontPoppins),
      fixedSize: const Size(108, 38),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));

  /// Returns tbStyle button
  static ButtonStyle tbStyle = TextButton.styleFrom(
    primary: Colors.black,
    textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: AppTextConstants.fontGilroy),
  );
}

/// Class for header text widget
class HeaderText {
  /// Constructor
  HeaderText(final String text);

  /// Widget
  static Widget headerText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 24, fontFamily: 'Gilroy'
            // fontFamily: 'GilRoy',
            ),
      ),
    );
  }
}

/// Class for sub header text
class SubHeaderText {
  /// Constructor
  SubHeaderText(final String text);

  /// Widget
  static Widget subHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gilroy',
        fontSize: 15,
      ),
    );
  }
}
