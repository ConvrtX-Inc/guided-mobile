// ignore_for_file: unnecessary_string_escapes, unnecessary_nullable_for_final_variable_declarations, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guided/constants/api_path.dart';

import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/activity_availability_hours.dart';
import 'package:guided/models/activity_availability_hours_model.dart';
import 'package:guided/models/activity_availability_model.dart';
import 'package:guided/models/activity_destination_model.dart';
import 'package:guided/models/activity_outfitter/activity_outfitter_model.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/advertisement_image_model.dart';
import 'package:guided/models/advertisement_model.dart';
import 'package:guided/models/badge.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/bank_account_model.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/chat_model.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/models/currencies_model.dart';
import 'package:guided/models/event_image_model.dart';
import 'package:guided/models/event_model.dart';
import 'package:guided/models/outfitter_image_model.dart';
import 'package:guided/models/outfitter_model.dart';
import 'package:guided/models/package_destination_image_model.dart';
import 'package:guided/models/package_destination_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/popular_guide.dart';
import 'package:guided/models/preset_form_model.dart';
import 'package:guided/models/profile_data_model.dart';

import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/profile_image.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:guided/models/user_terms_and_condition_model.dart';
import 'package:guided/models/user_transaction_model.dart';
import 'package:guided/utils/mixins/global_mixin.dart';

import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/global_api_service.dart';
import 'package:http/http.dart' as http;

import '../../models/booking_request.dart';

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
    final String url =
        '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getProfileDetails}/${UserSingleton.instance.user.user!.id}';
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
    final String url =
        '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.getBookingRequest}/$userId';
    debugPrint('URL $url');
    final http.Response response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${UserSingleton.instance.user.token}',
    });

    final dynamic jsonData = jsonDecode(response.body);
    final List<BookingRequest> bookingRequest = <BookingRequest>[];
    final booking =
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
    var tour_guide_id = UserSingleton.instance.user.user!.id;
    var statusName = "";
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
    var url = Uri.encodeFull(
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
        body: jsonEncode({
          'latitude': '$latitude',
          'longitude': '$longitude',
          'distance': '20'
        }),
        headers: headers);

    final dynamic jsonData = jsonDecode(response.body);
    print(response.request!.url);
    print(jsonData);
    print(jsonData['response']['data']['details']);
    final List<ActivityPackage> activityPackages = <ActivityPackage>[];
    final activityPackage = (jsonData['response']['data']['details'] as List)
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

    final dynamic jsonData = jsonDecode(response.body);

    final List<ActivityHourAvailability> activityHours =
        <ActivityHourAvailability>[];
    final activityHour = (jsonData as List)
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
    final badge =
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

    final List<User> popularGuides = <User>[];
    final activityPackage =
        (jsonData['data'] as List).map((i) => User.fromJson(i)).toList();

    final List<User> guides = activityPackage.where(
      (User element) {
        return element.isTraveller == false;
      },
    ).toList();
    print(guides.length);
    popularGuides.addAll(guides);

    return guides;
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
  Future<BankAccountModel> addBankAccount(BankAccountModel params) async {
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
      debugPrint('BAnk Response ${jsonData}');
      return BankAccountModel.fromJson(jsonData);
    } else {
      return BankAccountModel();
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
    final String? userId = UserSingleton.instance.user.user?.id;

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
    String id = '';
    if (type == 'terms_and_condition') {
      id = 'terms_and_condition_$userId';
    } else if (type == 'traveler_waiver_form') {
      id = 'traveler_waiver_form_$userId';
    } else if (type == 'cancellation_policy') {
      id = 'cancellation_policy_$userId';
    } else if (type == 'guided_payment_payout') {
      id = 'guided_payment_payout_$userId';
    } else if (type == 'local_laws') {
      id = 'local_laws_$userId';
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
      UserSubscription params) async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

    final http.Response response = await http.post(
        Uri.parse('$apiBaseMode$apiBaseUrl${AppAPIPath.userSubscription}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId.toString(),
          'name': params.name,
          'payment_reference_no': params.paymentReferenceNo,
          'start_date': params.startDate,
          'end_date': params.endDate,
          'message': params.message,
          'price': params.price
        }));

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
            '${AppAPIPath.apiBaseMode}${AppAPIPath.apiBaseUrl}/${AppAPIPath.activityEventUrl}'),
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
  Future<UserProfileImage> getUserProfileImages() async {
    final String? token = UserSingleton.instance.user.token;
    final String? userId = UserSingleton.instance.user.user?.id;

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
  Future<String> createStripeAccount(ProfileDetailsModel params) async {
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
        body: jsonEncode(<String, String>{
          'user_id': userId.toString(),
          'email': params.email,
          'country': 'CA',
          'company_name': params.fullName,
          'first_name': params.firstName,
          'last_name': params.lastName,
          'phone': params.phoneNumber,
          'product_description': 'Provide tour services'
        }));

    debugPrint('Response ${response.body}');

    return response.body;
  }

  /// API service for  stripe account link
  Future<String> getOnboardAccountLink(String accountId) async {
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
    final jsonData = jsonDecode(response.body);
    return jsonData['url'];
  }

  /// API service add bank account to stripe
  Future<String> addBankAccountToStripeAccount(
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
    final jsonData = jsonDecode(response.body);
    return jsonData['id'];
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
    return jsonData['paymentIntent'];
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
}
