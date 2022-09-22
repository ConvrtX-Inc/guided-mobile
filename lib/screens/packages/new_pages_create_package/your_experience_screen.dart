// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';
import '../../../common/widgets/package_images.dart';
import '../../../models/activities_model.dart';

/// Create Package Screen
class YourExperienceScreen extends StatefulWidget {
  /// Constructor
  const YourExperienceScreen({Key? key, required this.arguments})
      : super(key: key);
  final Map<dynamic, dynamic> arguments;

  @override
  _YourExperienceScreenState createState() => _YourExperienceScreenState();
}

class _YourExperienceScreenState extends State<YourExperienceScreen> {
  late final Activity activity;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    final focusArgs = widget.arguments[AppRoutes.WHAT_OUR_EXPERIENCE_FOCUS_ON];
    activity = (focusArgs['allActivities'] as List<Activity>).first;
  }

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.THE_PERKS, _formKey.currentState!.value);
      },
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight('Your Experience'),
              SizedBox(
                height: 20.h,
              ),
              Stack(
                children: [
                  PackageImageWidget(assetUrl: activity.featureImage),
                  Positioned(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(activity.path),
                      backgroundColor: Colors.transparent,
                      radius: 40.0,
                    ),
                    bottom: 0.0,
                    left: 0.0,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      "At GuidED, we look for people who are passionate about the outdoors, who want to share their unique stories, skills and perspectives, and who have the knowledge that only a local or expert would have. ",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text("This could consist of:",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      "⚫️ Being a knowledgeable, well-rounded outdoor enthusiast ",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text("⚫️ Having specialized training & skills",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      "⚫️ Having certificates or achievements in your area of expertise",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      "Travellers love to learn something new on every Adventure",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Have you lead this Adventure before?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListTile(
                    leading: Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    title: Text(
                      'Yes, I have lead this Adventure professionally',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    title: Text(
                      'Yes, I have lead this Adventure before, but for only friends and family. ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    title: Text(
                      'No, I have never lead an Adventure before, but am excited to get started!',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      page: 4,
    );
  }
}
