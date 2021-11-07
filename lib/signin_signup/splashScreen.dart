// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/signin_signup/userTypeScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(ConstantHelpers.logoSmall),
                ),
              ),
              Image.asset(
                "assets/images/splashImage.png",
                width: 300,
              ),
              Image.asset(
                "assets/images/forThePlanet.png",
                width: 80,
                height: 29,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Create Your Business\n As A Guide",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "The application will help you find tourists\n and build to your tourism business",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserTypeScreen()),
                  );
                },
                child:
                    const Icon(Icons.arrow_forward_sharp, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: ConstantHelpers.primaryGreen, // <-- Button color
                  onPrimary: Colors.green, // <-- Splash color
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
