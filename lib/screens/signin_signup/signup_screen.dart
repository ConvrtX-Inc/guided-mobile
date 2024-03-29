// ignore_for_file: file_names, diagnostic_describe_all_properties, prefer_final_locals

import 'dart:convert';
import 'dart:io';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/text_helper.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/models/preset_form_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/text_service.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Sign up screen
class SignupScreen extends StatefulWidget {
  /// Constructor
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _phoneTextController = TextEditingController();
  bool buttonIsLoading = false;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List<String> errorMessages = <String>[];
  TextServices textServices = TextServices();
  String _phonenumber = '';
  String country = '+63';
  String _countryCode = '';
  String termsAndCondition = '';
  String travelerWaiverForm = '';
  String cancellationPolicy = '';
  String guidedPaymentPayout = '';
  String localLaws = '';
  bool appleLoading = false;
  bool googleLoading = false;
  bool facebookLoading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAuthentication? _signInAuthentication;

  ///Text Editing Controllers
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  String _password = '';
  String _confirmPassword = '';

  @override
  void initState() {
    _googleSignIn.signOut();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      account?.authentication.then((GoogleSignInAuthentication googleKey) {
        print(googleKey.accessToken);
        APIServices()
            .loginFacebook(googleKey.accessToken!)
            .then((APIStandardReturnFormat response) async {
          if (response.status == 'error') {
            AdvanceSnackBar(
                    message: ErrorMessageConstants.loginWrongEmailorPassword)
                .show(context);
            setState(() => buttonIsLoading = false);
          } else {
            final UserModel user =
                UserModel.fromJson(json.decode(response.successResponse));
            UserSingleton.instance.user = user;
            if (user.user?.isTraveller != true) {
              await SecureStorage.saveValue(
                  key: AppTextConstants.userType, value: 'guide');
              await Navigator.pushReplacementNamed(context, '/main_navigation');
            } else {
              await Navigator.pushReplacementNamed(context, '/traveller_tab');
              await SecureStorage.saveValue(
                  key: AppTextConstants.userType, value: 'traveller');
            }
          }
        });
        setState(() {
          _signInAuthentication = googleKey;
          googleLoading = false;
        });
      }).catchError((err) {
        print('inner error');
      });
    });
    // _googleSignIn.signInSilently();
    super.initState();
  }

  Future<void> googleSignIn() async {
    setState(() {
      googleLoading = true;
    });
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print('Error signing in $e');
      setState(() {
        googleLoading = false;
      });
    }
  }

  Future<void> appleLogin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print(credential.email);
    print(credential.authorizationCode);
    print(credential.givenName);
    print(credential.familyName);
    print(credential.identityToken);
    print(credential.userIdentifier);

    if (credential.identityToken != null) {
      setState(() {
        appleLoading = true;
      });
      await APIServices()
          .loginFacebook(credential.identityToken!)
          .then((APIStandardReturnFormat response) async {
        if (response.status == 'error') {
          AdvanceSnackBar(
                  message: ErrorMessageConstants.loginWrongEmailorPassword)
              .show(context);
          setState(() => appleLoading = false);
        } else {
          final UserModel user =
              UserModel.fromJson(json.decode(response.successResponse));
          UserSingleton.instance.user = user;
          if (user.user?.isTraveller != true) {
            await SecureStorage.saveValue(
                key: AppTextConstants.userType, value: 'guide');
            await Navigator.pushReplacementNamed(context, '/main_navigation');
          } else {
            await SecureStorage.saveValue(
                key: AppTextConstants.userType, value: 'traveller');
            await Navigator.pushReplacementNamed(context, '/traveller_tab');
          }
        }
      });
    }
  }

  Future<void> getTermsAndCondition() async {
    final List<PresetFormModel> resForm =
        await APIServices().getPresetTermsAndCondition('terms_and_condition');
    termsAndCondition = resForm[0].description;
  }

  Future<void> getTravelerReleaseForm() async {
    final List<PresetFormModel> resForm =
        await APIServices().getPresetTermsAndCondition('traveler_waiver_form');
    travelerWaiverForm = resForm[0].description;
  }

  Future<void> getCancellationPolicy() async {
    final List<PresetFormModel> resForm =
        await APIServices().getPresetTermsAndCondition('cancellation_policy');
    cancellationPolicy = resForm[0].description;
  }

  Future<void> getGuidEDPaymentPayout() async {
    final List<PresetFormModel> resForm =
        await APIServices().getPresetTermsAndCondition('guided_payment_payout');
    guidedPaymentPayout = resForm[0].description;
  }

  Future<void> getLocalLaws() async {
    final List<PresetFormModel> resForm =
        await APIServices().getPresetTermsAndCondition('local_laws');
    localLaws = resForm[0].description;
  }

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
                    LoadingElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      disabledWhileLoading: false,
                      isLoading: facebookLoading,
                      onPressed: () async {
                        setState(() {
                          facebookLoading = true;
                        });
                        final fb = FacebookLogin();
                        final res =
                            await fb.logIn(permissions: <FacebookPermission>[
                          FacebookPermission.publicProfile,
                          FacebookPermission.email,
                        ]);

                        switch (res.status) {
                          case FacebookLoginStatus.success:
                            setState(() {
                              facebookLoading = false;
                            });

                            // Send access token to server for validation and auth
                            final FacebookAccessToken? accessToken =
                                res.accessToken;
                            await APIServices()
                                .loginFacebook(accessToken!.token)
                                .then((APIStandardReturnFormat response) async {
                              if (response.status == 'error') {
                                AdvanceSnackBar(
                                        message: ErrorMessageConstants
                                            .loginWrongEmailorPassword)
                                    .show(context);
                                setState(() => buttonIsLoading = false);
                              } else {
                                final UserModel user = UserModel.fromJson(
                                    json.decode(response.successResponse));
                                UserSingleton.instance.user = user;
                                if (user.user?.isTraveller != true) {
                                  await SecureStorage.saveValue(
                                      key: AppTextConstants.userType,
                                      value: 'guide');
                                  await Navigator.pushReplacementNamed(
                                      context, '/main_navigation');
                                } else {
                                  await SecureStorage.saveValue(
                                      key: AppTextConstants.userType,
                                      value: 'traveller');
                                  await Navigator.pushReplacementNamed(
                                      context, '/traveller_tab');
                                }
                              }
                            });
                            // print('Access token: ${accessToken?.token}');

                            // // Get profile data
                            // final profile = await fb.getUserProfile();
                            // print(
                            //     'Hello, ${profile?.name}! You ID: ${profile?.userId}');

                            // // Get user profile image url
                            // final imageUrl =
                            //     await fb.getProfileImageUrl(width: 100);
                            // print('Your profile image: $imageUrl');

                            // // Get email (since we request email permission)
                            // final email = await fb.getUserEmail();
                            // // But user can decline permission
                            // if (email != null) print('And your email is $email');

                            break;
                          case FacebookLoginStatus.cancel:
                            setState(() {
                              facebookLoading = false;
                            });
                            break;
                          case FacebookLoginStatus.error:
                            setState(() {
                              facebookLoading = false;
                            });
                            print('Error while log in: ${res.error}');
                            break;
                        }
                        // await Future.delayed(
                        //   const Duration(seconds: 3),
                        //   () {
                        //     setState(() {
                        //       facebookLoading = false;
                        //     });
                        //   },
                        // );
                      },
                      loadingChild: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.mercury,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        leading: Image.asset(
                          AssetsPath.facebook,
                          height: 30.h,
                        ),
                        title: const Text(
                          'Loading',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.mercury,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        leading: Image.asset(
                          AssetsPath.facebook,
                          height: 30.h,
                        ),
                        title: Text(
                          AppTextConstants.loginWithFacebook,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    LoadingElevatedButton(
                      isLoading: googleLoading,
                      onPressed: googleSignIn,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      loadingChild: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.mercury,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        leading: Image.asset(
                          'assets/images/google.png',
                          height: 30.h,
                        ),
                        title: const Text(
                          'Loading',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.mercury,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        leading: Image.asset(
                          'assets/images/google.png',
                          height: 30.h,
                        ),
                        title: Text(
                          AppTextConstants.loginWithGoogle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    if (Platform.isIOS)
                      LoadingElevatedButton(
                        isLoading: appleLoading,
                        onPressed: appleLogin,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.transparent,
                          padding: EdgeInsets.zero,
                        ),
                        loadingChild: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColors.mercury,
                            ),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          leading: Icon(
                            Icons.apple,
                            size: 30.h,
                          ),
                          title: const Text(
                            'Loading',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColors.mercury,
                            ),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          leading: Icon(
                            Icons.apple,
                            size: 30.h,
                          ),
                          title: Text(
                            'Login with Apple',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
                      AppTextConstants.firstName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    FormBuilderTextField(
                      controller: _firstNameController,
                      focusNode: _nameFocusNode,
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
                      name: 'first_name',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      AppTextConstants.lastName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    FormBuilderTextField(
                      controller: _lastNameController,
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
                      name: 'last_name',
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
                      focusNode: _emailFocusNode,
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
                      obscureText: hidePassword,
                      focusNode: _passwordFocusNode,
                      onChanged: (String? val) {
                        setState(() {
                          _password = val!.trim();
                        });
                      },
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
                          suffixIcon: _password.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon: Icon(
                                      hidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey))
                              : null),
                      name: 'password',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(context, 6),
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      AppTextConstants.confirmPassword,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(height: 15.h),
                    FormBuilderTextField(
                      controller: _confirmPasswordController,
                      obscureText: hideConfirmPassword,
                      onChanged: (String? val) {
                        setState(() {
                          _confirmPassword = val!.trim();
                        });
                      },
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
                          suffixIcon: _confirmPassword.trim().isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hideConfirmPassword =
                                          !hideConfirmPassword;
                                    });
                                  },
                                  icon: Icon(
                                    hideConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ))
                              : null),
                      name: 'password',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(context, 6),
                        FormBuilderValidators.required(context),
                        // FormBuilderValidators.match(context, password.text,
                        //     errorText:
                        //         ErrorMessageConstants.passwordDoesNotMatch)
                        FormBuilderValidators.equal(context, password.text,
                            errorText:
                                ErrorMessageConstants.passwordDoesNotMatch)
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
                        onPressed: register,
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
                    SizedBox(height: 20.h),
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

  Future<void> saveTermsAndCondition(String? userId, String description) async {
    Map<String, dynamic> termsDetails = {
      'tour_guide_id': userId,
      'type': 'terms_and_condition_$userId',
      'description': description
    };

    /// Terms and Condition Details API
    final dynamic response = await APIServices().request(
        AppAPIPath.termsAndCondition, RequestType.POST,
        needAccessToken: true, data: termsDetails);
  }

  Future<void> saveTravelerForm(String? userId, String description) async {
    Map<String, dynamic> travelerWaiverFormDetails = {
      'tour_guide_id': userId,
      'type': 'traveler_waiver_form_$userId',
      'description': description
    };

    /// Traveler Waiver Form Details API
    final dynamic response = await APIServices().request(
        AppAPIPath.termsAndCondition, RequestType.POST,
        needAccessToken: true, data: travelerWaiverFormDetails);
  }

  Future<void> saveCancellationPolicy(
      String? userId, String description) async {
    Map<String, dynamic> cancellationPolicyDetails = {
      'tour_guide_id': userId,
      'type': 'cancellation_policy_$userId',
      'description': description
    };

    /// Traveler Waiver Form Details API
    final dynamic response = await APIServices().request(
        AppAPIPath.termsAndCondition, RequestType.POST,
        needAccessToken: true, data: cancellationPolicyDetails);
  }

  Future<void> saveGuidedPaymentPayout(
      String? userId, String description) async {
    Map<String, dynamic> guidedPaymentPayoutDetails = {
      'tour_guide_id': userId,
      'type': 'guided_payment_payout_$userId',
      'description': description
    };

    /// Traveler Waiver Form Details API
    final dynamic response = await APIServices().request(
        AppAPIPath.termsAndCondition, RequestType.POST,
        needAccessToken: true, data: guidedPaymentPayoutDetails);
  }

  Future<void> saveLocalLaws(String? userId, String description) async {
    Map<String, dynamic> localLawsDetails = {
      'tour_guide_id': userId,
      'type': 'local_laws_$userId',
      'description': description
    };

    /// Traveler Waiver Form Details API
    final dynamic response = await APIServices().request(
        AppAPIPath.termsAndCondition, RequestType.POST,
        needAccessToken: true, data: localLawsDetails);
  }

  Future<void> saveUserTermsAndCondition(String? userId) async {
    final Map<String, dynamic> userTermsDetails = {
      'user_id': userId,
      'is_terms_and_conditions': false,
      'is_traveler_release_and_waiver_form': false,
      'is_cancellation_policy': false,
      'is_payment_and_payout_terms': false,
      'is_local_laws_and_taxes': false
    };

    final dynamic response = await APIServices().request(
        AppAPIPath.usersTermsAndCondition, RequestType.POST,
        needAccessToken: true, data: userTermsDetails);
  }

  Future<void> register() async {
    bool isTraveller = false;
    await SecureStorage.readValue(key: AppTextConstants.userType)
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

      final Map<String, dynamic> details = {
        'email': _formKey.currentState?.value['email'],
        'password': _formKey.currentState?.value['password'],
        'full_name':
            '${_formKey.currentState?.value['first_name']} ${_formKey.currentState?.value['last_name']}',
        'first_name': _formKey.currentState?.value['first_name'],
        'last_name': _formKey.currentState?.value['last_name'],
        'user_type': isTraveller ? 'Traveller' : 'Guide',
        'phone_no': _phonenumber,
        'country_code': _countryCode,
        'is_traveller': isTraveller,
        // 'user_type_id': isTraveller ? '1e16e10d-ec6f-4c32-b5eb-cdfcfe0563a5' : 'c40cca07-110c-473e-a0e7-6720fc3d42ff', /// Dev
        'user_type_id': isTraveller
            ? 'fb536b69-3e54-415a-aaf0-1db1ab017bb3'
            : '3e3528ef-2387-4480-878e-685d44c6c2ee',

        /// Staging
        'is_for_the_planet': true,
        'is_first_aid_trained': true,
        'is_guide': !isTraveller
      };
      print(details);

      ///Register api
      final APIStandardReturnFormat result =
          await APIServices().register(details);

      if (result.status == 'error') {
        setState(() {
          buttonIsLoading = false;
        });
        final Map<String, dynamic> decoded = jsonDecode(result.errorResponse);
        decoded['errors'].forEach((String k, dynamic v) =>
            <dynamic>{errorMessages..add(textServices.filterErrorMessage(v))});
      } else {
        final Map<String, String> credentials = <String, String>{
          'email': _formKey.currentState?.value['email'],
          'password': _formKey.currentState?.value['password']
        };

        await APIServices()
            .login(credentials)
            .then((APIStandardReturnFormat response) async {
          final UserModel user =
              UserModel.fromJson(json.decode(response.successResponse));
          UserSingleton.instance.user.token = user.token;
        });

        setState(() {
          buttonIsLoading = false;
        });
        await Navigator.of(context).pushReplacementNamed('/login');
      }

    } else {
      print("validation failed");
    }
  }


}
