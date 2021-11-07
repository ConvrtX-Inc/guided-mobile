// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:guided/signin_signup/userOnboardingScreen.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 90,
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserOnboardingScreen()),
                      );
                    },
                    child: Image.asset(
                      "assets/images/ImATourist.png",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserOnboardingScreen()),
                      );
                    },
                    child: Image.asset(
                      "assets/images/ImAGuideOutfitter.png",
                      width: 345,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              "assets/images/forThePlanet.png",
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
