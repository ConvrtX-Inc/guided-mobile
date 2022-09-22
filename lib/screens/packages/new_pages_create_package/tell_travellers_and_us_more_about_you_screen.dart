// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/common/widgets/text_flieds.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

import '../../../constants/app_routes.dart';

/// Create Package Screen
class TellTravellersAndUsMoreAboutYouScreen extends StatefulWidget {
  /// Constructor
  const TellTravellersAndUsMoreAboutYouScreen({Key? key}) : super(key: key);

  @override
  _TellTravellersAndUsMoreAboutYouScreenState createState() =>
      _TellTravellersAndUsMoreAboutYouScreenState();
}

class _TellTravellersAndUsMoreAboutYouScreenState
    extends State<TellTravellersAndUsMoreAboutYouScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Continue',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }
        navigateTo(context, AppRoutes.WHERE_SHOULD_TRAVELLERS_MEET_YOU,
            _formKey.currentState!.value);
      },
      page: 8,
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight(
                  'Tell Travellers  & us more about you'),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'How are you leading this Adventure',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              FormBuilderRadioGroup(
                name: 'independant',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                options: [
                  FormBuilderFieldOption(
                    value: 'independant',
                    child: ListTile(
                      title: Text("I'm an independent guide"),
                    ),
                  ),
                  FormBuilderFieldOption(
                    value: 'not-independant',
                    child: ListTile(
                      title: Text("I have a team guides who helps me"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Your personal profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Use your legal name and provide a photo that cleary shows your face (not a logo)',
              ),
              SizedBox(
                height: 20.h,
              ),
              ListTile(
                title: Text('SSegning Lambou'),
                subtitle: Text('Location'),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'What makes you qualified to lead this Adventure?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                name: 'youQualified',
                maxLines: 6,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
