// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/signin_signup/continue_with_phone.dart';
import 'package:guided/signin_signup/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
        builder: () => Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: Transform.scale(
                  scale: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: ConstantHelpers.backarrowgrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
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
                          Text(
                            ConstantHelpers.signupForm,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ConstantHelpers.spacing15,
                          TextField(
                            decoration: InputDecoration(
                              hintText: ConstantHelpers.firstName,
                              hintStyle: TextStyle(
                                color: ConstantHelpers.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.2),
                              ),
                            ),
                          ),
                          ConstantHelpers.spacing20,
                          TextField(
                            decoration: InputDecoration(
                              hintText: ConstantHelpers.lastName,
                              hintStyle: TextStyle(
                                color: ConstantHelpers.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.2),
                              ),
                            ),
                          ),
                          ConstantHelpers.spacing20,
                          TextField(
                            decoration: InputDecoration(
                              hintText: ConstantHelpers.birthday,
                              hintStyle: TextStyle(
                                color: ConstantHelpers.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.2),
                              ),
                            ),
                          ),
                          ConstantHelpers.spacing20,
                          TextField(
                            decoration: InputDecoration(
                              hintText: ConstantHelpers.email,
                              hintStyle: TextStyle(
                                color: ConstantHelpers.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.2),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Theme(
                                data: ThemeData(
                                  primarySwatch: Colors.blue,
                                  unselectedWidgetColor:
                                      ConstantHelpers.buttonNext,
                                ),
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: ConstantHelpers.primaryGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    value: isAgree,
                                    onChanged: (value) => setState(() {
                                      isAgree = value!;
                                    }),
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ConstantHelpers.grey,
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text:
                                            "By selecting agree and continue below, I\nagree to Company\u0027s"),
                                    TextSpan(
                                        text:
                                            ' Privacy policy, Terms of\nservice',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          decoration: TextDecoration.underline,
                                          color: ConstantHelpers.limeGreen,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: width,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: ConstantHelpers.buttonNext,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(18), // <-- Radius
                                ),
                                primary: ConstantHelpers.primaryGreen,
                                onPrimary: Colors.white, // <-- Splash color
                              ),
                              child: Text(
                                ConstantHelpers.agreeContinue,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        designSize: const Size(375, 812));
  }
}
