import 'package:guided/constants/app_texts.dart';

/// Text services
class TextServices {
  /// Filter error message
  String filterErrorMessage(String errorTextMessage) {
    String filteredMessage = '';
    switch (errorTextMessage) {
      case 'emailAlreadyExists':
        filteredMessage = 'Email ${AppTextConstants.alreadyExists}';
        break;
      case 'usernameAlreadyExists':
        filteredMessage = 'Username ${AppTextConstants.alreadyExists}';
        break;
      case 'incorrectPassword':
        filteredMessage = 'Incorrect Password';
        break;
      default:
        filteredMessage = errorTextMessage;
    }
    return filteredMessage;
  }
}
