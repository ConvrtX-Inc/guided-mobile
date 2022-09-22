// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';

/// Create Package Screen
class Summary1Screen extends StatefulWidget {
  /// Constructor
  const Summary1Screen({Key? key}) : super(key: key);

  @override
  _Summary1ScreenState createState() => _Summary1ScreenState();
}

class _Summary1ScreenState extends State<Summary1Screen> {
  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Summary 1/5',
      onButton: () {
        Navigator.of(context).pushNamed(AppRoutes.SUMMARY_2);
      },
      page: -1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderText.headerTextLight("Summary 1/5"),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
