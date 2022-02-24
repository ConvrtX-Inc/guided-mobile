import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Global widget for api response message display
class APIMessageDisplay extends StatelessWidget {
  /// Constructor
  const APIMessageDisplay(
      {Key? key,
      this.message = '',
      this.icon = Icons.info,
      this.textCallback,
      this.iconColor = Colors.red})
      : super(key: key);

  /// api message
  final String message;

  /// api icon
  final IconData icon;

  /// function for message callback
  final dynamic textCallback;

  /// api icon color
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
              child: Text(
            message,
            style: const TextStyle(overflow: TextOverflow.clip),
          ))
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('message', message))
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(DiagnosticsProperty<dynamic>('textCallback', textCallback))
      ..add(ColorProperty('iconColor', iconColor));
  }
}
