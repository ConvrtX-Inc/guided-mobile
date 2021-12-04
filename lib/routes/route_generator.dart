import 'package:flutter/material.dart';
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
