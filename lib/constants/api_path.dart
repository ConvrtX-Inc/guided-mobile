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
}
