
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'package:guided/utils/secure_storage.dart';

/// App Auth service
class AuthServices{

  /// Logout and clear storage/current state
  Future<void> logout(BuildContext context) async {
    //Clear Secure storage
    await SecureStorage.clearAll();

    // clear get x controllers
    await Get.delete<UserProfileDetailsController>();
    await Get.delete<CardController>();
    await Get.delete<UserSubscriptionController>();

    // Navigate to Select user type Screen
    await Navigator.of(context)
        .pushNamedAndRemoveUntil('/user_type',
            (Route<dynamic> route) => false);
  }
}