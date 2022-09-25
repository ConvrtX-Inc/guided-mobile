// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/common/widgets/text_flieds.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

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
      disableSpacer: true,
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.BOOKING_SETTINGS,
            _formKey.currentState!.value);
      },
      page: 17,
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight("Traveller Pricing"),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "You decide on the price, that's entirely up to you. Enter the price you want the Traveller to pay and discover what you can earn.",
                style: TextStyle(fontSize: 16),
              ),
              AppSizedBox(h: 40.h),
              AppTextField(
                name: 'amountPerGuest',
                hintText: "100",
                label: 'Individual rate',
                maxLines: 1,
                subLabel: 'Each guest pays',
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      children: [
                        Text("Price that will be displayed on the app (15% will go to GuidED)"),
                        Text(
                          '115',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      children: [
                        Text("Your estimated earnings (5% will go to Guided)"),
                        Text(
                          '95',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
