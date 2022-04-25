import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/models/user_subscription.dart';

///User User Subscription controller
class UserSubscriptionController extends GetxController {

  /// Profile Details
  UserSubscription  userSubscription =   UserSubscription();

  /// Set User Subscription function
  void setSubscription(UserSubscription data) {
    debugPrint('Data $data');
    userSubscription = data;
    update();
  }
}
