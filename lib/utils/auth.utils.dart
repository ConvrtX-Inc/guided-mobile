import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/error_dialog.dart';
import 'package:guided/utils/secure_storage.dart';

/// To Set the user with roles
Future<void> setRoles(BuildContext context, APIStandardReturnFormat response) async {
  final UserModel user =
  UserModel.fromJson(jsonDecode(response.successResponse));
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

/// To save the Token AND the ID
Future<void> saveTokenAndId(String token, String userId) async {
  debugPrint('Token $token , User id $userId');
  await SecureStorage.saveValue(
      key: AppTextConstants.userToken, value: token);
  await SecureStorage.saveValue(key: AppTextConstants.userId, value: userId);
}