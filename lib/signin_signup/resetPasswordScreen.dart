// ignore_for_file: file_names
import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/signin_signup/verifyPhoneScreen.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  String id = 'Reset';
  String code = '';
  String _dialCode = '+1';

  TextEditingController phoneController = new TextEditingController();

  late TwilioFlutter twilioFlutter;

  /// Twilio Account Initialization
  @override
  void initState() {
    twilioFlutter =
        TwilioFlutter(accountSid: 'AC6aeec4233812df810ce39c0eb698dd3b', authToken: 'dbb33f76dc4f534cbeb520221c34f312', twilioNumber: '(830) 947-5543');

    super.initState();
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
    await twilioFlutter.sendSMS(toNumber: _dialCode + phoneController.text, messageBody: '[GuidED] Your verification code is: $code');
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VerifyPhoneScreen(id: id, phoneNumber: _dialCode + phoneController.text, code: code)),
    );
  }

  /// Country code
  void _onCountryChange(CountryCode countryCode) => _dialCode = countryCode.dialCode.toString();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                    'Reset Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  const Text(
                    "Enter your email ID  or phone number associated with your account and we’ll send an verification code for reset your password",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  ConstantHelpers.spacing20,
                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  ConstantHelpers.spacing15,
                  TextField(
                    decoration: InputDecoration(
                      hintText: "johnsmith@gmail.com",
                      hintStyle: TextStyle(
                        color: ConstantHelpers.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing15,
                  const Text(
                    "Enter Phone Number",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  ConstantHelpers.spacing15,
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: SizedBox(
                        child: CountryCodePicker(
                          onChanged: _onCountryChange,
                          initialSelection: 'US',
                          favorite: const ['+1', 'US'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: ConstantHelpers.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: 60,
          child: ElevatedButton(
            onPressed: sendSms,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: HexColor("#C4C4C4"),
                ),
                borderRadius: BorderRadius.circular(18), // <-- Radius
              ),
              primary: ConstantHelpers.primaryGreen,
              onPrimary: Colors.white, // <-- Splash color
            ),
            child: const Text(
              'Reset Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
