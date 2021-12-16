/*
  Although we have described the assets path in pubspec.yaml but to use that asset in an application we need to give there relative path in any widgets.
  If we add all the assets relative path in one file then it will be easy for us to get all the paths and update the path if required in the future.
 */
/// Class for app assets path
class AssetsPath {
  /// Constructor
  const AssetsPath();

  /// returns assets png path
  static const String assetsPNGPath = 'assets/images/png';

  /// returns assets svg path
  static const String assetsSVGPath = 'assets/images/svg';

  /// sample image for first vest
  static String vest1 = 'assets/images/jpg/sample_1.jpg';

  /// sample image for second vest
  static String vest2 = 'assets/images/jpg/sample_2.jpg';

  /// sample image for third vest
  static String vest3 = 'assets/images/jpg/sample_3.jpg';

  /// sample image for first hiking shoes
  static String hikingShoes1 = 'assets/images/png/hiking_shoes_1.png';

  /// sample image for second hiking shoes
  static String hikingShoes2 = 'assets/images/jpg/hiking_shoes_2.jpg';

  /// sample image for third hiking shoes
  static String hikingShoes3 = 'assets/images/jpg/hiking_shoes_3.jpg';

  /// sample image for image prey
  static String imagePrey = 'assets/images/imageprev.png';

  /// sample image for first ad
  static String ads1 = 'assets/images/png/ads_sample_1.png';

  /// sample image for second ad
  static String ads2 = 'assets/images/png/ads_sample_2.png';

  /// sample image for third ad
  static String ads3 = 'assets/images/png/ads_sample_3.png';

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

  /// sample image for profile
  static String image1 = 'assets/images/image1.png';

  /// sample image for profile
  static String image2 = 'assets/images/image2.png';

  /// profile certificate icon
  static String certificateIcon = 'assets/images/certificateIcon.png';

  /// facebook icon
  static String facebook = 'assets/images/facebook.png';

  /// google icon
  static String google = 'assets/images/google.png';

  /// returns splash image
  static String splashImage = 'assets/images/splashImage.png';

  /// returns for the planet image
  static String forThePlanet = 'assets/images/forThePlanet.png';

  /// returns im a tourist image
  static String touristImage = 'assets/images/ImATourist.png';

  /// returns a guide image
  static String guideImage = 'assets/images/ImAGuideOutfitter.png';

  /// returns welcome to guide image
  static String welcomeToGuideImage = 'assets/images/welcomeToGuidED.png';

  /// returns no user image
  static String noUser = 'assets/images/no_user.png';

  /// returns arrow back with tail text
  static String arrowWithTail = 'assets/images/svg/arrow_back_with_tail.svg';

  /// returns setting icon bell
  static String iconBell = 'assets/images/svg/settings_icon_bell.svg';
}
