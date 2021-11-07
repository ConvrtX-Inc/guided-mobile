import 'package:flutter/material.dart';
import 'package:guided/models/requests.dart';

/// Requests screen items data generator
class RequestsScreenUtils {
  /// generate mock data
  static List<RequestsScreenModel> getMockedDataRequestsScreen() {
    return <RequestsScreenModel>[
      RequestsScreenModel(
          id: 1,
          name: 'John Doe',
          status: 'Pending',
          imgUrl: 'assets/images/no_user.png'),
      RequestsScreenModel(
          id: 2,
          name: 'Jane Doe',
          status: 'Pending',
          imgUrl: 'assets/images/no_user.png'),
      RequestsScreenModel(
          id: 3,
          name: 'Peter Parker',
          status: 'Pending',
          imgUrl: 'assets/images/no_user.png'),
    ];
  }
}