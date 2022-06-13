import 'package:flutter/services.dart';

/// App Input Formatter
class AppInputFormatters {
  ///Constructor
   AppInputFormatters();

  ///Input Formatter for Name
  static TextInputFormatter name =
      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z -]'));
}
