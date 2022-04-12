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
  TextEditingController _guided_payment_payout = TextEditingController();
  final FocusNode _guided_payment_payout_focus = FocusNode();
  @override
  void initState() {
    super.initState();
    getTermsAndConditionStatus();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      _guided_payment_payout =
          TextEditingController(text: screenArguments['guided_payment_payout']);
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset(
                        '${AssetsPath.assetsPNGPath}/chevron_back_button.png',
                      ),
                      iconSize: 44.h,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: Text(
                        AppTextConstants.guidedPaymentPayoutTerms,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: SizedBox(
                  height: 600.h,
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: TextField(
                      maxLines: null,
                      enabled: _isEnabledEdit,
                      controller: _guided_payment_payout,
                      focusNode: _guided_payment_payout_focus,
                      decoration: InputDecoration(
                        hintText: AppTextConstants.hintGuidedPayment,
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          height: 2,
                          fontSize: 16.sp,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              if (_btnStatus)
                Container()
              else
                Center(
                  child: SizedBox(
                    width: 315.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(20)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.r),
                                  side: BorderSide(color: AppColors.silver)))),
                      child: Text(
                        _isEnabledEdit
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.spruce),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_isEnabledEdit) {
                            _isEnabledEdit = false;
                          } else {
                            _isEnabledEdit = true;
                          }
                        });
                      },
                    ),
                  ),
                ),
              SizedBox(
                height: 20.h,
              ),
              if (_btnStatus)
                Container()
              else
                Center(
                  child: SizedBox(
                    width: 315.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(20)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.spruce),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ))),
                      onPressed: saveGuidedPayment,
                      child: _isSubmit
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                              AppTextConstants.save,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveGuidedPayment() async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    if (_guided_payment_payout.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.fieldMustBeFilled)
          .show(context);
    } else {
      setState(() {
        _isSubmit = true;
      });
      Map<String, dynamic> guidedPaymentPayoutDetails = {
        'description': _guided_payment_payout.text
      };

      /// Cancellation Policy Details API
      final dynamic response1 = await APIServices().request(
          '${AppAPIPath.termsAndCondition}/${screenArguments['id']}',
          RequestType.PATCH,
          needAccessToken: true,
          data: guidedPaymentPayoutDetails);

      Navigator.pop(context);
    }
  }
}
