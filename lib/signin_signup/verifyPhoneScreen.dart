// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/signin_signup/createNewPasswordScreen.dart';
import 'package:guided/signin_signup/signup_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String id;
  final String phoneNumber;

  VerifyPhoneScreen({Key? key, required this.id, required this.phoneNumber}) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState(id, phoneNumber);
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {

  String id = '';
  String phoneNumber = '';

  _VerifyPhoneScreenState(this.id, this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    _txtCode() {
      return SizedBox(
        width: 55,
        child: TextField(
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
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
          _txtCode(),
          ConstantHelpers.spacingwidth20,
          _txtCode(),
          ConstantHelpers.spacingwidth20,
          _txtCode(),
          ConstantHelpers.spacingwidth20,
          _txtCode(),
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
                              onTap: () {},
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
                          height: 50,
                        ),
                        SizedBox(
                          width: width,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => id == 'Signup' ? const SignupForm() : const CreateNewPasswordScreen()
                                        ),
                              );
                            },
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
