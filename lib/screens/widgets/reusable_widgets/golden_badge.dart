import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guided/helpers/hexColor.dart';

///Golden Badge
class GoldenBadge extends StatelessWidget {
  ///Constructor
  const GoldenBadge({this.base64Image = '', Key? key}) : super(key: key);

  final String base64Image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 5, color: HexColor('#FFD700')),
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
