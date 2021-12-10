import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/utils/secure_storage.dart';
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
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjJiN2NmNDM1LTQwOTAtNGEzOC1hYzVhLTUzNzA3ZTQ0YmMwMCIsImlhdCI6MTYzOTEwOTY4OSwiZXhwIjoxNjQwNDA1Njg5fQ._YUI1FFHJoF76NLb6JP02Q8HgLxnvKwG9V9PILnA-8U';
  

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
      token = await SecureStorage.readValue(key: SecureStorage.userTokenKey);
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
}
