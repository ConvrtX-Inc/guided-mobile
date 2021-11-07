import 'package:flutter/material.dart';
import 'package:guided/models/settings.dart';

/// Settings items data generator
class SettingsUtils {
  /// generate mock data
  static List<SettingsModel> getMockedDataSettings() {
    return <SettingsModel>[
      SettingsModel(
          keyName: 'schedule',
          name: 'Schedule',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_schedule.svg',
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
      SettingsModel(
          keyName: 'faq',
          name: 'FAQ',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_faq.svg',
          subSettings: []),
      SettingsModel(
          keyName: 'help',
          name: 'Help',
          icon: 'test',
          color: Colors.black,
          imgUrl: 'assets/images/svg/settings_icon_help.svg',
          subSettings: []),
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
}
