import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/signin_signup/signup_verify_phone.dart';
import 'package:guided/utils/services/rest_api_service.dart';

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
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(height: 15.h),
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
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
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
            onPressed: () async => sendVerification(screenArguments),
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  /// Method for getting the country code
  void _onCountryChange(CountryCode countryCode) =>
      _dialCode = countryCode.dialCode.toString();

  /// Method for calling the API
  Future<void> sendVerification(Map<String, dynamic> data) async {
    final Map<String, dynamic> phoneDetails = {
      'phone_number': _dialCode + phoneController.text,
    };

    final Map<String, dynamic> signupDetails = Map<String, dynamic>.from(data);
    signupDetails['phone_number'] = phoneController.text;
    signupDetails['country_code'] = _dialCode.substring(0);
    
    await APIServices().request(
        AppAPIPath.sendVerificationCodeSignUpUrl, RequestType.POST,
        data: phoneDetails);
        
    await Navigator.pushNamed(context, '/sign_up_verify',
        arguments: signupDetails);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isPhoneValid', isPhoneValid));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>(
        'phoneController', phoneController));
  }
}
