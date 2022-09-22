// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_text_style.dart';

import '../../../constants/app_routes.dart';

/// Create Package Screen
class DescribeYourAdventureScreen extends StatefulWidget {
  /// Constructor
  const DescribeYourAdventureScreen({Key? key}) : super(key: key);

  @override
  _DescribeYourAdventureScreenState createState() =>
      _DescribeYourAdventureScreenState();
}

class _DescribeYourAdventureScreenState
    extends State<DescribeYourAdventureScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        Navigator.of(context).pushNamed(AppRoutes.TELL_TRAVELLERS_AND_US_MORE_ABOUT_YOU,
            arguments: _formKey.currentState!.value);
      },
      page: 7,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight('Describe your Adventure'),
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
