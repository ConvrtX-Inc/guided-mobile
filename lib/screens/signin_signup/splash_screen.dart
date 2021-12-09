// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/signin_signup/user_type_screen.dart';

/// Splash screen
class SplashScreen extends StatelessWidget {

  /// Constructor
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(AssetsPath.logoSmall),
                ),
              ),
              Image.asset(
                AssetsPath.splashImage,
                width: 300.w,
              ),
              Image.asset(
                AssetsPath.forThePlanet,
                width: 80.w,
                height: 29.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                AppTextConstants.createYourBusiness,
                style: const TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                AppTextConstants.theApplicationWillHelp,
                style: const TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/user_type');
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  primary: AppColors.primaryGreen, // <-- Button color
                  onPrimary: Colors.green, // <-- Splash color
                ),
                child:
                const Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
