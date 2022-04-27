// ignore_for_file: implementation_imports, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart';
import 'package:guided/models/preset_form_model.dart';
import 'package:guided/routes/route_generator.dart';
import 'package:guided/screens/main_navigation/settings/screens/calendar_management/settings_calendar_management.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widgets for displaying list of user settings
class SettingsItems extends StatefulWidget {
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
  State<SettingsItems> createState() => _SettingsItemsState();
}

class _SettingsItemsState extends State<SettingsItems> {
  bool isEnableTile = true;
  String description = '';
  String id = '';
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        switch (widget._keyName) {
          case 'schedule':
            showAvatarModalBottomSheet(
              expand: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) =>
                  const SettingsCalendarManagement(),
            );
            break;
          case 'transaction_history':
            Navigator.pushNamed(context, '/transaction_history');
            break;
          case 'contact_us':
            Navigator.pushNamed(context, '/contact_us');
            break;
          case 'faq':
            Navigator.pushNamed(context, '/faq');
            break;
          case 'terms_of_service':
            isEnableTile ? getTermsAndCondition(context) : false;
            break;
          case 'traveler_release_waiver_form':
            isEnableTile ? getTravelerAndWaiverForm(context) : false;
            break;
          case 'cancellation_policy':
            isEnableTile ? getCancellationPolicy(context) : false;
            break;
          case 'guided_payment_payout_terms':
            isEnableTile ? getGuidedPaymentPayout(context) : false;
            break;
          case 'local_laws_taxes':
            isEnableTile ? getLocalLaws(context) : false;
            break;
          case 'bank_account':
            Navigator.pushNamed(context, '/add_bank_account');
            break;
          case 'payment':
            Navigator.pushNamed(context, '/payment');
            break;
          case 'switch_user_type':
            Navigator.pushNamed(context, '/switch_user_type');
            break;
          case 'switch_to_guide':
            Navigator.pushNamed(context, '/switch_user_type');
            break;
          case 'availability':
            Navigator.pushNamed(context, '/availability');
            break;
          case 'manage_payment':
            Navigator.pushNamed(context, '/manage_payment');
            break;
          case 'become_a_guide':
            Navigator.pushNamed(context, '/become_a_guide');
            break;
          case 'manage_cards':
            Navigator.pushNamed(context, '/manage_cards');
            break;
        }
      },
      leading: SvgPicture.asset(widget._imgUrl),
      title: Text(
        widget._name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      trailing: const Icon(
        Icons.navigate_next,
        size: 36,
        color: Colors.black,
      ),
    );
  }

  Future<void> getTermsAndCondition(BuildContext context) async {
    setState(() {
      isEnableTile = false;
    });
    final List<PresetFormModel> resForm =
        await APIServices().getTermsAndCondition('terms_and_condition');
    description = resForm[0].description;
    id = resForm[0].id;

    final Map<String, dynamic> details = {
      'id': id,
      'terms_and_condition': description
    };

    setState(() {
      isEnableTile = true;
    });
    await Navigator.pushNamed(context, '/terms_and_condition',
        arguments: details);
  }

  Future<void> getTravelerAndWaiverForm(BuildContext context) async {
    setState(() {
      isEnableTile = false;
    });

    final List<PresetFormModel> resForm =
        await APIServices().getTermsAndCondition('traveler_waiver_form');
    description = resForm[0].description;
    id = resForm[0].id;
    final Map<String, dynamic> details = {
      'id': id,
      'traveler_waiver_form': description
    };

    setState(() {
      isEnableTile = true;
    });
    await Navigator.pushNamed(context, '/waiver_form', arguments: details);
  }

  Future<void> getCancellationPolicy(BuildContext context) async {
    setState(() {
      isEnableTile = false;
    });

    final List<PresetFormModel> resForm =
        await APIServices().getTermsAndCondition('cancellation_policy');
    description = resForm[0].description;
    id = resForm[0].id;
    final Map<String, dynamic> details = {
      'id': id,
      'cancellation_policy': description
    };

    setState(() {
      isEnableTile = true;
    });
    await Navigator.pushNamed(context, '/cancellation_policy',
        arguments: details);
  }

  Future<void> getGuidedPaymentPayout(BuildContext context) async {
    setState(() {
      isEnableTile = false;
    });

    final List<PresetFormModel> resForm =
        await APIServices().getTermsAndCondition('guided_payment_payout');
    description = resForm[0].description;
    id = resForm[0].id;
    final Map<String, dynamic> details = {
      'id': id,
      'guided_payment_payout': description
    };

    setState(() {
      isEnableTile = true;
    });
    await Navigator.pushNamed(context, '/guide_payment_payout_terms',
        arguments: details);
  }

  Future<void> getLocalLaws(BuildContext context) async {
    setState(() {
      isEnableTile = false;
    });

    final List<PresetFormModel> resForm =
        await APIServices().getTermsAndCondition('local_laws');
    description = resForm[0].description;
    id = resForm[0].id;
    final Map<String, dynamic> details = {'id': id, 'local_laws': description};

    setState(() {
      isEnableTile = true;
    });

    await Navigator.pushNamed(context, '/local_laws_taxes_form',
        arguments: details);
  }
}
