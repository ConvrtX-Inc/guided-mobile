import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/signin_signup/verifyPhoneScreen.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class ContinueWithPhone extends StatefulWidget {
  const ContinueWithPhone({Key? key}) : super(key: key);

  @override
  _ContinueWithPhoneState createState() => _ContinueWithPhoneState();
}

class _ContinueWithPhoneState extends State<ContinueWithPhone> {
  String id = 'Signup';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                        ConstantHelpers.continueWithPhone,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      Text(
                        ConstantHelpers.codeDescription,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      ConstantHelpers.spacing20,
                      Text(
                        ConstantHelpers.enterPhoneNumber,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      ConstantHelpers.spacing15,
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: ConstantHelpers.phoneNumberHint,
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
                      color: ConstantHelpers.buttonNext,
                    ),
                    borderRadius: BorderRadius.circular(18), // <-- Radius
                  ),
                  primary: ConstantHelpers.primaryGreen,
                  onPrimary: Colors.white, // <-- Splash color
                ),
                child: Text(
                  ConstantHelpers.continueText,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        designSize: const Size(375, 812)
    );
  }
}
