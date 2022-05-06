// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Event Destination image model
class EventDestinationImageModel {
  /// Constructor
  EventDestinationImageModel({required this.eventDestinationImageDetails});

  /// Event Destination image details
  late List<EventImageDestinationDetails> eventDestinationImageDetails =
      <EventImageDestinationDetails>[];
}

/// Event Destination image class
class EventImageDestinationDetails {
  /// Constructor
  EventImageDestinationDetails(
      {this.id = '',
      this.activityEventDestinationId = '',
      this.snapshotImg = '',
      this.firebaseSnapshotImg = ''});

  /// String property initialization
  final String id, activityEventDestinationId, snapshotImg, firebaseSnapshotImg;

  /// mapping
  EventImageDestinationDetails.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        activityEventDestinationId = parseJson['activity_event_destination_id'],
        snapshotImg = parseJson['snapshot_img'],
        firebaseSnapshotImg = parseJson['firebase_snapshot_img'];
}
