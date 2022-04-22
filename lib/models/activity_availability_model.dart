// ignore_for_file: prefer_constructors_over_static_methods, public_member_api_docs, non_constant_identifier_names
/// Model for Activity Availability Model
class ActivityAvailability {
  /// Constructor
  ActivityAvailability(
      {this.id = '',
      this.activity_package_id = '',
      this.availability_date = ''});

  /// initialization for id
  final String id;

  /// initialization for tour guide id
  final String activity_package_id;

  /// initialization for type
  final String availability_date;

  static ActivityAvailability fromJson(Map<String, dynamic> json) =>
      ActivityAvailability(
          id: json['id'],
          activity_package_id: json['availability_date'] ?? '',
          availability_date: json['availability_date'] ?? '');

  Map<String, dynamic> toJson() => {
        'id': id,
        'activity_package_id': activity_package_id,
        'availability_date': availability_date
      };
}
