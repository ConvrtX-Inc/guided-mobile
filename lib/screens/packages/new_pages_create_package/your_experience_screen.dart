// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

/// Create Package Screen
class YourExperienceScreen extends StatefulWidget {
  /// Constructor
  const YourExperienceScreen({Key? key}) : super(key: key);

  @override
  _YourExperienceScreenState createState() => _YourExperienceScreenState();
}

class _YourExperienceScreenState extends State<YourExperienceScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.THE_PERKS, _formKey.currentState!.value);
      },
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight('Your Experience'),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
      page: 4,
    );
  }
}
