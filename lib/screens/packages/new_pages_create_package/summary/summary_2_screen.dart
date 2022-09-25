// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/dividers.dart';
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
            AppSizedBox(
              h: 5.h,
            ),
            Text(
              "2. Describe your Adventure",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            AppSizedBox(h: 20.h),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldText(
                        "What will you and your Travellers do?",
                      ),
                      valueText(
                        "Adventure story description goes here to explain the content. Adventure story description goes here to explain the content.Adventure story description goes here to explain the content. See more",
                      ),
                      dividerWithMargin(),
                      fieldText(
                        "How long is your Adventure?",
                      ),
                      valueText(
                        "4 Days",
                      ),
                      dividerWithMargin(),
                      fieldText(
                        "Location Description",
                      ),
                      fieldText(
                        "Regulated Areas",
                      ),
                      valueText(
                        "Yes",
                      ),
                      AppSizedBox(h: 30),
                      fieldText('Describe the location'),
                      valueText("Location descrition goes here to explain the content. Location descrition goes here to explain the content."),
                    ],
                  ),
                ))
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

  Text fieldText(String text) {
    return Text(text, style: TextStyle(fontSize: 14));
  }

  Text valueText(String text) {
    return Text(text,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
  }

  Widget dividerWithMargin() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(thickness: 1, color: Colors.grey),
    );
  }
}
