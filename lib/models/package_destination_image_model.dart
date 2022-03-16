// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Pacakage Destination image model
class PackageDestinationImageModelData {
  /// Constructor
  PackageDestinationImageModelData(
      {required this.packageDestinationImageDetails});

  /// package destination image details
  late List<PackageDestinationImageDetailsModel>
      packageDestinationImageDetails = <PackageDestinationImageDetailsModel>[];
}

/// Outfitter image class
class PackageDestinationImageDetailsModel {
  /// Constructor
  PackageDestinationImageDetailsModel(
      {this.id = '', this.packageDestinationId = '', this.snapshotImg = ''});

  /// String property initialization
  final String id, packageDestinationId, snapshotImg;

  /// mapping
  PackageDestinationImageDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        packageDestinationId = parseJson['activity_package_destination_id'],
        snapshotImg = parseJson['snapshot_img'];
}
