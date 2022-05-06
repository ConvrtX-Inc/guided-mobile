/// Class for app API urls
class AppAPIPath {
  /// Constructor
  const AppAPIPath();

  /// Returns staging mode (change to false if deploying to live)
  static bool isStaging = false;

  // static bool isStaging = true;

  /// Returns API mode
  static String apiBaseMode = isStaging ? 'http://' : 'https://';

  ///Returns mode : (dev | staging | local )
  static String mode = 'staging';

  /// Returns API base url
  static String apiBaseUrl = getBaseUrl(mode);

  ///Returns web socket url
  static String webSocketUrl = '$apiBaseMode$apiBaseUrl/messenger';

  /// Returns login url
  static String loginUrl = 'api/v1/auth/email/login';

  /// Returns facebook url
  static String facebookLogin = 'api/v1/auth/facebook/login';

  /// Returns user Type url
  static String userTpye = 'api/v1/user-types';

  /// Returns send verification code for forgot password url
  static String sendVerificationCodeUrl = 'api/v1/auth/forgot/forgot';

  /// Returns check verification code url
  static String checkVerificationCodeUrl = 'api/v1/auth/email/confirm';

  /// Returns send verification code for sign up url
  static String sendVerificationCodeSignUpUrl =
      'api/v1/auth/verify/mobile/send';

  /// Returns check verification code for sign up url
  static String checkVericationCodeSignUpUrl =
      'api/v1/auth/verify/mobile/check';

  /// Returns create outffiter url
  static String createOutfitterUrl = 'api/v1/activity-outfitter';

  /// Returns reset password url
  static String resetPasswordUrl = 'api/v1/auth/reset/password';

  /// Returns sign up url
  static String signupUrl = 'api/v1/auth/email/register';

  /// Returns request booking
  static String requestBooking = 'api/v1/booking-requests';

  /// Returns create advertisement url
  static String createAdvertisementUrl = 'api/v1/activity-advertisement';

  /// Returns activity advertisement image url
  static String imageUrl = 'api/v1/activity-advertisement-image';

  /// Returns activity advertisement bulk image url
  static String bulkImageUrl = 'api/v1/activity-advertisement-image/bulk';

  /// Returns outfitter url
  static String outfitterUrl = 'api/v1/activity-outfitter';

  /// Returns outfitter image url
  static String outfitterImageUrl = 'api/v1/activity-outfitter-image';

  /// Returns outfitter bulk image url
  static String outfitterBulkImageUrl = 'api/v1/activity-outfitter-image/bulk';

  /// Returns outfitter details url
  static String getOutfitterDetail = 'api/v1/activity-outfitter';

  /// Returns advertisement details
  static String getAdvertisementDetail = 'api/v1/activity-advertisement';

  /// Returns outfitter image
  static String getOutfitterImage = 'api/v1/activity-outfitter-image';

  /// Returns advertisement image
  static String getAdvertisementImage = 'api/v1/activity-advertisement-image';

  /// Returns profile details
  static String getProfileDetails = 'api/v1/users';

  /// Returns booking request
  static String getBookingRequest = 'api/v1/booking-requests';

  /// Returns currencies url
  static String getCurrencies = 'api/v1/currencies';

  /// Returns activity packages url
  static String activityPackagesUrl = 'api/v1/activity-packages';

  /// Returns activity packages url
  static String activityPackagesUrlDescOrder =
      'api/v1/activity-packages?sort=created_date%2CDESC';

  /// Returns closest-activity url
  static String closestActivity = 'api/v1/activity-packages/closest-activity';

  /// Returns popular guides url
  static String popularGuides = 'api/v1/nearby-activities/popular-guides-list';

  /// Returns activity-availability-hours
  static String activityAvailabilityHours =
      'api/v1/activity-availability-hours/date-range';

  /// Returns activity destination image url
  static String activityDestinationImage =
      'api/v1/activity-package-destination-images';

  /// Returns activity destination image url
  static String activityDestinationImageBulk =
      'api/v1/activity-package-destination-images/bulk';

  /// Returns activity packages destinations url
  static String activityDestinationDetails =
      'api/v1/activity-package-destinations';

  /// Returns otp url
  static String otpUrl = 'api/v1/auth/forgot/confirm/otp';

  /// Returns contact us url
  static String contactUsUrl = 'api/v1/contact-us';

  /// Returns guide rules and what to bring url
  static String guideRules = 'api/v1/rules-what-to-bring';

  /// Returns local laws and taxes url
  static String localLawandTaxes = 'api/v1/laws-and-taxes';

  /// Returns waiver url
  static String waiverUrl = 'api/v1/waivers';

  /// Returns activity event
  static String activityEventUrl = 'api/v1/activity-events';

  /// Returns event image
  static String getEventImage = 'api/v1/activity-event-image';

  /// Returns transactions
  static String getTransactions = 'api/v1/transactions';

  /// Returns posts
  static String getPosts = 'api/v1/activity-post';

  ///Return transactions by-guide
  static String getTransactionsByGuide =
      'api/v1/transactions/byguide/transaction';

  /// Returns terms and condition url
  static String getTermsAndCondtion = 'api/v1/terms-and-conditons';

  /// Returns activity advertisement image url
  static String eventImageUrl = 'api/v1/activity-event-image';

  /// Returns badges url
  static String badgesUrl = 'api/v1/badges';

  /// Returns bank account url
  static String bankAccountUrl = 'api/v1/bank-account';

  /// Returns booking dates
  static String createSlotAvailability =
      'api/v1/activity-availabilities/create-slot-availability';

  ///Returns  card url
  static String cardUrl = '/api/v1/card';

  /// Returns booking dates and hour
  static String createSlotAvailabilityHour =
      'api/v1/activity-availability-hours';

  /// Returns Terms and Condition url
  static String termsAndCondition = 'api/v1/terms-and-conditions';

  /// Returns Users Terms and Condition url
  static String usersTermsAndCondition = 'api/v1/users-terms-and-conditions';

  ///Returns  payment url
  static String paymentUrl = '/api/v1/charge';

  ///Returns  subscription url
  static String userSubscription = '/api/v1/user-subscription';

  /// Returns activity availabilities url
  static String activityAvailability = 'api/v1/activity-availabilities';

  ///Returns payment intent url
  static String paymentIntentUrl = 'api/v1/payment-intent';

  ///Returns user transactions url
  static String userTransactionsUrl = 'api/v1/transactions';

  ///Returns activity event destination
  static String eventDestination = 'api/v1/activity-event-destination';

  ///Returns activity event image destination
  static String eventDestinationImage =
      'api/v1/activity-event-destination-image';

  ///Returns newsfeed list url
  static String newsfeedList = 'api/v1/activity-newsfeed/list';

  ///Returns news feed image url
  static String newsfeedImage = 'api/v1/activity-newsfeed-image';
}

///Get Api Base Url
getBaseUrl(String mode) {
  switch (mode) {
    case 'local':
      return '192.168.100.55:3000';
    case 'dev':
      return 'guided-api-dev.herokuapp.com';
    case 'staging':
      return 'guided-api-staging.herokuapp.com';
  }
}
