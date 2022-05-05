// ignore_for_file: sort_constructors_first

/// Package Destination Model
class PackageDestinationModelData {
  /// Constructor
  PackageDestinationModelData({required this.packageDestinationDetails});

  /// package destination details
  late List<PackageDestinationDetailsModel> packageDestinationDetails =
      <PackageDestinationDetailsModel>[];

  /// mapping
  PackageDestinationModelData.fromJson(List<dynamic> parseJson)
      : packageDestinationDetails = parseJson
            .map((i) => PackageDestinationDetailsModel.fromJson(i))
            .toList();
}

/// Package Destination details model
class PackageDestinationDetailsModel {
  /// Contructor
  PackageDestinationDetailsModel(
      {this.id = '',
      this.activityPackageId = '',
      this.name = '',
      this.description = '',
      this.latitude = '',
      this.longitude = '',
      this.code = ''});

  /// String property initialization
  final String id,
      activityPackageId,
      name,
      description,
      latitude,
      longitude,
      code;

  PackageDestinationDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        activityPackageId = parseJson['activity_package_id'],
        name = parseJson['place_name'],
        description = parseJson['place_description'],
        latitude = parseJson['latitude'],
        longitude = parseJson['longitude'],
        code = parseJson['code'] ?? '';
}
