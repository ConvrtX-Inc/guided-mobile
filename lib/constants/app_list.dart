import 'package:guided/models/badgesModel.dart';
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
    ['7:00 - 8:00 AM'],
    ['9:00 - 10:00 AM'],
    ['11:00 - 12:00 PM'],
    ['12:00 - 1:00 PM'],
    ['2:00 - 3:00 PM'],
    ['4:00 - 5:00 PM'],
    ['6:00 - 7:00 PM'],
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

  ///
  static List<int> numberList = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  ///Test transaction data
  static List<Transaction> transactions = <Transaction>[
    Transaction(id : '0001', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0001', transactionNumber : 'tn-0001', statusId : Transaction.COMPLETED, total : 50.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null),
    Transaction(id : '0002', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0002', transactionNumber : 'tn-0002', statusId : Transaction.COMPLETED, total : 60.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null),
    Transaction(id : '0003', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0003', transactionNumber : 'tn-0003', statusId : Transaction.COMPLETED, total : 70.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null),
    Transaction(id : '0004', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0004', transactionNumber : 'tn-0004', statusId : Transaction.PENDING, total : 80.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null),
    Transaction(id : '0005', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0005', transactionNumber : 'tn-0005', statusId :  Transaction.PENDING, total : 90.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null),
    Transaction(id : '0006', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0006', transactionNumber : 'tn-0006', statusId :  Transaction.PENDING, total : 100.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null),
    Transaction(id : '0007', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0007', transactionNumber : 'tn-0007', statusId : Transaction.REJECTED, total : 110.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null),
    Transaction(id : '0008', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0008', transactionNumber : 'tn-0008', statusId : Transaction.REJECTED, total : 120.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null),
    Transaction(id : '0009', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0009', transactionNumber : 'tn-0009', statusId : Transaction.REJECTED, total : 130.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null)
  ];
  ///Test post data
  static List<Post> posts = <Post>[
    Post(id:'0001',userId:'u-0001',postId:'p-0001',title: 'title-001',categoryType: 1,views: 0,isPublished: true),
    Post(id:'0002',userId:'u-0002',postId:'p-0002',title: 'title-001',categoryType: 1,views: 0,isPublished: true),
    Post(id:'0003',userId:'u-0003',postId:'p-0003',title: 'title-001',categoryType: 1,views: 0,isPublished: true),
    Post(id:'0004',userId:'u-0004',postId:'p-0004',title: 'title-001',categoryType: 2,views: 0,isPublished: true),
    Post(id:'0005',userId:'u-0005',postId:'p-0005',title: 'title-001',categoryType: 2,views: 0,isPublished: true),
    Post(id:'0006',userId:'u-0006',postId:'p-0006',title: 'title-001',categoryType: 2,views: 0,isPublished: true),
    Post(id:'0007',userId:'u-0007',postId:'p-0007',title: 'title-001',categoryType: 3,views: 0,isPublished: true),
    Post(id:'0008',userId:'u-0008',postId:'p-0008',title: 'title-001',categoryType: 3,views: 0,isPublished: true),
    Post(id:'0009',userId:'u-0009',postId:'p-0009',title: 'title-001',categoryType: 3,views: 0,isPublished: true),
  ];
}
