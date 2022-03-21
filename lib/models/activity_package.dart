/// ActivityPackage model
// ignore_for_file: public_member_api_docs, sort_constructors_first

class ActivityPackage {
  String? id;
  String? userId;
  String? mainBadgeId;
  // Null? subBadgeIds;
  String? packageNote;
  String? name;
  String? description;
  String? coverImg;
  int? maxTraveller;
  int? minTraveller;
  String? country;
  String? address;
  // List<String>? services;
  String? createdDate;
  String? updatedDate;
  String? basePrice;
  String? extraCostPerPerson;
  int? maxExtraPerson;
  String? currencyId;
  String? priceNote;
  bool? isPublished;

  String? sEntity;

  ActivityPackage(
      {this.id,
      this.userId,
      this.mainBadgeId,
      // this.subBadgeIds,
      this.packageNote,
      this.name,
      this.description,
      this.coverImg,
      this.maxTraveller,
      this.minTraveller,
      this.country,
      this.address,
      // this.services,
      this.createdDate,
      this.updatedDate,
      this.basePrice,
      this.extraCostPerPerson,
      this.maxExtraPerson,
      this.currencyId,
      this.priceNote,
      this.isPublished,
      // this.deletedAt,
      this.sEntity});

  ActivityPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mainBadgeId = json['main_badge_id'];
    // subBadgeIds = json['sub_badge_ids'];
    packageNote = json['package_note'];
    name = json['name'];
    description = json['description'];
    coverImg = json['cover_img'];
    maxTraveller = json['max_traveller'];
    minTraveller = json['min_traveller'];
    country = json['country'];
    address = json['address'];
    // services = json['services'].cast<String>();
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    basePrice = json['base_price'];
    extraCostPerPerson = json['extra_cost_per_person'];
    maxExtraPerson = json['max_extra_person'];
    currencyId = json['currency_id'];
    priceNote = json['price_note'];
    isPublished = json['is_published'];
    // deletedAt = json['deletedAt'];
    sEntity = json['__entity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['main_badge_id'] = mainBadgeId;
    // data['sub_badge_ids'] = this.subBadgeIds;
    data['package_note'] = packageNote;
    data['name'] = name;
    data['description'] = description;
    data['cover_img'] = coverImg;
    data['max_traveller'] = maxTraveller;
    data['min_traveller'] = minTraveller;
    data['country'] = country;
    data['address'] = address;
    // data['services'] = services;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['base_price'] = basePrice;
    data['extra_cost_per_person'] = extraCostPerPerson;
    data['max_extra_person'] = maxExtraPerson;
    data['currency_id'] = currencyId;
    data['price_note'] = priceNote;
    data['is_published'] = isPublished;
    // data['deletedAt'] = this.deletedAt;
    data['__entity'] = sEntity;
    return data;
  }
}
