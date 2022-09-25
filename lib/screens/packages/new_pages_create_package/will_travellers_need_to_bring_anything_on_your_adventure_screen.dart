// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

import '../../../common/data/option_data.dart';
import '../../../common/widgets/text_flieds.dart';
import '../../../constants/app_routes.dart';

/// Create Package Screen
class WillTravellersNeedToBringAnythingOnYourAdventureScreen
    extends StatefulWidget {
  /// Constructor
  const WillTravellersNeedToBringAnythingOnYourAdventureScreen({Key? key})
      : super(key: key);

  @override
  _WillTravellersNeedToBringAnythingOnYourAdventureScreenState createState() =>
      _WillTravellersNeedToBringAnythingOnYourAdventureScreenState();
}

class _WillTravellersNeedToBringAnythingOnYourAdventureScreenState
    extends State<WillTravellersNeedToBringAnythingOnYourAdventureScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.WHO_CAN_COME_ON_YOUR_ADVENTURE,
            _formKey.currentState!.value);
      },
      page: 11,
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight(
                  "Will Travellers need to bring anything on your Adventure?"),
              const AppSizedBox(h: 20),
              FormBuilderRadioGroup(
                name: 'traveller_bring_anything',
                options: [
                  OptionData(true, 'Yes'),
                  OptionData(false, 'No, Travellers just need to show up')
                ]
                    .map(
                      (e) => FormBuilderFieldOption(
                        value: e.value,
                        child: Text(
                          e.label,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const AppSizedBox(h: 20),
              AppTextField(
                name: 'description',
                subLabel: 'Description',
                hintText: 'Type description here',
                maxLines: 6,
              ),
              const AppSizedBox(h: 20),
            ],
          ),
        ),
      ),
    );
  }
}
