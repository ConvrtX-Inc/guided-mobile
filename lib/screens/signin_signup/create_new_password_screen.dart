import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/helpers/api_calls.dart';

/// Create new password screen
class CreateNewPasswordScreen extends StatefulWidget {

  /// Constructor
  const CreateNewPasswordScreen({Key? key, required this.code, required this.phoneNumber}) : super(key: key);

  /// 4 digit code
  final String code;

  /// User phone number
  final String phoneNumber;

  @override
  _CreateNewPasswordScreenState createState() => _CreateNewPasswordScreenState(code, phoneNumber);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('code', code));
    properties.add(StringProperty('phoneNumber', phoneNumber));
  }
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {

  _CreateNewPasswordScreenState(this.code, this.phoneNumber);

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
                  SizedBox(
                    height: 20.h
                  ),
                  Text(
                    AppTextConstants.yourPasswordMustBeDifferent,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                      height: 40.h
                  ),
                  Text(
                    AppTextConstants.newPassword,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15
                  ),
                  ),
                  SizedBox(
                      height: 20.h
                  ),
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
                        BorderSide(
                          color: Colors.grey,
                          width: 0.2.w
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h
                  ),
                  Text(
                    AppTextConstants.confirmPassword,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
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
                        BorderSide(
                          color: Colors.grey,
                            width: 0.2.w
                        ),
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
            onPressed: _checkPassword,
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
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Method for checking the password
  void _checkPassword(){
    if(newPassword.text == confirmPassword.text){
      ApiCalls.resetPassword(confirmPassword.text, code, phoneNumber);
    }
    else{
      setState(() {
        isPasswordMatch = true;
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('newPassword', newPassword));
    properties.add(DiagnosticsProperty<TextEditingController>('confirmPassword', confirmPassword));
    properties.add(DiagnosticsProperty<bool>('isPasswordMatch', isPasswordMatch));
    properties.add(StringProperty('code', code));
    properties.add(StringProperty('phoneNumber', phoneNumber));
  }
}
