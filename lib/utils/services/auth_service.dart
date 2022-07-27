import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/ui/dialogs.dart';

/// App Auth service
class AuthServices {


  ///Login with email and password
  Future<void> loginWithEmailAndPassword(
      dynamic credentials, BuildContext context) async {
    final APIStandardReturnFormat response =
    await APIServices().login(credentials);

    if (response.status == 'error') {
      AppDialogs().showError(
          context: context,
          message: ErrorMessageConstants.loginWrongEmailorPassword,
          title: 'Login Failed');
    } else {
      await setRoles(response, context);
    }
  }

  ///Login With Google
  Future<void> loginWithGoogle(String idToken, BuildContext context) async {
    final APIStandardReturnFormat response =
        await APIServices().loginGoogle(idToken);
    if (response.status == 'error') {
      AppDialogs().showError(
          context: context,
          message: 'An Error occurred',
          title: 'Login Failed');
    } else {
      await setRoles(response, context);
    }
  }


  ///Set User Roles Guide/Traveler
  Future<void> setRoles(
      APIStandardReturnFormat response, BuildContext context) async {
    final UserModel user =
        UserModel.fromJson(json.decode(response.successResponse));
    UserSingleton.instance.user = user;

    final String userType =
        await SecureStorage.readValue(key: AppTextConstants.userType);
    if (userType == 'traveller') {
      await saveTokenAndId(user.token!, user.user!.id!);
      await Navigator.of(context).pushNamedAndRemoveUntil(
          '/traveller_tab', (Route<dynamic> route) => false);
    } else {
      if (user.user!.isGuide!) {
        await saveTokenAndId(user.token!, user.user!.id!);
        await Navigator.of(context).pushNamedAndRemoveUntil(
            '/main_navigation', (Route<dynamic> route) => false);
      } else {
        AppDialogs().showError(
            context: context,
            title: 'Login Failed',
            message: "You don't have any Guide Access yet.");
      }
    }
  }

  /// Save token and User Id
  Future<void> saveTokenAndId(String token, String userId) async {
    await SecureStorage.saveValue(
        key: AppTextConstants.userToken, value: token);
    await SecureStorage.saveValue(key: AppTextConstants.userId, value: userId);
  }

  /// Logout and clear storage/current state
  Future<void> logout(BuildContext context) async {
    //Clear Secure storage
    await SecureStorage.clearAll();

    // clear get x controllers
    await Get.delete<UserProfileDetailsController>();
    await Get.delete<CardController>();
    await Get.delete<UserSubscriptionController>();

    // Navigate to Select user type Screen
    await Navigator.of(context)
        .pushNamedAndRemoveUntil('/user_type', (Route<dynamic> route) => false);
  }

}
