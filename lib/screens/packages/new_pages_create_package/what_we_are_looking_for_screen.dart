// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/utils/package.util.dart';

import '../../../common/widgets/package_images.dart';

/// Create Package Screen
class WhatWeAreLookingForScreen extends StatefulWidget {
  /// Constructor
  const WhatWeAreLookingForScreen({Key? key, required this.arguments})
      : super(key: key);
  final Map<dynamic, dynamic> arguments;

  @override
  _WhatWeAreLookingForScreenState createState() =>
      _WhatWeAreLookingForScreenState();
}

class _WhatWeAreLookingForScreenState extends State<WhatWeAreLookingForScreen> {
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
      buttonText: 'Next',
      onButton: () {
        navigateTo(context, AppRoutes.YOUR_EXPERIENCE, {});
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderText.headerTextLight('What we’re looking for?'),
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
            SizedBox(
              height: 20.h,
            ),
            Text(
                "At GuidED, we're passionate about getting outside and adventuring anywhere & everywhere, but especially in our own communities. There's nothing that makes a Traveller feel more at home, and at ease, then being with a knowledgeable local, or Guide when they are in a new area. A knowledgeable Guide will meet these standards",
                style: TextStyle(fontSize: 16)),
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Experience',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    'You have great knowledge, ability or background',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Perks:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    "You give Travellers something they couldn't get on their own, something special. ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A Connection:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    'You provide a genuine, meaningful and memorable experience.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      page: 3,
    );
  }
}
