// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unused_field

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/user_terms_and_condition_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Guided Payment Payout Terms Screen
class GuidedPaymentPayoutTerms extends StatefulWidget {
  /// Constructor
  const GuidedPaymentPayoutTerms({Key? key}) : super(key: key);

  @override
  _GuidedPaymentPayoutTermsState createState() =>
      _GuidedPaymentPayoutTermsState();
}

class _GuidedPaymentPayoutTermsState extends State<GuidedPaymentPayoutTerms> {
  bool _isChecked = false;
  bool _btnStatus = true;
  bool _isSubmit = false;
  String _id = '';
  bool _isEnabledEdit = false;

  String _guided_payment = '';

  @override
  void initState() {
    super.initState();
    // getTermsAndConditionStatus();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      setState(() {
        _guided_payment = screenArguments['guided_payment_payout'];
      });
     });
  }

  Future<void> getTermsAndConditionStatus() async {
    final List<UsersTermsAndConditionModel> resForm =
        await APIServices().getUsersTermsAndCondition();

    setState(() {
      _btnStatus = resForm[0].is_payment_and_payout_terms;
      _id = resForm[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            icon: Image.asset(
              '${AssetsPath.assetsPNGPath}/chevron_back_button.png',
            ),
            iconSize: 44.h,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          title: Text(
            AppTextConstants.guidedPaymentPayoutTerms,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
          child: SingleChildScrollView(
            // physics: const ScrollPhysics(),
            child: Text(_guided_payment,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    height: 2,
                    fontSize: 12.sp,
                    fontFamily: 'Gilroy')),
          ),
        ));
  }
}
