import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:pinput/pin_put/pin_put.dart';

/// Sign up verification screen
class SignupVerify extends StatefulWidget {
  /// Constructor
  const SignupVerify({Key? key}) : super(key: key);

  @override
  _SignupVerifyState createState() => _SignupVerifyState();
}

class _SignupVerifyState extends State<SignupVerify> {
  final TextEditingController _verifyCodeController = TextEditingController();
  bool incorrectOTP = false;

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
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Verification code sent to your phone ${screenArguments['phone_number'].toString()}',
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
                          onTap: () async =>
                              resendCode(screenArguments), // Resend OTP
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
                      height: 20.h,
                    ),
                    Center(
                      child: SizedBox(
                        child: incorrectOTP
                            ? Text(
                                AppTextConstants.authenticationFailed,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Gilroy',
                                  color: Colors.red,
                                ),
                              )
                            : const Text(''),
                      ),
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
                            borderRadius:
                                BorderRadius.circular(18.r), // <-- Radius
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
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Method for verifying Code
  Future<void> verifyCode(Map<String, dynamic> data) async {
    print(data['phone_number']);
    final Map<String, dynamic> details = {
      'phone_number': data['phone_number'],
      'verifyCode': _verifyCodeController.text
    };

    if (_verifyCodeController.text.isNotEmpty) {
      incorrectOTP = false;
      await APIServices().request(
          AppAPIPath.checkVericationCodeSignUpUrl, RequestType.POST,
          data: details);
      await Navigator.pushNamed(context, '/sign_up_form', arguments: data);
    } else {
      setState(() {
        incorrectOTP = true;
      });
    }
  }

  /// Method for resending code
  Future<void> resendCode(Map<String, dynamic> details) async {
    final Map<String, dynamic> phoneDetails =
        Map<String, dynamic>.from(details);

    await APIServices().request(
        AppAPIPath.sendVerificationCodeSignUpUrl, RequestType.POST,
        data: phoneDetails);
  }
}
