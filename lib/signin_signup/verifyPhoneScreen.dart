// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/signin_signup/createNewPasswordScreen.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({Key? key}) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
            fillColor: HexColor("#F7F7F7"),
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
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Verify Your Phone',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    ConstantHelpers.spacing20,
                    const Text(
                      "Verification code sent to your phone",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Gilroy",
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
                        const Text(
                          "Didn’t recive code? ",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Gilroy",
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Resend OTP",
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
                                builder: (context) =>
                                    const CreateNewPasswordScreen()),
                          );
                        },
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: HexColor("#C4C4C4"),
                            ),
                            borderRadius:
                                BorderRadius.circular(18), // <-- Radius
                          ),
                          primary: ConstantHelpers.primaryGreen,
                          onPrimary: Colors.white, // <-- Splash color
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
    );
  }
}
