//ignore_for_file: avoid_classes_with_only_static_members

import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/models/wishlist_model.dart';

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
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/hiking.jpg'),
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
          featureImage: 'assets/images/jpg/fishing.jpg'),
      Activity(
          id: '5',
          name: 'ECO Tour',
          path: AssetsPath.eco,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/eco_tour.jpg'),
      Activity(
          id: '6',
          name: 'Retreat',
          path: AssetsPath.retreat,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/retreat.jpg'),
      Activity(
          id: '7',
          name: 'Paddle Spot',
          path: AssetsPath.paddle,
          distance: '4.5 hours drive',
          featureImage: 'assets/images/png/activity2.png'),
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
          featureImage: 'assets/images/jpg/sport_fishing.jpeg'),
    ];
  }

  /// returns guide list
  static List<Guide> getGuideList() {
    return <Guide>[
      Guide(
          id: '1',
          name: 'John Watson',
          path: AssetsPath.hiking,
          distance: '12 KM  distance',
          featureImage: 'assets/images/png/student_profile.png'),
      Guide(
          id: '2',
          name: 'Sasha Cruz',
          path: AssetsPath.paddle,
          distance: '12 KM  distance',
          featureImage: 'assets/images/png/guide2.png'),
    ];
  }

  static List<Wishlist> getWishListData() {
    return <Wishlist>[
      Wishlist(
        id: '1',
        title: 'St. John\'s, Newfoundland',
        reviewScore: '16',
        price: '50',
        packageCategory: AssetsPath.hunt,
        featureImage1: 'assets/images/png/activity3.png',
        featureImage2: 'assets/images/png/activity1.png',
        featureImage3: 'assets/images/png/activity2.png',
      ),
      Wishlist(
        id: '2',
        title: 'St. Paul\'s, Oldland',
        reviewScore: '19',
        price: '100',
        packageCategory: AssetsPath.paddle,
        featureImage1: 'assets/images/png/activity1.png',
        featureImage2: 'assets/images/png/activity2.png',
        featureImage3: 'assets/images/png/activity3.png',
      ),
    ];
  }
}
