// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/signin_signup/login_screen.dart';
import 'package:guided/signin_signup/signupScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Welcome to GuidED",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  "assets/images/welcomeToGuidED.png",
                  height: 320,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur.",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: ConstantHelpers.grey),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: width / 1.2,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Already I have A Account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: HexColor("#C4C4C4"),
                        ),
                        borderRadius: BorderRadius.circular(18), // <-- Radius
                      ),
                      primary: ConstantHelpers.primaryGreen,
                      onPrimary: Colors.white, // <-- Splash color
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: width / 1.2,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()),
                      );
                    },
                    child: const Text(
                      'Create A New Account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: HexColor("#C4C4C4"),
                        ),
                        borderRadius: BorderRadius.circular(18), // <-- Radius
                      ),
                      primary: Colors.white,
                      onPrimary:
                          ConstantHelpers.primaryGreen, // <-- Splash color
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
