// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/data/adventure_feature.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/common/widgets/simple_text_modal.dart';
import 'package:guided/common/widgets/vehicule_operator_modal.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

/// Create Package Screen
class WhatIsIncludedInYourAdventureScreen extends StatefulWidget {
  /// Constructor
  const WhatIsIncludedInYourAdventureScreen({Key? key}) : super(key: key);

  @override
  _WhatIsIncludedInYourAdventureScreenState createState() =>
      _WhatIsIncludedInYourAdventureScreenState();
}

class _WhatIsIncludedInYourAdventureScreenState
    extends State<WhatIsIncludedInYourAdventureScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _drivingOnAdventure = <AdventureFeature>[];

  @override
  void initState() {
    super.initState();
    _drivingOnAdventure.addAll([
      AdventureFeature("Driving (Car, ATV's, Snowmobiles, etc?)"),
      AdventureFeature("Boating (Motor Boat, Sailboat, Seadoo's, etc)"),
      AdventureFeature("Motorcycle or Dirt Bikes"),
      AdventureFeature("Flying (Plane, Helicopter, Hot Air Balloon etc)"),
      AdventureFeature("My Adventure does not include any of these.", false),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Next',
      onButton: () async {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        if (_hasMotorized()) {
          final result = await showFloatingModal(
            context: context,
            builder: (c) => const VehicleOperatorModal(),
          );
          if (result is VehicleOperator) {
            _formKey.currentState!.fields['operator']!.didChange(result);
          } else {
            return;
          }
        }

        navigateTo(
            context,
            AppRoutes.WILL_TRAVELLERS_NEED_TO_BRING_ANYTHING_ON_YOUR_ADVENTURE,
            _formKey.currentState!.value);
      },
      page: 10,
      child: Expanded(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight("What's included in your Adventure?"),
              SizedBox(
                height: 20.h,
              ),
              Text(
                  'You can provide food & drinks, equipment, park passes or anything else to accommodate your Travellers.'),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Will you be driving on your Adventure?',
                style: AppTextStyle.blackStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              FormBuilderCheckboxGroup(
                name: 'driving_on_adventure',
                options: _drivingOnAdventure
                    .map(
                      (e) => FormBuilderFieldOption(
                        value: e,
                        child: Text(e.title),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () async {
                  final result = await showFloatingModal(
                    context: context,
                    builder: (c) => SimpleTextModal(),
                  );
                  if ((result is AdventureFeature) && mounted) {
                    setState(() {
                      _drivingOnAdventure.add(result);
                    });
                  }
                },
                child: Text(
                  '+ Add an Item',
                  style: AppTextStyle.underlinedLinkStyle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Not providing anything for your Traveller?',
                style: AppTextStyle.blackStyle,
              ),
              FormBuilderCheckbox(
                name: 'not_providing_anything',
                title: Text('I’m not providing anything'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _hasMotorized() {
    final state = _formKey.currentState;
    if (state == null) {
      return false;
    }

    final List<AdventureFeature> drivingOnAdventure =
        state.value['driving_on_adventure'];
    final motorized = drivingOnAdventure.firstWhereOrNull((e) => e.isMotorized);

    return motorized != null;
  }
}
