// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/common/widgets/text_flieds.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';

/// Create Package Screen
class TellUsABitMoreScreen extends StatefulWidget {
  /// Constructor
  const TellUsABitMoreScreen({Key? key}) : super(key: key);

  @override
  _TellUsABitMoreScreenState createState() => _TellUsABitMoreScreenState();
}

class _TellUsABitMoreScreenState extends State<TellUsABitMoreScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        Navigator.of(context)
            .pushNamed(AppRoutes.WHAT_OUR_EXPERIENCE_FOCUS_ON, arguments: _formKey.currentState!.value);
      },
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight('Tell us a bit more'),
              const Text(
                'Where will your Adventure take place?',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'GilRoy',
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40.h),
              AppTextField(
                label: 'City / Town / Area',
                name: 'place',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
              SizedBox(height: 40.h),
              const Text(
                'Which languages will your adventures be offered in?',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'GilRoy',
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10.h),
              const Text(
                'You should be able to read, write and speak in this language',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'GilRoy',
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20.h),
              // TODO
              AppTextField(
                label: 'Language',
                name: 'languages',
                hintText: 'English',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
              SizedBox(height: 10.h),
              Text(
                'Add additional languages',
                style: TextStyle(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'GilRoy',
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
      page: 1,
    );
  }
}
