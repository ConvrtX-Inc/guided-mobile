// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';

/// Create Package Screen
class TravellerPricingScreen extends StatefulWidget {
  /// Constructor
  const TravellerPricingScreen({Key? key}) : super(key: key);

  @override
  _TravellerPricingScreenState createState() => _TravellerPricingScreenState();
}

class _TravellerPricingScreenState extends State<TravellerPricingScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        Navigator.of(context).pushNamed(AppRoutes.BOOKING_SETTINGS,
            arguments: _formKey.currentState!.value);
      },
      page: 17,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight("Traveller Pricing"),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
