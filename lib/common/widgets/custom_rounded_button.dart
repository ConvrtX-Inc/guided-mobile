import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: HexColor('#C4C4C4'),
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            onPrimary: Colors.white,
          ),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
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
