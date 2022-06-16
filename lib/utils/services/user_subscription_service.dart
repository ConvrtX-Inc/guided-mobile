import 'package:get/get.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'package:guided/models/user_subscription.dart';

import 'package:guided/utils/services/rest_api_service.dart';

///Service for User Subscription
class UserSubscriptionServices {
  final UserSubscriptionController _subscriptionController =
      Get.put(UserSubscriptionController());


  Future<bool> hasUserSubscription() async {
    final UserSubscription subscription =
        await APIServices().getUserSubscription();

    bool hasPremiumSubscription = false;

    if (subscription.id.isNotEmpty) {
      final DateTime currentDate = DateTime.now();
      final DateTime endDate = DateTime.parse(subscription.endDate);

      final bool isExpired = endDate.isBefore(currentDate);

      if (!isExpired) {
        hasPremiumSubscription = true;
      }
      _subscriptionController.setSubscription(subscription);
    }

    return hasPremiumSubscription;
  }
}
