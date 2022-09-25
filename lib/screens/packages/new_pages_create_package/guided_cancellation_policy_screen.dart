// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

/// Create Package Screen
class GuidedCancellationPolicyScreen extends StatefulWidget {
  /// Constructor
  const GuidedCancellationPolicyScreen({Key? key}) : super(key: key);

  @override
  _GuidedCancellationPolicyScreenState createState() =>
      _GuidedCancellationPolicyScreenState();
}

class _GuidedCancellationPolicyScreenState extends State<GuidedCancellationPolicyScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  String firstParagraph = "Travellers can cancel until 7 days before the Adventure start time for a full refund, or within 24 hours of booking as long as the booking is made more than 7 days before the start time.  If cancelled within 7 days of the start time of the Adventure, there will be a 50% refund.  If cancelled within 48 hours of the start time of the Adventure, there will be no refund.";
  String secondParagraph = "If a Guide cancels an Adventure, the following provisions govern the cancellation, unless there are Exceptional Circumstances: The Traveler will receive a full refund of the Adventure Fee for the Adventure. If the Guide makes a cancellation more than 48 hours before the start time of the Adventure, there will be no penalty. If the Guide makes a cancellation within 24 hours of the start time of the Adventure, the Guide will be charged a penalty of 20%, with the penalty to be deducted from future Payouts. The Guide’s calendar will be blacked out for the dates on which they have cancelled so that they will no longer be able to host an Adventure on that date; and An automatic review/rating will be posted to their page citing the cancellation. - If a Guide cancels within 24 hours of the start time of an Adventure more than 3 times they may be removed from the Services.";

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Continue',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.A_FEW_MORE_THINGS,
            _formKey.currentState!.value);
      },
      page: 20,
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight("GuidED's Cancellation Policy"),
              SizedBox(
                height: 20.h,
              ),
              Text(
                firstParagraph,
                  style: TextStyle(fontSize: 16)
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                  secondParagraph,
                  style: TextStyle(fontSize: 16)
              )
            ],
          ),
        ),
      ),
    );
  }
}
