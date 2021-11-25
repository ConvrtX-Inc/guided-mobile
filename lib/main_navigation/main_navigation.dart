import 'package:flutter/material.dart';
import 'package:guided/common/widgets/bottom_navigation_bar.dart';
import 'package:guided/main_navigation/home/screens/home_main.dart';
import 'package:guided/main_navigation/settings/screens/settings_main.dart';
import 'package:guided/main_navigation/content/content_main.dart';

/// Screen for home
class MainNavigationScreen extends StatefulWidget {
  final int navIndex;
  final int contentIndex;

  /// Constructor
  const MainNavigationScreen({Key? key, required this.navIndex, required this.contentIndex}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(navIndex, contentIndex);
}

class _HomeScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  int _selectedContent = 0;

  int navIndex;
  int contentIndex;

  _HomeScreenState(this.navIndex, this.contentIndex);

  void setBottomNavigationIndexHandler(int value) {
    setState(() {
      _selectedIndex = value;
      _selectedContent = contentIndex;
    });
  }

  @override
  void initState(){
    setState(() {
      _selectedIndex = navIndex;
      _selectedContent = contentIndex;
    });
    super.initState();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late final List<Widget> _mainNavigationWidgetOptions = <Widget>[
    const HomeScreen(),
    MainContent(initIndex: _selectedContent),
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
