// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/signin_signup/login_screen.dart';

/// Sign up form screen
class SignupForm extends StatefulWidget {

  /// Constructor
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: Transform.scale(
                  scale: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: AppColors.harp,
                        borderRadius: BorderRadius.circular(10.r),
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
                      padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppTextConstants.signupForm,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: AppTextConstants.firstName,
                              hintStyle: TextStyle(
                                color: AppColors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.r),
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.2.w
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: AppTextConstants.lastName,
                              hintStyle: TextStyle(
                                color: AppColors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.r),
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.2.w
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: AppTextConstants.birthday,
                              hintStyle: TextStyle(
                                color: AppColors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.r),
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.2.w
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: AppTextConstants.email,
                              hintStyle: TextStyle(
                                color: AppColors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.r),
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.2.w
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            children: <Widget>[
                              Theme(
                                data: ThemeData(
                                  primarySwatch: Colors.blue,
                                  unselectedWidgetColor:
                                      AppColors.silver,
                                ),
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: AppColors.primaryGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    value: isAgree,
                                    onChanged: (bool? value) => setState(() {
                                      isAgree = value!;
                                    }),
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.grey,
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
                                          color: AppColors.sushi,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          SizedBox(
                            width: width,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/login');
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: AppColors.silver,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(18.r),
                                ),
                                primary: AppColors.primaryGreen,
                                onPrimary: Colors.white, // <-- Splash color
                              ),
                              child: Text(
                                AppTextConstants.agreeContinue,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isAgree', isAgree));
  }
}
