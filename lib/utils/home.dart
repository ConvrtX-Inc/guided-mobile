import 'package:flutter/material.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/home.dart';
import 'package:guided/models/popular_guide_model.dart';

/// Settings items data generator
class HomeUtils {
  static List<HomeModel> getMockFeatures() {
    return [
      HomeModel(
          featureName: 'Tour to India',
          featureImageUrl: 'assets/images/png/package1.png',
          featureStarRating: 3.2,
          featureFee: 200,
          featureNumberOfTourists: 5,
          dateRange: '1-9',
          path: AssetsPath.hiking),
      HomeModel(
          featureName: 'Cebu is my province',
          featureImageUrl: 'assets/images/png/package2.png',
          featureStarRating: 5.0,
          featureFee: 100,
          featureNumberOfTourists: 2,
          dateRange: '11-19',
          path: AssetsPath.hiking),
      HomeModel(
          featureName: 'Welcome to Philippines',
          featureImageUrl: 'assets/images/png/package3.png',
          featureStarRating: 2,
          featureFee: 500,
          featureNumberOfTourists: 100,
          dateRange: '5-9',
          path: AssetsPath.hiking),
    ];
  }

  /// Mock function to get customer requests
  static List<HomeModel> getMockCustomerRequests() {
    return <HomeModel>[
      HomeModel(
        cRFirstName: 'Khaleesi',
        cRMiddleName: 'Encabo',
        cRLastName: 'Saromines',
        cRProfilePic:
            'https://shotkit.com/wp-content/uploads/2021/06/cool-profile-pic-matheus-ferrero.jpeg',
      ),
      HomeModel(
        cRFirstName: 'Mark Anthony',
        cRMiddleName: 'Encabo',
        cRLastName: 'Saromines',
        cRProfilePic:
            'https://i.pinimg.com/originals/37/70/a7/3770a70e8fc0b3823b79fc7e757b944a.jpg',
      ),
      HomeModel(
        cRFirstName: 'Yoni',
        cRMiddleName: 'Encabo',
        cRLastName: 'Saromines',
        cRProfilePic:
            'https://blog.photofeeler.com/wp-content/uploads/2017/09/tinder-photo-size-tinder-picture-size-tinder-aspect-ratio-image-dimensions-crop.jpg',
      ),
    ];
  }

  /// Mock function to get earnings
  static List<HomeModel> getMockEarnings() {
    return <HomeModel>[
      HomeModel(
        personalBalance: 780,
        pendingOrders: 200,
        totalEarnings: 2000,
      ),
    ];
  }

  /// Mock data for Popular Guides Near You!
  static List<PopularGuideModel> getPopularGuideNearYou() {
    return <PopularGuideModel>[
      PopularGuideModel(
        id: '0',
        name: 'John Mark',
        mainBadgeId: AssetsPath.hiking,
        location: "St. John's, Newfoundland, Canada",
        coverImg: AssetsPath.guide1,
        starRating: '0',
        profileImg: AssetsPath.pmessage3,
      ),
      PopularGuideModel(
          id: '1',
          name: 'Ethan Hunt',
          mainBadgeId: AssetsPath.hunt,
          location: 'Willboard Avenue, Newfoundland, Canada',
          coverImg: 'assets/images/png/activity1.png',
          starRating: '0',
          profileImg: 'assets/images/png/student_profile.png',
          isFirstAid: true),
      PopularGuideModel(
        id: '2',
        name: 'Jesika Ann',
        mainBadgeId: AssetsPath.hiking,
        location: "St. John's, Newfoundland, Canada",
        coverImg: 'assets/images/png/activity3.png',
        starRating: '0',
        profileImg: 'assets/images/png/pmessage1.png',
      ),
    ];
  }
}
