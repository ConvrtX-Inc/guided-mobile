// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

import '../../../constants/app_routes.dart';

/// Create Package Screen
class WhoCanComeOnYourAdventureScreen extends StatefulWidget {
  /// Constructor
  const WhoCanComeOnYourAdventureScreen({Key? key}) : super(key: key);

  @override
  _WhoCanComeOnYourAdventureScreenState createState() =>
      _WhoCanComeOnYourAdventureScreenState();
}

class _WhoCanComeOnYourAdventureScreenState
    extends State<WhoCanComeOnYourAdventureScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        Navigator.of(context).pushNamed(
            AppRoutes.TIME_TO_NAME_YOUR_ADVENTURE_SCREEN,
            arguments: _formKey.currentState!.value);
      },
      page: 12,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight("Who can come on your Adventure"),
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
