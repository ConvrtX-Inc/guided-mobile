/// Model for Preset Form Model
// ignore_for_file: prefer_constructors_over_static_methods, public_member_api_docs, non_constant_identifier_names

class ActivityAvailabilityHour {
  /// Constructor
  ActivityAvailabilityHour(
      {this.id = '',
      this.activity_availability_id = '',
      this.availability_date_hour,
      this.slots = 0});

  /// initialization for id
  final String id;

  /// initialization for tour guide id
  final String activity_availability_id;

  /// initialization for type
  final DateTime? availability_date_hour;

  final int slots;

  static ActivityAvailabilityHour fromJson(Map<String, dynamic> json) =>
      ActivityAvailabilityHour(
          id: json['id'],
          activity_availability_id: json['activity_availability_id'] ?? '',
          availability_date_hour:
              DateTime.parse(json['availability_date_hour']),
          slots: json['slots']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'activity_availability_id': activity_availability_id,
        'availability_date_hour': availability_date_hour,
        'slots': slots
      };
}
