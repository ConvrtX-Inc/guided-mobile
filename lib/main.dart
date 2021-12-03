import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/settings/profile_screen.dart';
import 'package:guided/signin_signup/login_screen.dart';
import 'package:guided/signin_signup/splashScreen.dart';
import 'package:guided/main_navigation/main_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Splash(),
          );
        } else {
          return MaterialApp(
            title: 'GuidED',
            theme: ThemeData(
              backgroundColor: HexColor("#E5E5E5"),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                ),
                bodyText2: TextStyle(
                  color: Colors.black,
                ),
              ).apply(
                  // fontFamily: 'Lora',
                  // bodyColor: Colors.white,
                  // displayColor: Colors.white,
                  ),
            ),
            debugShowCheckedModeBanner: false,
            home: const LoginScreen(),
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/images/splashImage.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 0));
  }
}
