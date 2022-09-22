import 'package:flutter/material.dart';

void navigateTo(BuildContext context, String road, Map<String, dynamic> currentArgs) {
  final previous = (ModalRoute.of(context)?.settings.arguments ?? {}) as Map;
  final nav = Navigator.of(context);
  nav.pushNamed(road,
      arguments: {}..addAll({road: currentArgs})..addAll(previous));
}
