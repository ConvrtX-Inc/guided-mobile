// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/certificate.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/activities/screens/activities.dart';
import 'package:guided/screens/activities/screens/activity_package_info.dart';
import 'package:guided/screens/auths/splashes/splash.dart';
import 'package:guided/screens/bank_accounts/add_bank_account.dart';
import 'package:guided/screens/bank_accounts/manage_payment.dart';
import 'package:guided/screens/bookings/screens/my_booking_date.dart';

import 'package:guided/screens/cancellation_policy/cancellation_policy_screen.dart';
import 'package:guided/screens/dicovery/discovery.dart';
import 'package:guided/screens/dicovery/discovery_map.dart';
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
import 'package:guided/screens/home/availability_booking_dates.dart';

import 'package:guided/screens/main_navigation/content/advertisements/advertisements_add.dart';
import 'package:guided/screens/main_navigation/content/event/event_add.dart';
import 'package:guided/screens/main_navigation/content/event/event_edit.dart';
import 'package:guided/screens/main_navigation/content/event/event_view.dart';
import 'package:guided/screens/main_navigation/content/packages/package_view.dart';
import 'package:guided/screens/main_navigation/content/packages/packages_edit.dart';
import 'package:guided/screens/main_navigation/content/packages/tab/tab_destination_edit.dart';
import 'package:guided/screens/main_navigation/traveller/booking_journey/details.dart';
import 'package:guided/screens/main_navigation/traveller/check_availability/check_availability.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/popular_guides_list.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/popular_guides_view.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/tabs/popular_guides_traveler_limit_schedules.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/event_tab/hub_event_list.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/event_tab/hub_event_view.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/outfitter_tab/hub_outfitter_list.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/outfitter_tab/hub_outfitter_view.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/tab_discovery_hub.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/tab_discovery_hub_view.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_inbox.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_map.dart';

import 'package:guided/screens/main_navigation/traveller/traveller_tabbar.dart';
import 'package:guided/screens/maps/activity_map.dart';

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
import 'package:guided/screens/main_navigation/settings/screens/settings_switch_user_type.dart';
import 'package:guided/screens/main_navigation/settings/screens/settings_availability.dart';
import 'package:guided/screens/main_navigation/settings/screens/settings_become_a_guide.dart';
import 'package:guided/screens/message/message_custom_offer_screen.dart';
import 'package:guided/screens/message/message_filter_screen.dart';
import 'package:guided/screens/message/message_inbox.dart';
import 'package:guided/screens/message/message_individual_screen.dart';
import 'package:guided/screens/message/message_screen_traveler.dart';
import 'package:guided/screens/notification/notification_screen.dart';
import 'package:guided/screens/notification/notifications_traveler.dart';
import 'package:guided/screens/packages/create_package/create_package_screen.dart';
import 'package:guided/screens/packages/create_package/free_service_screen.dart';
import 'package:guided/screens/packages/create_package/guide_rules_screen.dart';
import 'package:guided/screens/packages/create_package/local_laws_taxes_screen.dart';
import 'package:guided/screens/packages/create_package/location_screen.dart';
import 'package:guided/screens/packages/create_package/not_included_free_services.dart';
import 'package:guided/screens/packages/create_package/number_of_traveler_screen.dart';
import 'package:guided/screens/packages/create_package/package_info_screen.dart';
import 'package:guided/screens/packages/create_package/package_photos_screen.dart';
import 'package:guided/screens/packages/create_package/package_price_screen.dart';
import 'package:guided/screens/packages/create_package/package_summary_screen.dart';
import 'package:guided/screens/packages/create_package/waiver_screen.dart';
import 'package:guided/screens/passwords/change_password.dart';
import 'package:guided/screens/payment/payment_method.dart';
import 'package:guided/screens/payments/payment_add_card.dart';

import 'package:guided/screens/profile/main_profile.dart';
import 'package:guided/screens/profile/profile_details/about_me/screen/edit_profile.dart';
import 'package:guided/screens/profile/profile_details/certificate/screen/add_certificate_modal.dart';
import 'package:guided/screens/profile/profile_details/certificate/screen/certificate_screen.dart';
import 'package:guided/screens/profile/profile_details/certificate/screen/edit_certificate.dart';
import 'package:guided/screens/profile/profile_details/certificate/screen/view_certificate.dart';
import 'package:guided/screens/profile/reviews_profile.dart';

