import 'package:flutter/material.dart';
import 'package:guided/models/home.dart';

/// Settings items data generator
class HomeUtils {
  static List<HomeModel> getMockFeatures() {
    return [
      HomeModel(
        featureName: 'Tour to India',
        featureImageUrl: 'https://random.imagecdn.app/270/202',
        featureStarRating: 3.2,
        featureFee: 200,
        featureNumberOfTourists: 5,
      ),
      HomeModel(
        featureName: 'Cebu is my province',
        featureImageUrl: 'https://random.imagecdn.app/270/202',
        featureStarRating: 5.0,
        featureFee: 100,
        featureNumberOfTourists: 2,
      ),
      HomeModel(
        featureName: 'Welcome to Philippines',
        featureImageUrl: 'https://random.imagecdn.app/270/202',
        featureStarRating: 2,
        featureFee: 500,
        featureNumberOfTourists: 100,
      ),
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
}
