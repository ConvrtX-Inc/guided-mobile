import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';

// import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';

/// Custom rounded button widget
class CustomRoundedButton extends StatelessWidget {
  /// constructor
  const CustomRoundedButton(
      {required this.title,
      required this.onpressed,
      this.isLoading = false,
      this.buttonHeight = 60,
      this.buttonWidth,
      this.isEnabled = true,
      Key? key})
      : super(key: key);

  /// button name
  final String title;

  /// button function
  final dynamic onpressed;

  ///isloading
  final bool isLoading;

  ///height
  final double buttonHeight;

  ///width
  final double? buttonWidth;

  ///Is enabled
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth ?? MediaQuery.of(context).size.width,
      height: buttonHeight,
      child: ElevatedButton(
          onPressed: !isLoading ? onpressed : null,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              // side: BorderSide(
              //   color: !isLoading ? Colors.white:  AppColors.deepGreen,
              // ),
              borderRadius: BorderRadius.circular(18),
            ),
            onPrimary: Colors.white,
            primary: AppColors.deepGreen,
          ),
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 10.w),
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                )),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<Object>('onpressed', onpressed));
  }
}
