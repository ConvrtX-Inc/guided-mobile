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
class AFewMoreThingsScreen extends StatefulWidget {
  /// Constructor
  const AFewMoreThingsScreen({Key? key}) : super(key: key);

  @override
  _AFewMoreThingsScreenState createState() => _AFewMoreThingsScreenState();
}

class _AFewMoreThingsScreenState extends State<AFewMoreThingsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Continue',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.SUMMARY_1,
            _formKey.currentState!.value);
      },
      page: 21,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight("A few more things....."),
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
