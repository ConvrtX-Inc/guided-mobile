// ignore_for_file: unnecessary_string_escapes, unnecessary_nullable_for_final_variable_declarations, avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guided/constants/api_path.dart';

import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/activity_availability_hours.dart';
import 'package:guided/models/activity_availability_hours_model.dart';
import 'package:guided/models/activity_availability_model.dart';
import 'package:guided/models/activity_destination_model.dart';
import 'package:guided/models/activity_event_destination_image_model.dart';
import 'package:guided/models/activity_event_destination_model.dart';
import 'package:guided/models/activity_outfitter/activity_outfitter_model.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/advertisement_image_model.dart';
import 'package:guided/models/advertisement_model.dart';
import 'package:guided/models/badge.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/bank_account_model.dart';
import 'package:guided/models/become_a_guide_activites_model.dart';
import 'package:guided/models/become_a_guide_request_model.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/certificate.dart';
import 'package:guided/models/chat_model.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/models/currencies_model.dart';
import 'package:guided/models/event_image_model.dart';
import 'package:guided/models/event_model.dart';
import 'package:guided/models/notification_model.dart';
import 'package:guided/models/newsfeed_image_model.dart';
import 'package:guided/models/newsfeed_model.dart';
import 'package:guided/models/outfitter_image_model.dart';
import 'package:guided/models/outfitter_model.dart';
import 'package:guided/models/package_destination_image_model.dart';
import 'package:guided/models/package_destination_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/payment_transaction.dart';
import 'package:guided/models/popular_guide.dart';
import 'package:guided/models/preset_form_model.dart';
import 'package:guided/models/profile_data_model.dart';

import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/profile_image.dart';
import 'package:guided/models/user_list_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:guided/models/user_terms_and_condition_model.dart';
import 'package:guided/models/user_transaction_model.dart';
import 'package:guided/models/wishlist_activity_model.dart';
import 'package:guided/utils/mixins/global_mixin.dart';

import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/global_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/booking_request.dart';
import '../../models/settings_availability.dart';

enum RequestType { GET, POST, PATCH, DELETE }

/// Service for API Calls
class APIServices {
  /// API base mode
  final String apiBaseMode = AppAPIPath.apiBaseMode;

  /// API base url
  final String apiBaseUrl = AppAPIPath.apiBaseUrl;

