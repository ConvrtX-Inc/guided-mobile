// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Outfitter image model
class AdvertisementImageModelData {
  /// Constructor
  AdvertisementImageModelData({required this.advertisementImageDetails});

  /// outfitter image details
  late List<AdvertisementImageDetailsModel> advertisementImageDetails =
      <AdvertisementImageDetailsModel>[];
}

/// Outfitter image class
class AdvertisementImageDetailsModel {
  /// Constructor
  AdvertisementImageDetailsModel(
      {this.id = '', this.activityAdvertisementId = '', this.snapshotImg = ''});

  /// String property initialization
  final String id, activityAdvertisementId, snapshotImg;

  /// mapping
  AdvertisementImageDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        activityAdvertisementId = parseJson['activity_advertisement_id'],
        snapshotImg = parseJson['snapshot_img'];
}
