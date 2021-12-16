// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/auths/splashes/screens/welcome_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

/// User on boarding screen
class UserOnboardingScreen extends StatefulWidget {

  /// Constructor
  const UserOnboardingScreen({Key? key}) : super(key: key);

  @override
  _UserOnboardingScreenState createState() => _UserOnboardingScreenState();
}

class _UserOnboardingScreenState extends State<UserOnboardingScreen> {

  CarouselController buttonCarouselController = CarouselController();
  double activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget _buildImage(String image, [double width = 350]) {
      return Image.asset(
        image,
        width: width,
        height: 360.h,
      );
    }

    Column headerImage(String step, imageUrl) {
      return Column(
        children: <Widget>[
          Text(
            AppTextConstants.userOnBoarding,
            style: const TextStyle(
                fontSize: 18,
                fontFamily: 'GilroyBold',
                fontWeight: FontWeight.bold),
          ),
          Text(step),
          _buildImage(
            imageUrl,
          ),
        ],
      );
    }

    Column footer(String description, bool isLast) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.grey),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 50.h,
                width: 150.w,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isLast) {
                      setState(() {
                        activeIndex = activeIndex + 1;
                      });
                    } else {
                      Navigator.of(context).pushNamed('/welcome');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: AppColors.silver,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    primary: Colors.white,
                    onPrimary: AppColors.primaryGreen,
                  ),
                  child: Text(
                    AppTextConstants.skip,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
                width: 150.w,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isLast) {
                      setState(() {
                        activeIndex = activeIndex + 1;
                      });
                    } else {
                      Navigator.of(context).pushNamed('/welcome');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: AppColors.silver,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    primary: AppColors.primaryGreen,
                    onPrimary: Colors.white, // <-- Splash color
                  ),
                  child: isLast ? Text(AppTextConstants.done) : Text(AppTextConstants.next),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (activeIndex == 0) headerImage('Step 1/3', 'assets/images/userOnBoarding1.png') else activeIndex == 1
                  ? headerImage(
                  'Step 2/3', 'assets/images/userOnBoarding2.png')
                  : activeIndex == 2
                  ? headerImage(
                  'Step 3/3', 'assets/images/userOnBoarding3.png')
                  : const SizedBox(),
              DotsIndicator(
                dotsCount: 3,
                position: activeIndex,
                decorator: DotsDecorator(
                  activeColor: Colors.black,
                  activeSize: const Size(29, 7),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r)),
                ),
              ),
              if (activeIndex == 0) footer(
                AppTextConstants.footerDescr1,
                false,
              ) else activeIndex == 1
                  ? footer(
                AppTextConstants.footerDescr2,
                false,
              )
                  : activeIndex == 2
                  ? footer(
                AppTextConstants.footerDescr3,
                true,
              )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CarouselController>('buttonCarouselController', buttonCarouselController));
    properties.add(DoubleProperty('activeIndex', activeIndex));
  }
}