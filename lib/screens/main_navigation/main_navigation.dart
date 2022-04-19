import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/bottom_navigation_bar.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/screens/main_navigation/content/content_main.dart';
import 'package:guided/screens/main_navigation/home/screens/home_main.dart';
import 'package:guided/screens/main_navigation/settings/screens/settings_main.dart';
import 'package:guided/screens/message/message_inbox.dart';
import 'package:guided/screens/requests/ui/requests_screen.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Screen for home
class MainNavigationScreen extends StatefulWidget {
  /// Navigation Index
  final int navIndex;

  /// Content Index
  final int contentIndex;

  /// Constructor
  const MainNavigationScreen(
      {Key? key, required this.navIndex, required this.contentIndex})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(navIndex, contentIndex);
}

class _HomeScreenState extends State<MainNavigationScreen>
    with AutomaticKeepAliveClientMixin<MainNavigationScreen> {
  @override
  bool get wantKeepAlive => true;
  int _selectedIndex = 0;
  int _selectedContent = 0;

  int navIndex;
  int contentIndex;

  _HomeScreenState(this.navIndex, this.contentIndex);
  final CardController  _creditCardController  = Get.put(CardController());


  void setBottomNavigationIndexHandler(int value) {
    setState(() {
      _selectedIndex = value;
      _selectedContent = contentIndex;
    });
  }

  @override
  void initState() {
    setState(() {
      _selectedIndex = navIndex;
      _selectedContent = contentIndex;
    });
    super.initState();

    getUserCards();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late final List<Widget> _mainNavigationWidgetOptions = <Widget>[
    const HomeScreen(),
    MainContent(initIndex: _selectedContent),
    const RequestsScreen(),
    const MessageInbox(),
    SettingsMain(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        // body: _mainNavigationWidgetOptions.elementAt(_selectedIndex),
        body: IndexedStack(
          index: _selectedIndex,
          children: _mainNavigationWidgetOptions,
        ),
        bottomNavigationBar: GuidedBottomNavigationBar(
            selectedIndex: _selectedIndex,
            setBottomNavigationIndex: setBottomNavigationIndexHandler));
  }

  Future<void> getUserCards() async {
    final List<CardModel> cards = await APIServices().getCards();
    await _creditCardController.initCards(cards);

    if (cards.isNotEmpty) {
      debugPrint('cards $cards');
      final CardModel card = cards.firstWhere(
              (CardModel c) => c.isDefault == true,
          orElse: () => CardModel());

      if (card.id != '') {
        _creditCardController.setDefaultCard(card);
      } else {
        _creditCardController.setDefaultCard(cards[0]);
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('navIndex', navIndex));
    properties.add(IntProperty('contentIndex', contentIndex));
  }
}
