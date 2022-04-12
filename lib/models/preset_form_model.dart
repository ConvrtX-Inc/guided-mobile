/// Model for Preset Form Model
class PresetFormModel {
  /// Constructor
  PresetFormModel(
      {this.id = '',
      this.tourGuideId = '',
      this.type = '',
      this.description = ''});

  /// initialization for id
  final String id;

  /// initialization for tour guide id
  final String tourGuideId;

  /// initialization for type
  final String type;

  /// initialization for description
  late final String description;

  static PresetFormModel fromJson(Map<String, dynamic> json) => PresetFormModel(
      id: json['id'],
      tourGuideId: json['tour_guide_id'] ?? '',
      type: json['type'],
      description: json['description']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'tour_guide_id': tourGuideId,
        'type': type,
        'description': description
      };
}
