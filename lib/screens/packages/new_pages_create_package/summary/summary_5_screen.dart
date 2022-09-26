// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/modals/submit_my_adventure_modal.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/utils/package.util.dart';
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
      disableSpacer: true,
      buttonText: 'Submit 5/5',
      child: Expanded(
        child: ListView(
          children: <Widget>[
            HeaderText.headerTextLight("Summary 5/5"),
            SizedBox(
              height: 5,
            ),
            Text(
              "5. Booking Settings",
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
                        "Cutoff time",
                      ),
                      valueText(
                        "1 hour before start time",
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      onButton: () {
        openSubmitDialog();
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

  Future<void> openSubmitDialog() async {
    final result = await showFloatingModal(
      context: context,
      builder: (c) => SubmitMyAdventureModal(),
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
