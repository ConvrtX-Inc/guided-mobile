import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';

/// Widget for home menu titles
class HomeMenuTitles extends StatelessWidget {
  /// Constructor
  const HomeMenuTitles(
      {required int keyNumber,
      required String title,
      required bool isBordered,
      this.setMenuIndex,
      Key? key})
      : _keyNumber = keyNumber,
        _title = title,
        _isBordered = isBordered,
        super(key: key);

  final int _keyNumber;
  final String _title;
  final bool _isBordered;

  /// function to set index in the home menu
  final dynamic setMenuIndex;

  @override
  Widget build(BuildContext context) {
    if (_isBordered) {
      return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 3, color: ConstantHelpers.rangooGreen),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 11),
              ),
              onPressed: () {
                setMenuIndex(_keyNumber);
              },
              child: Text(
                _title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: Colors.black),
              ),
            ),
          ));
    }

    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 11),
      ),
      onPressed: () {
        setMenuIndex(_keyNumber);
      },
      child: Text(
        _title,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: ConstantHelpers.osloGrey),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DiagnosticPropertiesBuilder>(
        'setMenuIndex', setMenuIndex));
  }
}
