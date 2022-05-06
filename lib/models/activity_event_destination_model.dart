// ignore_for_file: sort_constructors_first

/// Activity Event Destination Model
class ActivityEventDestination {
  /// Constructor
  ActivityEventDestination({required this.activityEventDestinationDetails});

  /// package destination details
  late List<ActivityEventDestinationDetailsModel>
      activityEventDestinationDetails =
      <ActivityEventDestinationDetailsModel>[];

  /// mapping
  ActivityEventDestination.fromJson(List<dynamic> parseJson)
      : activityEventDestinationDetails = parseJson
            .map((i) => ActivityEventDestinationDetailsModel.fromJson(i))
            .toList();
}

/// Activity Event Destination details model
class ActivityEventDestinationDetailsModel {
  /// Contructor
  ActivityEventDestinationDetailsModel(
      {this.id = '',
      this.activityEventId = '',
      this.placeName = '',
      this.placeDescription = '',
      this.latitude = '',
      this.longitude = ''});

  /// String property initialization
  final String id,
      activityEventId,
      placeName,
      placeDescription,
      latitude,
      longitude;

  ActivityEventDestinationDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        activityEventId = parseJson['activity_event_id'],
        placeName = parseJson['place_name'],
        placeDescription = parseJson['place_description'],
        latitude = parseJson['latitude'],
        longitude = parseJson['longitude'];
}
