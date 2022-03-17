// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/auths/logins/screens/login_screen.dart';
import 'package:guided/screens/signin_signup/signup_screen.dart';

/// Welcome screen
class WelcomeScreen extends StatelessWidget {
  /// Constructor
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppTextConstants.welcomeGuided,
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  AssetsPath.welcomeToGuideImage,
                  height: 320.h,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                  child: Column(
                    children: <Widget>[
                      Text(
                        AppTextConstants.loremIpsum,
                        style: TextStyle(
                            color: AppColors.grey, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  width: width / 1.2,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
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
                      AppTextConstants.alreadyHaveAccount,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  width: width / 1.2,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/sign_up');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.silver,
                        ),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      primary: Colors.white,
                      onPrimary: AppColors.primaryGreen, // <-- Splash color
                    ),
                    child: Text(
                      AppTextConstants.createNewAccount,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
