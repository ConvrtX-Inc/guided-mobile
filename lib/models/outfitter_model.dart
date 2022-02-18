// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Outfitter model
class OutfitterModelData {
  /// Constructor
  OutfitterModelData(
      {required this.outfitterDetails, required this.outfitterImageDetails});
  // {required this.outfitterDetails});

  /// outfitter details
  late List<OutfitterDetailsModel> outfitterDetails = <OutfitterDetailsModel>[];

  /// outfitter image details
  late List<OutfitterImageDetailsModel> outfitterImageDetails =
      <OutfitterImageDetailsModel>[];

  /// mapping
  OutfitterModelData.fromJson(List<dynamic> parseJson, List<dynamic> parseJson2)
      // OutfitterModelData.fromJson(List<dynamic> parseJson)
      : outfitterDetails =
            parseJson.map((i) => OutfitterDetailsModel.fromJson(i)).toList(),
        outfitterImageDetails = parseJson2
            .map((e) => OutfitterImageDetailsModel.fromJson(e))
            .toList();
}

/// Outfitter details model
class OutfitterDetailsModel {
  /// Constructor
  OutfitterDetailsModel({
    this.id = '',
    this.userId = '',
    this.title = '',
    this.price = '',
    this.productLink = '',
    this.country = '',
    this.address = '',
    this.availabilityDate,
    this.description = '',
    this.isPublished = false,
    this.createdDate,
  });

  /// String property initialization
  final String id,
      userId,
      title,
      price,
      productLink,
      country,
      address,
      description;

  /// date time initialization
  final DateTime? availabilityDate, createdDate;

  /// boolean initialization
  final bool isPublished;

  /// mapping
  OutfitterDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        userId = parseJson['user_id'],
        title = parseJson['title'],
        price = parseJson['price'],
        productLink = parseJson['product_link'],
        country = parseJson['country'],
        address = parseJson['address'],
        availabilityDate = DateTime.parse(parseJson['availability_date']),
        description = parseJson['description'],
        isPublished = parseJson['is_published'],
        createdDate = DateTime.parse(parseJson['created_date']);
}

/// Outfitter image class
class OutfitterImageDetailsModel {
  /// Constructor
  OutfitterImageDetailsModel(
      {this.id = '', this.activityOutfitterId = '', this.snapshotImg = ''});

  /// String property initialization
  final String id, activityOutfitterId, snapshotImg;

  /// mapping
  OutfitterImageDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        activityOutfitterId = parseJson['activity_outfitter_id'],
        snapshotImg = parseJson['snapshot_img'];
}