import 'package:guided/screens/payments/payment_edit_card.dart';
import 'package:guided/screens/payments/payment_manage_card.dart';
import 'package:guided/screens/refunds/guide/refund.dart';
import 'package:guided/screens/refunds/traveler/request_refund.dart';

import 'package:guided/screens/requests/ui/request_filter_screen.dart';
import 'package:guided/screens/requests/ui/request_view.dart';
import 'package:guided/screens/requests/ui/requests_screen.dart';
import 'package:guided/screens/search/place_search.dart';
import 'package:guided/screens/settings/edit_profile.dart';
import 'package:guided/screens/settings/edit_profile_traveller.dart';
import 'package:guided/screens/settings/profile_screen.dart';
import 'package:guided/screens/settings/subscription_details.dart';
import 'package:guided/screens/settings/update_phone_number.dart';
import 'package:guided/screens/signin_signup/phone_number.dart';
import 'package:guided/screens/signin_signup/signup_form.dart';
import 'package:guided/screens/signin_signup/signup_screen.dart';
import 'package:guided/screens/signin_signup/signup_verify_phone.dart';
import 'package:guided/screens/stripe/setup_stripe.dart';
import 'package:guided/screens/terms_and_condition/terms_and_condition_screen.dart';
import 'package:guided/screens/transaction_notifications/transaction_history_main.dart';
import 'package:guided/screens/traveler_waiver_form/traveler_waiver_form_screen.dart';

