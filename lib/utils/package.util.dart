import 'package:flutter/material.dart';

void navigateTo(
    BuildContext context, String road, Map<dynamic, dynamic> currentArgs) {
  final previous = (ModalRoute.of(context)?.settings.arguments ?? {}) as Map;
  final nav = Navigator.of(context);
  final name = ModalRoute.of(context)?.settings.name;
  final allArgs = {}
    ..addAll({name: currentArgs})
    ..addAll(previous);
  nav.pushNamed(road, arguments: allArgs);
}
