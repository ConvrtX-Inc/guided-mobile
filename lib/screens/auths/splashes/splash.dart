// ignore_for_file: always_specify_types, public_member_api_docs, use_key_in_widget_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/main.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/auths/splashes/screens/splash_screen.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/main_navigation/traveller/traveller_tabbar.dart';
import 'package:guided/utils/secure_storage.dart';

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
        nextScreen: getNextScreen(),
      ),
    );
  }

  Widget getNextScreen() => FutureBuilder(
      future: SecureStorage.readValue(key: AppTextConstants.userToken),
      builder: (BuildContext context, AsyncSnapshot<String> userToken) {
        if (userToken.data != null) {
          UserSingleton.instance.user.token = userToken.data;
          return getScreenByType();
        } else {
          return const SplashScreen();
        }
      });

  Widget getScreenByType() => FutureBuilder(
      future: SecureStorage.readValue(key: AppTextConstants.userType),
      builder: (BuildContext context, AsyncSnapshot<String> userType) {
        if (userType.data != null) {
          switch (userType.data!) {
            case 'traveller':
              return const TravellerTabScreen();
            case 'guide':
              return const MainNavigationScreen(navIndex: 0, contentIndex: 0);
            default:
              return const SplashScreen();
          }
        }

        return Container();
      });
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
