// ignore_for_file: sort_constructors_first

/// Package Model
class EventModelData {
  /// Constructor
  EventModelData({required this.eventDetails});

  /// advertisement details
  late List<EventDetailsModel> eventDetails = <EventDetailsModel>[];

  /// mapping

  EventModelData.fromJson(List<dynamic> parseJson)
      : eventDetails =
            parseJson.map((i) => EventDetailsModel.fromJson(i)).toList();
}

/// Package Details model
class EventDetailsModel {
  /// Contructor
  EventDetailsModel({
    this.id = '',
    this.userId = '',
    this.badgeId = '',
    this.title = '',
    this.country = '',
    this.address = '',
    this.description = '',
    this.fee = '',
    this.isPublished = false,
  });

  /// String property initialization
  final String id, userId, badgeId, title, country, address, description, fee;

  /// boolean initialization
  final bool isPublished;

  EventDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        userId = parseJson['user_id'],
        badgeId = parseJson['badge_id'],
        title = parseJson['title'],
        country = parseJson['country'],
        address = parseJson['address'],
        description = parseJson['description'],
        fee = parseJson['price'],
        isPublished = parseJson['is_published'];
}