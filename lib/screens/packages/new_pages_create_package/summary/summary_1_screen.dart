// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/dividers.dart';
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
      disableSpacer: true,
      buttonText: 'Summary 1/5',
      onButton: () {
        Navigator.of(context).pushNamed(AppRoutes.SUMMARY_2);
      },
      page: -1,
      child: Expanded(
        child: ListView(
          children: <Widget>[
            HeaderText.headerTextLight("Summary 1/5"),
            AppSizedBox(
              h: 5,
            ),
            Text(
              "1. Tell us a bit more",
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
                        "Where will your Adventure take place?",
                      ),
                      valueText(
                        "100 Queen St W, Toronto",
                      ),
                      AppSizedBox(
                        h: 15.h,
                      ),
                      fieldText(
                        "Which languages will your Adventures be offered in?",
                      ),
                      valueText(
                        "English",
                      ),
                      dividerWithMargin(),
                      fieldText(
                        "What will your adventure focus on?",
                      ),
                      ListTile(
                        leading: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/png/hiking.png'),
                                fit: BoxFit.contain,
                              ),
                            )),
                        title: valueText("Hiking"),
                      ),
                      dividerWithMargin(),
                      fieldText('Your Experience'),
                      valueText(
                          'Yes, I have lead this Adventure professionally'),
                      dividerWithMargin(),
                      fieldText('The Perks'),
                      valueText(
                          'Travellers could do this on their own, but I bring a unique view to the Adventure.'),
                      dividerWithMargin(),
                      fieldText('A Connection'),
                      valueText(
                          "I don't like getting too personal with the Travellers.....really??? what??? are you kidding? ok then....."),
                    ],
                  ),
                ))
          ],
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
