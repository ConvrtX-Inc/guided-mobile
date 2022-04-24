//ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/models/payment_mode.dart';
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

  /// projects mock data
  static List<Activity> getActivityForNearybyGuides() {
    return <Activity>[
      Activity(
          id: '764f32ae-7f8c-4d3c-b948-d7b93eaed436',
          name: 'Camping',
          path: 'assets/images/png/activity_icon5.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity3.png'),
      Activity(
          id: 'd39690d5-a692-49b8-bc30-610dfc4ca6b7',
          name: 'Hiking',
          path: 'assets/images/png/activity_icon6.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/hiking.jpg'),
      Activity(
          id: '97253245-07c1-47e8-9da6-2187e6a1c648',
          name: 'Hunt',
          path: 'assets/images/png/activity_icon0.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: 'b513f525-b84b-4420-8b10-f4c30236bcf3',
          name: 'Fishing',
          path: 'assets/images/png/activity_icon7.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/fishing.jpg'),
      Activity(
          id: 'd90ad697-91d1-4f8c-89f1-6382895242b0',
          name: 'ECO Tour',
          path: 'assets/images/png/activity_icon2.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/eco_tour.jpg'),
      Activity(
          id: '88b7631d-ca94-4777-a92b-020e80480914',
          name: 'Retreat',
          path: 'assets/images/png/activity_icon3.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/retreat.jpg'),
      Activity(
          id: 'f89b5ca2-2179-41d3-98ad-ee81b6762a03',
          name: 'Paddle Spot',
          path: 'assets/images/png/activity_icon4.png',
          distance: '4.5 hours drive',
          featureImage: 'assets/images/png/activity2.png'),
      Activity(
          id: 'd66ecb13-38ed-4f36-901d-e5c9db24651f',
          name: 'Discovery',
          path: 'assets/images/png/activity_icon1.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: '58bf3725-f77c-42c8-8da2-cfec49423b9f',
          name: 'Motor',
          path: 'assets/images/png/activity_icon9.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/sport_fishing.jpeg'),
    ];
  }

  /// returns tour list
  static List<Activity> getTourList() {
    return <Activity>[
      Activity(
          id: '1',
          name: 'Green Lake 4 Night Camp',
          path: AssetsPath.camping,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity3.png'),
      Activity(
          id: '2',
          name: 'Clear Lake Day Paddle',
          path: AssetsPath.paddle,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/hiking.jpg'),
      Activity(
          id: '3',
          name: 'Water Foul Hunt',
          path: AssetsPath.hunt,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: '4',
          name: 'River Fly Fishing',
          path: AssetsPath.fishing,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/fishing.jpg'),
      Activity(
          id: '5',
          name: 'Botanical Garden Tour',
          path: AssetsPath.eco,
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/eco_tour.jpg'),
      Activity(
          id: '6',
          name: 'Great Lakes Fishing',
          path: AssetsPath.fishing,
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
          featureImage: 'assets/images/png/pmessage3.png'),
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

  ///Get Payment Modes
  static List<PaymentMode> getPaymentModes() {
    return <PaymentMode>[
      PaymentMode(
          mode: 'Bank_Card',
          logo: 'assets/images/png/bank_card.png',
          isSelected: true),
      PaymentMode(
          mode: 'Google_Pay',
          logo: 'assets/images/png/google_wallet.png',
          isEnabled: Platform.isAndroid),
      PaymentMode(
          mode: 'Apple_Pay',
          logo: 'assets/images/png/wallet_app_icon.png',
          isEnabled: Platform.isIOS)
    ];
  }
}
