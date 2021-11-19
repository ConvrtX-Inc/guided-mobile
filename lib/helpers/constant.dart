import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/badgesModel.dart';

/// Helpers for app constants
class ConstantHelpers {
  /// hex color for primaryGreen
  static HexColor primaryGreen = HexColor('#066028');

  /// hex color for grey
  static HexColor grey = HexColor('#979B9B');

  /// hex color for platinum
  static HexColor platinum = HexColor('#E3E3E3');

  /// hex color for primaryGreen
  static HexColor lightRed = HexColor('#FF4848');

  /// hex color for primaryGreen
  static HexColor doveGrey = HexColor('#696D6D');

  /// hex color for primaryGreen
  static HexColor nobel = HexColor('#696D6D');

  /// hex color for spruce
  static HexColor spruce = HexColor('#066028');

  /// hex color for harp
  static HexColor harp = HexColor('#ECEFF0');

  /// hex color for rangooGreen
  static HexColor rangooGreen = HexColor('#181B1B');

  /// hex color for osloGrey
  static HexColor osloGrey = HexColor('#898A8D');

  /// hex color for duckEggBlue
  static HexColor duckEggBlue = HexColor('#B6FFE3');

  /// hex color for tropicalRainForest
  static HexColor tropicalRainForest = HexColor('#007749');

  /// hex color for lightningYellow
  static HexColor lightningYellow = HexColor('#FFC31A');

  /// hex color for porcelain
  static HexColor porcelain = HexColor('#F2F2F2');

  /// hex color for aqua green
  static HexColor aquaGreen = HexColor('#37DD8D');

  /// hex color for butter scotch
  static HexColor butterScotch = HexColor('#FFB240');

  /// hex color for pine cone
  static HexColor pineCone = HexColor('#705F5A');

  /// hex color for venus
  static HexColor venus = HexColor('#8B8B8B');

  /// hex color for back arrow grey
  static HexColor backarrowgrey = HexColor('#ECEFF0');

  /// hex color for calendar font
  static HexColor lightgrey = HexColor('#898A8D');

  /// hex color for active calendar date
  static HexColor activeDate = HexColor('#FFC31A');

  /// hex color for badge
  static HexColor badgeColor = HexColor('#007749');

  /// hex color for Calendar
  static HexColor calendarMonth = HexColor('#FFC74A');

  /// hex Color for the button Next
  static HexColor buttonNext = HexColor('#C4C4C4');

  /// String used for Calendar Management
  static String fontGilroy = 'Gilroy';

  static String fontPoppins = 'Poppins';

  static String cancel = 'Cancel';

  static String findBookingDates = 'Find Booking Dates';

  static String fullDateSample = '9/April/2021';

  static String viewSchedule = 'View Schedule';

  static String january = 'January';

  static String february = 'February';

  static String march = 'March';

  static String april = 'April';

  static String may = 'May';

  static String june = 'June';

  static String july = 'July';

  static String august = 'August';

  static String september = 'September';

  static String october = 'October';

  static String november = 'November';

  static String december = 'December';


  /// logo URL
  static String logo = 'assets/images/logo.png';

  /// logo URL small
  static String logoSmall = 'assets/images/logoSmall.png';

  /// bottom navigation icon - home
  static String bottomNavigationIconHome =
      'assets/images/svg/bottom_navigation_icon_home.svg';

  /// bottom navigation icon selected - home
  static String bottomNavigationIconHomeSelected =
      'assets/images/svg/bottom_navigation_icon_home_selected.svg';

  /// bottom navigation icon - union
  static String bottomNavigationIconUnion =
      'assets/images/svg/bottom_navigation_icon_union.svg';

  /// bottom navigation icon selected - union
  static String bottomNavigationIconUnionSelected =
      'assets/images/svg/bottom_navigation_icon_union_selected.svg';

  /// bottom navigation icon - add person
  static String bottomNavigationIconAddPerson =
      'assets/images/svg/bottom_navigation_icon_add_person.svg';

  /// bottom navigation icon selected - add person
  static String bottomNavigationIconAddPersonSelected =
      'assets/images/svg/bottom_navigation_icon_add_person_selected.svg';

  /// bottom navigation icon - chat
  static String bottomNavigationIconChat =
      'assets/images/svg/bottom_navigation_icon_chat.svg';

  /// bottom navigation icon selected - chat
  static String bottomNavigationIconChatSelected =
      'assets/images/svg/bottom_navigation_icon_chat_selected.svg';

  /// bottom navigation icon - settings
  static String bottomNavigationIconSettings =
      'assets/images/svg/bottom_navigation_icon_settings.svg';

  /// bottom navigation icon selected - chat
  static String bottomNavigationIconSettingsSelected =
      'assets/images/svg/bottom_navigation_icon_settings_selected.svg';

  /// home feature calendar icon
  static String homeFeatureCalendarIcon =
      'assets/images/svg/feature_calendar.svg';

  /// home feature calendar icon
  static String homeFeatureHikingIcon = 'assets/images/hiking.png';

  /// spacing 20
  static Widget spacing20 = const SizedBox(
    height: 20,
  );

  /// spacing 15
  static Widget spacing15 = const SizedBox(
    height: 15,
  );

  /// spacing 30
  static Widget spacing30 = const SizedBox(
    height: 15,
  );

  /// spacing 40
  static Widget spacing40 = const SizedBox(
    height: 15,
  );

  /// spacing width 20
  static Widget spacingwidth20 = const SizedBox(
    width: 20,
  );

  /// spacing width 15
  static Widget spacingwidth15 = const SizedBox(
    width: 15,
  );

  static List<BadgesModel> badges = [
    BadgesModel(1, "Camping", "assets/images/badge-Camping.png"),
    BadgesModel(2, "Fishing", "assets/images/badge-Fishing.png"),
    BadgesModel(3, "Eco Tour", "assets/images/badge-Eco.png"),
    BadgesModel(4, "Hunt", "assets/images/badge-Hunt.png"),
    BadgesModel(5, "Hiking", "assets/images/badge-Hiking.png"),
    BadgesModel(6, "Retreat", "assets/images/badge-Retreat.png"),
    BadgesModel(7, "Discovery", "assets/images/badge-Discovery.png"),
    BadgesModel(8, "Paddle Spot", "assets/images/badge-PaddleSpot.png"),
    BadgesModel(9, "Outfitter", "assets/images/badge-Outfitter.png"),
    BadgesModel(10, "Motor", "assets/images/badge-Motor.png"),
  ];
}

class HeaderText {
  static Widget headerText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 25,
        // fontFamily: 'GilRoy',
      ),
    );
  }

  HeaderText(final String text);
}

class SubHeaderText {
  static Widget subHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontFamily: 'GilRoy',
        fontSize: 15,
      ),
    );
  }

  SubHeaderText(final String text);
}
