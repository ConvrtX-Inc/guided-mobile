import 'dart:convert';

import 'package:flutter/material.dart';

///White border Badge
class WhiteBorderBadge extends StatelessWidget {
  ///Constructor
  const WhiteBorderBadge({this.base64Image = '', Key? key}) : super(key: key);

  final String base64Image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.white),
          borderRadius: BorderRadius.circular(50)),
      child: Image.memory(
        base64.decode(base64Image.split(',').last),
        gaplessPlayback: true,
        width: 30,
        height: 30,
      ),
    );
  }
}
