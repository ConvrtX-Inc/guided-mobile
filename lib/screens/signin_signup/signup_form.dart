// ignore_for_file: file_names

import 'dart:convert';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/helpers/text_helper.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/utils/auth.utils.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/text_service.dart';
import 'package:intl/intl.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';

/// Sign up form screen
class SignupForm extends StatefulWidget {
  /// Constructor
  const SignupForm({required this.screenArguments, Key? key}) : super(key: key);

  final Map<String, dynamic> screenArguments;

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool ptosAgree = false;
  bool envAgree = false;
  bool buttonIsLoading = false;

  List<String> errorMessages = <String>[];
  TextServices textServices = TextServices();

  late final TextEditingController firstName = TextEditingController(
      text: widget.screenArguments['first_name'] ??
          widget.screenArguments['full_name']);
  late final TextEditingController lastName =
      TextEditingController(text: widget.screenArguments['last_name']);
  final TextEditingController birthday = TextEditingController();
  late final TextEditingController email =
      TextEditingController(text: widget.screenArguments['email']);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const BackButtonWidget(),
                  SizedBox(
                    height: 20.h,
                  ),
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
                    controller: firstName,
                    decoration: InputDecoration(
                      hintText: AppTextConstants.firstName,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: lastName,
                    decoration: InputDecoration(
                      hintText: AppTextConstants.lastName,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1800),
                          lastDate: DateTime.now());
                      if (pickedDate != null) {
                        final String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          birthday.text =
                              formattedDate; //set output date to TextField value.
                        });
                      }
                    },
                    controller: birthday,
                    decoration: InputDecoration(
                      hintText: AppTextConstants.birthday,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: email,
                    decoration: InputDecoration(
                      hintText: AppTextConstants.email,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (String item in errorMessages)
                        TextHelper.errorTextDisplay(item)
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: <Widget>[
                      Theme(
                        data: ThemeData(
                          primarySwatch: Colors.blue,
                          unselectedWidgetColor: AppColors.silver,
                        ),
                        child: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: AppColors.primaryGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            value: ptosAgree,
                            onChanged: (bool? value) => setState(() {
                              ptosAgree = value == true;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.grey,
                            ),
                            children: <InlineSpan>[
                              const TextSpan(
                                  text:
                                      "By selecting agree and continue below, I agree to Company\u0027s "),
                              TextSpan(
                                text: 'Privacy policy, Terms of service',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  color: AppColors.sushi,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: <Widget>[
                      Theme(
                        data: ThemeData(
                          primarySwatch: Colors.blue,
                          unselectedWidgetColor: AppColors.silver,
                        ),
                        child: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: AppColors.primaryGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            value: envAgree,
                            onChanged: (bool? value) => setState(() {
                              envAgree = value!;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Expanded(
                        child: Text.rich(TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                          children: <InlineSpan>[
                            const TextSpan(
                              text: 'Agree to environmental pledge ',
                            ),
                            TextSpan(
                              text:
                                  'with link in blue that directly connects to website.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                color: AppColors.sushi,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 60,
                    child: LoadingElevatedButton(
                      isLoading: buttonIsLoading,
                      onPressed: signupUser,
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
                        AppTextConstants.agreeContinue,
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
    );
  }

  /// Method for verifying Code
  Future<void> signupUser() async {
    if (!envAgree || !ptosAgree) {
      return;
    }

    setState(() {
      buttonIsLoading = false;
    });

    final Map<String, dynamic> data = widget.screenArguments;

    final Map<String, dynamic> details = <String, dynamic>{
      'email': data['email'],
      'password': data['password'],
      'full_name': firstName.text.isEmpty ? data['full_name'] : firstName.text,
      'first_name':
          firstName.text.isEmpty ? data['first_name'] : firstName.text,
      'last_name': lastName.text.isEmpty ? data['last_name'] : lastName.text,
      'birth_day': birthday.text.isEmpty ? data['birth_day'] : birthday.text,
      'user_type': data['user_type'],
      'is_traveller': data['is_traveller'],
      // 'user_type_id': isTraveller ? '1e16e10d-ec6f-4c32-b5eb-cdfcfe0563a5' : 'c40cca07-110c-473e-a0e7-6720fc3d42ff', /// Dev
      'user_type_id': data['user_type_id'],

      /// Staging
      'is_for_the_planet': true,
      'is_first_aid_trained': true,
      'is_guide': !(data['is_traveller'] as bool)
    };

    final APIStandardReturnFormat result =
        await APIServices().register(details);

    if (result.status == 'error') {
      final Map<String, dynamic> decoded = jsonDecode(result.errorResponse);
      decoded['errors'].forEach((String k, dynamic v) =>
          <dynamic>{errorMessages..add(textServices.filterErrorMessage(v))});
    } else {
      final Map<String, String> credentials = <String, String>{
        'email': data['email'],
        'password': data['password']
      };

      APIStandardReturnFormat response = await APIServices().login(credentials);

      if (response.status == 'error') {
        AdvanceSnackBar(
                message: ErrorMessageConstants.loginWrongEmailorPassword)
            .show(context);
        setState(() => buttonIsLoading = false);
      } else {
        setRoles(context, response);
      }
    }

    if (mounted) {
      setState(() => buttonIsLoading = false);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('ptosAgree', ptosAgree));
    properties.add(DiagnosticsProperty<bool>('envAgree', envAgree));
    // ignore: cascade_invocations
    properties.add(
        DiagnosticsProperty<TextEditingController>('firstName', firstName));
    // ignore: cascade_invocations
    properties
        .add(DiagnosticsProperty<TextEditingController>('lastName', lastName));
    // ignore: cascade_invocations
    properties
        .add(DiagnosticsProperty<TextEditingController>('birthday', birthday));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>('email', email));
  }
}
