// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/signin_signup/continue_with_phone.dart';
import 'package:guided/screens/signin_signup/login_screen.dart';

/// Sign up screen
class SignupScreen extends StatefulWidget {

  /// Constructor
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                    AppTextConstants.signup,
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
                      // Insert here the Sign up to Facebook API
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
                      AppTextConstants.signupWithFacebook,
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
                      // Insert here the Sign up to Google API
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: AppColors.mercury,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    leading: Image.asset(
                      AssetsPath.google,
                      height: 30,
                    ),
                    title: Text(
                      AppTextConstants.signupWithGoogle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h
                  ),
                  Text(
                    AppTextConstants.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                      height: 15.h
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: AppTextConstants.nameHint,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide(
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
                    decoration: InputDecoration(
                      hintText: AppTextConstants.emailHint,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.2.w
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 15.h
                  ),
                  Text(
                    AppTextConstants.password,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
                  ),
                  SizedBox(
                      height: 15.h
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: AppTextConstants.passwordHint,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.2.w
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 20.h
                  ),
                  SizedBox(
                    width: width,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/continue_with_phone');
                      },
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
                        AppTextConstants.signup,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppTextConstants.alreadyHaveAnAccount,
                        style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'Gilroy',
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                        child: Text(
                          AppTextConstants.login,
                          style: TextStyle(
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
}
