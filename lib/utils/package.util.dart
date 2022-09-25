import 'package:flutter/material.dart';
import 'package:guided/common/widgets/modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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

Future<T?> showFloatingModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) async {
  return await showCustomModalBottomSheet(
    context: context,
    builder: builder,
    containerWidget: (_, animation, child) => FloatingModal(
      child: child,
    ),
    expand: true,
  );
}
