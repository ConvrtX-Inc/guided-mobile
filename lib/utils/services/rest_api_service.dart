// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/activity_outfitter/activity_outfitter_model.dart';
import 'package:guided/models/advertisement_model.dart';
import 'package:guided/models/outfitter_image_model.dart';
import 'package:guided/models/outfitter_model.dart';
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

  /// Getting the activity outfitter details
  Future<ActivityOutfitterModel> getActivityOutfitterDetails() async {
    final String token =
        await SecureStorage.readValue(key: AppTextConstants.userToken);
    final http.Response response = await http
        .get(Uri.http(apiBaseUrl, AppAPIPath.getOutfitterDetail), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    final ActivityOutfitterModel dataSummary =
        ActivityOutfitterModel.fromJson(json.decode(response.body));

    /// I stopped here. Data is not being retrieved
    print(dataSummary);

    return ActivityOutfitterModel(
        data: dataSummary.data,
        page: dataSummary.page,
        pageCount: dataSummary.pageCount,
        total: dataSummary.total,
        count: dataSummary.count);
  }

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

    debugPrint('COMPLETE URI: $completeUri');
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

  /// API service for outfitter model
  Future<OutfitterModelData> getOutfitterData() async {
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final String? token =
        await SecureStorage.readValue(key: AppTextConstants.userToken);

    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.createOutfitterUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final http.Response response2 = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.outfitterImageUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    /// seeding for data summary
    final OutfitterModelData dataSummary = OutfitterModelData.fromJson(
        json.decode(response.body), json.decode(response2.body));

    // final OutfitterModelData dataSummary =
    //     OutfitterModelData.fromJson(json.decode(response.body));

    return OutfitterModelData(
        outfitterDetails: dataSummary.outfitterDetails,
        outfitterImageDetails: dataSummary.outfitterImageDetails);
    // return OutfitterModelData(outfitterDetails: dataSummary.outfitterDetails);
  }

  /// API service for outfitter image model
  Future<OutfitterImageModelData> getOutfitterImageData(String id) async {
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final String? token =
        await SecureStorage.readValue(key: AppTextConstants.userToken);

    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.outfitterImageUrl}?s={"activity_outfitter_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    /// seeding for data summary
    final OutfitterImageModelData dataSummary =
        OutfitterImageModelData.fromJson(json.decode(response.body));

    return OutfitterImageModelData(
        outfitterImageDetails: dataSummary.outfitterImageDetails);
  }

  /// API service for outfitter model
  Future<AdvertisementModelData> getAdvertisementData() async {
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final String? token =
        await SecureStorage.readValue(key: AppTextConstants.userToken);

    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.createAdvertisementUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    /// seeding for data summary
    final AdvertisementModelData dataSummary =
        AdvertisementModelData.fromJson(json.decode(response.body));

    return AdvertisementModelData(
        advertisementDetails: dataSummary.advertisementDetails);
  }
}
