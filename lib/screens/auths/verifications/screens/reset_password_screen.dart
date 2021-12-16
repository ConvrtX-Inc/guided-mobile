import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Reset Password Screen
class ResetPasswordScreen extends StatefulWidget {
  /// Constructor
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // ignore: unused_field
  String _dialCode = '+1';

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

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
                    AppTextConstants.resetPassword,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppTextConstants.enterYourEmailID,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    AppTextConstants.email,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(height: 15.h),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: AppTextConstants.emailHint,
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
                  SizedBox(height: 15.h),
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
                      prefixIcon: SizedBox(
                        child: CountryCodePicker(
                          onChanged: _onCountryChange,
                          initialSelection: AppTextConstants.defaultCountry,
                          // ignore: always_specify_types
                          favorite: const ['+1', 'US'],
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
            onPressed: () async => sendVerificationCode(),
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
              AppTextConstants.resetPassword,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  /// Country code
  void _onCountryChange(CountryCode countryCode) =>
      _dialCode = countryCode.dialCode.toString();

  /// Methode for caling the API
  Future<void> sendVerificationCode() async {
    final Map<String, dynamic> userDetails = {
      'email': emailController.text,
      'phone_no': _dialCode + phoneController.text
    };

    await APIServices().request(
        AppAPIPath.sendVerificationCodeUrl, RequestType.POST,
        data: userDetails);
    await Navigator.pushNamed(context, '/verification_code',
        arguments: userDetails);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'phoneController', phoneController));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>(
        'emailController', emailController));
  }
}
