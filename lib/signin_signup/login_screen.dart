import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/main_navigation/main_navigation.dart';
import 'package:guided/signin_signup/reset_password_screen.dart';
import 'package:guided/signin_signup/signupScreen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  ///Temporary commented out
  // void _ApiLogin(){
  //   ApiCalls.login(context, emailController.text, passwordController.text);
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                    'Login',
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
                      'Login With Facebook',
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
                      'Login With Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
                    controller: emailController,
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
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
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
                  ConstantHelpers.spacing15,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen()),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  SizedBox(
                    width: width,
                    height: 60,
                    child: ElevatedButton(
                      // onPressed: _ApiLogin,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainNavigationScreen(
                                    navIndex: 0,
                                    contentIndex: 0,
                                  )),
                        );
                      },
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
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  Row(
                    children: [
                      const Text(
                        "Don't have an account? ",
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
                                builder: (context) => const SignupScreen()),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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
