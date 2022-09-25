// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_adventure_name_modal.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/common/widgets/text_flieds.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

import '../../../constants/app_routes.dart';

/// Create Package Screen
class TimeToNameYourAdventureScreen extends StatefulWidget {
  /// Constructor
  const TimeToNameYourAdventureScreen({Key? key}) : super(key: key);

  @override
  _TimeToNameYourAdventureScreenState createState() =>
      _TimeToNameYourAdventureScreenState();
}

class _TimeToNameYourAdventureScreenState
    extends State<TimeToNameYourAdventureScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  num get _descriptionLength {
    final value = _formKey.currentState?.value['description'];
    if (value is String) {
      return value.length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Continue',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(
          context,
          AppRoutes.SOME_QUICK_PHOTO_ADVICE,
          _formKey.currentState!.value,
        );
      },
      page: 13,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight("Time to name your Adventure!"),
              const AppSizedBox(h: 20),
              const Text(
                'Make it descriptive, unique & awesome so Travellers will know what your offering and it will really stand out.',
              ),
              AppTextField(
                name: 'description',
                maxLines: 6,
                hintText: 'Explore the Secret Caves of Tobermory',
                maxLength: 60,
              ),
              Row(
                children: [
                  Text('$_descriptionLength/60'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showFloatingModal(
                        context: context,
                        builder: (c) => PackageAdventureNameModal(),
                      );
                    },
                    child: Text(
                      'Show Examples',
                      style: AppTextStyle.underlinedLinkStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
