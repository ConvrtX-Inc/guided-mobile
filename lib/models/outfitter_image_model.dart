// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Outfitter image model
class OutfitterImageModelData {
  /// Constructor
  OutfitterImageModelData({required this.outfitterImageDetails});

  /// outfitter image details
  late List<OutfitterImageDetailsModel> outfitterImageDetails =
      <OutfitterImageDetailsModel>[];

  /// mapping
  OutfitterImageModelData.fromJson(List<dynamic> parseJson)
      : outfitterImageDetails = parseJson
            .map((i) => OutfitterImageDetailsModel.fromJson(i))
            .toList();
}

/// Outfitter image class
class OutfitterImageDetailsModel {
  /// Constructor
  OutfitterImageDetailsModel(
      {this.id = '', this.activityOutfitterId = '', this.snapshotImg = ''});

  /// String property initialization
  final String id, activityOutfitterId, snapshotImg;

  /// mapping
  OutfitterImageDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        activityOutfitterId = parseJson['activity_outfitter_id'],
        snapshotImg = parseJson['snapshot_img'];
}
