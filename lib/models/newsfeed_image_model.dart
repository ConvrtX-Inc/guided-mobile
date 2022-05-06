// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Newfeed image model
class NewsfeedImageModel {
  /// Constructor
  NewsfeedImageModel({required this.newsfeedImageDetails});

  /// Newfeed image details
  late List<NewsfeedImageDetails> newsfeedImageDetails =
      <NewsfeedImageDetails>[];
}

/// Newfeed image class
class NewsfeedImageDetails {
  /// Constructor
  NewsfeedImageDetails(
      {this.id = '', this.newsfeedId = '', this.firebaseSnapshotImg = ''});

  /// String property initialization
  final String id, newsfeedId, firebaseSnapshotImg;

  /// mapping
  NewsfeedImageDetails.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        newsfeedId = parseJson['activity_newsfeed_id'],
        firebaseSnapshotImg = parseJson['firebase_snapshot_img'];
}
