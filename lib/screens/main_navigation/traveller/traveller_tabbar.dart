// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/popular_guides.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_home.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/tab_map.dart';
import 'package:guided/screens/widgets/reusable_widgets/traveller_bottom_navigation.dart';

import 'tabs/tab_inbox.dart';

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
        _selectedWidget = TabHomeScreen(
          onItemPressed: popularGuideds,
        );
      } else if (index == 1) {
        _selectedWidget = const TabNotificationScreen();
      } else if (index == 2) {
        _selectedWidget = const TabMapScreen();
      } else if (index == 3) {
        _selectedWidget = const TabInboxScreen();
      } else if (index == 4) {
        _selectedWidget = const TabProfileScreen();
      }
    });
  }
}

class TabNotificationScreen extends StatelessWidget {
  const TabNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Wishlist Screen'));
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

class TabProfileScreen extends StatelessWidget {
  const TabProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Screen'));
  }
}
