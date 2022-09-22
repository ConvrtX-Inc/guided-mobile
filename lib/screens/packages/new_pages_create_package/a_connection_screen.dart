// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';
import 'package:guided/common/widgets/package_images.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/utils/package.util.dart';
import 'package:guided/utils/services/rest_api_service.dart';

import '../../../constants/app_routes.dart';
import '../../../models/activities_model.dart';

/// Create Package Screen
class AConnectionScreen extends StatefulWidget {
  /// Constructor
  const AConnectionScreen({Key? key, required this.arguments}) : super(key: key);
  final Map<dynamic, dynamic> arguments;

  @override
  _AConnectionScreenState createState() => _AConnectionScreenState();
}

class _AConnectionScreenState extends State<AConnectionScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final Activity activity;

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
        navigateTo(context, AppRoutes.DESCRIBE_YOUR_ADVENTURE, {});
      },
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight('A Connection'),
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
                      "We look for kind folks, who are friendly and can help everyone have a great time",
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
                      "⚫️ Get to know each other, share names before you head out on your Adventure",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text("⚫️ Share personal stories and experiences",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      "⚫️ Create memories that will last a lifetime",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      "We hope Travellers arrive as strangers and leave as friends!",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Which statement sounds most like you?',
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
                      'Bringing folks together in the outdoors & creating new friendships is my fav!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    title: Text(
                      "I love sharing my skills & passion for the outdoors with others",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    title: Text(
                      "I don't like getting too personal with the Travellers.....really??? what??? are you kidding? ok then.....",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      page: 6,
    );
  }
}
