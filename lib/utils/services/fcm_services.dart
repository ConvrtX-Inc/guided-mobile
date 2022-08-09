import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/models/user_model.dart';
import 'package:http/http.dart' as http;

/// Firebase Cloud Messaging Services
class FCMServices {
  /// Send Push Notification
  Future<void> sendNotification(
      String fcmToken, String title, String body, dynamic data) async {
    // final String url = AppAPIPath.fcmUrl;
    const String url = 'http://192.168.100.55:8000/api/v1/fcm/sendNotification';
    final String token = UserSingleton.instance.user.token!;

    /// API service for  update booking payment status

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      HttpHeaders.authorizationHeader:
          'Bearer $token',
    };
    final http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode({'title': title, 'body': body, 'data': data, 'registration_ids':[fcmToken]} ),
        headers: headers);

    debugPrint('Response: ${response.body}');
  }
}
