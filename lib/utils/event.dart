import 'package:flutter/material.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/discovery_hub.dart';
import 'package:guided/models/home.dart';
import 'package:guided/models/hub_outfitter.dart';

/// Settings items data generator
class EventUtils {
  static List<HomeModel> getMockEventFeatures() {
    return [
      HomeModel(
          featureName: 'Rowing on Blue Lake.',
          featureImageUrl: 'assets/images/png/event1.png',
          featureStarRating: 4.9,
          featureFee: 200,
          featureNumberOfTourists: 5,
          dateRange: '1-9',
          path: AssetsPath.paddle),
      HomeModel(
          featureName: 'Fishing on Blue Tank',
          featureImageUrl: 'assets/images/png/event2.png',
          featureStarRating: 4.9,
          featureFee: 100,
          featureNumberOfTourists: 2,
          dateRange: '1-9',
          path: AssetsPath.fishing),
      HomeModel(
          featureName: 'Forest of Fireflies',
          featureImageUrl: 'assets/images/png/event3.png',
          featureStarRating: 2,
          featureFee: 500,
          featureNumberOfTourists: 100,
          dateRange: '5-9',
          path: AssetsPath.hiking),
    ];
  }

  static List<DiscoveryHub> getMockDiscoveryHubFeatures() {
    return [
      DiscoveryHub(
        id: 0,
        title: 'Flower Planting',
        description:
            'On Saturday April 23rd, Stanley Park Ecology Community is celebrating Earth Day! Come volunteer to help the Stanley Park ecosystem by managing and planting different flowers. You will learn about local ecology and conservation issues, and make an important contribution to habitat conservation and restoration in Stanley Park. Register here.',
        date: '21/10/2021',
        path: AssetsPath.discoveryTree,
        img1: 'assets/images/jpg/tree_planting_1.jpg',
        img2: 'assets/images/jpg/tree_planting_2.jpeg',
        img3: 'assets/images/jpg/tree_planting_3.png',
      ),
      DiscoveryHub(
        id: 1,
        title: 'Saving The Moose',
        description:
            'Moose in Minnesota need help. Their numbers have dropped by 60 percent in less than a decade. On May 2, Maple park rangers are releasing 4 captive moose that was illegally taken from the park ecosystem. Register here to join this event.',
        date: '21/10/2021',
        path: AssetsPath.discovery,
        img1: 'assets/images/jpg/save_moose_1.jpeg',
        img2: 'assets/images/jpg/save_moose_2.jpeg',
        img3: 'assets/images/jpg/save_moose_3.jpeg',
      ),
      DiscoveryHub(
        id: 2,
        title: 'Save The Bears',
        description:
            'Join us for a fun and fabulous gourmet tour of the Swan Valley! Funds raised will help care for rescued bears in our sanctuaries. Be there on Sunday, 3rd of April 2022 at Burswood Train Station at 10am.',
        date: '21/10/2021',
        path: AssetsPath.discoveryTree,
        img1: 'assets/images/jpg/save_bears_1.jpeg',
        img2: 'assets/images/jpg/save_bears_2.png',
        img3: 'assets/images/jpg/save_bears_3.jpeg',
      ),
      DiscoveryHub(
        id: 3,
        title: 'New Gopro Camera',
        description:
            'GoPro Hero12 will be released on May 10 at Canada Games Park. Be there at 4PM to see and experience the latest and most advance Gopro Camera.',
        date: '21/10/2021',
        path: '',
        img1: 'assets/images/jpg/go_pro_1.jpeg',
        img2: 'assets/images/jpg/go_pro_2.png',
        img3: 'assets/images/jpg/go_pro_3.jpeg',
      ),
      DiscoveryHub(
        id: 4,
        title: 'Camp Night',
        description:
            'From spooky to silly, a well-told campfire story will entertain your campers for hours. Eerie flashlight effects are optional. Join us to this weekend event with your kids and experience a fun night of story telling and camping activities.',
        date: '21/10/2021',
        path: AssetsPath.discoveryTree,
        img1: 'assets/images/jpg/camp_night_1.jpeg',
        img2: 'assets/images/jpg/camp_night_2.jpeg',
        img3: 'assets/images/jpg/camp_night_3.jpeg',
      ),
    ];
  }


  static List<HubOutfitter> getMockHubOutfitterFeatures() {
    return [
      HubOutfitter(
        id: 0,
        title: 'Travel Vest',
        description:
            'Our signature style will keep you safe &  organized. You\'ll fit all your essentials with room to spare. Whether you\'re on a trip around the world or a trip to the grocery store, you\'ll be comfortable thanks to the breathable, lightweight fabric of our best-selling travel vest.',
        date: '21/10/2021',
        price: '45',
        img1: 'assets/images/jpg/sample_1.jpg',
        img2: 'assets/images/jpg/sample_2.jpg',
        img3: 'assets/images/jpg/sample_3.jpg',
      ),
      HubOutfitter(
        id: 1,
        title: 'Hiking Shoes',
        description:
            'Hiking shoes can be a big investment, so finding a durable pair will help you get the most bang for your buck. Traditional leather shoes are almost always going to be more durable than lightweight trail runners.',
        date: '21/10/2021',
        price: '63',
        img1: 'assets/images/jpg/hiking_shoes_1.jpg',
        img2: 'assets/images/jpg/hiking_shoes_2.jpg',
        img3: 'assets/images/jpg/hiking_shoes_3.jpg',
      ),
      HubOutfitter(
        id: 2,
        title: 'Hiking Hat',
        description:
            'Fishing Sun Boonie Hat Wide Brim Outdoor Hiking Safari Summer Hunting Hat UV Protection Sun Cap',
        date: '21/10/2021',
        price: '20',
        img1: 'assets/images/jpg/hiking_hat_1.png',
        img2: 'assets/images/jpg/hiking_hat_2.jpeg',
        img3: 'assets/images/jpg/hiking_hat_3.jpeg',
      ),
    ];
  }
}
