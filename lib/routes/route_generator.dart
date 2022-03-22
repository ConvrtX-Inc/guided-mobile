import 'package:flutter/material.dart';
import 'package:guided/screens/activities/activities.dart';

import 'package:guided/screens/cancellation_policy/cancellation_policy_screen.dart';
import 'package:guided/screens/dicovery/discovery.dart';
import 'package:guided/screens/faq/faq.dart';

import 'package:guided/screens/auths/logins/screens/login_screen.dart';
import 'package:guided/screens/auths/splashes/screens/splash_screen.dart';
import 'package:guided/screens/auths/splashes/screens/user_on_boarding_screen.dart';
import 'package:guided/screens/auths/splashes/screens/user_type_screen.dart';
import 'package:guided/screens/auths/splashes/screens/welcome_screen.dart';
import 'package:guided/screens/auths/verifications/screens/create_new_password_screen.dart';
import 'package:guided/screens/auths/verifications/screens/reset_password_screen.dart';
import 'package:guided/screens/auths/verifications/screens/reset_password_verify_phone.dart';
import 'package:guided/screens/cancellation_policy/cancellation_policy_screen.dart';
import 'package:guided/screens/faq/faq.dart';

import 'package:guided/screens/main_navigation/content/advertisements/advertisements_add.dart';
import 'package:guided/screens/main_navigation/content/event/event_add.dart';
import 'package:guided/screens/main_navigation/content/event/event_edit.dart';
import 'package:guided/screens/main_navigation/content/event/event_view.dart';
import 'package:guided/screens/main_navigation/content/packages/package_view.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/outfitter_tab/hub_outfitter.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/outfitter_tab/hub_outfitter_view.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/tab_discovery_hub.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/tab_discovery_hub_view.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_inbox.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_map.dart';

import 'package:guided/screens/main_navigation/traveller/traveller_tabbar.dart';

import 'package:guided/screens/message/message_custom_offer_screen.dart';
import 'package:guided/screens/message/message_individual_screen.dart';
import 'package:guided/screens/home/calendar_availability_screen.dart';
import 'package:guided/screens/home/set_booking_date_screen.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_add.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_edit.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_view.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_edit.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_list.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_view.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/main_navigation/settings/screens/settings_contact_us.dart';
import 'package:guided/screens/main_navigation/settings/screens/settings_guided_payments_payout_terms.dart';
import 'package:guided/screens/main_navigation/settings/screens/settings_local_laws_taxes_form.dart';
import 'package:guided/screens/message/message_custom_offer_screen.dart';
import 'package:guided/screens/message/message_filter_screen.dart';
import 'package:guided/screens/message/message_inbox.dart';
import 'package:guided/screens/message/message_individual_screen.dart';
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
import 'package:guided/screens/requests/ui/request_filter_screen.dart';
import 'package:guided/screens/requests/ui/request_view.dart';
import 'package:guided/screens/requests/ui/requests_screen.dart';
import 'package:guided/screens/settings/profile_screen.dart';
import 'package:guided/screens/signin_signup/phone_number.dart';
import 'package:guided/screens/signin_signup/signup_form.dart';
import 'package:guided/screens/signin_signup/signup_screen.dart';
import 'package:guided/screens/signin_signup/signup_verify_phone.dart';
import 'package:guided/screens/terms_and_condition/terms_and_condition_screen.dart';
import 'package:guided/screens/traveler_waiver_form/traveler_waiver_form_screen.dart';

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
            builder: (_) => const GuideRulesScreen(), settings: settings);
      case '/advertisement_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const AdvertisementView(), settings: settings);
      case '/advertisement_edit':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const AdvertisementEdit(), settings: settings);
      case '/advertisement_add':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const AdvertisementAdd());
      case '/outfitter_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const OutfitterView(), settings: settings);
      case '/outfitter_edit':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const OutfitterEdit(), settings: settings);
      case '/outfitter_list':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const OutfitterList());
      case '/package_photo':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PackagePhotosScreen(), settings: settings);
      case '/package_price':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PackagePriceScreen(), settings: settings);
      case '/waiver':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const WaiverScreen(), settings: settings);
      case '/free_service':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const FreeServicesScreen(), settings: settings);
      case '/location':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const LocationScreen(), settings: settings);
      case '/number_of_traveler':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const NumberOfTravelersScreen(),
            settings: settings);
      case '/local_law_taxes':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const LocalLawsTaxesScreen(), settings: settings);
      case '/package_info':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PackageInfoScreen(), settings: settings);
      case '/package_summary':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PackageSummaryScreen(), settings: settings);
      case '/sign_up':
        return MaterialPageRoute<dynamic>(builder: (_) => const SignupScreen());
      case '/reset_password':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const ResetPasswordScreen());
      case '/continue_with_phone':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const ContinueWithPhone(), settings: settings);
      case '/sign_up_form':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const SignupForm(), settings: settings);
      case '/user_type':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const UserTypeScreen());
      case '/welcome':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const WelcomeScreen());
      case '/user_on_boarding':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const UserOnboardingScreen(), settings: settings);

      case '/terms_and_condition':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TermsAndCondition());
      case '/faq':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const FrequentlyAskQuestion());
      case '/cancellation_policy':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const CancellationPolicy());
      case '/waiver_form':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TravelerReleaseAndWaiverForm());
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
      case '/request_screen':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const RequestsScreen());
      case '/contact_us':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const SettingsContactUs());
      case '/guide_payment_payout_terms':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const GuidedPaymentPayoutTerms());
      case '/local_laws_taxes_form':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const LocalLawsTaxesForm());
      case '/request_filter':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const RequestFilterScreen());
      case '/request_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const RequestViewScreen());
      case '/discovery':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const DiscoveryScreen(), settings: settings);
      case '/activities':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const ActivitiesScreen(), settings: settings);
      case '/traveller_tab':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TravellerTabScreen(), settings: settings);
      case '/package_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PackageView(
                  initIndex: 0,
                ),
            settings: settings);
      case '/traveller_map':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TabMapScreen(), settings: settings);
      case '/discovery_hub':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TabDiscoveryHub());
      case '/discovery_hub_outfitter':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TabDiscoveryHubOutfitter());
      case '/discovery_hub_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TabDiscoveryHubView(), settings: settings);
      case '/discovery_hub_outfitter_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const HubOutfitterView(), settings: settings);
      case '/event_add':
        return MaterialPageRoute<dynamic>(builder: (_) => const EventAdd());
      case '/event_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const EventView(), settings: settings);
      case '/event_edit':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const EventEdit(), settings: settings);
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
