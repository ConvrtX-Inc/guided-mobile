import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:guided/constants/app_colors.dart';
// import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';

/// Custom rounded button widget
class CustomRoundedButton extends StatelessWidget {
  /// constructor
  const CustomRoundedButton({required this.title, required this.onpressed, Key? key}) : super(key: key);

  /// button name
  final String title;
  /// button function
  final dynamic onpressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.deepGreen,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          onPrimary: Colors.white,
          primary: AppColors.deepGreen,
        ),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
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
