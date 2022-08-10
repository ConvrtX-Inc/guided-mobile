import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

/// Firebase Cloud Messaging Services
class FCMServices {
  final String apiUrl = '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}';

  /// Send Push Notification
  Future<void> sendNotification(
      String fcmToken, String title, String body, dynamic data) async {
    final String url = '$apiUrl/${AppAPIPath.fcmUrl}';
    // const String url = 'http://192.168.100.55:8000/api/v1/fcm/sendNotification';
    final String token = UserSingleton.instance.user.token!;

    List<String> fcmTokens = await getFCMTokens(fcmToken);

    debugPrint('FCM TOKENS : ${fcmTokens.length}');

    /// API service for  update booking payment status

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    final http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'title': title,
          'body': body,
          'data': data,
          'registration_ids': fcmTokens
        }),
        headers: headers);

    debugPrint('Response: ${response.body}');
  }

  /// Add Firebase Device Token
  Future<void> addFCMToken(String deviceToken) async {
    final String url = '$apiUrl/${AppAPIPath.fcmTokenUrl}';

    final String token = UserSingleton.instance.user.token!;
    final String userId =
        await SecureStorage.readValue(key: AppTextConstants.userId);

    final List<String> myFcmTokens = await getFCMTokens(userId);

    String existingToken = '';

    if (myFcmTokens.isNotEmpty) {
      existingToken =
          myFcmTokens.firstWhere((String _token) => deviceToken == _token ,orElse: () => '');
    }

    debugPrint('Existing token $existingToken');

    if (existingToken.isEmpty) {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
      final http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode({'user_id': userId, 'device_token': deviceToken}),
          headers: headers);

      debugPrint('Response fcm token: ${response.body}');
    }
  }

  Future<List<String>> getFCMTokens(String userId) async {
    String token = UserSingleton.instance.user.token!;

    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint(
        'URLL :${Uri.http(AppAPIPath.apiBaseUrl, '/${AppAPIPath.fcmTokenUrl}', queryParameters)}');

    final http.Response response = await http.get(
        Uri.http(AppAPIPath.apiBaseUrl, '/${AppAPIPath.fcmTokenUrl}',
            queryParameters),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    List<String> deviceTokens = [];
    final dynamic jsonData = jsonDecode(response.body);

    for (final dynamic data in jsonData) {
      deviceTokens.add(data['device_token'].toString());
    }

    return deviceTokens;
  }
}
