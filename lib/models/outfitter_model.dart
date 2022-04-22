// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Outfitter model
class OutfitterModelData {
  /// Constructor
  OutfitterModelData(
      {required this.outfitterDetails});

  /// outfitter details
  late List<OutfitterDetailsModel> outfitterDetails = <OutfitterDetailsModel>[];

  /// mapping
  OutfitterModelData.fromJson(List<dynamic> parseJson)
      : outfitterDetails =
            parseJson.map((i) => OutfitterDetailsModel.fromJson(i)).toList();
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
    this.street = '',
    this.city = '',
    this.province = '',
    this.zipCode = '',
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
      street,
      city,
      province,
      zipCode,
      description;

  /// date time initialization
  final DateTime? availabilityDate, createdDate;

  /// boolean initialization
  final bool isPublished;

  /// mapping
  OutfitterDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        userId = parseJson['user_id'],
        title = parseJson['title'] ?? '',
        price = parseJson['price'] ?? '',
        productLink = parseJson['product_link'] ?? '',
        country = parseJson['country'] ?? '',
        address = parseJson['address'] ?? '',
        street = parseJson['street'] ?? '',
        city = parseJson['city'] ?? '',
        province = parseJson['province'] ?? '',
        zipCode = parseJson['zip_code'] ?? '',
        availabilityDate = DateTime.parse(parseJson['availability_date']),
        description = parseJson['description'] ?? '',
        isPublished = parseJson['is_published'],
        createdDate = DateTime.parse(parseJson['created_date']);
}