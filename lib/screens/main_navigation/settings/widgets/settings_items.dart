// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart';
import 'package:guided/screens/main_navigation/settings/screens/calendar_management/settings_calendar_management.dart';

/// Widgets for displaying list of user settings
class SettingsItems extends StatelessWidget {
  /// Constructor
  const SettingsItems(
      {String keyName = '', String imgUrl = '', String name = '', Key? key})
      : _keyName = keyName,
        _imgUrl = imgUrl,
        _name = name,
        super(key: key);

  final String _keyName;
  final String _imgUrl;
  final String _name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        switch (_keyName) {
          case 'schedule':
            showAvatarModalBottomSheet(
              expand: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) =>
                  const SettingsCalendarManagement(),
            );
            break;
          case 'contact_us':
            Navigator.pushNamed(context, '/contact_us');
            break;
          case 'faq':
            Navigator.pushNamed(context, '/faq');
            break;
          case 'terms_of_service':
            Navigator.pushNamed(context, '/terms_and_condition');
            break;
          case 'traveler_release_waiver_form':
            Navigator.pushNamed(context, '/waiver_form');
            break;
          case 'cancellation_policy':
            Navigator.pushNamed(context, '/cancellation_policy');
            break;
          case 'guided_payment_payout_terms':
            Navigator.pushNamed(context, '/guide_payment_payout_terms');
            break;
          case 'local_laws_taxes':
            Navigator.pushNamed(context, '/local_laws_taxes_form');
            break;
          case 'bank_account':
            Navigator.pushNamed(context, '/add_bank_account');
            break;
          case 'payment':
            Navigator.pushNamed(context, '/payment');
            break;
        }
      },
      leading: SvgPicture.asset(_imgUrl),
      title: Text(
        _name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      trailing: const Icon(
        Icons.navigate_next,
        size: 36,
        color: Colors.black,
      ),
    );
  }
}
