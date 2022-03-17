// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Outfitter image model
class EventImageModelData {
  /// Constructor
  EventImageModelData({required this.eventImageDetails});

  /// outfitter image details
  late List<EventImageDetailsModel> eventImageDetails =
      <EventImageDetailsModel>[];
}

/// Outfitter image class
class EventImageDetailsModel {
  /// Constructor
  EventImageDetailsModel(
      {this.id = '', this.activityEventId = '', this.snapshotImg = ''});

  /// String property initialization
  final String id, activityEventId, snapshotImg;

  /// mapping
  EventImageDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        activityEventId = parseJson['activity_event_id'],
        snapshotImg = parseJson['snapshot_img'];
}
