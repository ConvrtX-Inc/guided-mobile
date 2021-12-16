import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/helpers/api_calls.dart';
import 'package:guided/screens/signin_signup/signup_verify_phone.dart';

/// Continue w/ phone screen
class ContinueWithPhone extends StatefulWidget {
  /// Constructor
  const ContinueWithPhone({Key? key}) : super(key: key);

  @override
  _ContinueWithPhoneState createState() => _ContinueWithPhoneState();
}

class _ContinueWithPhoneState extends State<ContinueWithPhone> {
  String _dialCode = '+1';
  bool isPhoneValid = false;
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

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
                  padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppTextConstants.continueWithPhone,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        AppTextConstants.codeDescription,
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
                      Text(
                        AppTextConstants.enterPhoneNumber,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),
                      ),
                      SizedBox(
                        height: 15.h
                      ),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: AppTextConstants.phoneNumberHint,
                          prefixIcon: SizedBox(
                            child: CountryCodePicker(
                              onChanged: _onCountryChange,
                              initialSelection: AppTextConstants.defaultCountry,
                              favorite: ['+1', 'US'],
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(color: Colors.grey, width: 0.2.w),
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
              height: 60.h,
              child: ElevatedButton(
                onPressed: _apiCall,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.cloud,
                    ),
                    borderRadius: BorderRadius.circular(18), // <-- Radius
                  ),
                  primary: AppColors.primaryGreen,
                  onPrimary: Colors.white, // <-- Splash color
                ),
                child: Text(
                  AppTextConstants.continueText,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
              ),
            ),
          ),
        ),
        designSize: const Size(375, 812)
    );
  }

  /// Method for getting the country code
  void _onCountryChange(CountryCode countryCode) => _dialCode = countryCode.dialCode.toString();

  /// Method for calling the API
  void _apiCall() {
    // ApiCalls.sendCode(context, _dialCode + phoneController.text); // Temporary commented out for setting up other API Integration
    Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => SignupVerify(phoneNumber: _dialCode + phoneController.text))
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isPhoneValid', isPhoneValid));
    properties.add(DiagnosticsProperty<TextEditingController>('phoneController', phoneController));
  }
}