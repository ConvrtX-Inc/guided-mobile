// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Outfitter image model
class BadgeModelData {
  /// Constructor
  BadgeModelData({required this.badgeDetails});

  /// outfitter image details
  late List<BadgeDetailsModel> badgeDetails = <BadgeDetailsModel>[];
}

/// OutFitter image class
class BadgeDetailsModel {
  /// Constructor
  BadgeDetailsModel(
      {this.id = '', this.name = '', this.description = '', this.imgIcon = ''});

  /// String property initialization
  final String id, name, description, imgIcon;

  /// mapping
  BadgeDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['badge_name'],
        description = parseJson['badge_description'],
        imgIcon = parseJson['img_icon'];
}
