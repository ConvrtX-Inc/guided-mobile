import 'package:guided/models/available_date_model.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/models/booking_hours.dart';
import 'package:guided/models/faq.dart';
import 'package:guided/models/message.dart';
import 'package:guided/models/post_model.dart';
import 'package:guided/models/transaction_model.dart';

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

  /// Time List [<Time Display>, <CheckBox Status>, <Counter>, <Value>, <Time List Id>, <Activity Availability Hour Id>, <Activity Availability Id>]
  static List<dynamic> timeList = [
    ['12:00 - 1:00 AM', false, 0, '00:00:00', 0, '', ''],
    ['1:00 - 2:00 AM', false, 0, '1:00:00', 1, '', ''],
    ['2:00 - 3:00 AM', false, 0, '2:00:00', 2, '', ''],
    ['3:00 - 4:00 AM', false, 0, '3:00:00', 3, '', ''],
    ['4:00 - 5:00 AM', false, 0, '4:00:00', 4, '', ''],
    ['5:00 - 6:00 AM', false, 0, '5:00:00', 5, '', ''],
    ['6:00 - 7:00 AM', false, 0, '6:00:00', 6, '', ''],
    ['7:00 - 8:00 AM', false, 0, '7:00:00', 7, '', ''],
    ['8:00 - 9:00 AM', false, 0, '8:00:00', 8, '', ''],
    ['9:00 - 10:00 AM', false, 0, '9:00:00', 9, '', ''],
    ['10:00 - 11:00 AM', false, 0, '10:00:00', 10, '', ''],
    ['11:00 - 12:00 AM', false, 0, '11:00:00', 11, '', ''],
    ['12:00 - 1:00 PM', false, 0, '12:00:00', 12, '', ''],
    ['1:00 - 2:00 PM', false, 0, '13:00:00', 13, '', ''],
    ['2:00 - 3:00 PM', false, 0, '14:00:00', 14, '', ''],
    ['3:00 - 4:00 PM', false, 0, '15:00:00', 15, '', ''],
    ['4:00 - 5:00 PM', false, 0, '16:00:00', 16, '', ''],
    ['5:00 - 6:00 PM', false, 0, '17:00:00', 17, '', ''],
    ['6:00 - 7:00 PM', false, 0, '18:00:00', 18, '', ''],
    ['7:00 - 8:00 PM', false, 0, '19:00:00', 19, '', ''],
    ['8:00 - 9:00 PM', false, 0, '20:00:00', 20, '', ''],
    ['9:00 - 10:00 PM', false, 0, '21:00:00', 21, '', ''],
    ['10:00 - 11:00 PM', false, 0, '22:00:00', 22, '', ''],
    ['11:00 - 12:00 AM', false, 0, '23:00:00', 23, '', ''],
  ];

  static List<dynamic> timeListAvailable = [
    ['00:00:00', '12:00 - 1:00 AM'],
    ['1:00:00', '1:00 - 2:00 AM'],
    ['2:00:00', '2:00 - 3:00 AM'],
    ['3:00:00', '3:00 - 4:00 AM'],
    ['4:00:00', '4:00 - 5:00 AM'],
    ['5:00:00', '5:00 - 6:00 AM'],
    ['6:00:00', '6:00 - 7:00 AM'],
    ['7:00:00', '7:00 - 8:00 AM'],
    ['8:00:00', '8:00 - 9:00 AM'],
    ['9:00:00', '9:00 - 10:00 AM'],
    ['10:00:00', '10:00 - 11:00 AM'],
    ['11:00:00', '11:00 - 12:00 AM'],
    ['12:00:00', '12:00 - 1:00 PM'],
    ['13:00:00', '1:00 - 2:00 PM'],
    ['14:00:00', '2:00 - 3:00 PM'],
    ['15:00:00', '3:00 - 4:00 PM'],
    ['16:00:00', '4:00 - 5:00 PM'],
    ['17:00:00', '5:00 - 6:00 PM'],
    ['18:00:00', '6:00 - 7:00 PM'],
    ['19:00:00', '7:00 - 8:00 PM'],
    ['20:00:00', '8:00 - 9:00 PM'],
    ['21:00:00', '9:00 - 10:00 PM'],
    ['22:00:00', '10:00 - 11:00 PM'],
    ['23:00:00', '11:00 - 12:00 AM'],
  ];

  /// booking Hours comparison
  static List<BookingHours> bookingHours = [
    BookingHours(0, '00:00:00', '12:00', '1:00'),
    BookingHours(1, '01:00:00', '1:00', '2:00'),
    BookingHours(2, '02:00:00', '2:00', '3:00'),
    BookingHours(3, '03:00:00', '3:00', '4:00'),
    BookingHours(4, '04:00:00', '4:00', '5:00'),
    BookingHours(5, '05:00:00', '5:00', '6:00'),
    BookingHours(6, '06:00:00', '6:00', '7:00'),
    BookingHours(7, '07:00:00', '7:00', '8:00'),
    BookingHours(8, '08:00:00', '8:00', '9:00'),
    BookingHours(9, '09:00:00', '9:00', '10:00'),
    BookingHours(10, '10:00:00', '10:00', '11:00'),
    BookingHours(11, '11:00:00', '11:00', '12:00'),
    BookingHours(12, '12:00:00', '12:00', '13:00'),
    BookingHours(13, '13:00:00', '13:00', '14:00'),
    BookingHours(14, '14:00:00', '14:00', '15:00'),
    BookingHours(15, '15:00:00', '15:00', '16:00'),
    BookingHours(16, '16:00:00', '16:00', '17:00'),
    BookingHours(17, '17:00:00', '17:00', '18:00'),
    BookingHours(18, '18:00:00', '18:00', '19:00'),
    BookingHours(19, '19:00:00', '19:00', '20:00'),
    BookingHours(20, '20:00:00', '20:00', '21:00'),
    BookingHours(21, '21:00:00', '21:00', '22:00'),
    BookingHours(22, '22:00:00', '22:00', '23:00'),
    BookingHours(23, '23:00:00', '23:00', '24:00'),
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

  ///Test transaction data
  static List<Transaction> transactions = <Transaction>[
    Transaction(
        id: '0001',
        userId: 'u-0001',
        activityPackageId: 'p-0001',
        tourGuideId: 'u-0002',
        serviceName: 'Test Service 0001',
        transactionNumber: 'tn-0001',
        statusId: Transaction.COMPLETED,
        total: '50.0',
        numberOfPeople: 1,
        bookDate: DateTime.now(),
        createdDate: null,
        updatedDate: null),
    Transaction(
        id: '0002',
        userId: 'u-0001',
        activityPackageId: 'p-0001',
        tourGuideId: 'u-0002',
        serviceName: 'Test Service 0002',
        transactionNumber: 'tn-0002',
        statusId: Transaction.COMPLETED,
        total: '60.0',
        numberOfPeople: 1,
        bookDate: DateTime.now(),
        createdDate: null,
        updatedDate: null),
    Transaction(
        id: '0003',
        userId: 'u-0001',
        activityPackageId: 'p-0001',
        tourGuideId: 'u-0002',
        serviceName: 'Test Service 0003',
        transactionNumber: 'tn-0003',
        statusId: Transaction.COMPLETED,
        total: '70.0',
        numberOfPeople: 1,
        bookDate: DateTime.now(),
        createdDate: null,
        updatedDate: null),
    Transaction(
        id: '0004',
        userId: 'u-0001',
        activityPackageId: 'p-0001',
        tourGuideId: 'u-0002',
        serviceName: 'Test Service 0004',
        transactionNumber: 'tn-0004',
        statusId: Transaction.PENDING,
        total: '80.0',
        numberOfPeople: 1,
        bookDate: DateTime.now(),
        createdDate: null,
        updatedDate: null),
    Transaction(
        id: '0005',
        userId: 'u-0001',
        activityPackageId: 'p-0001',
        tourGuideId: 'u-0002',
        serviceName: 'Test Service 0005',
        transactionNumber: 'tn-0005',
        statusId: Transaction.PENDING,
        total: '90.0',
        numberOfPeople: 1,
        bookDate: DateTime.now(),
        createdDate: null,
        updatedDate: null),
    Transaction(
        id: '0006',
        userId: 'u-0001',
        activityPackageId: 'p-0001',
        tourGuideId: 'u-0002',
        serviceName: 'Test Service 0006',
        transactionNumber: 'tn-0006',
        statusId: Transaction.PENDING,
        total: '100.0',
        numberOfPeople: 1,
        bookDate: DateTime.now(),
        createdDate: null,
        updatedDate: null),
    Transaction(
        id: '0007',
        userId: 'u-0001',
        activityPackageId: 'p-0001',
        tourGuideId: 'u-0002',
        serviceName: 'Test Service 0007',
        transactionNumber: 'tn-0007',
        statusId: Transaction.REJECTED,
        total: '110.0',
        numberOfPeople: 1,
        bookDate: DateTime.now(),
        createdDate: null,
        updatedDate: null),
    Transaction(
        id: '0008',
        userId: 'u-0001',
        activityPackageId: 'p-0001',
        tourGuideId: 'u-0002',
        serviceName: 'Test Service 0008',
        transactionNumber: 'tn-0008',
        statusId: Transaction.REJECTED,
        total: '120.0',
        numberOfPeople: 1,
        bookDate: DateTime.now(),
        createdDate: null,
        updatedDate: null),
    Transaction(
        id: '0009',
        userId: 'u-0001',
        activityPackageId: 'p-0001',
        tourGuideId: 'u-0002',
        serviceName: 'Test Service 0009',
        transactionNumber: 'tn-0009',
        statusId: Transaction.REJECTED,
        total: '130.0',
        numberOfPeople: 1,
        bookDate: DateTime.now(),
        createdDate: null,
        updatedDate: null)
  ];

  ///Test post data
  static List<Post> posts = <Post>[
    Post(
        id: '0001',
        userId: 'u-0001',
        postId: 'p-0001',
        title: 'title-001',
        categoryType: 1,
        views: 0,
        isPublished: true),
    Post(
        id: '0002',
        userId: 'u-0002',
        postId: 'p-0002',
        title: 'title-001',
        categoryType: 1,
        views: 0,
        isPublished: true),
    Post(
        id: '0003',
        userId: 'u-0003',
        postId: 'p-0003',
        title: 'title-001',
        categoryType: 1,
        views: 0,
        isPublished: true),
    Post(
        id: '0004',
        userId: 'u-0004',
        postId: 'p-0004',
        title: 'title-001',
        categoryType: 2,
        views: 0,
        isPublished: true),
    Post(
        id: '0005',
        userId: 'u-0005',
        postId: 'p-0005',
        title: 'title-001',
        categoryType: 2,
        views: 0,
        isPublished: true),
    Post(
        id: '0006',
        userId: 'u-0006',
        postId: 'p-0006',
        title: 'title-001',
        categoryType: 2,
        views: 0,
        isPublished: true),
    Post(
        id: '0007',
        userId: 'u-0007',
        postId: 'p-0007',
        title: 'title-001',
        categoryType: 3,
        views: 0,
        isPublished: true),
    Post(
        id: '0008',
        userId: 'u-0008',
        postId: 'p-0008',
        title: 'title-001',
        categoryType: 3,
        views: 0,
        isPublished: true),
    Post(
        id: '0009',
        userId: 'u-0009',
        postId: 'p-0009',
        title: 'title-001',
        categoryType: 3,
        views: 0,
        isPublished: true),
  ];

    List<AvailableDateModel> availableDates = <AvailableDateModel>[
    AvailableDateModel(month: 1, monthName: 'January'),
    AvailableDateModel(month: 2, monthName: 'February'),
    AvailableDateModel(month: 3, monthName: 'March'),
    AvailableDateModel(month: 4, monthName: 'April'),
    AvailableDateModel(month: 5, monthName: 'May'),
    AvailableDateModel(month: 6, monthName: 'June'),
    AvailableDateModel(month: 7, monthName: 'July'),
    AvailableDateModel(month: 8, monthName: 'August'),
    AvailableDateModel(month: 9, monthName: 'September'),
    AvailableDateModel(month: 10, monthName: 'October'),
    AvailableDateModel(month: 11, monthName: 'November'),
    AvailableDateModel(month: 12, monthName: 'December'),
  ];
}
