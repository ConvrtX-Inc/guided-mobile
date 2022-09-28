// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';

/// Create Package Screen
class Summary4Screen extends StatefulWidget {
  /// Constructor
  const Summary4Screen({Key? key}) : super(key: key);

  @override
  _Summary4ScreenState createState() => _Summary4ScreenState();
}

class _Summary4ScreenState extends State<Summary4Screen> {
  final _files = <String>[
    'https://firebasestorage.googleapis.com/v0/b/guided-dev-app.appspot.com/o/images%2F2022-09-25%2015%3A47%3A18.787270-image_picker_0D8C6D85-BEA0-4095-8164-88E4EAA322A2-33876-00005A139D3E1D3F.jpg?alt=media&token=9b88ab26-fb57-45ae-8fd2-01424644cc6c',
    'https://firebasestorage.googleapis.com/v0/b/guided-dev-app.appspot.com/o/images%2F2022-09-25%2015%3A47%3A18.787270-image_picker_0D8C6D85-BEA0-4095-8164-88E4EAA322A2-33876-00005A139D3E1D3F.jpg?alt=media&token=9b88ab26-fb57-45ae-8fd2-01424644cc6c',
    'https://firebasestorage.googleapis.com/v0/b/guided-dev-app.appspot.com/o/images%2F2022-09-25%2015%3A47%3A18.787270-image_picker_0D8C6D85-BEA0-4095-8164-88E4EAA322A2-33876-00005A139D3E1D3F.jpg?alt=media&token=9b88ab26-fb57-45ae-8fd2-01424644cc6c',
    'https://firebasestorage.googleapis.com/v0/b/guided-dev-app.appspot.com/o/images%2F2022-09-25%2015%3A47%3A18.787270-image_picker_0D8C6D85-BEA0-4095-8164-88E4EAA322A2-33876-00005A139D3E1D3F.jpg?alt=media&token=9b88ab26-fb57-45ae-8fd2-01424644cc6c',
    'https://firebasestorage.googleapis.com/v0/b/guided-dev-app.appspot.com/o/images%2F2022-09-25%2015%3A47%3A18.787270-image_picker_0D8C6D85-BEA0-4095-8164-88E4EAA322A2-33876-00005A139D3E1D3F.jpg?alt=media&token=9b88ab26-fb57-45ae-8fd2-01424644cc6c',
    'https://firebasestorage.googleapis.com/v0/b/guided-dev-app.appspot.com/o/images%2F2022-09-25%2015%3A47%3A18.787270-image_picker_0D8C6D85-BEA0-4095-8164-88E4EAA322A2-33876-00005A139D3E1D3F.jpg?alt=media&token=9b88ab26-fb57-45ae-8fd2-01424644cc6c',
    'https://firebasestorage.googleapis.com/v0/b/guided-dev-app.appspot.com/o/images%2F2022-09-25%2015%3A47%3A18.787270-image_picker_0D8C6D85-BEA0-4095-8164-88E4EAA322A2-33876-00005A139D3E1D3F.jpg?alt=media&token=9b88ab26-fb57-45ae-8fd2-01424644cc6c',
  ];

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Next 4/5',
      onButton: () {
        Navigator.of(context).pushNamed(AppRoutes.SUMMARY_5);
      },
      page: -1,
      child: Expanded(
        child: ListView(
          children: <Widget>[
            HeaderText.headerTextLight("Summary 4/5"),
            AppSizedBox(
              h: 5,
            ),
            Text(
              "4. Time to name your adventure 0/7",
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
                        "Time to name your Adventure!",
                      ),
                      AppSizedBox(h: 10.h),
                      valueText(
                        "Explore the Secret Caves of Tobermory",
                      ),
                      dividerWithMargin(),
                      fieldText(
                        "Add your photos",
                      ),
                      AppSizedBox(h: 10.h),
                      SingleChildScrollView(
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: _files
                              .map(
                                (e) => Padding(
                              padding: EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24.0),
                                child: Image.network(e, fit: BoxFit.cover),
                              ),
                            ),
                          )
                              .toList(),
                        ),
                      ),
                      dividerWithMargin(),
                      fieldText(
                        "Group Size",
                      ),
                      AppSizedBox(h: 20.h),
                      fieldText(
                        "Minimum group size",
                      ),
                      AppSizedBox(h: 10.h),
                      valueText(
                        "5",
                      ),
                      AppSizedBox(h: 20.h),
                      fieldText(
                        "Maximum group size ",
                      ),
                      AppSizedBox(h: 10.h),
                      valueText(
                        "10",
                      ),
                      dividerWithMargin(),
                      fieldText(
                        "Schedule",
                      ),
                      AppSizedBox(h: 20.h),
                      fieldText(
                        "Adventure start date & time",
                      ),
                      AppSizedBox(h: 10.h),
                      Row(
                        children: [
                          valueText("12. 06. 2022"),
                          Spacer(),
                          valueText("10:00 am"),
                        ],
                      ),
                      AppSizedBox(h: 20.h),
                      fieldText(
                        "Adventure end date & time",
                      ),
                      AppSizedBox(h: 10.h),
                      Row(
                        children: [
                          valueText("15. 06. 2022"),
                          Spacer(),
                          valueText("10:00 am"),
                        ],
                      ),
                      AppSizedBox(h: 20.h),
                      valueText("Repeat event on the same day and time"),
                      AppSizedBox(h: 10.h),
                      valueText("Repeat every other week"),
                      AppSizedBox(h: 10.h),
                      valueText("Repeat event every month"),
                      dividerWithMargin(),
                      fieldText(
                        "Traveller Pricing",
                      ),
                      AppSizedBox(h: 20.h),
                      fieldText(
                        "Individual rate",
                      ),
                      AppSizedBox(h: 10.h),
                      valueText(
                        "100",
                      ),
                      AppSizedBox(h: 20.h),
                      fieldText(
                        "Price that will be displayed on the app (15% will go to Guided)",
                      ),
                      AppSizedBox(h: 10.h),
                      valueText(
                        "115",
                      ),
                      AppSizedBox(h: 20.h),
                      fieldText(
                        "Your estimated earnings (5% will go to Guided)",
                      ),
                      AppSizedBox(h: 10.h),
                      valueText(
                        "95",
                      ),
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
