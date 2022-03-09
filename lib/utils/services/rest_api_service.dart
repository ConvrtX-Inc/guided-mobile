// ignore_for_file: unnecessary_string_escapes, unnecessary_nullable_for_final_variable_declarations, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guided/constants/api_path.dart';

import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/activity_outfitter/activity_outfitter_model.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/advertisement_image_model.dart';
import 'package:guided/models/advertisement_model.dart';
import 'package:guided/models/currencies_model.dart';
import 'package:guided/models/outfitter_image_model.dart';
import 'package:guided/models/outfitter_model.dart';
import 'package:guided/models/profile_data_model.dart';

import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/user_model.dart';

import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/global_api_service.dart';
import 'package:http/http.dart' as http;

enum RequestType { GET, POST, PATCH }

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
    final http.Response response = await http
        .get(Uri.http(apiBaseUrl, AppAPIPath.getOutfitterDetail), headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${UserSingleton.instance.user.token}',
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
      case RequestType.PATCH:
        requestType = 'PATCH';
        break;
    }

    debugPrint('COMPLETE URI: $completeUri');
    final http.Request request = http.Request(requestType, completeUri);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };

    if (needAccessToken) {
      token = UserSingleton.instance.user.token;
      // staticToken; //await SecureStorage.readValue(key: SecureStorage.userTokenKey);
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
      switch (response.statusCode) {
        case 422:
          {}
          break;
        case 500:
          {}
          break;
        case 401:
          {
            // await refreshAccessToken();
          }
          break;
      }

      if (body.containsKey('errors')) {}
    } else {
      if (body == null) {
        return response.statusCode;
      }
    }

    if (type == RequestType.GET) {
      //Do if request type is GET
    }

    return body;
  }

  Future<OutfitterModelData> getOutfitterData() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.createOutfitterUrl}?s={"user_id": \"${UserSingleton.instance.user.user!.id}\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final http.Response response2 = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.outfitterImageUrl}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final OutfitterModelData dataSummary =
        OutfitterModelData.fromJson(json.decode(response.body));

    return OutfitterModelData(outfitterDetails: dataSummary.outfitterDetails);
  }

  /// API service for outfitter image model
  Future<OutfitterImageModelData> getOutfitterImageData(String id) async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.outfitterImageUrl}?s={"activity_outfitter_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<OutfitterImageDetailsModel> details =
        <OutfitterImageDetailsModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final OutfitterImageDetailsModel imageModel =
          OutfitterImageDetailsModel.fromJson(data);
      details.add(imageModel);
    }

    return OutfitterImageModelData(outfitterImageDetails: details);
  }

  /// API service for outfitter image model
  Future<OutfitterImageModelData> getOutfitterImage(String id) async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.outfitterImageUrl}?s={"id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<OutfitterImageDetailsModel> details =
        <OutfitterImageDetailsModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final OutfitterImageDetailsModel imageModel =
          OutfitterImageDetailsModel.fromJson(data);
      details.add(imageModel);
    }

    return OutfitterImageModelData(outfitterImageDetails: details);
  }

  /// API service for advertisement image model
  Future<AdvertisementImageModelData> getAdvertisementImageData(
      String id) async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getAdvertisementImage}?s={"activity_advertisement_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<AdvertisementImageDetailsModel> details =
        <AdvertisementImageDetailsModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final AdvertisementImageDetailsModel imageModel =
          AdvertisementImageDetailsModel.fromJson(data);
      details.add(imageModel);
    }

    return AdvertisementImageModelData(advertisementImageDetails: details);
  }

  /// API service for advertisement model
  Future<AdvertisementModelData> getAdvertisementData() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.createAdvertisementUrl}?s={"user_id": \"${UserSingleton.instance.user.user!.id}\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    /// seeding for data summary
    final AdvertisementModelData dataSummary =
        AdvertisementModelData.fromJson(json.decode(response.body));

    return AdvertisementModelData(
        advertisementDetails: dataSummary.advertisementDetails);
  }

  /// API service for profile model
  Future<ProfileModelData> getProfileData() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getProfileDetails}?s={"id": \"${UserSingleton.instance.user.user!.id}\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<ProfileDetailsModel> details = <ProfileDetailsModel>[];

    final List<dynamic> res = jsonDecode(response.body);

    for (final dynamic data in res) {
      final ProfileDetailsModel profileModel =
          ProfileDetailsModel.fromJson(data);
      details.add(profileModel);
    }

    return ProfileModelData(profileDetails: details);
  }

  /// API service for currencies
  Future<List<Currency>> getCurrencies() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getCurrencies}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final dynamic jsonData = jsonDecode(response.body);
    final List<Currency> currencies = <Currency>[];
    for (final dynamic uType in jsonData) {
      final Currency currency = Currency(
          uType['id'],
          uType['currency_code'] ?? '',
          uType['currency_name'] ?? '',
          uType['currency_symbol'] ?? '');
      currencies.add(currency);
    }
    return currencies;
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

  /// API service for currencies
  Future<List<ActivityPackage>> getActivityPackages() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesUrl}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final dynamic jsonData = jsonDecode(response.body);
    final List<ActivityPackage> activityPackages = <ActivityPackage>[];
    final activityPackage =
        (jsonData as List).map((i) => ActivityPackage.fromJson(i)).toList();
    activityPackages.addAll(activityPackage);
    return activityPackages;
  }
}
