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

import '../../../common/widgets/text_flieds.dart';
import '../../../constants/app_routes.dart';
import '../../../utils/package.util.dart';

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
      disableSpacer: true,
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
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight(
                  "Who can come on your Adventure"),
              SizedBox(
                height: 20.h,
              ),
              Text(
               "Remember, someone might be booking spots for other Travellers.  If you are strict about age, skill level, licenses or certifications, include them here. ",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                name: 'minimumAge',
                label: 'Minimum age',
                maxLines: 1,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Set age limits for Travellers. Minors can only attend with an adult. ",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 20.h,
              ),
              CheckboxListTile(
                title: Text('Parents can bring kids under 5 years of age.'),
                  value: false, onChanged: (value) {}
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Does your Adventure  have any accessibility features?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Communication",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              CheckboxListTile(
                  title: Text('You are able to communicate with someone who is hearing or verbally impaired'),
                  value: false, onChanged: (value) {}
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Environmental accessibility features",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              CheckboxListTile(
                  title: Text("My Adventure takes place in an area that is accessible for all people"),
                  value: false, onChanged: (value) {}
              ),
              SizedBox(
                height: 60.h,
              ),
              Text(
                "What activity level should Travellers expect?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                "Consider how experienced people should be to go on your Adventure",
                style: TextStyle(fontSize: 12),
              ),
              Wrap(
                spacing: 10,
                children: [
                  Chip(
                  label: Text('Light'),
                ),
                  Chip(
                    label: Text('Moderate'),
                  ),
                  Chip(
                    label: Text('Strenuous'),
                  ),
                  Chip(
                    label: Text('Extreme'),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "What skill level is required",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                "Think about how experienced people should be to go on your Adventure",
                style: TextStyle(fontSize: 12),
              ),
              Wrap(
                spacing: 10,
                children: [
                  Chip(
                    label: Text('Beginner'),
                  ),
                  Chip(
                    label: Text('Intermediate'),
                  ),
                  Chip(
                    label: Text('Advanced'),
                  ),
                  Chip(
                    label: Text('Expert'),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                name: '',
                hintText: "Additional requirements (Optional)",
                maxLines: 7,
              ),
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
