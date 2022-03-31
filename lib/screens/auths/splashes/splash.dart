// ignore_for_file: always_specify_types, public_member_api_docs, use_key_in_widget_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/main.dart';
import 'package:guided/screens/auths/splashes/screens/splash_screen.dart';

/// Splash Screen for waiting
class Splash extends StatefulWidget {
  /// Constructor
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Splash1(),
        duration: 1500,
        splashIconSize: 700,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const SplashScreen(),
      ),
    );
  }
}

class Splash1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Image.asset(
              AssetsPath.logo,
            )),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'ADVENTURE',
              style: TextStyle(
                  color: AppColors.brightSun,
                  fontFamily: 'Gilroy',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'DISCOVER',
              style: TextStyle(
                  color: AppColors.brightSun,
                  fontFamily: 'Gilroy',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'EXPLORE',
              style: TextStyle(
                  color: AppColors.brightSun,
                  fontFamily: 'Gilroy',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}