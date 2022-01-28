/// Class for app API urls
class AppAPIPath {
  /// Constructor
  const AppAPIPath();

  /// Returns staging mode (change to false if deploying to live)
  static bool isStaging = false;

  /// Returns API mode
  static String apiBaseMode = isStaging ? 'http://' : 'https://';

  /// Returns API base url
  static String apiBaseUrl = 'dev-guided-convrtx.herokuapp.com';

  /// Returns login url
  static String loginUrl = 'api/v1/auth/email/login';

  /// Returns send verification code for forgot password url
  static String sendVerificationCodeUrl = 'api/v1/auth/forgot/password';

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
}
