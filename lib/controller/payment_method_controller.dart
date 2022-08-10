import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/constants/payment_config.dart';

/// Payment Method Controller
class PaymentMethodController extends GetxController {
  /// Default Payment method
  String paymentMethod = '';

  /// Set Default Payment Method
  void setDefaultPaymentMethod(String data) {

    debugPrint('Data $data');
    paymentMethod = data;
    update();
  }
}
