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

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.WILL_TRAVELLERS_NEED_TO_BRING_ANYTHING_ON_YOUR_ADVENTURE,
            _formKey.currentState!.value);
      },
      page: 10,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight("What's included in your Adventure?"),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
