import 'package:flutter/material.dart';
import 'package:guided/screens/messsage/message_custom_offer_screen.dart';
import 'package:guided/screens/messsage/message_filter_screen.dart';
import 'package:guided/screens/messsage/message_inbox_screen.dart';
import 'package:guided/screens/messsage/message_individual_screen.dart';
import 'package:guided/screens/notification/notification_screen.dart';
import 'package:guided/signin_signup/login_screen.dart';

/// Route generator configuration
class RouteGenerator {
  /// Generate route function
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final Object? args = settings.arguments;
    // Obtain a list of the available cameras on the device.
    switch (settings.name) {
      case '/notification':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const NotificationScreen());
      case '/login':
        return MaterialPageRoute<dynamic>(builder: (_) => const LoginScreen());
      case '/message_filter':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const MessageFilterScreen());
      case '/message_inbox':
        return MaterialPageRoute<dynamic>(builder: (_) => const MessageInbox());
      case '/message_individual':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const MessageIndividual());
      case '/message_custom_offer':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const MessageCustomOffer());
      default:
        return _errorRoute();
    }
  }

  /// Route for erroneous navigation
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
