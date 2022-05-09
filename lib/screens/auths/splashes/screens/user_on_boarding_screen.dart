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

    // Widget _buildImage(String image, [double width = 350]) {
    //   return Image.asset(
    //     image,
    //     width: width,
    //     height: 360.h,
    //   );
    // }

    // Column headerImage(String step, imageUrl) {
    //   return Column(
    //     children: <Widget>[
    //       Text(
    //         AppTextConstants.userOnBoarding,
    //         style: const TextStyle(
    //             fontSize: 18,
    //             fontFamily: 'GilroyBold',
    //             fontWeight: FontWeight.bold),
    //       ),
    //       Text(step),
    //       _buildImage(
    //         imageUrl,
    //       ),
    //     ],
    //   );
    // }

    // Column footer(String description, bool isLast) {
    //   return Column(
    //     children: <Widget>[
    //       Padding(
    //         padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
    //         child: Text(
    //           description,
    //           textAlign: TextAlign.center,
    //           style: TextStyle(color: AppColors.grey),
    //         ),
    //       ),
    //       SizedBox(
    //         height: 20.h,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: <Widget>[
    //           SizedBox(
    //             height: 50.h,
    //             width: 150.w,
    //             child: ElevatedButton(
    //               onPressed: () async {
    //                 await SecureStorage.readValue(
    //                         key: AppTextConstants.userType)
    //                     .then((String value) async {
    //                   if (value == 'traveller') {
    //                     await Navigator.of(context).pushNamed('/discovery');
    //                   } else {
    //                     await Navigator.of(context).pushNamed('/welcome');
    //                   }
    //                 });
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 shape: RoundedRectangleBorder(
    //                   side: BorderSide(
    //                     color: AppColors.silver,
    //                   ),
    //                   borderRadius: BorderRadius.circular(14.r),
    //                 ),
    //                 primary: Colors.white,
    //                 onPrimary: AppColors.primaryGreen,
    //               ),
    //               child: Text(
    //                 AppTextConstants.skip,
    //                 style: const TextStyle(
    //                     fontWeight: FontWeight.bold, fontSize: 16),
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 50.h,
    //             width: 150.w,
    //             child: ElevatedButton(
    //               onPressed: () async {
    //                 if (!isLast) {
    //                   setState(() {
    //                     activeIndex = activeIndex + 1;
    //                   });
    //                 } else {
    //                   await SecureStorage.readValue(
    //                           key: AppTextConstants.userType)
    //                       .then((String value) async {
    //                     if (value == 'traveller') {
    //                       await Navigator.of(context).pushNamed('/discovery');
    //                     } else {
    //                       await Navigator.of(context).pushNamed('/welcome');
    //                     }
    //                   });
    //                 }
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 shape: RoundedRectangleBorder(
    //                   side: BorderSide(
    //                     color: AppColors.silver,
    //                   ),
    //                   borderRadius: BorderRadius.circular(14.r),
    //                 ),
    //                 primary: AppColors.primaryGreen,
    //                 onPrimary: Colors.white, // <-- Splash color
    //               ),
    //               child: isLast
    //                   ? Text(AppTextConstants.done)
    //                   : Text(AppTextConstants.next),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   );
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          // padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
          padding: const EdgeInsets.all(8),

          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     if (screenArguments['user_type'] == 'traveller')
          //       if (activeIndex == 0)
          //         headerImage('Step 1/2', 'assets/images/userOnBoarding2.png')
          //       else
          //         activeIndex == 1
          //             ? headerImage(
          //                 'Step 2/2', 'assets/images/userOnBoarding3.png')
          //             : const SizedBox(),
          //     if (screenArguments['user_type'] == 'traveller')
          //       if (activeIndex == 0)
          //         footer(
          //           AppTextConstants.footerDescr2,
          //           false,
          //         )
          //       else
          //         activeIndex == 1
          //             ? footer(
          //                 AppTextConstants.footerDescr3,
          //                 true,
          //               )
          //             : const SizedBox(),
          //     if (screenArguments['user_type'] == 'guide')
          //       if (activeIndex == 0)
          //         headerImage('Step 1/2', 'assets/images/userOnBoarding1.png')
          //       else
          //         activeIndex == 1
          //             ? headerImage(
          //                 'Step 2/2', 'assets/images/userOnBoarding3.png')
          //             : const SizedBox(),
          //     if (screenArguments['user_type'] == 'guide')
          //       if (activeIndex == 0)
          //         footer(
          //           AppTextConstants.footerDescr1,
          //           false,
          //         )
          //       else
          //         activeIndex == 1
          //             ? footer(
          //                 AppTextConstants.footerDescr3,
          //                 true,
          //               )
          //             : const SizedBox(),
          //     DotsIndicator(
          //       dotsCount: 2,
          //       position: activeIndex,
          //       decorator: DotsDecorator(
          //         activeColor: Colors.black,
          //         activeSize: const Size(29, 7),
          //         activeShape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(5.r)),
          //       ),
          //     ),
          //   ],
          // ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            if (screenArguments['user_type'] == 'traveller')
              buildTraveller()
            else
              buildGuide(),
            SizedBox(
              height: 10.h,
            ),
            Row(
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
                    child: activeIndex == 1
                        ? Text(AppTextConstants.done)
                        : Text(AppTextConstants.next),
                  ),
                ),
              ],
            ),
          ]),
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
            Image.asset('assets/images/userOnBoarding1.png'),
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
            Image.asset('assets/images/userOnBoarding3.png'),
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
            Image.asset('assets/images/userOnBoarding2.png'),
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
            Image.asset('assets/images/userOnBoarding3.png'),
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
