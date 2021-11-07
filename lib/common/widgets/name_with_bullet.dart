import 'package:flutter/material.dart';

/// List with bullet
class MyListWithBullet extends StatelessWidget {
  /// Constructor
  const MyListWithBullet(
      {required String text,
      required double height,
      required double width,
      required Color color,
      Key? key})
      : _text = text,
        _height = height,
        _width = width,
        _color = color,
        super(key: key);

  final String _text;
  final double _height;
  final double _width;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          Icons.fiber_manual_record,
          color: _color,
          size: 16,
        ),
        title: Transform.translate(
          offset: const Offset(-28, -4),
          child: Text(
            _text,
            style: TextStyle(
                color: _color, fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
