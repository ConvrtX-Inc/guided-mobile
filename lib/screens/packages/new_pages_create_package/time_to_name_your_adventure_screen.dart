// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.SOME_QUICK_PHOTO_ADVICE,
            _formKey.currentState!.value);
      },
      page: 13,
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight("Time to name your Adventure!"),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Make it descriptive, unique & awesome so Travellers will know what your offering and it will really stand out.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                name: 'description',
                hintText: 'Explore the Secret Caves of Tobermory',
                label: 'Description',
                maxLines: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
