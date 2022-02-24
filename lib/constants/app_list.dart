import 'package:guided/models/badgesModel.dart';
import 'package:guided/models/faq.dart';

/// Class for app constant list
class AppListConstants {
  /// Constructor
  AppListConstants();

  /// use in message filter screen
  static List<String> filterList = <String>[
    'All',
    'Unread',
    'Spam',
    'Sent',
    'Archive'
  ];

  /// use in message offer screen
  static List<String> packages = <String>['Basic', 'Premium'];

  /// Returns number of people list use in message offer screen
  static List<String> people = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  /// use in FAQ  screen
  static List<FaqModel> faqDummyContent = [
    FaqModel(1, 'Sample question 1',
        'Lorem ipsum1 dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. '),
    FaqModel(2, 'Sample question 2',
        'Lorem ipsum2 dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. '),
    FaqModel(3, 'Sample question 3',
        'Lorem ipsum3 dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. '),
    FaqModel(4, 'Sample question 4',
        'Lorem ipsum4 dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. '),
  ];

  /// Returns number of currency list use in message offer screen
  static List<String> currency = <String>['CAD', 'USD'];

  /// use in badge model screen
  static List<BadgesModel> badges = [
    BadgesModel(1, 'Camping', 'assets/images/badge-Camping.png'),
    BadgesModel(2, 'Fishing', 'assets/images/badge-Fishing.png'),
    BadgesModel(3, 'Eco Tour', 'assets/images/badge-Eco.png'),
    BadgesModel(4, 'Hunt', 'assets/images/badge-Hunt.png'),
    BadgesModel(5, 'Hiking', 'assets/images/badge-Hiking.png'),
    BadgesModel(6, 'Retreat', 'assets/images/badge-Retreat.png'),
    BadgesModel(7, 'Discovery', 'assets/images/badge-Discovery.png'),
    BadgesModel(8, 'Paddle Spot', 'assets/images/badge-PaddleSpot.png'),
    BadgesModel(9, 'Outfitter', 'assets/images/badge-Outfitter.png'),
    BadgesModel(10, 'Motor', 'assets/images/badge-Motor.png'),
  ];

  /// Sample only
  static List<dynamic> timeList = [
    ['7:00 - 8:00 AM', true],
    ['9:00 - 10:00 AM', false],
    ['11:00 - 12:00 PM', false],
    ['12:00 - 1:00 PM', false],
    ['2:00 - 3:00 PM', false],
    ['4:00 - 5:00 PM', false],
    ['6:00 - 7:00 PM', false],
  ];

  /// [<Month>, <# of Customer>, <hasScheduled>, <isSelected>]
  static List<dynamic> monthList = [
    ['January', '', false, false],
    ['February', '', false, false],
    ['March', '', false, false],
    ['April', '2', true, true],
    ['May', '1', true, false],
    ['June', '', false, false],
    ['July', '', false, false],
    ['August', '', false, false],
    ['September', '', false, false],
    ['October', '', false, false],
    ['November', '', false, false],
    ['December', '', false, false],
  ];

  static List<dynamic> timeList_ = <dynamic>[
    '7:00 - 8:00 AM',
    '9:00 - 10:00 AM',
    '11:00 - 12:00 PM',
    '12:00 - 1:00 PM',
    '2:00 - 3:00 PM',
    '4:00 - 5:00 PM',
    '6:00 - 7:00 PM',
  ];

  /// sample list of card for payment manage card
  static List<String> cardImage = <String>[
    'sampleCard',
    'sampleCard',
    'sampleCard',
  ];

}
