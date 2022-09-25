// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';

/// Create Package Screen
class Summary2Screen extends StatefulWidget {
  /// Constructor
  const Summary2Screen({Key? key}) : super(key: key);

  @override
  _Summary2ScreenState createState() => _Summary2ScreenState();
}

class _Summary2ScreenState extends State<Summary2Screen> {
  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      child: Expanded(
        child: ListView(
          children: <Widget>[
            HeaderText.headerTextLight("Summary 2/5"),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
      onButton: () {
        Navigator.of(context).pushNamed(AppRoutes.SUMMARY_3);
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
