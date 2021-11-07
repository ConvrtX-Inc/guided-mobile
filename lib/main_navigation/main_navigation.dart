import 'package:flutter/material.dart';
import 'package:guided/common/widgets/bottom_navigation_bar.dart';
import 'package:guided/main_navigation/home/screens/home_main.dart';
import 'package:guided/main_navigation/settings/screens/settings_main.dart';

/// Screen for home
class MainNavigationScreen extends StatefulWidget {
  /// Constructor
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void setBottomNavigationIndexHandler(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _mainNavigationWidgetOptions = <Widget>[
    const HomeScreen(),
    const Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    const Text(
      'Index 2: School',
      style: optionStyle,
    ),
    const Text(
      'Index 3: Mall',
      style: optionStyle,
    ),
    SettingsMain(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _mainNavigationWidgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: GuidedBottomNavigationBar(
            selectedIndex: _selectedIndex,
            setBottomNavigationIndex: setBottomNavigationIndexHandler));
  }
}
