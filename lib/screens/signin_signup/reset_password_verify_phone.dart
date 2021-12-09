import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/helpers/api_calls.dart';
import 'package:guided/screens/signin_signup/create_new_password_screen.dart';

/// Reset password verification screen
class ResetVerifyPhone extends StatefulWidget {
  /// Constructor
  ResetVerifyPhone({Key? key, required this.email, required this.phoneNumber}) : super(key: key);

  /// user's email
  final String email;

  /// user's phone number
  final String phoneNumber;

  @override
  _ResetVerifyPhoneState createState() => _ResetVerifyPhoneState(email, phoneNumber);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('email', email));
    properties.add(StringProperty('phoneNumber', phoneNumber));
  }
}

class _ResetVerifyPhoneState extends State<ResetVerifyPhone> {

  _ResetVerifyPhoneState(this.email, this.phoneNumber);

  String email = '';
  String phoneNumber = '';
  bool incorrectOTP = false;

  TextEditingController txtCode_1 = TextEditingController();
  TextEditingController txtCode_2 = TextEditingController();
  TextEditingController txtCode_3 = TextEditingController();
  TextEditingController txtCode_4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    SizedBox _txtCode_1() {
      return SizedBox(
        width: 55.w,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 1,
          controller: txtCode_1,
          textInputAction: TextInputAction.next,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: '',
            fillColor: AppColors.alabaster,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.2.w
              ),
            ),
          ),
        ),
      );
    }

    SizedBox _txtCode_2() {
      return SizedBox(
        width: 55.w,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 1,
          controller: txtCode_2,
          textInputAction: TextInputAction.next,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: '',
            fillColor: AppColors.alabaster,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.2.w
              ),
            ),
          ),
        ),
      );
    }

    SizedBox _txtCode_3() {
      return SizedBox(
        width: 55.w,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 1,
          controller: txtCode_3,
          textInputAction: TextInputAction.next,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: '',
            fillColor: AppColors.alabaster,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.grey, width: 0.2),
            ),
          ),
        ),
      );
    }

    SizedBox _txtCode_4() {
      return SizedBox(
        width: 55.w,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 1,
          controller: txtCode_4,
          textInputAction: TextInputAction.done,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: '',
            fillColor: AppColors.alabaster,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.2.w
              ),
            ),
          ),
        ),
      );
    }

    Row _codeWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _txtCode_1(),
          SizedBox(width: 20.w,),
          _txtCode_2(),
          SizedBox(width: 20.w,),
          _txtCode_3(),
          SizedBox(width: 20.w,),
          _txtCode_4(),
        ],
      );
    }

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
                          height: 20.h
                        ),
                        Text(
                          AppTextConstants.verifyPhoneCode,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          phoneNumber,
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
                        _codeWidget(),
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
                              onTap: _resendOTP,
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
                            child: incorrectOTP ? Text(
                              AppTextConstants.authenticationFailed,
                              style: const TextStyle(
                                fontSize: 17,
                                fontFamily: 'Gilroy',
                                color: Colors.red,
                              ),
                            ) : const Text(''),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          width: width,
                          height: 60.h,
                          child: ElevatedButton(
                            onPressed: _apiVerify,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColors.silver,
                                ),
                                borderRadius:
                                BorderRadius.circular(18.r),
                              ),
                              primary: AppColors.primaryGreen,
                              onPrimary: Colors.white, // <-- Splash color
                            ),
                            child: Text(
                              AppTextConstants.verifyText,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
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

  /// Method for resetting the text controller
  void reset() {
    setState(() {
      txtCode_1.clear();
      txtCode_2.clear();
      txtCode_3.clear();
      txtCode_4.clear();
      incorrectOTP = false;
    });
  }

  /// Method for calling the verification api
  void _apiVerify(){
    // ApiCalls.verifyForgotPassword(context, txtCode_1.text + txtCode_2.text + txtCode_3.text + txtCode_4.text, phoneNumber); // Temporary Commented it out for ease of use for testing
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>  const CreateNewPasswordScreen(code: '', phoneNumber: '')
      ),
    );
  }

  /// Method for resending the failed OTP attempt
  void _resendOTP() {
    reset();
    ApiCalls.resendOTP(email, phoneNumber);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('email', email));
    properties.add(StringProperty('phoneNumber', phoneNumber));
    properties.add(DiagnosticsProperty<bool>('incorrectOTP', incorrectOTP));
    properties.add(DiagnosticsProperty<TextEditingController>('txtCode_1', txtCode_1));
    properties.add(DiagnosticsProperty<TextEditingController>('txtCode_2', txtCode_2));
    properties.add(DiagnosticsProperty<TextEditingController>('txtCode_3', txtCode_3));
    properties.add(DiagnosticsProperty<TextEditingController>('txtCode_4', txtCode_4));
  }
}