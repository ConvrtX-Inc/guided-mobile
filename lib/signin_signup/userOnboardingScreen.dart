// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/signin_signup/welcomeScreen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class UserOnboardingScreen extends StatefulWidget {
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
        height: 360,
      );
    }

    headerImage(String step, imageUrl) {
      return Column(
        children: [
          const Text(
            "User Onboarding",
            style: TextStyle(
                fontSize: 18,
                fontFamily: "GilroyBold",
                fontWeight: FontWeight.bold),
          ),
          Text(step),
          _buildImage(
            imageUrl,
          ),
        ],
      );
    }

    footer(String description, bool isLast) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(color: ConstantHelpers.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isLast) {
                      setState(() {
                        activeIndex = activeIndex + 1;
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                      );
                    }
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: HexColor("#C4C4C4"),
                      ),
                      borderRadius: BorderRadius.circular(14), // <-- Radius
                    ),
                    primary: Colors.white,
                    onPrimary: ConstantHelpers.primaryGreen, // <-- Splash color
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isLast) {
                      setState(() {
                        activeIndex = activeIndex + 1;
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                      );
                    }
                  },
                  child: isLast ? const Text('Done') : const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: HexColor("#C4C4C4"),
                      ),
                      borderRadius: BorderRadius.circular(14), // <-- Radius
                    ),
                    primary: ConstantHelpers.primaryGreen,
                    onPrimary: Colors.white, // <-- Splash color
                  ),
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
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              activeIndex == 0
                  ? headerImage('Step 1/3', 'assets/images/userOnBoarding1.png')
                  : activeIndex == 1
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
                  size: const Size.square(9.0),
                  activeSize: const Size(29, 7),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              activeIndex == 0
                  ? footer(
                      "Become and guide and list your outdoor adventure. How about, fishing, kayaking, wild life viewing, photography, hiking, birdwatching, foraging, biking, camping, boat tours, your unique property tour or wilderness retreats....... With GuidED the possibilities are endless and in your hands!",
                      false,
                    )
                  : activeIndex == 1
                      ? footer(
                          "Get the most out of your travel experience by finding local guided adventures wherever you are or wherever you plan to go. The information booth is fine, but the GuidED Mobile Adventure App is where you'll find the hidden gems. Don't travel with out it!",
                          false,
                        )
                      : activeIndex == 2
                          ? footer(
                              "We all love outdoor adventure, but remember, the outdoor spaces we all love and share must be conserved, managed and taken care of for future generations. GuidED is proud to be a 1% For the Planet company, and every time you make a booking, you too will give back to Mother Nature. Join GuidED and lets make a difference!",
                              true,
                            )
                          : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
