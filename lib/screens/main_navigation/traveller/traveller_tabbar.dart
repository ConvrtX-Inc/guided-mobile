// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/controller/stripe_card_controller.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/stripe_card.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:guided/screens/main_navigation/traveller/nearby_activities/nearby_activities.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/popular_guides.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/tab_discovery_hub.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_home.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_inbox.dart';

import 'package:guided/screens/main_navigation/traveller/tabs/tab_map.dart';

import 'package:guided/screens/main_navigation/traveller/tabs/tab_settings_main.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_wishlist.dart';

import 'package:guided/screens/widgets/reusable_widgets/traveller_bottom_navigation.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/stripe_service.dart';
import 'package:guided/utils/services/user_subscription_service.dart';

///TravellerTabScreen
class TravellerTabScreen extends StatefulWidget {
  const TravellerTabScreen({Key? key}) : super(key: key);

  @override
  State<TravellerTabScreen> createState() => _TravellerTabScreenState();
}

class _TravellerTabScreenState extends State<TravellerTabScreen> {
  int _selectedIndex = 5;
  late Widget _selectedWidget;
  final CardController _creditCardController = Get.put(CardController());
  final UserSubscriptionController _userSubscriptionController =
      Get.put(UserSubscriptionController());

  final StripeCardController _stripeCardController =
      Get.put(StripeCardController());

  final UserProfileDetailsController _profileDetailsController =
  Get.put(UserProfileDetailsController());

  @override
  void initState() {
    _selectedWidget = TabHomeScreen(
      onItemPressed: popularGuideds,
    );
    super.initState();

    // getUserSubscription();
    /*if (_creditCardController.cards.isEmpty) {
      getUserCards();
    }*/

    getProfileDetails();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedWidget,
      bottomNavigationBar: TravellerBottomNavigation(
        itemIcons: const <String>[
          'assets/images/png/home_tab_icon.png',
          'assets/images/png/wish_tab_icon.png',
          'assets/images/png/inbox_tab_icon.png',
          'assets/images/png/profile_tab_icon.png',
        ],
        centerIcon: 'assets/images/png/map_tab_icon.png',
        centerIconSelected: 'assets/images/png/map_tab_selected_icon.png',
        selectedIndex: _selectedIndex,
        onItemPressed: onPressed,
        height: 89,
      ),
    );
  }

  void popularGuideds(String screen) {
    setState(() {
      // _selectedIndex = index;
      if (screen == 'guides') {
        _selectedIndex = 0;
        _selectedWidget = PopularGuides(
          onItemPressed: popularGuideds,
        );
      } else if (screen == 'nearbyActivities') {
        _selectedIndex = 0;
        _selectedWidget = NearbyActivitiesScreen(
          onItemPressed: popularGuideds,
        );
      } else {
        _selectedIndex = 0;
        _selectedWidget = TabHomeScreen(
          onItemPressed: popularGuideds,
        );
      }
    });
  }

  void onPressed(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _selectedWidget = const TabDiscoveryHub();
      } else if (index == 1) {
        _selectedWidget = const TabWishlistScreen(
          initIndex: 0,
        );
      } else if (index == 2) {
        _selectedWidget = const TabMapScreen();
      } else if (index == 3) {
        _selectedWidget = const TabInboxScreen();
      } else if (index == 4) {
        _selectedWidget = const TabSettingsMain();
      }
    });
  }



  Future<void> getProfileDetails() async {
    final ProfileDetailsModel res = await APIServices().getProfileData();

    final bool hasPremiumSubscription =
    await UserSubscriptionServices().hasUserSubscription();

    String paymentMethod = res.defaultPaymentMethod != ''
        ? res.defaultPaymentMethod
        : PaymentConfig.bankCard;

    UserSingleton.instance.user.user = User(
        id: res.id,
        email: res.email,
        fullName: res.fullName,
        stripeCustomerId: res.stripeCustomerId,
        firebaseProfilePicUrl: res.firebaseProfilePicUrl,
        defaultPaymentMethod: paymentMethod,
        hasPremiumSubscription: hasPremiumSubscription);

    _profileDetailsController.setUserProfileDetails(res);
    if(_stripeCardController.cards.isEmpty){
      await getCards();
    }

  }

  Future<void> getCards() async {
    final String customerId =
        UserSingleton.instance.user.user!.stripeCustomerId!;
    final List<StripeCardModel> result =
        await StripeServices().getCardList(customerId);

    await _stripeCardController.initCards(result);

    await getDefaultCard(customerId, result);
  }

  Future<void> getDefaultCard(
      String customerId, List<StripeCardModel> myCards) async {
    final String res = await StripeServices().getDefaultCard(customerId);

    final StripeCardModel card = myCards.firstWhere(
        (element) => element.id! == res,
        orElse: () => StripeCardModel());
    debugPrint('default CArd ${card.id!}');
    _stripeCardController.setDefaultCard(card);
  }
}

class TabNotificationScreen extends StatelessWidget {
  const TabNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Container(
                color: Colors.white,
                child: Image(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(AssetsPath.wishlistScreen),
                )),
          ],
        ),
      ),
    );
  }
}

class TabLocationScreen extends StatelessWidget {
  const TabLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Map Screen'));
  }
}

class TabMessagesScreen extends StatelessWidget {
  const TabMessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Messages Screen'));
  }
}

// class TabProfileScreen extends StatelessWidget {
//   const TabProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Profile Screen'));
//   }
// }
