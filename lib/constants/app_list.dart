import 'package:guided/models/badgesModel.dart';
import 'package:guided/models/faq.dart';
import 'package:guided/models/message.dart';

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

  /// generate mock data
  static List<Message> getMessages() {
    return <Message>[
      Message(
          id: 1,
          name: 'Ann Sasha',
          message: 'Hello, are we good for the hike at 2 pm?',
          imgUrl: 'assets/images/png/pmessage1.png'),
      Message(
          id: 2,
          name: 'Mark Henrry',
          message: "Sounds like fun, can't wait to get out on the lake",
          imgUrl: 'assets/images/png/pmessage2.png'),
      Message(
          id: 3,
          name: 'David Bill',
          message: 'I am happy to give you a discount for 5 or more people',
          imgUrl: 'assets/images/png/pmessage3.png'),
    ];
  }

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

  // /// Sample only
  // static List<dynamic> timeList = [
  //   ['7:00 - 8:00 AM', true],
  //   ['9:00 - 10:00 AM', false],
  //   ['11:00 - 12:00 PM', false],
  //   ['12:00 - 1:00 PM', false],
  //   ['2:00 - 3:00 PM', false],
  //   ['4:00 - 5:00 PM', false],
  //   ['6:00 - 7:00 PM', false],
  // ];

  /// Sample only
  static List<dynamic> timeList = [
    ['12:00 - 1:00 AM'],
    ['1:00 - 2:00 AM'],
    ['2:00 - 3:00 AM'],
    ['3:00 - 4:00 AM'],
    ['4:00 - 5:00 AM'],
    ['5:00 - 6:00 AM'],
    ['6:00 - 7:00 AM'],
    ['7:00 - 8:00 AM'],
    ['8:00 - 9:00 AM'],
    ['9:00 - 10:00 AM'],
    ['10:00 - 11:00 AM'],
    ['11:00 - 12:00 AM'],
    ['12:00 - 1:00 PM'],
    ['1:00 - 2:00 PM'],
    ['2:00 - 3:00 PM'],
    ['3:00 - 4:00 PM'],
    ['4:00 - 5:00 PM'],
    ['5:00 - 6:00 PM'],
    ['6:00 - 7:00 PM'],
    ['7:00 - 8:00 PM'],
    ['8:00 - 9:00 PM'],
    ['9:00 - 10:00 PM'],
    ['10:00 - 11:00 PM'],
    ['11:00 - 12:00 AM'],
  ];

  /// sample only
  static List<dynamic> timeListValues = [
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
    [false],
  ];

  /// availavilityTime
  static List<dynamic> availavilityTime = <String>[
    '7:00 - 9:00',
    '10:00 - 12:00',
    '13:00 - 15:00',
    '16:00 - 18:00',
    '18:30 - 20:00',
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

  /// use in request filter screen
  static List<String> requestFilterList = <String>[
    'All',
    'Pending',
    'Completed',
    'Rejected'
  ];

  ///
  static List<String> calendarMonths = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  /// use in request filter screen
  static List<String> activityIcons = <String>[
    'assets/images/png/activity_icon0.png',
    'assets/images/png/activity_icon1.png',
    'assets/images/png/activity_icon2.png',
    'assets/images/png/activity_icon3.png',
    'assets/images/png/activity_icon4.png',
    'assets/images/png/activity_icon5.png',
    'assets/images/png/activity_icon6.png',
    'assets/images/png/activity_icon7.png',
    'assets/images/png/activity_icon8.png',
    'assets/images/png/activity_icon9.png',
  ];

  ///
  static List<int> numberList = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
}
