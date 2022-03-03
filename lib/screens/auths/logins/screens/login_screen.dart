import 'dart:convert';

import 'package:advance_notification/advance_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Login Screen
class LoginScreen extends StatefulWidget {
  /// Constructor
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool hidePassword = true;
  bool buttonIsLoading = false;

  Future<void> login() async {
    final Map<String, String> credentials = <String, String>{
      'email': _emailController.text,
      'password': _passwordController.text
    };

    if (!EmailValidator.validate(_emailController.text)) {
      _emailFocus.requestFocus();
      AdvanceSnackBar(message: ErrorMessageConstants.emailInvalidorEmpty)
          .show(context);
      return;
    }

    if (_passwordController.text.isEmpty) {
      _passwordFocus.requestFocus();
      AdvanceSnackBar(message: ErrorMessageConstants.emptyPassword)
          .show(context);
      return;
    }
    setState(() => buttonIsLoading = true);
    // final dynamic response = await APIServices()
    //     .request(AppAPIPath.loginUrl, RequestType.POST, data: credentials);

    // if (response is Map) {
    //   if (response.containsKey('status')) {
    //     if (response['status'] == 422) {
    //       AdvanceSnackBar(
    //               message: ErrorMessageConstants.loginWrongEmailorPassword)
    //           .show(context);
    //     }
    //   } else {
    //     final UserModel user =
    //         UserModel.fromJson(json.decode(response.toString()));
    //     UserSingleton.instance.user = user;
    //     print(user.user?.isTraveller);
    //     await SecureStorage.saveValue(
    //         key: AppTextConstants.userToken, value: response['token']);
    //     // ignore: avoid_dynamic_calls
    //     await SecureStorage.saveValue(
    //         // ignore: avoid_dynamic_calls
    //         key: SecureStorage.userIdKey,
    //         value: response['user']['id']);
    //     await Navigator.of(context).pushNamed('/main_navigation');
    //   }
    // }

    await APIServices()
        .login(credentials)
        .then((APIStandardReturnFormat response) async {
      if (response.status == 'error') {
        AdvanceSnackBar(
                message: ErrorMessageConstants.loginWrongEmailorPassword)
            .show(context);
      } else {
        final UserModel user =
            UserModel.fromJson(json.decode(response.successResponse));
        UserSingleton.instance.user = user;
        if (user.user?.isTraveller != true) {
          await Navigator.pushReplacementNamed(context, '/main_navigation');
        } else {
          await Navigator.pushReplacementNamed(context, '/traveller_tab');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                    width: 40.w,
                    height: 40.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AppColors.harp,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppTextConstants.login,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListTile(
                    onTap: () {
                      // Insert here the Facebook API Integration
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: AppColors.mercury,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    leading: Image.asset(
                      AssetsPath.facebook,
                      height: 30.h,
                    ),
                    title: Text(
                      AppTextConstants.loginWithFacebook,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ListTile(
                    onTap: () {
                      // Insert here the Google API Integration
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: AppColors.mercury,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    leading: Image.asset(
                      'assets/images/google.png',
                      height: 30.h,
                    ),
                    title: Text(
                      AppTextConstants.loginWithGoogle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppTextConstants.email,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(height: 15.h),
                  TextField(
                    controller: _emailController,
                    focusNode: _emailFocus,
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
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    AppTextConstants.password,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
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
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/reset_password');
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () async => login(),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.silver,
                          ),
                          borderRadius:
                              BorderRadius.circular(18.r), // <-- Radius
                        ),
                        primary: AppColors.primaryGreen,
                        onPrimary: Colors.white, // <-- Splash color
                      ),
                      child: Text(
                        AppTextConstants.login,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: <Widget>[
                      Text(
                        AppTextConstants.dontHaveAccount,
                        style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'Gilroy',
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/sign_up');
                        },
                        child: Text(
                          AppTextConstants.signup,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'emailController', _emailController));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>(
        'passwordController', _passwordController));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<bool>('hidePassword', hidePassword));
    // ignore: cascade_invocations
    properties
        .add(DiagnosticsProperty<bool>('buttonIsLoading', buttonIsLoading));
  }
}
