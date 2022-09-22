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
import 'package:guided/utils/package.util.dart';
import 'package:guided/utils/services/rest_api_service.dart';

import '../../../constants/app_routes.dart';

/// Create Package Screen
class AConnectionScreen extends StatefulWidget {
  /// Constructor
  const AConnectionScreen({Key? key}) : super(key: key);

  @override
  _AConnectionScreenState createState() => _AConnectionScreenState();
}

class _AConnectionScreenState extends State<AConnectionScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PackageWidgetLayout(
        buttonText: 'Next',
        onButton: () {
          if (_formKey.currentState?.validate() != true) {
            return;
          }

          navigateTo(context, AppRoutes.DESCRIBE_YOUR_ADVENTURE,
              _formKey.currentState!.value);
        },
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            onChanged: () {
              _formKey.currentState!.save();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HeaderText.headerTextLight('A Connection'),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
        page: 6,
      ),
    );
  }
}
