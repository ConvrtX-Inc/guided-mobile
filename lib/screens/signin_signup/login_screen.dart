import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/api_calls.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/signin_signup/reset_password_screen.dart';
import 'package:guided/screens/signin_signup/signup_screen.dart';

/// Login Screen
class LoginScreen extends StatefulWidget {

  /// Constructor
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
                  ),
                  SizedBox(
                    height: 15.h
                  ),
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
                          BorderSide(
                              color: Colors.grey,
                              width: 0.2.w
                          ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    AppTextConstants.password,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextField(
                    controller: passwordController,
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
                          BorderSide(
                            color: Colors.grey,
                            width: 0.2.w
                          ),
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
                      // onPressed: _ApiLogin,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => const MainNavigationScreen(
                                    navIndex: 0,
                                    contentIndex: 0,
                                  )),
                        );
                      },
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
                        AppTextConstants.login,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h
                  ),
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


  // //Temporary commented out
  // void _ApiLogin(){
  //   ApiCalls.login(context, emailController.text, passwordController.text);
  // }


  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('emailController', emailController));
    properties.add(DiagnosticsProperty<TextEditingController>('passwordController', passwordController));
  }
}