  /// token
  final String staticToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIxY2E3MGIzLTllZWUtNDI4NS05NDczLWZiNTE4Y2FhNjdiZSIsImlhdCI6MTY1MDg5OTA5OSwiZXhwIjoxNjUyMTk1MDk5fQ.sYpHBg-K_bkiMAQLtUZxjzaM2hQn4K6M4o0i5JUYf6E';

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
      {bool needAccessToken = false,
      Map<String, dynamic> data = const <String, dynamic>{}}) async {
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
      case RequestType.DELETE:
        requestType = 'DELETE';
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
  Future<ProfileDetailsModel> getProfileData() async {
    final String? userId =
        await SecureStorage.readValue(key: AppTextConstants.userId);

    debugPrint('Profile USER ID $userId');
    final String url =
        '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getProfileDetails}/$userId';
    debugPrint('URL $url');
    final http.Response response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${UserSingleton.instance.user.token}',
    });

    final ProfileDetailsModel dataSummary =
        ProfileDetailsModel.fromJson(json.decode(response.body));
    return dataSummary;
  }

  /// API service for get booking request
  Future<List<BookingRequest>> getBookingRequest() async {
    final String? userId = UserSingleton.instance.user.user?.id;

    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint(
        'BookingURL ${Uri.http(apiBaseUrl, '/${AppAPIPath.getBookingRequest}', queryParameters)}');
    final http.Response response = await http.get(
        Uri.http(
            apiBaseUrl, '/${AppAPIPath.getBookingRequest}', queryParameters),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final dynamic jsonData = jsonDecode(response.body);
    final List<BookingRequest> bookingRequest = <BookingRequest>[];
    final List<BookingRequest> booking =
        (jsonData as List).map((i) => BookingRequest.fromJson(i)).toList();
    bookingRequest.addAll(booking);
    return bookingRequest;
  }

  /// API service for profile model
  Future<User> getUserDetails(String id) async {
    print(id);
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getProfileDetails}/$id'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final dynamic parsedJson = json.decode(response.body);
    print(response.request!.url);
    print(parsedJson);
    return User.fromJson(parsedJson);
  }

  /// API service for currencies
  Future<List<Currency>> getCurrencies() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getCurrencies}?sort=currency_name,ASC'),
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
    print(response.body);
    print(response.request!.url);
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for login
  Future<APIStandardReturnFormat> loginFacebook(String fbToken) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    final http.Response response = await http.post(
      Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.facebookLogin}'),
      body: jsonEncode({'accessToken': fbToken}),
      headers: headers,
    );
    print(response.body);
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for login
  Future<APIStandardReturnFormat> loginGoogle(String idToken) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    final http.Response response = await http.post(
      Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.facebookLogin}'),
      body: jsonEncode({'idToken': idToken}),
      headers: headers,
    );
    print(response.body);
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for login
  Future<APIStandardReturnFormat> loginWithApple(String idToken) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    final http.Response response = await http.post(
      Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.facebookLogin}'),
      body: jsonEncode(
          {'idToken': idToken, 'firstName': 'user', 'lastName': 'apple'}),
      headers: headers,
    );
    print(response.body);
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for currencies
  Future<List<ActivityPackage>> getActivityPackages() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesUrl}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}'
        });

    final dynamic jsonData = jsonDecode(response.body);

    final List<ActivityPackage> activityPackages = <ActivityPackage>[];
    final activityPackage =
        (jsonData as List).map((i) => ActivityPackage.fromJson(i)).toList();
    activityPackages.addAll(activityPackage);
    return activityPackages;
  }

  /// API service for currencies
  Future<List<ActivityPackage>> getActivityPackagesbyDescOrder() async {
    debugPrint(
        'Packages Url: ${Uri.parse('${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesUrlDescOrder}')}');
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesUrlDescOrder}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}'
        });

    final dynamic jsonData = jsonDecode(response.body);
    print(jsonData);
    final List<ActivityPackage> activityPackages = <ActivityPackage>[];
    final List<ActivityPackage> activityPackage =
        (jsonData as List).map((i) => ActivityPackage.fromJson(i)).toList();
    activityPackages.addAll(activityPackage);
    return activityPackages;
  }

  /// API service for currencies
  Future<List<ActivityPackage>> searchActivity(String searchKey) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesUrlSearch}/$searchKey'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}'
        });

    final dynamic jsonData = jsonDecode(response.body);
    print(jsonData);
    final List<ActivityPackage> activityPackages = <ActivityPackage>[];
    final List<ActivityPackage> activityPackage =
        (jsonData as List).map((i) => ActivityPackage.fromJson(i)).toList();
    activityPackages.addAll(activityPackage);
    return activityPackages;
  }

  /// API service for currencies
  Future<List<ActivityPackage>> getActivityByDateRange(
      String startDate, String endDate) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesbyDateRage}/$startDate/$endDate'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}'
        });

    final dynamic jsonData = jsonDecode(response.body);
    print(jsonData);
    final List<ActivityPackage> activityPackages = <ActivityPackage>[];
    final List<ActivityPackage> activityPackage =
        (jsonData as List).map((i) => ActivityPackage.fromJson(i)).toList();
    activityPackages.addAll(activityPackage);
    return activityPackages;
  }

  /// API service for getActivityPackageDetails
  Future<ActivityPackage> getActivityPackageDetails(String id) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesUrl}/$id'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    print(response.body);
    final dynamic parsedJson = json.decode(response.body);
    return ActivityPackage.fromJson(parsedJson);
  }

  /// API service for advertisement model
  Future<PackageModelData> getPackageData() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesUrl}?s={"user_id": \"${UserSingleton.instance.user.user!.id}\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    /// seeding for data summary
    final PackageModelData dataSummary =
        PackageModelData.fromJson(json.decode(response.body));

    return PackageModelData(packageDetails: dataSummary.packageDetails);
  }

  /// API service for package destination model
  Future<PackageDestinationModelData> getPackageDestinationData(
      String id) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityDestinationDetails}?s={"activity_package_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    /// seeding for data summary
    final PackageDestinationModelData dataSummary =
        PackageDestinationModelData.fromJson(json.decode(response.body));

    return PackageDestinationModelData(
        packageDestinationDetails: dataSummary.packageDestinationDetails);
  }

  /// API service for package destination image model
  Future<PackageDestinationImageModelData> getPackageDestinationImageData(
      String id) async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityDestinationImage}?s={"activity_package_destination_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<PackageDestinationImageDetailsModel> details =
        <PackageDestinationImageDetailsModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final PackageDestinationImageDetailsModel imageModel =
          PackageDestinationImageDetailsModel.fromJson(data);
      details.add(imageModel);
    }

    return PackageDestinationImageModelData(
        packageDestinationImageDetails: details);
  }

  /// API service for event model
  Future<EventModelData> getEventData() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityEventUrl}?s={"user_id": \"${UserSingleton.instance.user.user!.id}\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    /// seeding for data summary
    final EventModelData dataSummary =
        EventModelData.fromJson(json.decode(response.body));

    return EventModelData(eventDetails: dataSummary.eventDetails);
  }

  /// API service for event image model
  Future<EventImageModelData> getEventImageData(String id) async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getEventImage}?s={"activity_event_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<EventImageDetailsModel> details = <EventImageDetailsModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final EventImageDetailsModel imageModel =
          EventImageDetailsModel.fromJson(data);
      details.add(imageModel);
    }

    return EventImageModelData(eventImageDetails: details);
  }

  ///API Service for transactions
  Future<APIStandardReturnFormat> getTransactions() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getTransactions}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  ///API Service for Posts
  Future<APIStandardReturnFormat> getPosts() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getPosts}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  ///API Service for transactions-byguide
  Future<APIStandardReturnFormat> getTransactionsByGuide(int status) async {
    String? tour_guide_id = UserSingleton.instance.user.user!.id;
    String statusName = "";
    switch (status) {
      case 0:
        statusName = "all";
        break;
      case 1:
        statusName = "completed";
        break;
      case 2:
        statusName = "pending";
        break;
      case 3:
        statusName = "rejected";
        break;
    }
    String url = Uri.encodeFull(
        '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getTransactionsByGuide}\/${tour_guide_id}\/${statusName}');
    // var url  = Uri.encodeFull('${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getTransactionsByGuide}\/678036c1-9da6-43ae-bb21-253a5e9b54d5\/${statusName}');
    // var url  = Uri.encodeFull('${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getTransactionsByGuide}\/21ca70b3-9eee-4285-9473-fb518caa67be\/${statusName}');
    print("url2:" + url);
    final http.Response response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${UserSingleton.instance.user.token}',
    });
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for getClosestActivity
  Future<List<ActivityPackage>> getClosestActivity(
      double latitude, double longitude) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      HttpHeaders.authorizationHeader:
          'Bearer ${UserSingleton.instance.user.token}',
    };
    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.closestActivity}'),
        body: jsonEncode(
            {'latitude': '10.31', 'longitude': '123.89', 'distance': '20'}),
        headers: headers);

    final dynamic jsonData = jsonDecode(response.body);
    print(response.request!.url);
    print(jsonData);
    print(jsonData['response']['data']['details']);
    final List<ActivityPackage> activityPackages = <ActivityPackage>[];
    final List<ActivityPackage> activityPackage =
        (jsonData['response']['data']['details'] as List)
            .map((i) => ActivityPackage.fromJson(i))
            .toList();
    activityPackages.addAll(activityPackage);
    return activityPackages;
  }

  /// API service for register
  Future<APIStandardReturnFormat> requestBooking(
      Map<String, dynamic> data) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      HttpHeaders.authorizationHeader:
          'Bearer ${UserSingleton.instance.user.token}',
    };
    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.requestBooking}'),
        body: jsonEncode(data),
        headers: headers);
    print(jsonEncode(data));
    print(response.request);
    print(response.body);
    print(response.statusCode);
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  // /// API service for getActivityHours
  // Future<List<ActivityAvailability>> getActivityHours(
  //     String startDate, String endDate, String packageId) async {
  //   final Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': '*/*',
  //     HttpHeaders.authorizationHeader:
  //         'Bearer ${UserSingleton.instance.user.token}',
  //   };
  //   final http.Response response = await http.post(
  //       Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.closestActivity}'),
  //       body: jsonEncode({
  //         'activity_package_id': packageId,
  //         'start_date': startDate,
  //         'end_date': endDate
  //       }),
  //       headers: headers);

  //   final dynamic jsonData = jsonDecode(response.body);
  //   print(response.request!.url);
  //   print(jsonData);
  //   final List<ActivityAvailability> hours = <ActivityAvailability>[];
  //   final hour = (jsonData['response']['data']['details'] as List)
  //       .map((i) => ActivityAvailability.fromJson(i))
  //       .toList();
  //   hours.addAll(hour);
  //   return hours;
  // }

  /// API service getActivityHours

  Future<List<ActivityHourAvailability>> getActivityHours(
      String startDate, String endDate, String packageId) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityAvailabilityHours}/$packageId/$startDate/$endDate'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    print(response.request!.url);
    print(response.body);
    final dynamic jsonData = jsonDecode(response.body);
    final List<ActivityHourAvailability> activityHours =
        <ActivityHourAvailability>[];
    final List<ActivityHourAvailability> activityHour = (jsonData as List)
        .map((i) => ActivityHourAvailability.fromJson(i))
        .toList();
    activityHours.addAll(activityHour);

    return activityHours;
  }

  /// API service for badges model
  Future<BadgeModelData> getBadgesModel() async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.badgesUrl}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<BadgeDetailsModel> details = <BadgeDetailsModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final BadgeDetailsModel badgeModel = BadgeDetailsModel.fromJson(data);
      details.add(badgeModel);
    }

    return BadgeModelData(badgeDetails: details);
  }

  /// API service for all badges
  Future<List<ActivityBadge>> getAllBadges() async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.badgesUrl}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final dynamic jsonData = jsonDecode(response.body);
    print(jsonData);
    final List<ActivityBadge> badges = <ActivityBadge>[];
    final List<ActivityBadge> badge =
        (jsonData as List).map((i) => ActivityBadge.fromJson(i)).toList();
    badges.addAll(badge);

    return badges;
  }

  /// API service for get Popular guides

  Future<List<User>> getPopularGuides() async {
    final http.Response response = await http.get(
        // Uri.parse(
        //     '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.popularGuides}/51.43/-122.21/20'),
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getProfileDetails}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    final dynamic jsonData = jsonDecode(response.body);

    // final List<User> popularGuides = <User>[];
    // final List<User> activityPackage =
    //     (jsonData['data'] as List).map((i) => User.fromJson(i)).toList();

    // final List<User> guides = activityPackage.where(
    //   (User element) {
    //     return element.isTraveller == false;
    //   },
    // ).toList();
    // print(guides.length);
    // popularGuides.addAll(guides);

    final List<User> guides = jsonData;

    return jsonData;
  }

  /// API service for outfitter image model
  Future<BadgeModelData> getBadgesModelById(String id) async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.badgesUrl}?s={"id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<BadgeDetailsModel> details = <BadgeDetailsModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final BadgeDetailsModel badgeModel = BadgeDetailsModel.fromJson(data);
      details.add(badgeModel);
    }

    return BadgeModelData(badgeDetails: details);
  }

  /// API service for countries
  Future<List<CountryModel>> getCountries() async {
    final http.Response response =
        await http.get(Uri.http(apiBaseUrl, '/api/v1/countries'));
    final List<dynamic> res = jsonDecode(response.body);
    final List<CountryModel> countries = <CountryModel>[];

    for (final dynamic data in res) {
      final CountryModel country = CountryModel.fromJson(data);
      countries.add(country);
    }

    return countries;
  }

  /// Api service for adding bank account
  Future<dynamic> addBankAccount(BankAccountModel params) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    debugPrint(
        'URL ${Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.bankAccountUrl} token $token User $userId')}');

    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.bankAccountUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId.toString(),
          'account_name': params.accountName,
          'bank_name': params.bankName,
          'account_no': params.accountNumber,
          'country_id': params.countryId,
          'bank_routing_number': params.bankRoutingNumber
        }));
    final jsonData = json.decode(response.body);

    debugPrint(
        'base url    ${Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.bankAccountUrl}')}  ');
    debugPrint('BAnk Response ${jsonData} status code ${response.statusCode}');

    if (response.statusCode == 201) {
      return BankAccountModel.fromJson(jsonData);
    } else {
      return jsonData;
    }
  }

  /// API service for waiver form
  Future<List<PresetFormModel>> getPresetWaiver() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.termsAndCondition}?s={"id":"4c33d045-e881-4d93-a7b2-3ffa2a44c82c"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    final List<dynamic> res = jsonDecode(response.body);
    final List<PresetFormModel> forms = <PresetFormModel>[];

    for (final dynamic data in res) {
      final PresetFormModel form = PresetFormModel.fromJson(data);
      forms.add(form);
    }

    return forms;
  }

  /// API service for terms and condition form
  Future<List<PresetFormModel>> getPresetTermsAndCondition(String type) async {
    String id = '';
    if (type == 'terms_and_condition') {
      id = 'terms and conditions';
    } else if (type == 'traveler_waiver_form') {
      id = 'traveler release and waiver form';
    } else if (type == 'cancellation_policy') {
      id = 'cancellationpolicy';
    } else if (type == 'guided_payment_payout') {
      id = 'paymentandpayoutterms';
    } else if (type == 'local_laws') {
      id = 'locallawsandtaxes';
    }

    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.termsAndCondition}/$id'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    final List<dynamic> res = jsonDecode(response.body);
    final List<PresetFormModel> forms = <PresetFormModel>[];

    for (final dynamic data in res) {
      final PresetFormModel form = PresetFormModel.fromJson(data);
      forms.add(form);
    }

    print(response.request!.url);
    return forms;
  }

  ///API Service for Retrieving User Cards
  Future<List<CardModel>> getCards() async {
    final String? token = UserSingleton.instance.user.token;
    final String userId =
        await SecureStorage.readValue(key: AppTextConstants.userId);
    debugPrint('User id cards $userId');

    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint('DATA ${Uri.http(apiBaseUrl, '/api/v1/card', queryParameters)}');
    debugPrint('params R$queryParameters');
    final http.Response response = await http
        .get(Uri.http(apiBaseUrl, '/api/v1/card', queryParameters), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    final dynamic jsonData = jsonDecode(response.body);
    final List<CardModel> cards = <CardModel>[];
    for (final dynamic res in jsonData) {
      final CardModel card = CardModel.fromJson(res);
      cards.add(card);
    }
    return cards;
  }

  /// API service for Add Card
  Future<CardModel> addCard(CardModel cardDetailParams, String cardType) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl${AppAPIPath.cardUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId.toString(),
          'is_default': 'false',
          'full_name': cardDetailParams.fullName,
          'address': cardDetailParams.address,
          'city': cardDetailParams.city,
          'postal_code': cardDetailParams.postalCode,
          'country_id': cardDetailParams.countryId,
          'card_no': cardDetailParams.cardNo,
          'name_on_card': cardDetailParams.nameOnCard,
          'expiry_date': cardDetailParams.expiryDate,
          'cvv': cardDetailParams.cvv.toString(),
          'card_color': GlobalMixin().generateRandomHexColor().toString(),
          'card_type': cardType
        }));

    final jsonData = json.decode(response.body);

    if (response.statusCode == 201) {
      return CardModel.fromJson(jsonData);
    } else {
      return CardModel();
    }
  }

  /// API service for Remove Card
  Future<http.Response> removeCard(String cardID) async {
    final String? token = UserSingleton.instance.user.token;
    final http.Response response = await http.delete(
      Uri.parse('$apiBaseMode$apiBaseUrl${AppAPIPath.cardUrl}/$cardID'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return response;
  }

  /// API service for default Card
  Future<APIStandardReturnFormat> setDefaultCard(String cardID) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.post(
        Uri.parse(
            '$apiBaseMode$apiBaseUrl${AppAPIPath.cardUrl}/set-default-card'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId.toString(),
          'card_id': cardID,
        }));

    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for Edit Card
  Future<CardModel> editCard(
      CardModel cardDetailParams, String cardType) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.patch(
        Uri.parse(
            '$apiBaseMode$apiBaseUrl${AppAPIPath.cardUrl}/${cardDetailParams.id}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'id': cardDetailParams.id,
          'user_id': userId.toString(),
          'is_default': cardDetailParams.isDefault.toString(),
          'full_name': cardDetailParams.fullName,
          'address': cardDetailParams.address,
          'city': cardDetailParams.city,
          'postal_code': cardDetailParams.postalCode,
          'country_id': cardDetailParams.countryId,
          'card_no': cardDetailParams.cardNo,
          'name_on_card': cardDetailParams.nameOnCard,
          'expiry_date': cardDetailParams.expiryDate,
          'cvv': cardDetailParams.cvv.toString(),
          'card_color': cardDetailParams.cardColor,
          'card_type': cardType
        }));

    final dynamic jsonData = json.decode(response.body);

    if (response.statusCode == 200) {
      return CardModel.fromJson(jsonData);
    } else {
      return CardModel();
    }
  }

  /// API service for terms and condition form
  Future<List<PresetFormModel>> getTermsAndCondition(String type) async {
    final String? userId = UserSingleton.instance.user.user?.id;
    debugPrint('USER ID $userId');
    String id = '';
    if (type == 'terms_and_condition') {
      id = 'termsandconditions';
    } else if (type == 'traveler_waiver_form') {
      id = 'travelerreleaseandwaiverform';
    } else if (type == 'cancellation_policy') {
      id = 'cancellationpolicy';
    } else if (type == 'guided_payment_payout') {
      id = 'paymentandpayoutterms';
    } else if (type == 'local_laws') {
      id = 'locallawsandtaxes';
    }

    debugPrint(
        'TERMS  ${Uri.parse('${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.termsAndCondition}/$id')}');

    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.termsAndCondition}/$id'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    final List<dynamic> res = jsonDecode(response.body);
    final List<PresetFormModel> forms = <PresetFormModel>[];

    debugPrint('RESULT $res');

    for (final dynamic data in res) {
      final PresetFormModel form = PresetFormModel.fromJson(data);
      forms.add(form);
    }

    return forms;
  }

  /// API service for terms and condition form
  Future<List<UsersTermsAndConditionModel>> getUsersTermsAndCondition() async {
    final String? userId = UserSingleton.instance.user.user?.id;
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.usersTermsAndCondition}?s={"user_id":\"$userId\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    final List<dynamic> res = jsonDecode(response.body);
    final List<UsersTermsAndConditionModel> forms =
        <UsersTermsAndConditionModel>[];

    for (final dynamic data in res) {
      final UsersTermsAndConditionModel form =
          UsersTermsAndConditionModel.fromJson(data);
      forms.add(form);
    }

    return forms;
  }

  ///API service for Payment
  Future<APIStandardReturnFormat> pay(
      int amount, String paymentMethodID) async {
    final String? token = UserSingleton.instance.user.token;
    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl${AppAPIPath.paymentUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'content-type': 'application/json'
        },
        body: jsonEncode({
          'payment_method_id': paymentMethodID,
          'amount': amount,
        }));

    debugPrint('payment response:: ${response.body}');

    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for user  adding subscription
  Future<APIStandardReturnFormat> addUserSubscription(
      UserSubscription params, String paymentMethod, String action) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final String requestMethod = action == 'add' ? 'POST' : 'PATCH';
    final Uri uri = action == 'add'
        ? Uri.parse('$apiBaseMode$apiBaseUrl${AppAPIPath.userSubscription}')
        : Uri.parse(
            '$apiBaseMode$apiBaseUrl${AppAPIPath.userSubscription}/${params.id}');
    debugPrint('REQUEST METHOD:: $action ${params.id}');

    final http.Request request = http.Request(
      requestMethod,
      uri,
    );

    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    request.body = jsonEncode(<String, String>{
      'user_id': userId.toString(),
      'name': params.name,
      'payment_reference_no': params.paymentReferenceNo,
      'start_date': params.startDate,
      'end_date': params.endDate,
      'message': params.message,
      'price': params.price
    });

    final http.StreamedResponse streamedResponse = await request.send();
    final http.Response response =
        await http.Response.fromStream(streamedResponse);

    debugPrint('Response: ${response.body}');

    final PaymentTransactionModel transactionParams = PaymentTransactionModel(
        serviceName: 'Premium Subscription',
        transactionNumber: params.paymentReferenceNo,
        amount: params.price,
        type: AppTextConstants.deduction,
        paymentMethod: paymentMethod);
    await savePaymentTransaction(transactionParams);
    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service creating payment intent - stripe
  Future<APIStandardReturnFormat> createPaymentIntent(int amount) async {
    final String? token = UserSingleton.instance.user.token;
    final http.Response response = await http.post(
        Uri.parse(
            '$apiBaseMode$apiBaseUrl${AppAPIPath.paymentUrl}/create-payment-intent'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'content-type': 'application/json'
        },
        body: jsonEncode({
          'amount': amount,
        }));

    debugPrint('payment intent response:: ${response.body}');

    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for terms and condition form
  Future<List<ActivityAvailability>> getActivityAvailability(
      String activityPackageId) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityAvailability}?s={"activity_package_id":\"$activityPackageId\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    final List<dynamic> res = jsonDecode(response.body);
    final List<ActivityAvailability> forms = <ActivityAvailability>[];

    for (final dynamic data in res) {
      final ActivityAvailability form = ActivityAvailability.fromJson(data);
      forms.add(form);
    }

    return forms;
  }

  ///API Service for Retrieving User Bank Accounts
  Future<List<BankAccountModel>> getUserBankAccounts() async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint('params R$queryParameters');
    final http.Response response = await http.get(
        Uri.http(apiBaseUrl, AppAPIPath.bankAccountUrl, queryParameters),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final dynamic jsonData = jsonDecode(response.body);
    final List<BankAccountModel> bankAccounts = <BankAccountModel>[];
    for (final dynamic res in jsonData) {
      final BankAccountModel bankAccount = BankAccountModel.fromJson(res);
      bankAccounts.add(bankAccount);
    }
    return bankAccounts;
  }

  /// API service for Remove Bank Account
  Future<http.Response> removeBankAccount(String id) async {
    debugPrint(
        'base ${Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.bankAccountUrl}/$id')}');
    final String? token = UserSingleton.instance.user.token;
    final http.Response response = await http.delete(
      Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.bankAccountUrl}/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return response;
  }

  /// API service for terms and condition form
  Future<List<ActivityAvailabilityHour>> getActivityAvailabilityHour(
      String activityAvailabilityId) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.createSlotAvailabilityHour}?s={"activity_availability_id":\"$activityAvailabilityId\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });
    final List<dynamic> res = jsonDecode(response.body);
    final List<ActivityAvailabilityHour> forms = <ActivityAvailabilityHour>[];

    for (final dynamic data in res) {
      final ActivityAvailabilityHour form =
          ActivityAvailabilityHour.fromJson(data);
      forms.add(form);
    }

    return forms;
  }

  ///Api service for Save Payment Intent (Booking Request)
  Future<APIStandardReturnFormat> savePaymentIntent(String paymentIntentId,
      String bookingRequestId, String paymentMethodId) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.paymentIntentUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'content-type': 'application/json'
        },
        body: jsonEncode({
          'user_id': userId,
          'booking_request_id': bookingRequestId,
          'stripe_payment_intent_id': paymentIntentId,
          'stripe_payment_method_id': paymentMethodId
        }));

    debugPrint('save payment intent response:: ${response.body}');

    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for Add User Transaction
  Future<UserTransaction> addUserTransaction(UserTransaction params) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.userTransactionsUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId.toString(),
          'activity_package_id': params.activityPackageId,
          'total': params.total,
          'tour_guide_id': params.tourGuideId,
          'number_of_people': params.numberOfPeople,
          'service_name': params.serviceName,
          'transaction_number': params.transactionNumber,
          'status_id': params.statusId,
          'book_date': params.bookDate
        }));

    final jsonData = json.decode(response.body);

    debugPrint('JsonData $jsonData');
    if (response.statusCode == 201) {
      return UserTransaction.fromJson(jsonData);
    } else {
      return UserTransaction();
    }
  }

  /// API service for advertisement model
  Future<PackageModelData> getPopularGuidePackage(String? id) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesUrl}?s={"\$and": [{"user_id": \"$id\"}, {"is_published": true}]}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    /// seeding for data summary
    final PackageModelData dataSummary =
        PackageModelData.fromJson(json.decode(response.body));

    return PackageModelData(packageDetails: dataSummary.packageDetails);
  }

  /// API service for all event model
  Future<EventModelData> getAllEventData() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityEventUrl}?s={"is_post": true}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    /// seeding for data summary
    final EventModelData dataSummary =
        EventModelData.fromJson(json.decode(response.body));

    return EventModelData(eventDetails: dataSummary.eventDetails);
  }

  /// API service for all outfitter model
  Future<OutfitterModelData> getAllOutfitterData() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.createOutfitterUrl}'),
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

  ///Api Service for update profile
  Future<APIStandardReturnFormat> updateProfile(dynamic parameters) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.patch(
        Uri.parse(
            '$apiBaseMode$apiBaseUrl/${AppAPIPath.getProfileDetails}/$userId'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'content-type': 'application/json'
        },
        body: jsonEncode(parameters));

    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  ///API Service for Retrieving User Subscription
  Future<UserSubscription> getUserSubscription() async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint('DATA ${Uri.http(apiBaseUrl, '/api/v1/card', queryParameters)}');
    debugPrint('params R$queryParameters');
    final http.Response response = await http.get(
        Uri.http(apiBaseUrl, '/api/v1/user-subscription', queryParameters),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final dynamic jsonData = jsonDecode(response.body);
    final List<UserSubscription> subscriptions = <UserSubscription>[];
    for (final dynamic res in jsonData) {
      final UserSubscription subscription = UserSubscription.fromJson(res);
      subscriptions.add(subscription);
    }
    if (subscriptions.isNotEmpty) {
      debugPrint('Subscrption ${subscriptions[0].id}');
      return subscriptions[0];
    } else {
      debugPrint('No Subscrption');
      return UserSubscription();
    }
  }

  ///API Service for  retrieving user profile image
  Future<UserProfileImage> getUserProfileImages(String userId) async {
    final String? token = UserSingleton.instance.user.token;
    // final String? userId = UserSingleton.instance.user.user?.id;

    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint(
        'DATA ${Uri.http(apiBaseUrl, '/api/v1/user-profile-images', queryParameters)}');
    debugPrint('params R$queryParameters');
    final http.Response response = await http.get(
        Uri.http(apiBaseUrl, '/api/v1/user-profile-images', queryParameters),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final dynamic jsonData = jsonDecode(response.body);
    final List<UserProfileImage> profileImages = <UserProfileImage>[];
    for (final dynamic res in jsonData) {
      final UserProfileImage profileImage = UserProfileImage.fromJson(res);
      profileImages.add(profileImage);
    }
    if (profileImages.isNotEmpty) {
      debugPrint('Images ${profileImages[0].id}');
      return profileImages[0];
    } else {
      debugPrint('No images');
      return UserProfileImage();
    }
  }

  /// API service for Add User Profile Images
  Future<UserProfileImage> addUserProfileImages(UserProfileImage params) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response =
        await http.post(Uri.http(apiBaseUrl, '/api/v1/user-profile-images'),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: jsonEncode(<String, String>{
              'user_id': userId.toString(),
              'image_firebase_url_1': params.imageUrl1,
              'image_firebase_url_2': params.imageUrl2,
              'image_firebase_url_3': params.imageUrl3,
              'image_firebase_url_4': params.imageUrl4,
              'image_firebase_url_5': params.imageUrl5,
              'image_firebase_url_6': params.imageUrl6,
            }));

    final jsonData = json.decode(response.body);

    debugPrint('Profile Image $jsonData');
    if (response.statusCode == 201) {
      return UserProfileImage.fromJson(jsonData);
    } else {
      return UserProfileImage();
    }
  }

  /// API service for Update User Profile Images
  Future<UserProfileImage> updateUserProfileImages(
      UserProfileImage params) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.patch(
        Uri.http(apiBaseUrl, '/api/v1/user-profile-images/${params.id}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'image_firebase_url_1': params.imageUrl1,
          'image_firebase_url_2': params.imageUrl2,
          'image_firebase_url_3': params.imageUrl3,
          'image_firebase_url_4': params.imageUrl4,
          'image_firebase_url_5': params.imageUrl5,
          'image_firebase_url_6': params.imageUrl6,
        }));

    final jsonData = json.decode(response.body);

    if (response.statusCode == 200) {
      debugPrint('Update Profile image .. ${response.statusCode}');
      return UserProfileImage.fromJson(jsonData);
    } else {
      return UserProfileImage();
    }
  }

  /// API service for  stripe setup
  Future<http.Response> createStripeAccount(dynamic params) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    debugPrint(
        'Response::: ${Uri.parse('$apiBaseMode$apiBaseUrl/api/v1/account/create-stripe-account')} ');
    final http.Response response = await http.post(
        Uri.parse(
            '$apiBaseMode$apiBaseUrl/api/v1/account/create-stripe-account'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: params);

    return response;
  }

  /// API service for  stripe account link
  Future<http.Response> getOnboardAccountLink(String accountId) async {
    final String? token = UserSingleton.instance.user.token;

    debugPrint(
        'on board Response::: ${Uri.parse('$apiBaseMode$apiBaseUrl/api/v1/account/on-board-account')} ');
    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/api/v1/account/on-board-account'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'account_id': accountId,
        }));

    debugPrint('Response  Account id $accountId ${response.body}');
    return response;
  }

  /// API service add bank account to stripe
  Future<http.Response> addBankAccountToStripeAccount(
      String accountId, String bankToken) async {
    final String? token = UserSingleton.instance.user.token;

    final http.Response response = await http.post(
        Uri.parse(
            '$apiBaseMode$apiBaseUrl/api/v1/account/connect-bank-to-account'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'account_id': accountId,
          'external_account': bankToken
        }));

    debugPrint('Response Bank Account Account id $accountId ${response.body}');

    return response;
  }

  ///API Service for Retrieving payment intent booking request
  Future<dynamic> getPaymentIntentId(String bookingRequestId) async {
    final String? token = UserSingleton.instance.user.token;

    final Map<String, String> queryParameters = {
      'filter': 'booking_request_id||eq||"$bookingRequestId"',
    };

    debugPrint('params R$queryParameters');
    final http.Response response = await http.get(
        Uri.http(apiBaseUrl, '/api/v1/payment-intent', queryParameters),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final dynamic jsonData = jsonDecode(response.body);
    debugPrint('Data ${jsonData[0]}');

    return jsonData[0];
  }

  ///API Service for create transfer payment intent
  Future<dynamic> createTransferPaymentIntent(
      String accountId,
      double totalServiceAmount,
      double applicationFee,
      String payeeEmail) async {
    final String? token = UserSingleton.instance.user.token;

    final http.Response response =
        await http.post(Uri.parse('$apiBaseMode$apiBaseUrl/api/v1/transfer'),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: jsonEncode(<String, String>{
              'account': accountId,
              'total_service_amount': totalServiceAmount.toString(),
              'transfer_money': applicationFee.toString(),
              'payee_email': payeeEmail
            }));

    debugPrint('Response Payment Intent :: ${response.body}');
    final jsonData = jsonDecode(response.body);
    return jsonData['paymentIntent'] ?? '';
  }

  ///API Service for charging payment booking request
  Future<dynamic> chargeBookingPayment(
      String paymentIntentId, String paymentMethodId) async {
    final String? token = UserSingleton.instance.user.token;

    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/api/v1/transfer/confirm-transfer'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'payment_method_id': paymentMethodId,
          'payment_intent_id': paymentIntentId
        }));

    debugPrint('Response Payment :: ${response.body}');
    final jsonData = jsonDecode(response.body);
    return jsonData['id'];
  }

  ///API Service for Getting Booking Transaction
  Future<UserTransaction> getBookingTransaction(
      String packageId, String userId) async {
    final String? token = UserSingleton.instance.user.token;
    // final String? userId = UserSingleton.instance.user.user?.id;

    final Map<String, String> queryParameters = {
      'filter[0]': 'user_id||eq||"$userId"',
      'filter[1]': 'activity_package_id||eq||"$packageId"',
    };

    debugPrint('params R$queryParameters');
    final http.Response response = await http.get(
        Uri.http(apiBaseUrl, '/api/v1/transactions', queryParameters),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    UserTransaction transaction = UserTransaction();
    final dynamic jsonData = jsonDecode(response.body);

    transaction = UserTransaction.fromJson(jsonData[0]);
    //
    // debugPrint('Transaction ${transaction.id }');
    return transaction;
  }

  ///Api service to get chat messages
  Future<List<ChatModel>> getChatMessages(String userId, String filter) async {
    final String? token = UserSingleton.instance.user.token;

    final http.Response response = await http.get(
        Uri.http(apiBaseUrl, '/api/v1/message-detail/$userId/$filter'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final dynamic jsonData = jsonDecode(response.body);
    final List<ChatModel> chatMessages = <ChatModel>[];
    for (final dynamic res in jsonData) {
      final ChatModel chat = ChatModel.fromJson(res);
      chatMessages.add(chat);
    }

    return chatMessages;
  }

  ///Delete chat conversation
  Future<http.Response> deleteConversation(String roomId) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;
    final http.Response response = await http.delete(
      Uri.parse(
          '$apiBaseMode$apiBaseUrl/api/v1/message-detail/delete-conversation/$roomId/user/$userId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return response;
  }

  ///Block User chat
  Future<http.Response> blockUserChat(String toUserId) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;
    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/api/v1/user-messages-block'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'from_user_id': userId.toString(),
          'to_user_id': toUserId
        }));

    return response;
  }

  ///UnBlock User chat
  Future<http.Response> unBlockUserChat(String blockId) async {
    final String? token = UserSingleton.instance.user.token;

    final http.Response response = await http.delete(
        Uri.parse(
            '$apiBaseMode$apiBaseUrl/api/v1/user-messages-block/$blockId'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        });

    debugPrint('response $response');

    return response;
  }

  /// API service for profile model
  Future<ProfileDetailsModel> getProfileDataById(String id) async {
    final String url =
        '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getProfileDetails}/$id';
    debugPrint('URL $url');
    final http.Response response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${UserSingleton.instance.user.token}',
    });

    final ProfileDetailsModel dataSummary =
        ProfileDetailsModel.fromJson(json.decode(response.body));
    return dataSummary;
  }

  ///Api Service for approve booking request
  Future<APIStandardReturnFormat> approveBookingRequest(String id) async {
    final String? token = UserSingleton.instance.user.token;

    final http.Response response = await http.post(
      Uri.parse(
          '$apiBaseMode$apiBaseUrl/api/v1/booking-requests/approve-request/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  ///Api Service for reject booking request
  Future<APIStandardReturnFormat> rejectBookingRequest(String id) async {
    final String? token = UserSingleton.instance.user.token;

    final http.Response response = await http.post(
      Uri.parse(
          '$apiBaseMode$apiBaseUrl/api/v1/booking-requests/reject-request/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  ///API Service for Retrieving Settings Availability
  Future<SettingsAvailabilityModel> getSettingsAvailability() async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final date = DateTime.now();
    final formattedDate = DateTime(date.year, date.month, date.day + 1);

    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint(
        'DATA ${Uri.http(apiBaseUrl, '/api/v1/user-availability', queryParameters)}');
    debugPrint('params R$queryParameters');
    final http.Response response = await http.get(
        Uri.http(apiBaseUrl, '/api/v1/user-availability', queryParameters),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final dynamic jsonData = jsonDecode(response.body);
    if (jsonData.length > 0) {}
    print(response.request!.url);
    print('tata: $jsonData');
    if (jsonData.length > 0) {
      print('naay sulod nga data');
      return SettingsAvailabilityModel.fromJson(jsonData[0]);
    } else {
      final http.Response res = await http.post(
        Uri.http(apiBaseUrl, '/api/v1/user-availability'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'user_id': userId,
          'is_available': true,
          'reason': '',
          'return_date': DateFormat('dd MMMM yyyy').format(formattedDate),
        }),
      );
      final dynamic newData = jsonDecode(res.body);
      print(res.request!.url);
      print('create tata: $newData');
      return SettingsAvailabilityModel.fromJson(newData);
    }
  }

  ///API Service for Updating Settings Availability
  Future<dynamic> updateSettingsAvailability(
      bool _isActive, String reason, DateTime _selDate, String id) async {
    print('body update $_isActive - $reason - $_selDate - $id');
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint('DATA ${Uri.http(apiBaseUrl, '/api/v1/user-availability/$id')}');
    debugPrint('params R$queryParameters');

    final date = DateTime.now();
    final formattedDate = DateTime(date.year, date.month, date.day + 1);

    final http.Response response = await http.patch(
      Uri.http(apiBaseUrl, '/api/v1/user-availability/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'is_available': _isActive,
        'reason': reason,
        'return_date': DateFormat('dd MMMM yyyy').format(_selDate),
      }),
    );

    final dynamic jsonData = jsonDecode(response.body);
    print(response.request!.url);
    print('update tata: $jsonData');
    return SettingsAvailabilityModel.fromJson(jsonData);
  }

  /// API service for all badges
  Future<List<ActivityModel>> getAllBadgesInBecomeAguide() async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.badgesUrl}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final dynamic jsonData = jsonDecode(response.body);
    print(jsonData);
    final List<ActivityModel> badges = <ActivityModel>[];
    final List<ActivityModel> badge =
        (jsonData as List).map((i) => ActivityModel.fromJson(i)).toList();
    badges.addAll(badge);
    return badges;
  }

  ///API Service for Creating Become A Guide Request
  Future<dynamic> createBecomeAGuideRequest() async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint('DATA ${Uri.http(apiBaseUrl, '/api/v1/user-availability/')}');
    debugPrint('params R$queryParameters');

    final date = DateTime.now();
    final formattedDate = DateTime(date.year, date.month, date.day + 1);

    final http.Response response = await http.post(
      Uri.http(apiBaseUrl, '/api/v1/user-guide-request/'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        // 'is_available': _isActive,
        // 'reason': reason,
        // 'return_date': DateFormat('dd MMMM yyyy').format(_selDate),
      }),
    );

    final dynamic jsonData = jsonDecode(response.body);
    print(response.request!.url);
    print('update tata: $jsonData');
    return SettingsAvailabilityModel.fromJson(jsonData);
  }

  ///API Service for Retrieving BecomeAGuideRequest
  Future<dynamic> getBecomeAGuideRequest() async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint(
        'DATA ${Uri.http(apiBaseUrl, '/api/v1/user-guide-request', queryParameters)}');
    debugPrint('params R$queryParameters');
    final http.Response response = await http.get(
        Uri.http(apiBaseUrl, '/api/v1/user-guide-request', queryParameters),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final dynamic jsonData = jsonDecode(response.body);
    print(response.request!.url);
    print('tata response get become a guide request: $jsonData');
    if (jsonData.length > 0) {
      return BecomeAGudeModel.fromJson(jsonData[0]);
    } else {
      return BecomeAGudeModel();
    }
  }

  /// API service for event image model
  Future<ActivityEventDestination> getEventDestinationDetails(String id) async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.eventDestination}?s={"activity_event_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<ActivityEventDestinationDetailsModel> details =
        <ActivityEventDestinationDetailsModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final ActivityEventDestinationDetailsModel eventDestinationModel =
          ActivityEventDestinationDetailsModel.fromJson(data);
      details.add(eventDestinationModel);
    }

    return ActivityEventDestination(activityEventDestinationDetails: details);
  }

  /// API service for event image model
  Future<EventImageModelData> getEventDestinationImage(String id) async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getEventImage}?s={"activity_event_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<EventImageDetailsModel> details = <EventImageDetailsModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final EventImageDetailsModel imageModel =
          EventImageDetailsModel.fromJson(data);
      details.add(imageModel);
    }

    return EventImageModelData(eventImageDetails: details);
  }

  /// API service for outfitter image model
  Future<EventDestinationImageModel> getEventDestinationImageData(
      String id) async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.eventDestinationImage}?s={"activity_event_destination_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<EventImageDestinationDetails> details =
        <EventImageDestinationDetails>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final EventImageDestinationDetails eventImageDestination =
          EventImageDestinationDetails.fromJson(data);
      details.add(eventImageDestination);
    }

    return EventDestinationImageModel(eventDestinationImageDetails: details);
  }

  ///Api service for saving payment transaction
  Future<PaymentTransactionModel> savePaymentTransaction(
      PaymentTransactionModel params) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.post(
        Uri.parse(
            '$apiBaseMode$apiBaseUrl/${AppAPIPath.paymentTransactionUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId.toString(),
          'transaction_number': params.transactionNumber,
          'payment_method': params.paymentMethod,
          'service_name': params.serviceName,
          'amount': params.amount,
          'type': params.type,
        }));

    final jsonData = jsonDecode(response.body);
    PaymentTransactionModel paymentTransaction = PaymentTransactionModel();
    if (response.statusCode == 201) {
      debugPrint('DATA payment $jsonData');
      paymentTransaction = PaymentTransactionModel.fromJson(jsonData);
    }

    return paymentTransaction;
  }

  /// API service payment transaction lists
  Future<List<PaymentTransactionModel>> getPaymentTransactions() async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;
    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    final http.Response response = await http.get(
        Uri.http(apiBaseUrl, '/${AppAPIPath.paymentTransactionUrl}',
            queryParameters),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final List<PaymentTransactionModel> paymentTransactions =
        <PaymentTransactionModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final PaymentTransactionModel _paymentTransaction =
          PaymentTransactionModel.fromJson(data);
      paymentTransactions.add(_paymentTransaction);
    }

    return paymentTransactions;
  }

  ///Api services for notifications
  Future<List<NotificationModel>> getNotifications() async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;
    final Map<String, String> queryParameters = {
      'filter': 'to_user_id||eq||"$userId"',
    };

    final http.Response response = await http.get(
        Uri.http(
            apiBaseUrl, '/${AppAPIPath.notificationsUrl}', queryParameters),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final List<NotificationModel> notifications = <NotificationModel>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final NotificationModel _notification = NotificationModel.fromJson(data);
      notifications.add(_notification);
    }

    return notifications;
  }

  /// Api service to send Notification
  Future<NotificationModel> sendNotification(NotificationModel params) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    debugPrint(
        'Params: ${params.bookingRequestId} ${params.toUserId} ${params.title} ${params.type}');

    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.notificationsUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'from_user_id': userId.toString(),
          'to_user_id': params.toUserId!,
          'title': params.title!,
          'type': params.type!,
          'notification_msg': params.notificationMsg!,
          'booking_request_id': params.bookingRequestId!,
          'transaction_no': params.transactionNo!
        }));

    final jsonData = jsonDecode(response.body);
    NotificationModel _notification = NotificationModel();

    debugPrint('DATA notification $jsonData ${response.statusCode}');
    if (response.statusCode == 201) {
      _notification = NotificationModel.fromJson(jsonData);
    }

    return _notification;
  }

  ///Api services to get traveler notifications
  Future<List<NotificationModel>> getTravelerNotifications(
      String filter) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.get(
        Uri.http(apiBaseUrl,
            '/${AppAPIPath.notificationsUrl}/traveler/$userId/$filter'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final List<NotificationModel> notifications = <NotificationModel>[];

    debugPrint('data ${response.body}');

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final NotificationModel _notification = NotificationModel.fromJson(data);
      notifications.add(_notification);
    }

    return notifications;
  }

  /// API service for NewsFeed Model
  Future<NewsFeedModel> getNewsFeedData() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.newsfeedList}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    /// seeding for data summary
    final NewsFeedModel dataSummary =
        NewsFeedModel.fromJson(json.decode(response.body));

    return NewsFeedModel(newsfeedDetails: dataSummary.newsfeedDetails);
  }

  /// API service for outfitter image model
  Future<NewsfeedImageModel> getNewsfeedImageData(String id) async {
    final dynamic response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.newsfeedImage}?s={"activity_newsfeed_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final List<NewsfeedImageDetails> details = <NewsfeedImageDetails>[];

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final NewsfeedImageDetails eventImageDestination =
          NewsfeedImageDetails.fromJson(data);
      details.add(eventImageDestination);
    }

    return NewsfeedImageModel(newsfeedImageDetails: details);
  }

  /// API service for user list model
  Future<UserListModel> getUserListData() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/api/v1/users?page=1&limit=50'),
        // Uri.parse(
        //     '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.userTypeUrl}/tourist%20guide'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    // final dynamic jsonData = jsonDecode(response.body);

    // /// seeding for data summary
    // final UserListModel dataSummary =
    //     UserListModel.fromJson(jsonData['data']['value']);

    // return UserListModel(userDetails: dataSummary.userDetails);

    // final UserListModel dataSummary =
    //     UserListModel.fromJson(json.decode(response.body));

    // final List<UserDetailsModel> details = <UserDetailsModel>[];

    // final Map<String, dynamic> jsonData = jsonDecode(response.body);
    // final List<dynamic> res = jsonData['data'];

    // for (final dynamic data in res) {
    //   final UserDetailsModel user = UserDetailsModel.fromJson(data);
    //   details.add(user);
    // }

    final UserListModel dataSummary =
        UserListModel.fromJson(json.decode(response.body));

    return UserListModel(userDetails: dataSummary.userDetails);
  }

  ///Api services for certificates
  Future<List<Certificate>> getCertificates(String userId) async {
    final String? token = UserSingleton.instance.user.token;
    // final String? userId = UserSingleton.instance.user.user?.id;
    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
    };

    debugPrint(
        'URL: ${Uri.http(apiBaseUrl, '/${AppAPIPath.certificatesUrl}', queryParameters)}');
    final List<Certificate> certificates = <Certificate>[];

    final http.Response response = await http.get(
        Uri.http(apiBaseUrl, '/${AppAPIPath.certificatesUrl}', queryParameters),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    final List<dynamic> res = jsonDecode(response.body);
    for (final dynamic data in res) {
      final Certificate _certificate = Certificate.fromJson(data);
      certificates.add(_certificate);
    }

    return certificates;
  }

  ///api service to add certificate
  Future<Certificate> addCertificate(Certificate params) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    debugPrint('Params: ${params.certificateName} ');

    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.certificatesUrl}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId.toString(),
          'certificate_name': params.certificateName!,
          'certificate_description': params.certificateDescription!,
          'certificate_photo_firebase_url': params.certificatePhotoFirebaseUrl!,
        }));

    final jsonData = jsonDecode(response.body);
    Certificate _certificate = Certificate();

    debugPrint('DATA add certificate $jsonData ${response.statusCode}');
    if (response.statusCode == 201) {
      _certificate = Certificate.fromJson(jsonData);
    }

    return _certificate;
  }

  /// API service for delete Certificate
  Future<http.Response> deleteCertificate(String id) async {
    final String? token = UserSingleton.instance.user.token;
    final http.Response response = await http.delete(
      Uri.parse('$apiBaseMode$apiBaseUrl/${AppAPIPath.certificatesUrl}/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return response;
  }

  ///api service to update certificate
  Future<Certificate> updateCertificate(Certificate params) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    debugPrint('Params: ${params.certificateName} ');

    final http.Response response = await http.patch(
        Uri.parse(
            '$apiBaseMode$apiBaseUrl/${AppAPIPath.certificatesUrl}/${params.id}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'certificate_name': params.certificateName!,
          'certificate_description': params.certificateDescription!,
          'certificate_photo_firebase_url': params.certificatePhotoFirebaseUrl!,
        }));

    final jsonData = jsonDecode(response.body);
    Certificate _certificate = Certificate();

    debugPrint('DATA Edit certificate $jsonData ${response.statusCode}');
    if (response.statusCode == 200) {
      _certificate = Certificate.fromJson(jsonData);
    }

    return _certificate;
  }

  /// API for getting the wishlist data
  Future<WishlistActivityModel> getWishlistActivityData() async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.wishlistUrl}?s={"user_id": \"${UserSingleton.instance.user.user!.id}\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final WishlistActivityModel dataSummary =
        WishlistActivityModel.fromJson(json.decode(response.body));

    return WishlistActivityModel(
        wishlistActivityDetails: dataSummary.wishlistActivityDetails);
  }

  /// API for getting the wishlist data
  Future<void> addActivityToWishlist(String activityPackageId) async {
    final String? userId = UserSingleton.instance.user.user?.id;
    final http.Response response = await http.post(
      Uri.parse(
          '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.wishlistUrl}'),
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${UserSingleton.instance.user.token}',
      },
      body: jsonEncode({
        'user_id': userId,
        'activity_package_id': activityPackageId
      }),
    );
  }

  /// API service for advertisement model
  Future<PackageModelData> getPackageDataById(String activityPackageid) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesUrl}?s={"id":\"$activityPackageid\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    /// seeding for data summary
    final PackageModelData dataSummary =
        PackageModelData.fromJson(json.decode(response.body));

    return PackageModelData(packageDetails: dataSummary.packageDetails);
  }

  /// API for getting the wishlist data
  Future<WishlistActivityModel> getWishlistActivityByPackageId(
      String id) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.wishlistUrl}?s={"activity_package_id": \"$id\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    final WishlistActivityModel dataSummary =
        WishlistActivityModel.fromJson(json.decode(response.body));

    return WishlistActivityModel(
        wishlistActivityDetails: dataSummary.wishlistActivityDetails);
  }

  ///Api Service for update password
  Future<APIStandardReturnFormat> updatePassword(dynamic parameters) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.patch(
        Uri.parse(
            '$apiBaseMode$apiBaseUrl/${AppAPIPath.getProfileDetails}/newpassword/$userId'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'content-type': 'application/json'
        },
        body: jsonEncode(parameters));

    return GlobalAPIServices().formatResponseToStandardFormat(response);
  }

  /// API service for advertisement model
  Future<PackageModelData> getPackageDataByUserId(String userId) async {
    final http.Response response = await http.get(
        Uri.parse(
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityPackagesUrl}?s={"user_id": \"$userId\"}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}',
        });

    /// seeding for data summary
    final PackageModelData dataSummary =
        PackageModelData.fromJson(json.decode(response.body));

    return PackageModelData(packageDetails: dataSummary.packageDetails);
  }

  /// API service for guide packages
  Future<List<ActivityPackage>> getGuidePackages(String userId) async {
    final Map<String, String> queryParameters = {
      'filter': 'user_id||eq||"$userId"',
      'sort': 'created_date,DESC'
    };

    final http.Response response = await http.get(
        Uri.http(
            apiBaseUrl, '/${AppAPIPath.activityPackagesUrl}', queryParameters),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${UserSingleton.instance.user.token}'
        });

    final dynamic jsonData = jsonDecode(response.body);
    print(jsonData);
    final List<ActivityPackage> activityPackages = <ActivityPackage>[];
    final List<ActivityPackage> activityPackage =
        (jsonData as List).map((i) => ActivityPackage.fromJson(i)).toList();
    activityPackages.addAll(activityPackage);
    return activityPackages;
  }
}
