// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/auths/splashes/screens/welcome_screen.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// User on boarding screen
class UserOnboardingScreen extends StatefulWidget {
  /// Constructor
  const UserOnboardingScreen({Key? key}) : super(key: key);

  @override
  _UserOnboardingScreenState createState() => _UserOnboardingScreenState();
}

class _UserOnboardingScreenState extends State<UserOnboardingScreen> {
  CarouselController buttonCarouselController = CarouselController();
  int activeIndex = 0;
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (screenArguments['user_type'] == 'traveller')
                  buildTraveller()
                else
                  buildGuide(),
              ]),
        ),
      ),
      bottomNavigationBar: activeIndex == 1
          ? Padding(
              padding: const EdgeInsets.all(30),
              child: SizedBox(
                height: 50.h,
                width: 80.w,
                child: ElevatedButton(
                  onPressed: () async {
                    if (activeIndex != 1) {
                      setState(() {
                        activeIndex = activeIndex + 1;
                        buttonCarouselController.animateToPage(activeIndex);
                      });
                    } else {
                      await SecureStorage.readValue(
                              key: AppTextConstants.userType)
                          .then((String value) async {
                        if (value == 'traveller') {
                          await Navigator.of(context).pushNamed('/discovery');
                        } else {
                          await Navigator.of(context).pushNamed('/welcome');
                        }
                      });
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
                  child: Text(AppTextConstants.getStarted),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50.h,
                    width: 150.w,
                    child: ElevatedButton(
                      onPressed: () async {
                        await SecureStorage.readValue(
                                key: AppTextConstants.userType)
                            .then((String value) async {
                          if (value == 'traveller') {
                            await Navigator.of(context).pushNamed('/discovery');
                          } else {
                            await Navigator.of(context).pushNamed('/welcome');
                          }
                        });
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
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    width: 150.w,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (activeIndex != 1) {
                          setState(() {
                            activeIndex = activeIndex + 1;
                            buttonCarouselController.animateToPage(activeIndex);
                          });
                        } else {
                          await SecureStorage.readValue(
                                  key: AppTextConstants.userType)
                              .then((String value) async {
                            if (value == 'traveller') {
                              await Navigator.of(context)
                                  .pushNamed('/discovery');
                            } else {
                              await Navigator.of(context).pushNamed('/welcome');
                            }
                          });
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
                      child: Text(AppTextConstants.next),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildIndicator1(int count) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: count,
        effect: SlideEffect(
            activeDotColor: Colors.black,
            dotColor: Colors.grey.shade400,
            dotHeight: 10.h,
            dotWidth: 20.w),
      );

  Widget buildGuide() => CarouselSlider(
        options: CarouselOptions(
          height: 550,
          aspectRatio: 1,
          enableInfiniteScroll: false,
          viewportFraction: 1,
          onPageChanged: (int index, CarouselPageChangedReason reason) =>
              setState(() => activeIndex = index),
        ),
        carouselController: buttonCarouselController,
        items: <Widget>[
          Column(children: <Widget>[
            Text(AppTextConstants.userOnBoarding,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'GilroyBold',
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Step 1/2',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10.h,
            ),
            Image.asset('assets/images/userOnBoarding1.png',
                width: 250, height: 250),
            SizedBox(
              height: 10.h,
            ),
            buildIndicator1(2),
            SizedBox(
              height: 10.h,
            ),
            Text(
              AppTextConstants.footerDescr1,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontFamily: 'Gilroy',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ]),
          Column(children: <Widget>[
            Text(AppTextConstants.userOnBoarding,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'GilroyBold',
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Step 2/2',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10.h,
            ),
            Image.asset('assets/images/userOnBoarding3.png',
                width: 250, height: 250),
            SizedBox(
              height: 10.h,
            ),
            buildIndicator1(2),
            SizedBox(
              height: 10.h,
            ),
            Text(
              AppTextConstants.footerDescr3,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontFamily: 'Gilroy',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ]),
        ],
      );

  Widget buildTraveller() => CarouselSlider(
        options: CarouselOptions(
          height: 550,
          aspectRatio: 1,
          enableInfiniteScroll: false,
          viewportFraction: 1,
          onPageChanged: (int index, CarouselPageChangedReason reason) =>
              setState(() => activeIndex = index),
        ),
        carouselController: buttonCarouselController,
        items: <Widget>[
          Column(children: <Widget>[
            Text(AppTextConstants.userOnBoarding,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'GilroyBold',
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Step 1/2',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10.h,
            ),
            Image.asset('assets/images/userOnBoarding2.png',
                width: 250, height: 250),
            SizedBox(
              height: 10.h,
            ),
            buildIndicator1(2),
            SizedBox(
              height: 10.h,
            ),
            Text(
              AppTextConstants.footerDescr2,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontFamily: 'Gilroy',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ]),
          Column(children: <Widget>[
            Text(AppTextConstants.userOnBoarding,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'GilroyBold',
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Step 2/2',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10.h,
            ),
            Image.asset('assets/images/userOnBoarding3.png',
                width: 250, height: 250),
            SizedBox(
              height: 10.h,
            ),
            buildIndicator1(2),
            SizedBox(
              height: 10.h,
            ),
            Text(
              AppTextConstants.footerDescr3,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontFamily: 'Gilroy',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ]),
        ],
      );
}
