// ignore_for_file: unawaited_futures

import 'dart:convert';
import 'dart:io';

import 'package:advance_notification/advance_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guided/common/widgets/t-a-c.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/error_dialog.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Login Screen
class LoginScreen extends StatefulWidget {
  /// Constructor
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool hidePassword = true;
  bool buttonIsLoading = false;
  bool facebookLoading = false;
  bool googleLoading = false;
  bool appleLoading = false;
  GoogleSignInAuthentication? _signInAuthentication;

  @override
  void initState() {
    _googleSignIn.signOut();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
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

  ///Login via api
  Future<void> login() async {
    final Map<String, String> credentials = <String, String>{
      'email': _emailController.text,
      'password': _passwordController.text
    };

    final String userType =
        await SecureStorage.readValue(key: AppTextConstants.userType);

    // debugPrint('User Type ${userType}');
    if (!EmailValidator.validate(_emailController.text)) {
      _emailFocus.requestFocus();
      AdvanceSnackBar(message: ErrorMessageConstants.emailInvalidorEmpty)
          .show(context);
      setState(() => buttonIsLoading = false);
      return;
    }

    if (_passwordController.text.isEmpty) {
      _passwordFocus.requestFocus();
      AdvanceSnackBar(message: ErrorMessageConstants.emptyPassword)
          .show(context);
      setState(() => buttonIsLoading = false);
      return;
    }
    setState(() => buttonIsLoading = true);
    // final dynamic response = await APIServices()
    //     .request(AppAPIPath.loginUrl, RequestType.POST, data: credentials);

    // if (response is Map) {
    //   if (response.containsKey('status')) {
    //     if (response['status'] == 422) {
    //       AdvanceSnackBar(
    //               message: ErrorMessageConstants.loginWrongEmailorPassword)
    //           .show(context);
    //     }
    //   } else {
    //     final UserModel user =
    //         UserModel.fromJson(json.decode(response.toString()));
    //     UserSingleton.instance.user = user;
    //     print(user.user?.isTraveller);
    //     await SecureStorage.saveValue(
    //         key: AppTextConstants.userToken, value: response['token']);
    //     // ignore: avoid_dynamic_calls
    //     await SecureStorage.saveValue(
    //         // ignore: avoid_dynamic_calls
    //         key: SecureStorage.userIdKey,
    //         value: response['user']['id']);
    //     await Navigator.of(context).pushNamed('/main_navigation');
    //   }
    // }

    await APIServices()
        .login(credentials)
        .then((APIStandardReturnFormat response) async {
      setState(() => buttonIsLoading = false);
      if (response.status == 'error') {
        AdvanceSnackBar(
                message: ErrorMessageConstants.loginWrongEmailorPassword)
            .show(context);
        setState(() => buttonIsLoading = false);
      } else {
        setRoles(response);
      }
    });
  }

  Future<void> setRoles(APIStandardReturnFormat response) async {
    final UserModel user =
        UserModel.fromJson(json.decode(response.successResponse));
    UserSingleton.instance.user = user;

    final String userType =
        await SecureStorage.readValue(key: AppTextConstants.userType);
    if (userType == 'traveller') {
      await saveTokenAndId(user.token!, user.user!.id!);
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/traveller_tab', (Route<dynamic> route) => false);
    } else {
      if (user.user!.isGuide!) {
        await saveTokenAndId(user.token!, user.user!.id!);
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/main_navigation', (Route<dynamic> route) => false);
      } else {
        ErrorDialog().showErrorDialog(
            context: context,
            title: 'Login Failed',
            message: "You don't have any Guide Access");
      }
    }
  }

  Future<void> saveTokenAndId(String token, String userId) async {
    debugPrint('Token $token , User id $userId');
    await SecureStorage.saveValue(
        key: AppTextConstants.userToken, value: token);
    await SecureStorage.saveValue(key: AppTextConstants.userId, value: userId);
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
                    AppTextConstants.login,
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
                          APIServices()
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
                    height: 15.h,
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
                  Text(
                    AppTextConstants.email,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(height: 15.h),
                  TextField(
                    controller: _emailController,
                    focusNode: _emailFocus,
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
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    AppTextConstants.password,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
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
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/reset_password');
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 60.h,
                    child: LoadingElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.silver,
                          ),
                          borderRadius:
                              BorderRadius.circular(18.r), // <-- Radius
                        ),
                        primary: AppColors.primaryGreen,
                        onPrimary: Colors.white, // <-- Splash color
                      ),
                      isLoading: buttonIsLoading,
                      onPressed: () async => login(),
                      loadingChild: const Text(
                        'Loading',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      child: Text(
                        AppTextConstants.login,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: <Widget>[
                      Text(
                        AppTextConstants.dontHaveAccount,
                        style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'Gilroy',
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/sign_up');
                        },
                        child: Text(
                          AppTextConstants.signup,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const TacWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void googleSignOut() {
    _googleSignIn.disconnect();
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
      APIServices()
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

  Future<void> googleSignIn() async {
    setState(() {
      googleLoading = true;
    });
    try {
      await _googleSignIn.signIn();
    } catch (e, s) {
      print('--> E2 $e');
      print('--> $s');
      setState(() {
        googleLoading = false;
      });
    }
  }

  // Future<void> _checkIfIsLogged() async {
  //   final accessToken = await FacebookAuth.instance.accessToken;
  //   setState(() {
  //     _checking = false;
  //   });
  //   if (accessToken != null) {
  //     print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
  //     // now you can call to  FacebookAuth.instance.getUserData();
  //     final userData = await FacebookAuth.instance.getUserData();
  //     // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //     _accessToken = accessToken;
  //     setState(() {
  //       _userData = userData;
  //     });
  //   }
  // }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'emailController', _emailController));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>(
        'passwordController', _passwordController));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<bool>('hidePassword', hidePassword));
    // ignore: cascade_invocations
    properties
        .add(DiagnosticsProperty<bool>('buttonIsLoading', buttonIsLoading));
  }
}
