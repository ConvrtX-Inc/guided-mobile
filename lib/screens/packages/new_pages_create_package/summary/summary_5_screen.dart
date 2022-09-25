// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Create Package Screen
class Summary5Screen extends StatefulWidget {
  /// Constructor
  const Summary5Screen({Key? key}) : super(key: key);

  @override
  _Summary5ScreenState createState() => _Summary5ScreenState();
}

class _Summary5ScreenState extends State<Summary5Screen> {
  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      child: Expanded(
        child: ListView(
          children: <Widget>[
            HeaderText.headerTextLight("Summary 5/5"),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
      onButton: () {
        // TODO Submit
      },
      beforeButton: (context) => SizedBox(
        height: 60.h,
        child: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryGreen,
          ),
          child: Text(
            'Previous',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
