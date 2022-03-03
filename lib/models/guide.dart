/// Model for Guide
class Guide {
  /// Constructor
  Guide({
    this.id = '',
    this.name = '',
    this.path = '',
    this.distance = '',
    this.featureImage = '',
  });

  /// Activity id
  final String id;

  /// Activity name
  final String name;

  /// Activity asset
  final String path;

  /// distance
  final String distance;

  /// featured image
  final String featureImage;
}
