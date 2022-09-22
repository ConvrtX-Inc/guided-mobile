// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/activity_selection.dart';
import 'package:guided/common/widgets/modal.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/utils/package.util.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Create Package Screen
class WhatYourExperienceFocusOnScreen extends StatefulWidget {
  /// Constructor
  const WhatYourExperienceFocusOnScreen({Key? key}) : super(key: key);

  @override
  _WhatYourExperienceFocusOnScreenState createState() =>
      _WhatYourExperienceFocusOnScreenState();
}

class _WhatYourExperienceFocusOnScreenState
    extends State<WhatYourExperienceFocusOnScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  List<Activity> allActivities = [];

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true || allActivities.isEmpty) {
          return;
        }

        navigateTo(context, AppRoutes.WHAT_WE_ARE_LOOKING_FOR,
            {'allActivities': allActivities});
      },
      page: 2,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight('What will your adventure focus on?'),
              const Text(
                "Use Discovery Badge for unique Adventures that don't fall under other badges. It's a mixed bag of Adventures!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'GilRoy',
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: _openModalSelection,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.silver),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      primary: AppColors.primaryGreen,
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      'Select a Badge',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
              if (allActivities.length > 0)
                Center(
                  child: CircleAvatar(
                    child: Image.asset(allActivities.first.path),
                    backgroundColor: Colors.transparent,
                    radius: 64,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSelection(List<Activity> activities) {
    setState(() {
      allActivities = activities;
    });
  }

  void _openModalSelection() {
    showCustomModalBottomSheet(
      context: context,
      builder: (context) => ActivitySelection(
        onActivity: _handleSelection,
        previousSelection: allActivities,
      ),
      containerWidget: (_, animation, child) => FloatingModal(
        child: child,
      ),
      expand: false,
    );
  }
}
