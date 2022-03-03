//ignore_for_file: avoid_classes_with_only_static_members

import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/guide.dart';

/// Static data service
class StaticDataService {
  /// projects mock data
  static List<Activity> getActivityList() {
    return <Activity>[
      Activity(
          id: '1',
          name: 'Camping',
          path: AssetsPath.camping,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity3.png'),
      Activity(
          id: '2',
          name: 'Hiking',
          path: AssetsPath.hiking,
          distance: '4.5 hours drive',
          featureImage: 'assets/images/png/activity2.png'),
      Activity(
          id: '3',
          name: 'Hunt',
          path: AssetsPath.hunt,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: '4',
          name: 'Fishing',
          path: AssetsPath.fishing,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: '5',
          name: 'ECO Tour',
          path: AssetsPath.eco,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: '6',
          name: 'Retreat',
          path: AssetsPath.retreat,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: '7',
          name: 'Paddle spot',
          path: AssetsPath.paddle,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: '8',
          name: 'Discovery',
          path: AssetsPath.discovery,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: '9',
          name: 'Motor',
          path: AssetsPath.motor,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
    ];
  }

  /// returns guide list
  static List<Guide> getGuideList() {
    return <Guide>[
      Guide(
          id: '1',
          name: "St. John's, Newfoundland",
          path: AssetsPath.hiking,
          distance: '12 KM  distance',
          featureImage: 'assets/images/png/guide1.png'),
      Guide(
          id: '2',
          name: 'Ottawa, Ontario',
          path: AssetsPath.paddle,
          distance: '12 KM  distance',
          featureImage: 'assets/images/png/guide2.png'),
    ];
  }
}
