// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';

/// Create Package Screen
class Summary3Screen extends StatefulWidget {
  /// Constructor
  const Summary3Screen({Key? key}) : super(key: key);

  @override
  _Summary3ScreenState createState() => _Summary3ScreenState();
}

class _Summary3ScreenState extends State<Summary3Screen> {
  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      child: Expanded(
        child: ListView(
          children: <Widget>[
            HeaderText.headerTextLight("Summary 3/5"),
            AppSizedBox(h: 5),
            Text(
              "3. Tell Travellers  & us more about you",
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
                        "Where should Travellers meet you?",
                      ),
                      valueText(
                        "googlemap/address/goes/here/", //TODO
                      ),
                      AppSizedBox(h: 15),
                      fieldText("Street Address"),
                      valueText("123, HNK Lane, Toronto, Canada",),
                      AppSizedBox(h: 15),
                      fieldText("Postal code"),
                      valueText("129000"),
                      AppSizedBox(h: 15),
                      fieldText("Meeting point name"),
                      valueText("GGH Block"),
                      dividerWithMargin(),
                      fieldText("What's included in your Adventure?"),
                      AppSizedBox(h: 10),
                      valueText("Driving (Car, ATV's, Snowmobiles, etc?)"),
                      AppSizedBox(h: 10),
                      valueText("Boating (Motor Boat, Sailboat, Seadoo's, etc)"),
                      AppSizedBox(h: 10),
                      valueText("Motorcycle or Dirt Bikes"),
                      AppSizedBox(h: 10),
                      valueText("Flying (Plane, Helicopter, Hot Air Balloon etc)"),
                      AppSizedBox(h: 15),
                      fieldText("Who will operate the vehicle when driving?"),
                      valueText("No, Travellers just need to show up"),
                      AppSizedBox(h: 15),
                      valueText("Description goes here to explain the  content. Description goes here to explain the content."), //TODO,
                      dividerWithMargin(),
                      fieldText("Who can come on your Adventure ?"),
                      AppSizedBox(h: 10),
                      fieldText("Minimum age"),
                      valueText("5"),
                      AppSizedBox(h: 15),
                      fieldText("Adventure accessibility features?"),
                      AppSizedBox(h: 10),
                      valueText("Communication"),
                      AppSizedBox(h: 10),
                      valueText("Environmental accessibility features"),
                      AppSizedBox(h: 15),
                      fieldText("Travellers expect activity level "),
                      valueText("Moderate"),
                      AppSizedBox(h: 15),
                      fieldText("Travellers expect activity level"),
                      valueText("Moderate"),
                      AppSizedBox(h: 15),
                      fieldText("Skills level"),
                      valueText("Intermediate"),
                      AppSizedBox(h: 15),
                      fieldText("Skills level"),
                      valueText("Additional requirements goes here")
                    ],
                  ),
                ))
          ],
        ),
      ),
      onButton: () {
        Navigator.of(context).pushNamed(AppRoutes.SUMMARY_4);
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
