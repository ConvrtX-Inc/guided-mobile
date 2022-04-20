import 'package:flutter/material.dart';
import 'package:guided/models/requests.dart';

/// Requests screen items data generator
class RequestsScreenUtils {
  /// generate mock data
  static List<RequestsScreenModel> getMockedDataRequestsScreen() {
    return <RequestsScreenModel>[
      RequestsScreenModel(
          id: 1,
          name: 'Ann Sasha',
          status: 'Pending',
          imgUrl: 'assets/images/profile-photos-2.png'),
      RequestsScreenModel(
          id: 2,
          name: 'David Bill',
          status: 'Pending',
          imgUrl: 'assets/images/customer-2.png'),
    ];
  }
}
