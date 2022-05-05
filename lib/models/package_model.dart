// ignore_for_file: sort_constructors_first

/// Package Model
class PackageModelData {
  /// Constructor
  PackageModelData({required this.packageDetails});

  /// advertisement details
  late List<PackageDetailsModel> packageDetails = <PackageDetailsModel>[];

  /// mapping

  PackageModelData.fromJson(List<dynamic> parseJson)
      : packageDetails =
            parseJson.map((i) => PackageDetailsModel.fromJson(i)).toList();
}

/// Package Details model
class PackageDetailsModel {
  /// Contructor
  PackageDetailsModel(
      {this.id = '',
      this.userId = '',
      this.mainBadgeId = '',
      this.subBadgeId = '',
      this.packageNote = '',
      this.name = '',
      this.description = '',
      this.coverImg = '',
      this.maxTraveller = 0,
      this.minTraveller = 0,
      this.country = '',
      this.address = '',
      this.services = '',
      this.basePrice = '',
      this.extraCostPerPerson = '',
      this.maxExtraPerson = 0,
      this.currencyId = '',
      this.priceNote = '',
      this.isPublished = false,
      this.firebaseCoverImg = ''});

  /// String property initialization
  final String id,
      userId,
      mainBadgeId,
      subBadgeId,
      packageNote,
      name,
      description,
      coverImg,
      country,
      address,
      services,
      basePrice,
      extraCostPerPerson,
      currencyId,
      priceNote,
      firebaseCoverImg;

  /// int initialization
  final int maxExtraPerson, maxTraveller, minTraveller;

  /// boolean initialization
  final bool isPublished;

  PackageDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'] ?? '',
        userId = parseJson['user_id'] ?? '',
        mainBadgeId = parseJson['main_badge_id'] ?? '',
        subBadgeId = parseJson['sub_badge_ids'] ?? '',
        packageNote = parseJson['package_note'],
        name = parseJson['name'],
        description = parseJson['description'],
        coverImg = parseJson['cover_img'],
        maxTraveller = parseJson['max_traveller'],
        minTraveller = parseJson['min_traveller'],
        country = parseJson['country'],
        address = parseJson['address'],
        services = parseJson['services'] ?? '',
        basePrice = parseJson['base_price'],
        extraCostPerPerson = parseJson['extra_cost_per_person'],
        maxExtraPerson = parseJson['max_extra_person'],
        currencyId = parseJson['currency_id'],
        priceNote = parseJson['price_note'],
        isPublished = parseJson['is_published'],
        firebaseCoverImg = parseJson['firebase_cover_img'] ?? '';
}
