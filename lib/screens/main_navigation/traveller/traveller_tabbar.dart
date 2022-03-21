// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/popular_guides.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/tab_discovery_hub.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_home.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_inbox.dart';

import 'package:guided/screens/main_navigation/traveller/tabs/tab_map.dart';

import 'package:guided/screens/main_navigation/traveller/tabs/tab_settings_main.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_wishlist.dart';

import 'package:guided/screens/widgets/reusable_widgets/traveller_bottom_navigation.dart';

///TravellerTabScreen
class TravellerTabScreen extends StatefulWidget {
  const TravellerTabScreen({Key? key}) : super(key: key);

  @override
  State<TravellerTabScreen> createState() => _TravellerTabScreenState();
}

class _TravellerTabScreenState extends State<TravellerTabScreen> {
  int _selectedIndex = 0;
  late Widget _selectedWidget;

  @override
  void initState() {
    _selectedWidget = TabHomeScreen(
      onItemPressed: popularGuideds,
    );
    super.initState();
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
      } else {
        _selectedIndex = 0;
        _selectedWidget = const TabDiscoveryHub();
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
