import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

///DateTimeAgo
class DateTimeAgo extends StatelessWidget {
  ///Constructor
  const DateTimeAgo(
      {String dateString = '',
      Color color = Colors.white,
      double size = 12,
      TextAlign textAlign = TextAlign.left,
      Key? key})
      : _dateString = dateString,
        _color = color,
        _size = size,
        _textAlign = textAlign,
        super(key: key);

  ///Date param in String
  final String _dateString;

  ///Color of the date
  final Color _color;

  ///Font size of the date
  final double _size;

  ///Text align
  final TextAlign _textAlign;

  @override
  Widget build(BuildContext context) {
    return Timeago(
      builder: (_, String value) =>
          Text(value, textAlign: _textAlign, style: TextStyle(fontSize: _size, color: _color)),
      date: DateTime.parse(_dateString),
      allowFromNow: true,
    );
  }
}
