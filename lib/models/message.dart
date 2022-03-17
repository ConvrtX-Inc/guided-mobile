import 'dart:ui';

/// Class for settings items
class Message {
  /// Constructor
  Message({
    required this.id,
    required this.name,
    required this.message,
    required this.imgUrl,
  });

  /// property for name
  int id;

  /// property for name
  String name;

  /// property for icon
  String message;

  /// property for image url
  String imgUrl;
}
