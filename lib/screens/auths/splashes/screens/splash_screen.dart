// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/auths/splashes/screens/user_type_screen.dart';

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
      body: SingleChildScrollView(
        child: SafeArea(
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
                  width: 250.w,
                ),
                Image.asset(
                  AssetsPath.forThePlanet,
                  width: 80.w,
                  height: 50.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'The Great Outdoors Just',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'A Few Seconds Away',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  AppTextConstants.bookYourNextAdventureOnApp,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.nobel,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                 AppTextConstants.findAmazingWilderness,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.nobel,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  AppTextConstants.getGuided,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.nobel,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15.h,
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
                  child: const Icon(Icons.arrow_forward_sharp,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
