import 'package:flutter/material.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/home.dart';

/// Settings items data generator
class EventUtils {
  static List<HomeModel> getMockEventFeatures() {
    return [
      HomeModel(
        featureName: 'Roving on Blue Sea',
        featureImageUrl: 'assets/images/png/event1.png',
        featureStarRating: 4.9,
        featureFee: 200,
        featureNumberOfTourists: 5,
        dateRange: '1-9',
        path: AssetsPath.paddle
      ),
      HomeModel(
        featureName: 'Fishing on Blue Tank',
        featureImageUrl: 'assets/images/png/event2.png',
        featureStarRating: 4.9,
        featureFee: 100,
        featureNumberOfTourists: 2,
        dateRange: '1-9',
        path: AssetsPath.fishing
      ),
      HomeModel(
        featureName: 'Forest of Fireflies',
        featureImageUrl: 'assets/images/png/event3.png',
        featureStarRating: 2,
        featureFee: 500,
        featureNumberOfTourists: 100,
        dateRange: '5-9',
        path: AssetsPath.hiking
      ),
    ];
  }
}
