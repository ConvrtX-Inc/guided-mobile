import 'dart:ui';

/// Class for settings items
class RequestsScreenModel {
  /// Constructor
  RequestsScreenModel({
    required this.id,
    required this.name,
    required this.status,
    required this.imgUrl,
  });

  /// property for name
  int id;

  /// property for name
  String name;

  /// property for icon
  String status;

  /// property for image url
  String imgUrl;

}