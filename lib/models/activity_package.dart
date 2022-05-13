/// ActivityPackage model
// ignore_for_file: public_member_api_docs, sort_constructors_first

class ActivityPackage {
  String? id;
  String? userId;
  String? mainBadgeId;
  String? subBadgeIds;
  String? packageNote;
  String? name;
  String? description;
  bool? premiumUser;
  String? coverImg;
  String? activityDate;
  int? maxTraveller;
  int? minTraveller;
  String? country;
  String? address;
  String? services;
  String? createdDate;
  String? updatedDate;
  String? basePrice;
  String? maxPrice;
  String? packageTotalCost;
  String? extraCostPerPerson;
  int? maxExtraPerson;
  String? currencyId;
  String? priceNote;
  bool? isPublished;
  bool? isPost;
  Null? deletedAt;
  String? sEntity;
  MainBadge? mainBadge;
  ActivityPackageDestination? activityPackageDestination;
  String? firebaseCoverImg;

  ActivityPackage(
      {this.id,
      this.userId,
      this.mainBadgeId,
      this.subBadgeIds,
      this.packageNote,
      this.name,
      this.description,
      this.premiumUser,
      this.coverImg,
      this.activityDate,
      this.maxTraveller,
      this.minTraveller,
      this.country,
      this.address,
      this.services,
      this.createdDate,
      this.updatedDate,
      this.basePrice,
      this.maxPrice,
      this.packageTotalCost,
      this.extraCostPerPerson,
      this.maxExtraPerson,
      this.currencyId,
      this.priceNote,
      this.isPublished,
      this.isPost,
      this.deletedAt,
      this.sEntity,
      this.mainBadge,
      this.activityPackageDestination,
      this.firebaseCoverImg =''});

  ActivityPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mainBadgeId = json['main_badge_id'];
    subBadgeIds = json['sub_badge_ids'];
    packageNote = json['package_note'];
    name = json['name'];
    description = json['description'];
    premiumUser = json['premium_user'];
    coverImg = json['cover_img'];
    activityDate = json['activity_date'];
    maxTraveller = json['max_traveller'];
    minTraveller = json['min_traveller'];
    country = json['country'];
    address = json['address'];
    services = json['services'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    basePrice = json['base_price'];
    maxPrice = json['max_price'];
    packageTotalCost = json['package_total_cost'];
    extraCostPerPerson = json['extra_cost_per_person'];
    maxExtraPerson = json['max_extra_person'];
    currencyId = json['currency_id'];
    priceNote = json['price_note'];
    isPublished = json['is_published'];
    isPost = json['is_post'];
    deletedAt = json['deletedAt'];
    sEntity = json['__entity'];
    mainBadge = json['main_badge'] != null
        ? new MainBadge.fromJson(json['main_badge'])
        : null;
    activityPackageDestination = json['activity_package_destination'] != null
        ? new ActivityPackageDestination.fromJson(
            json['activity_package_destination'])
        : null;
    firebaseCoverImg = json['firebase_cover_img'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['main_badge_id'] = this.mainBadgeId;
    data['sub_badge_ids'] = this.subBadgeIds;
    data['package_note'] = this.packageNote;
    data['name'] = this.name;
    data['description'] = this.description;
    data['premium_user'] = this.premiumUser;
    data['cover_img'] = this.coverImg;
    data['activity_date'] = this.activityDate;
    data['max_traveller'] = this.maxTraveller;
    data['min_traveller'] = this.minTraveller;
    data['country'] = this.country;
    data['address'] = this.address;
    data['services'] = this.services;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['base_price'] = this.basePrice;
    data['max_price'] = this.maxPrice;
    data['package_total_cost'] = this.packageTotalCost;
    data['extra_cost_per_person'] = this.extraCostPerPerson;
    data['max_extra_person'] = this.maxExtraPerson;
    data['currency_id'] = this.currencyId;
    data['price_note'] = this.priceNote;
    data['is_published'] = this.isPublished;
    data['is_post'] = this.isPost;
    data['deletedAt'] = this.deletedAt;
    data['__entity'] = this.sEntity;
    if (this.mainBadge != null) {
      data['main_badge'] = this.mainBadge!.toJson();
    }
    if (this.activityPackageDestination != null) {
      data['activity_package_destination'] =
          this.activityPackageDestination!.toJson();
    }
    return data;
  }
}

class MainBadge {
  String? id;
  String? badgeName;
  String? badgeDescription;
  String? imgIcon;
  bool? isMainActivity;
  bool? isSubActivity;
  Null? deletedAt;
  String? sEntity;

