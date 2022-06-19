import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';

/// App Snackbars
class AppSnackbars {
  /// Show success snackbar
  void success(
      {required BuildContext context,
      required String message,
      Duration duration = const Duration(seconds: 1)}) {
    AdvanceSnackBar(
            mode: 'MODERN', isIcon: true, duration: duration, message: message)
        .show(context);
  }

  /// Show error snackbar
  void error(
      {required BuildContext context,
      required String message,
      Duration duration = const Duration(seconds: 1)}) {
    AdvanceSnackBar(
            mode: 'MODERN',
            type: 'ERROR',
            isIcon: true,
            duration: duration,
            message: message)
        .show(context);
  }
}
