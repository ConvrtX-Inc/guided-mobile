import 'dart:ui';

/// Class for settings items
class SettingsModel {
  /// Constructor
  SettingsModel({
    required this.keyName,
    required this.name,
    required this.icon,
    required this.color,
    required this.imgUrl,
    required this.subSettings,
  });

  /// property for key
  String keyName;

  /// property for name
  String name;

  /// property for icon
  String icon;

  /// property for color
  Color color;

  /// property for image url
  String imgUrl;

  /// property for subSettings
  List<SettingsModel> subSettings;
}
