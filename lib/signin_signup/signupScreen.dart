// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/signin_signup/continue_with_phone.dart';
import 'package:guided/signin_signup/loginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      print("Login");
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: HexColor("#e6e6e6"),
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    leading: Image.asset(
                      "assets/images/facebook.png",
                      height: 30,
                    ),
                    title: const Text(
                      'Signup With Facebook',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () {
                      print("Login");
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: HexColor("#e6e6e6"),
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    leading: Image.asset(
                      "assets/images/google.png",
                      height: 30,
                    ),
                    title: const Text(
                      'Signup With Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  const Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  ConstantHelpers.spacing15,
                  TextField(
                    decoration: InputDecoration(
                      hintText: "John Smith",
                      hintStyle: TextStyle(
                        color: ConstantHelpers.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  ConstantHelpers.spacing15,
                  TextField(
                    decoration: InputDecoration(
                      hintText: "johnsmith@gmail.com",
                      hintStyle: TextStyle(
                        color: ConstantHelpers.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing15,
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  ConstantHelpers.spacing15,
                  TextField(
                    decoration: InputDecoration(
                      hintText: "*******",
                      hintStyle: TextStyle(
                        color: ConstantHelpers.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  SizedBox(
                    width: width,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContinueWithPhone()),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                  ConstantHelpers.spacing20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Gilroy",
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            color: ConstantHelpers.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
