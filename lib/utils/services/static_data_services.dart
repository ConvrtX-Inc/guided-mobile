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
          id: 'd54b5cc7-ef50-496b-a01b-0b18a7fdcd3b',
          name: 'Camping',
          path: 'assets/images/png/activity_icon5.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity3.png'),
      Activity(
          id: 'c2d31a67-9ad5-477e-bcb2-465710777525',
          name: 'Hiking',
          path: 'assets/images/png/activity_icon6.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/hiking.jpg'),
      Activity(
          id: '11bbd0ab-9a5a-4a60-9d79-698ac8933084',
          name: 'Hunt',
          path: 'assets/images/png/activity_icon0.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: 'cd434cbb-9f93-4c98-a84d-249c76d85282',
          name: 'Fishing',
          path: 'assets/images/png/activity_icon7.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/fishing.jpg'),
      Activity(
          id: 'd283aa50-dccf-4b76-a254-a402c37abebf',
          name: 'ECO Tour',
          path: 'assets/images/png/activity_icon2.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/eco_tour.jpg'),
      Activity(
          id: 'dc777b8a-de31-413e-b5c1-9fc2a72df353',
          name: 'Retreat',
          path: 'assets/images/png/activity_icon3.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/jpg/retreat.jpg'),
      Activity(
          id: 'a74618c0-8b12-4d3d-98a1-f62df5ed2513',
          name: 'Paddle Spot',
          path: 'assets/images/png/activity_icon4.png',
          distance: '4.5 hours drive',
          featureImage: 'assets/images/png/activity2.png'),
      Activity(
          id: '19eeab58-762c-400e-ba26-4fdc02b43a20',
          name: 'Discovery',
          path: 'assets/images/png/activity_icon1.png',
          distance: '3.5 hours drive',
          featureImage: 'assets/images/png/activity1.png'),
      Activity(
          id: 'fb65f344-5d04-4c90-baac-3a7bf5fc6702',
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
