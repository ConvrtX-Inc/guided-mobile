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
class SomeQuickPhotoAdviceScreen extends StatefulWidget {
  /// Constructor
  const SomeQuickPhotoAdviceScreen({Key? key}) : super(key: key);

  @override
  _SomeQuickPhotoAdviceScreenState createState() =>
      _SomeQuickPhotoAdviceScreenState();
}

class _SomeQuickPhotoAdviceScreenState
    extends State<SomeQuickPhotoAdviceScreen> {

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.ADD_YOUR_PHOTOS_SCREEN,
            _formKey.currentState!.value);
      },
      page: 14,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight("Some quick photo advice"),
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