import '../screens/main_navigation/settings/screens/calendar_management/settings_calendar_management.dart';
import '../screens/main_navigation/settings/screens/settings_main.dart';
import '../screens/main_navigation/traveller/booking_journey/check_activity_availability.dart';
import '../screens/main_navigation/traveller/booking_journey/go_to_paymentmethod.dart';
import '../screens/main_navigation/traveller/booking_journey/guide_screen.dart';
import '../screens/main_navigation/traveller/booking_journey/request_to_book.dart';

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
        return MaterialPageRoute<dynamic>(
          builder: (_) => const LoginScreen(),
        );
      case '/message_filter':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const MessageFilterScreen());
      case '/message_inbox':
        return MaterialPageRoute<dynamic>(builder: (_) => const MessageInbox());
      case '/message_individual':
        return MaterialPageRoute<dynamic>(builder: (_) => MessageIndividual());
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
            builder: (_) => const CalendarAvailabilityScreen(),
            settings: settings);
      case '/set_booking_date':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const SetBookingDateScreen(), settings: settings);
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
            builder: (_) => const TermsAndCondition(), settings: settings);
      case '/faq':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const FrequentlyAskQuestion());
      case '/cancellation_policy':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const CancellationPolicy(), settings: settings);
      case '/waiver_form':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TravelerReleaseAndWaiverForm(),
            settings: settings);
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
            builder: (_) => const GuidedPaymentPayoutTerms(),
            settings: settings);
      case '/local_laws_taxes_form':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const LocalLawsTaxesForm(), settings: settings);
      case '/request_filter':
        return MaterialPageRoute<dynamic>(
            builder: (_) =>
                RequestFilterScreen(selectedFilter: args! as String));
      case '/request_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => RequestViewScreen(params: args));
      case '/discovery':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const DiscoveryScreen(), settings: settings);
      case '/discovery_map':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const DiscoveryMapScreen(), settings: settings);
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
      case '/checkAvailability':
        return MaterialPageRoute<dynamic>(
            builder: (_) => CheckAvailability(screenArguments: args),
            settings: settings);
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
      case '/availability_booking_dates':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const AvailabilityBookingDateScreen(),
            settings: settings);
      case '/main_profile':
        return MaterialPageRoute<dynamic>(
            builder: (_) => MainProfileScreen(userId: args as String));
      case '/reviews_profile':
        return MaterialPageRoute<dynamic>(
            builder: (_) =>
                ReviewsProfileScreen(profileDetails: args! as User));
      case '/payment':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TabMapScreen(), settings: settings);
      case '/transaction_history':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TransactionHistoryMain(), settings: settings);
      case '/':
        return MaterialPageRoute<dynamic>(builder: (_) => const Splash());
      case '/package_edit':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PackageEdit(), settings: settings);
      case '/settingsCalendarManagement':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const SettingsCalendarManagement(),
            settings: settings);
      case '/checkActivityAvailabityScreen':
        return MaterialPageRoute<dynamic>(
            builder: (_) => CheckActivityAvailabityScreen(params: args),
            settings: settings);
      case '/travellerBookingDetailsScreen':
        return MaterialPageRoute<dynamic>(
          builder: (_) => TravellerBookingDetailsScreen(params: args),
        );
      case '/requestToBookScreen':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const RequestToBookScreen(), settings: settings);
      case '/goToPaymentMethod':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const GoToPaymentMethod(), settings: settings);
      case '/add_bank_account':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const AddBankAccountScreen());
      case '/manage_payment':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const ManagePayment());
      case '/payment_edit_card':
        return MaterialPageRoute<dynamic>(
            builder: (_) => PaymentEditCard(card: args! as CardModel));
      case '/switch_user_type':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const SettingsSwitchUserType());
      case '/become_a_guide':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const SettingsBecomeAGuide());
      case '/availability':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const SettingsAvailability());
      case '/popular_guides_list':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PopularGuidesList());
      case '/popular_guides_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PopularGuidesView(
                  initIndex: 0,
                ),
            settings: settings);
      case '/add_card':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PaymentAddCard());
      case '/popular_guides_traveler_limit_schedules':
        return MaterialPageRoute<dynamic>(
            builder: (_) => PopularGuidesTravelerLimitSchedules(
                  packageId: '',
                  price: '',
                ));
      case '/refund':
        return MaterialPageRoute<dynamic>(builder: (_) => const RefundScreen());
      case '/request_refund':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const RequestRefund());
      case '/hub_event_view':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const HubEventView(), settings: settings);
      case '/discovery_hub_events':
        return MaterialPageRoute<dynamic>(builder: (_) => const HubEventList());
      case '/edit_profile':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const EditProfileScreen());

      ///Profile
      case '/profile-certificate':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const CertificateScreen());
      case '/profile-edit':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const UpdateProfileScreen());
      case '/test':
        return MaterialPageRoute<dynamic>(builder: (_) => SettingsMain());
      case '/manage_cards':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PaymentManageCard());
      case '/traveller_message':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const MessageScreenTraveler());
      case '/setup_stripe_account':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const SetupStripeAccount());
      case '/tab_destination_edit':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const TabDestinationEditScreen(),
            settings: settings);
      case '/not_included_free_service':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const NotIncludedFreeServicesScreen(),
            settings: settings);
      case '/notification_traveler':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const NotificationTraveler());
      case '/popular_guide_list':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PopularGuidesList());
      case '/add_certificate':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const AddCertificate());
      case '/edit_certificate':
        return MaterialPageRoute<dynamic>(
            builder: (_) => EditCertificate(certificate: args! as Certificate));
      case '/subscription_details':
        return MaterialPageRoute<dynamic>(
            builder: (_) => SubscriptionDetails());
      case '/edit_profile_traveler':
        return MaterialPageRoute<dynamic>(
            builder: (_) => EditProfileTraveler());
      case '/change_password':
        return MaterialPageRoute<dynamic>(
            builder: (_) => ChangePasswordScreen());
      case '/activity_package_info':
        return MaterialPageRoute<dynamic>(
            builder: (_) =>
                ActivityPackageInfo(package: args! as ActivityPackage));
      case '/view_certificate':
        return MaterialPageRoute<dynamic>(
            builder: (_) => CertificateView(certificate: args! as Certificate));
      case '/change_phone_number':
        return MaterialPageRoute<dynamic>(builder: (_) => UpdatePhoneNumber());

      case '/search_place':
        return MaterialPageRoute<dynamic>(builder: (_) => SearchPlace());

      case '/activity_map':
        return MaterialPageRoute<dynamic>(
            builder: (_) => ActivityFindMap(params: args));
      case '/manage_payment_method':
        return MaterialPageRoute<dynamic>(
            builder: (_) => const PaymentMethodScreen());

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
