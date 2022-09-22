// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/package_images.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/utils/package.util.dart';

/// Create Package Screen
class ThePerksScreen extends StatefulWidget {
  /// Constructor
  const ThePerksScreen({Key? key, required this.arguments}) : super(key: key);
  final Map<dynamic, dynamic> arguments;

  @override
  _ThePerksScreenState createState() => _ThePerksScreenState();
}

class _ThePerksScreenState extends State<ThePerksScreen> {
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
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(
            context, AppRoutes.A_CONNECTION, {});
      },
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
            child: ListView(
                children: <Widget>[
                  HeaderText.headerTextLight('The Perks'),
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
                          "We're looking for a Guide who can take Travellers \"Off the Beaten Path\" a little, away from the major tourist areas & into those hidden gems & spots that they wouldn't find otherwise.",
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
                          "⚫️ Hidden Gems that only locals know about.",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("⚫️ Unique and interesting people .",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                          "⚫️ Cool stuff, and opportunities that are hard to find. ",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                          "Travellers really appreciate getting away from the tourist traps. ",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 20.h,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Which statement best describes your Adventure?",
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
                          "Yes, I have lead this Adventure professionally",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        leading: Checkbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        title: Text(
                          "My Adventure is totally unique and they couldn't do it without me",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        leading: Checkbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        title: Text(
                          "Travellers could do this on their own, but I bring a unique view to the Adventure. ",
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ])),
      ),
      page: 5,
    );
  }
}
