import 'package:flutter/material.dart';
import 'package:guided/screens/auths/logins/screens/login_screen.dart';
import 'package:guided/screens/auths/splashes/screens/splash_screen.dart';
import 'package:guided/screens/auths/splashes/screens/user_on_boarding_screen.dart';
import 'package:guided/screens/auths/splashes/screens/user_type_screen.dart';
import 'package:guided/screens/auths/splashes/screens/welcome_screen.dart';
import 'package:guided/screens/auths/verifications/screens/create_new_password_screen.dart';
import 'package:guided/screens/auths/verifications/screens/reset_password_screen.dart';
import 'package:guided/screens/auths/verifications/screens/reset_password_verify_phone.dart';
import 'package:guided/screens/home/calendar_availability_screen.dart';
import 'package:guided/screens/home/set_booking_date_screen.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_edit.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_view.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_edit.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_list.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_view.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/message/message_filter_screen.dart';
import 'package:guided/screens/message/message_inbox.dart';
import 'package:guided/screens/notification/notification_screen.dart';
import 'package:guided/screens/packages/create_package/create_package_screen.dart';
import 'package:guided/screens/packages/create_package/free_service_screen.dart';
import 'package:guided/screens/packages/create_package/guide_rules_screen.dart';
import 'package:guided/screens/packages/create_package/local_laws_taxes_screen.dart';
import 'package:guided/screens/packages/create_package/location_screen.dart';
import 'package:guided/screens/packages/create_package/number_of_traveler_screen.dart';
import 'package:guided/screens/packages/create_package/package_info_screen.dart';
import 'package:guided/screens/packages/create_package/package_photos_screen.dart';
import 'package:guided/screens/packages/create_package/package_price_screen.dart';
import 'package:guided/screens/packages/create_package/package_summary_screen.dart';
import 'package:guided/screens/packages/create_package/waiver_screen.dart';
import 'package:guided/screens/settings/profile_screen.dart';
import 'package:guided/screens/signin_signup/phone_number.dart';
import 'package:guided/screens/signin_signup/signup_form.dart';
import 'package:guided/screens/signin_signup/signup_screen.dart';
import 'package:guided/screens/signin_signup/signup_verify_phone.dart';

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
      case '/splash_screen':
        return MaterialPageRoute<dynamic>(builder: (_) => const SplashScreen());
      case '/profile':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const ProfileScreen());
      case '/main_navigation':
        return MaterialPageRoute<dynamic>(
            builder: (_) =>
                const MainNavigationScreen(navIndex: 0, contentIndex: 0));
      case '/create_package':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const CreatePackageScreen());
      case '/calendar_availability':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const CalendarAvailabilityScreen());
      case '/set_booking_date':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const SetBookingDateScreen());
      case '/guide_rule':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const GuideRulesScreen());
      case '/advertisement_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const AdvertisementView());
      case '/advertisement_edit':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const AdvertisementEdit());
      case '/outfitter_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const OutfitterView());
      case '/outfitter_edit':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const OutfitterEdit());
      case '/outfitter_list':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const OutfitterList());
      case '/package_photo':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PackagePhotosScreen());
      case '/package_price':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PackagePriceScreen());
      case '/waiver':
        return MaterialPageRoute<dynamic>(builder: (_) => const WaiverScreen());
      case '/free_service':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const FreeServicesScreen());
      case '/location':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const LocationScreen());
      case '/number_of_traveler':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const NumberOfTravelersScreen());
      case '/local_law_taxes':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const LocalLawsTaxesScreen());
      case '/package_info':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PackageInfoScreen());
      case '/package_summary':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PackageSummaryScreen());
      case '/sign_up':
        return MaterialPageRoute<dynamic>(builder: (_) => const SignupScreen());
      case '/reset_password':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const ResetPasswordScreen());
      case '/continue_with_phone':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const ContinueWithPhone());
      case '/sign_up_form':
        return MaterialPageRoute<dynamic>(builder: (_) => const SignupForm());
      case '/user_type':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const UserTypeScreen());
      case '/welcome':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const WelcomeScreen());
      case '/user_on_boarding':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const UserOnboardingScreen());
      case '/verification_code':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const ResetVerifyPhone(), settings: settings);
      case '/create_new_password':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const CreateNewPasswordScreen(),
            settings: settings);
      case '/sign_up_verify':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const SignupVerify(), settings: settings);
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
