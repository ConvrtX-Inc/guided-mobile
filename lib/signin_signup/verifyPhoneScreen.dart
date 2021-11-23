// ignore_for_file: file_names
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/signin_signup/createNewPasswordScreen.dart';
import 'package:guided/signin_signup/signup_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String id;
  final String phoneNumber;
  final String code;

  VerifyPhoneScreen({Key? key, required this.id, required this.phoneNumber, required this.code}) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState(id, phoneNumber, code);
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {

  String id = '';
  String phoneNumber = '';
  String code = '';

  bool incorrectOTP = false;

  _VerifyPhoneScreenState(this.id, this.phoneNumber, this.code);

  TextEditingController txtCode_1 = new TextEditingController();
  TextEditingController txtCode_2 = new TextEditingController();
  TextEditingController txtCode_3 = new TextEditingController();
  TextEditingController txtCode_4 = new TextEditingController();

  late TwilioFlutter twilioFlutter;

  @override
  void initState() {
    twilioFlutter =
        TwilioFlutter(accountSid: 'AC6aeec4233812df810ce39c0eb698dd3b', authToken: 'dbb33f76dc4f534cbeb520221c34f312', twilioNumber: '(830) 947-5543');

    super.initState();
  }


  void reset() {
    setState(() {
      txtCode_1.clear();
      txtCode_2.clear();
      txtCode_3.clear();
      txtCode_4.clear();
      incorrectOTP = false;
    });
  }

  /// Process verification
  void verifyCode() {
    String userCode = txtCode_1.text + txtCode_2.text + txtCode_3.text + txtCode_4.text;

    if(userCode == code){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => id == 'Signup' ? const SignupForm() : const CreateNewPasswordScreen()
        ),
      );
    }
    else{
      setState(() {
        incorrectOTP = true;
      });
    }
  }

  /// Generate the 4 code verification
  void generateCode() {
    setState(() {
      code = (Random().nextInt(1111) + 8888).toString();
    });
  }

  /// Twilio send message to user
  void sendSms() async {
    generateCode();
    reset();
    await twilioFlutter.sendSMS(toNumber: phoneNumber, messageBody: '[GuidED] Your verification code is: $code');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    _txtCode_1() {
      return SizedBox(
        width: 55,
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
            fillColor: ConstantHelpers.whiteFiller,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.grey, width: 0.2),
            ),
          ),
        ),
      );
    }

    _txtCode_2() {
      return SizedBox(
        width: 55,
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
            fillColor: ConstantHelpers.whiteFiller,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.grey, width: 0.2),
            ),
          ),
        ),
      );
    }

    _txtCode_3() {
      return SizedBox(
        width: 55,
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
            fillColor: ConstantHelpers.whiteFiller,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.grey, width: 0.2),
            ),
          ),
        ),
      );
    }

    _txtCode_4() {
      return SizedBox(
        width: 55,
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
            fillColor: ConstantHelpers.whiteFiller,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.grey, width: 0.2),
            ),
          ),
        ),
      );
    }

    _codeWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _txtCode_1(),
          ConstantHelpers.spacingwidth20,
          _txtCode_2(),
          ConstantHelpers.spacingwidth20,
          _txtCode_3(),
          ConstantHelpers.spacingwidth20,
          _txtCode_4(),
        ],
      );
    }

    return ScreenUtilInit(
        builder: () => Scaffold(
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
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ConstantHelpers.verifyPhone,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        ConstantHelpers.spacing20,
                        Text(
                          ConstantHelpers.verifyPhoneCode,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: ConstantHelpers.fontGilroy,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          phoneNumber,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: ConstantHelpers.fontGilroy,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        _codeWidget(),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              ConstantHelpers.didnotReceive,
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: ConstantHelpers.fontGilroy,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: sendSms,
                              child: Text(
                                ConstantHelpers.resendOTP,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  color: ConstantHelpers.primaryGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                              child: incorrectOTP ? Text(
                                'Authentication Failed, Try again!',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: ConstantHelpers.fontGilroy,
                                  color: Colors.red,
                                ),
                              ) : const Text(''),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: width,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: verifyCode,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: ConstantHelpers.buttonNext,
                                ),
                                borderRadius:
                                    BorderRadius.circular(18), // <-- Radius
                              ),
                              primary: ConstantHelpers.primaryGreen,
                              onPrimary: Colors.white, // <-- Splash color
                            ),
                            child: Text(
                              ConstantHelpers.verifyText,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                        ConstantHelpers.spacing20,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        designSize: const Size(375, 812)
    );
  }
}