  MainBadge(
      {this.id,
      this.badgeName,
      this.badgeDescription,
      this.imgIcon,
      this.isMainActivity,
      this.isSubActivity,
      this.deletedAt,
      this.sEntity});

  MainBadge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    badgeName = json['badge_name'];
    badgeDescription = json['badge_description'];
    imgIcon = json['img_icon'];
    isMainActivity = json['is_main_activity'];
    isSubActivity = json['is_sub_activity'];
    deletedAt = json['deletedAt'];
    sEntity = json['__entity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['badge_name'] = this.badgeName;
    data['badge_description'] = this.badgeDescription;
    data['img_icon'] = this.imgIcon;
    data['is_main_activity'] = this.isMainActivity;
    data['is_sub_activity'] = this.isSubActivity;
    data['deletedAt'] = this.deletedAt;
    data['__entity'] = this.sEntity;
    return data;
  }
}

class ActivityPackageDestination {
  String? activitypackagedestinationId;
  String? activitypackagedestinationActivityPackageId;
  String? activitypackagedestinationPlaceName;
  String? activitypackagedestinationPlaceDescription;
  String? activitypackagedestinationLatitude;
  String? activitypackagedestinationLongitude;
  String? activitypackagedestinationCreatedDate;
  String? activitypackagedestinationUpdatedDate;
  Null? activitypackagedestinationDeletedAt;

  ActivityPackageDestination(
      {this.activitypackagedestinationId,
      this.activitypackagedestinationActivityPackageId,
      this.activitypackagedestinationPlaceName,
      this.activitypackagedestinationPlaceDescription,
      this.activitypackagedestinationLatitude,
      this.activitypackagedestinationLongitude,
      this.activitypackagedestinationCreatedDate,
      this.activitypackagedestinationUpdatedDate,
      this.activitypackagedestinationDeletedAt});

  ActivityPackageDestination.fromJson(Map<String, dynamic> json) {
    activitypackagedestinationId = json['activitypackagedestination_id'];
    activitypackagedestinationActivityPackageId =
        json['activitypackagedestination_activity_package_id'];
    activitypackagedestinationPlaceName =
        json['activitypackagedestination_place_name'];
    activitypackagedestinationPlaceDescription =
        json['activitypackagedestination_place_description'];
    activitypackagedestinationLatitude =
        json['activitypackagedestination_latitude'];
    activitypackagedestinationLongitude =
        json['activitypackagedestination_longitude'];
    activitypackagedestinationCreatedDate =
        json['activitypackagedestination_created_date'];
    activitypackagedestinationUpdatedDate =
        json['activitypackagedestination_updated_date'];
    activitypackagedestinationDeletedAt =
        json['activitypackagedestination_deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activitypackagedestination_id'] = this.activitypackagedestinationId;
    data['activitypackagedestination_activity_package_id'] =
        this.activitypackagedestinationActivityPackageId;
    data['activitypackagedestination_place_name'] =
        this.activitypackagedestinationPlaceName;
    data['activitypackagedestination_place_description'] =
        this.activitypackagedestinationPlaceDescription;
    data['activitypackagedestination_latitude'] =
        this.activitypackagedestinationLatitude;
    data['activitypackagedestination_longitude'] =
        this.activitypackagedestinationLongitude;
    data['activitypackagedestination_created_date'] =
        this.activitypackagedestinationCreatedDate;
    data['activitypackagedestination_updated_date'] =
        this.activitypackagedestinationUpdatedDate;
    data['activitypackagedestination_deletedAt'] =
        this.activitypackagedestinationDeletedAt;
    return data;
  }
}
