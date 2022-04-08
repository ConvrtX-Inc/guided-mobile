// ignore_for_file: file_names

import 'dart:convert';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/text_helper.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/text_service.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';

/// Sign up screen
class SignupScreen extends StatefulWidget {
  /// Constructor
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  bool buttonIsLoading = false;
  final FocusNode _name = FocusNode();
  final FocusNode _email = FocusNode();
  final FocusNode _password = FocusNode();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List<String> errorMessages = <String>[];
  TextServices textServices = TextServices();
  String _phonenumber = '';
  String country = '+63';
  String _countryCode = '';
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
              child: FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
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
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      AppTextConstants.signup,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // ListTile(
                    //   onTap: () {
                    //     // Insert here the Sign up to Facebook API
                    //   },
                    //   shape: RoundedRectangleBorder(
                    //     side: BorderSide(
                    //       color: AppColors.mercury,
                    //     ),
                    //     borderRadius: BorderRadius.circular(14.r),
                    //   ),
                    //   leading: Image.asset(
                    //     AssetsPath.facebook,
                    //     height: 30.h,
                    //   ),
                    //   title: Text(
                    //     AppTextConstants.signupWithFacebook,
                    //     style: const TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 15.h,
                    // ),
                    // ListTile(
                    //   onTap: () {
                    //     // Insert here the Sign up to Google API
                    //   },
                    //   shape: RoundedRectangleBorder(
                    //     side: BorderSide(
                    //       color: AppColors.mercury,
                    //     ),
                    //     borderRadius: BorderRadius.circular(14),
                    //   ),
                    //   leading: Image.asset(
                    //     AssetsPath.google,
                    //     height: 30,
                    //   ),
                    //   title: Text(
                    //     AppTextConstants.signupWithGoogle,
                    //     style: const TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20.h),
                    Text(
                      AppTextConstants.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    FormBuilderTextField(
                      controller: name,
                      focusNode: _name,
                      decoration: InputDecoration(
                        hintText: AppTextConstants.name,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      name: 'first_name',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      AppTextConstants.email,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(height: 15.h),
                    FormBuilderTextField(
                      controller: email,
                      focusNode: _email,
                      decoration: InputDecoration(
                        hintText: AppTextConstants.emailHint,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      name: 'email',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.email(context),
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      AppTextConstants.password,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(height: 15.h),
                    FormBuilderTextField(
                      controller: password,
                      obscureText: true,
                      focusNode: _password,
                      decoration: InputDecoration(
                        hintText: AppTextConstants.passwordHint,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      name: 'password',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(context, 6),
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(height: 20.h),
                    IntlPhoneField(
                      controller: _phoneTextController,
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      countries: const <String>['CA'],
                      initialCountryCode: 'CA',
                      onChanged: (PhoneNumber phone) {
                        setState(() {
                          _phonenumber = phone.number;
                          _countryCode = phone.countryCode;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: width,
                      height: 60.h,
                      child: LoadingElevatedButton(
                        isLoading: buttonIsLoading,
                        onPressed: () async {
                          bool isTraveller = false;
                          await SecureStorage.readValue(
                                  key: AppTextConstants.userType)
                              .then((String value) async {
                            if (value == 'traveller') {
                              isTraveller = true;
                            } else {
                              isTraveller = false;
                            }
                          });
                          _formKey.currentState?.save();
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              buttonIsLoading = true;
                            });
                            // print(_formKey.currentState?.value['email']);
                            List<String> name = _formKey
                                .currentState?.value['first_name']
                                .split(' ');
                            final Map<String, dynamic> details = {
                              'email': _formKey.currentState?.value['email'],
                              'password':
                                  _formKey.currentState?.value['password'],
                              'full_name': name,
                              'user_type': isTraveller ? 'Traveller' : 'Guide',
                              'phone_no': _phonenumber,
                              'country_code': _countryCode,
                              'is_traveller': isTraveller
                            };
                            print(details);
                            // final dynamic response = await APIServices()
                            //     .request(AppAPIPath.signupUrl, RequestType.POST,
                            //         data: details);
                            final APIStandardReturnFormat result =
                                await APIServices().register(details);
                            if (result.status == 'error') {
                              setState(() {
                                buttonIsLoading = false;
                              });
                              final Map<String, dynamic> decoded =
                                  jsonDecode(result.errorResponse);
                              decoded['errors'].forEach((String k, dynamic v) =>
                                  <dynamic>{
                                    errorMessages
                                      ..add(textServices.filterErrorMessage(v))
                                  });
                            } else {
                              setState(() {
                                buttonIsLoading = false;
                              });
                              await Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            }
                            // if (response is Map) {
                            //   if (response.containsKey('status')) {
                            //     if (response['status'] == 422) {
                            //       AdvanceSnackBar(
                            //               message: ErrorMessageConstants
                            //                   .loginWrongEmailorPassword)
                            //           .show(context);
                            //     }
                            //   } else {
                            //     await Navigator.of(context).pushNamed('/login');
                            //   }
                            // } else {
                            //   await Navigator.of(context).pushNamed('/login');
                            // }
                          } else {
                            print("validation failed");
                          }
                          // Navigator.pushNamed(context, '/continue_with_phone',
                          //     arguments: {
                          //       'name': name.text,
                          //       'email': email.text,
                          //       'password': password.text
                          //     });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColors.silver,
                            ),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          primary: AppColors.primaryGreen,
                          onPrimary: Colors.white, // <-- Splash color
                        ),
                        loadingChild: const Text(
                          'Loading',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        child: Text(
                          AppTextConstants.signup,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppTextConstants.alreadyHaveAnAccount,
                          style: const TextStyle(
                            fontSize: 17,
                            fontFamily: 'Gilroy',
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Text(
                            AppTextConstants.login,
                            style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (String item in errorMessages)
                          TextHelper.errorTextDisplay(item)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // /// Method for verifying Code
  // Future<void> signupUser(Map<String, dynamic> data) async {
  //   final Map<String, dynamic> details = {
  //     'email': data['email'],
  //     'password': data['password'],
  //     'first_name': firstName.text,
  //     'last_name': lastName.text,
  //     'phone_no': data['phone_number'],
  //     'country_code': data['country_code'],
  //     'user_type_id': '',
  //     'is_for_the_planet': true,
  //     'is_first_aid_trained': true,
  //     'user_type': 'Guide'
  //   };
  //   await APIServices()
  //       .request(AppAPIPath.signupUrl, RequestType.POST, data: details);
  //   await Navigator.pushNamed(context, '/login');
  // }
}
