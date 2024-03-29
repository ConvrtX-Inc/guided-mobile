// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Outfitter image model
class OutfitterImageModelData {
  /// Constructor
  OutfitterImageModelData({required this.outfitterImageDetails});

  /// outfitter image details
  late List<OutfitterImageDetailsModel> outfitterImageDetails =
      <OutfitterImageDetailsModel>[];
}

/// Outfitter image class
class OutfitterImageDetailsModel {
  /// Constructor
  OutfitterImageDetailsModel(
      {this.id = '',
      this.activityOutfitterId = '',
      this.snapshotImg = '',
      this.firebaseSnapshotImg = ''});

  /// String property initialization
  final String id, activityOutfitterId, snapshotImg, firebaseSnapshotImg;

  /// mapping
  OutfitterImageDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        activityOutfitterId = parseJson['activity_outfitter_id'],
        snapshotImg = parseJson['snapshot_img'],
        firebaseSnapshotImg = parseJson['firebase_snapshot_img'];
}
