// ignore_for_file: sort_constructors_first

/// Advertisement Model
class AdvertisementModelData {
  /// Constructor
  AdvertisementModelData({required this.advertisementDetails});

  /// advertisement details
  late List<AdvertisementDetailsModel> advertisementDetails =
      <AdvertisementDetailsModel>[];

  /// mapping
  
  AdvertisementModelData.fromJson(List<dynamic> parseJson)
      : advertisementDetails = parseJson
            .map((i) => AdvertisementDetailsModel.fromJson(i))
            .toList();
}

/// Advertisement details model
class AdvertisementDetailsModel {
  /// Contructor
  AdvertisementDetailsModel(
      {this.id = '',
      this.userId = '',
      this.title = '',
      this.country = '',
      this.address = '',
      this.street = '',
      this.city = '',
      this.province = '',
      this.zipCode = '',
      this.adDate,
      this.description = '',
      this.price = '',
      this.isPublished = false,
      this.createdDate});

  /// String property initialization
  final String id,
      userId,
      title,
      country,
      address,
      description,
      price,
      street,
      city,
      province,
      zipCode;

  /// Date time initialization
  final DateTime? adDate, createdDate;

  /// boolean initialization
  final bool isPublished;

  AdvertisementDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        userId = parseJson['user_id'],
        title = parseJson['title'],
        country = parseJson['country'],
        address = parseJson['address'],
        street = parseJson['street'],
        city = parseJson['city'],
        province = parseJson['province'],
        zipCode = parseJson['zip_code'],
        adDate = DateTime.parse(parseJson['ad_date']),
        description = parseJson['description'],
        price = parseJson['price'],
        isPublished = parseJson['is_published'],
        createdDate = DateTime.parse(parseJson['created_date']);
}
