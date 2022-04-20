// ignore_for_file: always_put_required_named_parameters_first

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:pinput/pin_put/pin_put.dart';

/// Reset password verification screen
class ResetVerifyPhone extends StatefulWidget {
  /// Constructor
  const ResetVerifyPhone({Key? key}) : super(key: key);

  @override
  _ResetVerifyPhoneState createState() => _ResetVerifyPhoneState();
}

class _ResetVerifyPhoneState extends State<ResetVerifyPhone> {
  final TextEditingController _verifyCodeController = TextEditingController();

  /// Method for verifying code
  Future<void> verifyCode(Map<String, dynamic> details) async {
    if (_verifyCodeController.text != '') {
      final Map<String, dynamic> verificationDetails = {
        'hash': _verifyCodeController.text
      };

      final dynamic response = await APIServices().request(
          AppAPIPath.otpUrl, RequestType.POST,
          data: verificationDetails);

      if (response['status'] == 200) {
        final Map<String, dynamic> data = Map<String, dynamic>.from(details);
        data['hash'] = _verifyCodeController.text;

        await Navigator.pushNamed(context, '/create_new_password',
            arguments: data);
      } else {
        AdvanceSnackBar(message: ErrorMessageConstants.somethingWenWrong)
            .show(context);
      }
    } else {
      AdvanceSnackBar(message: ErrorMessageConstants.fieldMustBeFilled)
          .show(context);
    }
  }

  /// Method for resending code
  Future<void> resendCode(Map<String, dynamic> details) async {
    final Map<String, dynamic> phoneDetails =
        Map<String, dynamic>.from(details);

    await APIServices().request(
        AppAPIPath.sendVerificationCodeUrl, RequestType.POST,
        data: phoneDetails);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        // ignore: cast_nullable_to_non_nullable
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppTextConstants.verifyPhone,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Verification code sent to your phone + ${screenArguments['phone_no']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    PinPut(
                      fieldsCount: 4,
                      // eachFieldMargin: const EdgeInsets.all(0),
                      textStyle: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.w700),
                      eachFieldWidth: 70,
                      eachFieldHeight: 70,
                      controller: _verifyCodeController,
                      eachFieldPadding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      submittedFieldDecoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                      followingFieldDecoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                      selectedFieldDecoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.honeyYellow, width: 3),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          AppTextConstants.didnotReceive,
                          style: const TextStyle(
                            fontSize: 17,
                            fontFamily: 'Gilroy',
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () => resendCode(screenArguments),
                          child: Text(
                            AppTextConstants.resendOTP,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      width: width,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () => verifyCode(screenArguments),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColors.silver,
                            ),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          primary: AppColors.primaryGreen,
                          onPrimary: Colors.white, // <-- Splash color
                        ),
                        child: Text(
                          AppTextConstants.verifyText,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
