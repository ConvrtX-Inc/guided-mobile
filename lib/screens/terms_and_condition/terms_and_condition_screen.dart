// ignore_for_file: unused_local_variable, cast_nullable_to_non_nullable

import 'package:advance_notification/advance_notification.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Terms and Condition Screen
class TermsAndCondition extends StatefulWidget {
  /// Constructor
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  bool _isChecked = false;

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
                    Text(
                      AppTextConstants.termsAndCondidition,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: Text(
                  screenArguments['terms_and_condition'],
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      height: 2,
                      fontSize: 16.sp,
                      fontFamily: 'Gilroy'),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Row(
                  children: <Widget>[
                    CustomCheckBox(
                      value: _isChecked,
                      shouldShowBorder: true,
                      borderColor: AppColors.harp,
                      checkedFillColor: AppColors.primaryGreen,
                      borderRadius: 8,
                      borderWidth: 1,
                      checkBoxSize: 22,
                      uncheckedFillColor: AppColors.harp,
                      uncheckedIconColor: AppColors.harp,
                      onChanged: (bool val) {
                        setState(() {
                          _isChecked = val;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        AppTextConstants.agreeWithTermsConditions,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            fontFamily: 'Gilroy'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: SizedBox(
                  width: 315.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(20)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(AppColors.spruce),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r),
                        ))),
                    onPressed: saveTermsAndCondition,
                    child: Text(
                      AppTextConstants.iAgree,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveTermsAndCondition() async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String? userId = UserSingleton.instance.user.user!.id;

    if (_isChecked) {
      Map<String, dynamic> termsDetails = {
        'tour_guide_id': userId,
        'type': 'terms_and_condition_$userId',
        'description': screenArguments['terms_and_condition']
      };

      /// Terms and Condition Details API
      final dynamic response = await APIServices().request(
          '${AppAPIPath.termsAndCondition}/$userId', RequestType.POST,
          needAccessToken: true, data: termsDetails);
    } else {
      AdvanceSnackBar(message: ErrorMessageConstants.confirmTermsAndCondition)
          .show(context);
    }
  }
}
