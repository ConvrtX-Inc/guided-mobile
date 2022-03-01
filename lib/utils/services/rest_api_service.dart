import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/global_api_service.dart';
import 'package:http/http.dart' as http;

enum RequestType { GET, POST }

/// Service for API Calls
class APIServices {
  /// API base mode
  final String apiBaseMode = AppAPIPath.apiBaseMode;

  /// API base url
  final String apiBaseUrl = AppAPIPath.apiBaseUrl;

  /// token
  final String staticToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI0NGVkMjY1LWNkY2MtNDg5ZS05MzZjLTU2ZDk1ZGRmYWQyZiIsImlhdCI6MTY0NTA3NTk1NSwiZXhwIjoxNjQ2MzcxOTU1fQ.fGwU-Qu6V_vKZbB1VFx15oSBeoq80fIIxNBRKGBDenU';

  /// This this Global function for creating api request
  Future<dynamic> request(String url, RequestType type,
      {bool needAccessToken = false, Map<String, dynamic>? data}) async {
    final Uri completeUri = Uri.parse('$apiBaseMode$apiBaseUrl/$url');
    String? token;
    dynamic body;
    String? requestType;
    switch (type) {
      case RequestType.POST:
        requestType = 'POST';
        break;
      case RequestType.GET:
        requestType = 'GET';
        break;
    }
    final http.Request request = http.Request(requestType, completeUri);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };

    if (needAccessToken) {
      token =
          staticToken; //await SecureStorage.readValue(key: SecureStorage.userTokenKey);
      headers['Authorization'] = 'Bearer $token';
    }
    request.headers.addAll(headers);
    request.body = jsonEncode(data);

    final http.StreamedResponse streamedResponse = await request.send();
    final http.Response response =
        await http.Response.fromStream(streamedResponse);

    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }
    debugPrint(response.statusCode.toString());
    debugPrint(body.toString());
    if (response.statusCode != 200 && response.statusCode != 201) {
      // ignore: avoid_dynamic_calls
      if (body.containsKey('errors')) {}
    }

    if (type == RequestType.GET) {
      //Do if request type is GET
    }

    return body;
  }

  /// API service for register
  Future<APIStandardReturnFormat> register(Map<String, dynamic> data) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.signupUrl}'),
        body: jsonEncode(data),
        headers: headers);
    print(response.request);
    print(response.body);
    print(response.statusCode);
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for login
  Future<APIStandardReturnFormat> login(Map<String, dynamic> data) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    final http.Response response = await http.post(
      Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.loginUrl}'),
      body: jsonEncode(data),
      headers: headers,
    );
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }
}
