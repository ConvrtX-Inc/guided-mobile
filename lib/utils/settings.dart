import 'package:flutter/material.dart';
import 'package:guided/models/settings.dart';

/// Settings items data generator
class SettingsUtils {
  /// generate mock data
  static List<SettingsModel> getMockedDataSettings() {
    return <SettingsModel>[
      SettingsModel(
          keyName: 'availability',
          name: 'Availability',
          icon: 'calendar',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_availability.svg',
          subSettings: []),
      // SettingsModel(
      //     keyName: 'schedule',
      //     name: 'Schedule',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_schedule.svg',
      //     subSettings: []),
      SettingsModel(
          keyName: 'manage_payment',
          name: 'Payment',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_payment.svg',
          subSettings: []),
      SettingsModel(
          keyName: 'transaction_history',
          name: 'Transaction History',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_transaction_history.svg',
          subSettings: []),
      SettingsModel(
          keyName: 'switch_user_type',
          name: 'Switch User Type',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_switch_user_type.svg',
          subSettings: []),
      SettingsModel(
          keyName: 'contact_us',
          name: 'Contact Us',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_contact_us.svg',
          subSettings: []),
      // SettingsModel(
      //     keyName: 'faq',
      //     name: 'FAQ',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_faq.svg',
      //     subSettings: []),
      // SettingsModel(
      //     keyName: 'help',
      //     name: 'Help',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_help.svg',
      //     subSettings: []),
      SettingsModel(
          keyName: 'terms_of_service',
          name: 'Terms of Service',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_documents.svg',
          subSettings: []),
      SettingsModel(
          keyName: 'traveler_release_waiver_form',
          name: 'Traveler Release & Waiver Form',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_documents.svg',
          subSettings: []),
      SettingsModel(
          keyName: 'cancellation_policy',
          name: 'Cancellation Policy',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_documents.svg',
          subSettings: []),
      SettingsModel(
          keyName: 'guided_payment_payout_terms',
          name: 'Guided Payment & Payout Terms',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_documents.svg',
          subSettings: []),
      SettingsModel(
          keyName: 'local_laws_taxes',
          name: 'Local Laws & Taxes',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_documents.svg',
          subSettings: []),
    ];
  }

  /// generate mock data for traveller settings
  static List<SettingsModel> getMockedTravellerDataSettings() {
    return <SettingsModel>[
      /*SettingsModel(
          keyName: 'availability',
          name: 'Availability',
          icon: 'calendar',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_availability.svg',
          subSettings: []),*/
      SettingsModel(
          keyName: 'my_booking',
          name: 'My Bookings',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_calendar.svg',
          subSettings: []),
      // SettingsModel(
      //     keyName: 'personal_information',
      //     name: 'Personal Information',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_person.svg',
      //     subSettings: []),
      SettingsModel(
          keyName: 'manage_cards',
          name: 'Payment',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_payment.svg',
          subSettings: []),
      SettingsModel(
          keyName: 'premium_subscription',
          name: 'Premium Subscription',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/png/discoveryTree.png',
          subSettings: []),
      SettingsModel(
          keyName: 'notification_traveler',
          name: 'Notifications',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_notificationbell.svg',
          subSettings: []),
      // SettingsModel(
      //     keyName: 'review',
      //     name: 'Reviews',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_star.svg',
      //     subSettings: []),
      SettingsModel(
          keyName: 'switch_to_guide',
          name: 'Switch To Guide',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_infinite_arrow.svg',
          subSettings: []),
      // SettingsModel(
      //     keyName: 'transaction_history',
      //     name: 'Transaction History',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_transaction_history.svg',
      //     subSettings: []),
      // SettingsModel(
      //     keyName: 'help',
      //     name: 'Help',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_exclamation.svg',
      //     subSettings: []),
      // SettingsModel(
      //     keyName: 'faq',
      //     name: 'FAQ',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_bubble_question.svg',
      //     subSettings: []),
      SettingsModel(
          keyName: 'contact_us',
          name: 'Contact Us',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_person_filled.svg',
          subSettings: []),
      // SettingsModel(
      //     keyName: 'terms_and_condition',
      //     name: 'Terms & Condition',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_short_paper.svg',
      //     subSettings: []),
      // SettingsModel(
      //     keyName: 'local_laws_and_taxes',
      //     name: 'Local Laws & Taxes',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_long_paper.svg',
      //     subSettings: []),
      // SettingsModel(
      //     keyName: 'traveler_release_waiver_form',
      //     name: 'Traveler Release & Waiver Form',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_long_paper.svg',
      //     subSettings: []),
      // SettingsModel(
      //     keyName: 'cancellation_policy',
      //     name: 'Cancellation Policy',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_long_paper.svg',
      //     subSettings: []),
      // SettingsModel(
      //     keyName: 'guided_payment',
      //     name: 'GuidED Payment & Payout Terms',
      //     icon: 'test',
      //     color: Colors.black,
      //     imgUrl: 'assets/images/svg/settings_icon_long_paper.svg',
      //     subSettings: []),
    ];
  }
}
