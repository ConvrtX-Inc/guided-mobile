import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/utils/services/rest_api_service.dart';

///Change Password Screen
class ChangePasswordScreen extends StatefulWidget {
  ///Constructor
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool isPasswordMatch = false;
  String code = '';
  String phoneNumber = '';

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
                    AppTextConstants.createNewPassword,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppTextConstants.yourPasswordMustBeDifferent,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    AppTextConstants.newPassword,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: newPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: AppTextConstants.passwordHint,
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
                  SizedBox(height: 20.h),
                  Text(
                    AppTextConstants.confirmPassword,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextField(
                    controller: confirmPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: AppTextConstants.passwordHint,
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
            onPressed:updatePassword,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.silver,
                ),
                borderRadius: BorderRadius.circular(18.r), // <-- Radius
              ),
              primary: AppColors.primaryGreen,
              onPrimary: Colors.white, // <-- Splash color
            ),
            child: Text(
              AppTextConstants.setPassword,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

/*  Future<void> setPasswordAPI(Map<String, dynamic> verificationDetails) async {
    final Map<String, dynamic> passwordDetails = {
      'password': confirmPassword.text,
      'hash': verificationDetails['hash'],
      'phone': 0,
    };

    if (newPassword.text == confirmPassword.text) {
      final dynamic response = await APIServices().request(
          AppAPIPath.resetPasswordUrl, RequestType.POST,
          data: passwordDetails);

      if (response == 200) {
        AdvanceSnackBar(message: 'Password Updated!')
            .show(context);
        Navigator.of(context).pop();
      } else {
        final Map<String, dynamic> userDetails = {
          'email': verificationDetails['email'],
          'phone_no': verificationDetails['phone_no'],
        };

        await Navigator.pushNamed(context, '/verification_code',
            arguments: userDetails);
      }
    } else {
      AdvanceSnackBar(message: ErrorMessageConstants.passwordDoesNotMatch)
          .show(context);
    }
  }*/

  Future<void> updatePassword() async {
    if (newPassword.text == confirmPassword.text) {
      final dynamic updatePasswordParams = {
        'password': newPassword.text,
      };

      final APIStandardReturnFormat res =
      await APIServices().updatePassword(updatePasswordParams);
      debugPrint(
          'Response:: update password ${res.statusCode} ${res.status} ${res.errorResponse}${newPassword.text}');

      if (res.status == 'success') {
        const AdvanceSnackBar(message: 'Password Updated!')
            .show(context);
        Navigator.of(context).pop();
      }else{
        AdvanceSnackBar(message: ErrorMessageConstants.passwordDoesNotMatch)
            .show(context);
      }
    }
  }
}
