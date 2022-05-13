/// ActivityPackage model
// ignore_for_file: public_member_api_docs, sort_constructors_first

class ActivityPackage {
  String? id;
  String? userId;
  String? mainBadgeId;
  String? subBadgeIds;
  String? date;
  String? packageNote;
  String? name;
  String? description;
  String? included;
  String? notIncluded;
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
  String? firebaseCoverImg;
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
      this.date,
      this.packageNote,
      this.name,
      this.description,
      this.included,
      this.notIncluded,
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
      this.firebaseCoverImg,
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
    date = json['date'];
    packageNote = json['package_note'];
    name = json['name'];
    description = json['description'];
    included = json['included'] != null ? included = json['included'] : '';
    notIncluded =
        json['not_included'] != null ? notIncluded = json['included'] : '';
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
    firebaseCoverImg = json['firebase_cover_img'] != null
        ? firebaseCoverImg = json['firebase_cover_img']
        : '';
    premiumUser = json['premium_user'];
    deletedAt = json['deletedAt'];
    sEntity = json['__entity'];
    mainBadge = json['main_badge'] != null
        ? MainBadge.fromJson(json['main_badge'])
        : null;
    activityPackageDestination = json['activity_package_destination'] != null
        ? ActivityPackageDestination.fromJson(
            json['activity_package_destination'])
        : null;
    firebaseCoverImg = json['firebase_cover_img'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['main_badge_id'] = mainBadgeId;
    data['sub_badge_ids'] = subBadgeIds;
    data['date'] = date;
    data['package_note'] = packageNote;
    data['name'] = name;
    data['description'] = description;
    data['included'] = included;
    data['not_included'] = notIncluded;
    data['premium_user'] = premiumUser;
    data['cover_img'] = coverImg;
    data['activity_date'] = activityDate;
    data['max_traveller'] = maxTraveller;
    data['min_traveller'] = minTraveller;
    data['country'] = country;
    data['address'] = address;
    data['services'] = services;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['base_price'] = basePrice;
    data['max_price'] = maxPrice;
    data['package_total_cost'] = packageTotalCost;
    data['extra_cost_per_person'] = extraCostPerPerson;
    data['max_extra_person'] = maxExtraPerson;
    data['currency_id'] = currencyId;
    data['price_note'] = priceNote;
    data['is_published'] = isPublished;
    data['is_post'] = isPost;
    data['firebase_cover_img'] = firebaseCoverImg;
    data['deletedAt'] = deletedAt;
    data['__entity'] = sEntity;
    if (mainBadge != null) {
      data['main_badge'] = mainBadge!.toJson();
    }
    if (activityPackageDestination != null) {
      data['activity_package_destination'] =
          activityPackageDestination!.toJson();
    }
    return data;
  }
}

class MainBadge {
  String? id;
  String? badgeName;
  String? badgeDescription;
  String? imgIcon;
  Null? firebaseSnapshotImg;
  Null? filename;
  bool? isMainActivity;
  bool? isSubActivity;
  Null? deletedAt;
  String? sEntity;

  MainBadge(
      {this.id,
      this.badgeName,
      this.badgeDescription,
      this.imgIcon,
      this.firebaseSnapshotImg,
      this.filename,
      this.isMainActivity,
      this.isSubActivity,
      this.deletedAt,
      this.sEntity});

  MainBadge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    badgeName = json['badge_name'];
    badgeDescription = json['badge_description'];
    imgIcon = json['img_icon'];
    firebaseSnapshotImg = json['firebase_snapshot_img'];
    filename = json['filename'];
    isMainActivity = json['is_main_activity'];
    isSubActivity = json['is_sub_activity'];
    deletedAt = json['deletedAt'];
    sEntity = json['__entity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['badge_name'] = badgeName;
    data['badge_description'] = badgeDescription;
    data['img_icon'] = imgIcon;
    data['firebase_snapshot_img'] = firebaseSnapshotImg;
    data['filename'] = filename;
    data['is_main_activity'] = isMainActivity;
    data['is_sub_activity'] = isSubActivity;
    data['deletedAt'] = deletedAt;
    data['__entity'] = sEntity;
    return data;
  }
}

class BadgeImgIcon {
  String? type;
  List<int>? data;

  BadgeImgIcon({this.type, this.data});

  BadgeImgIcon.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['data'] = this.data;
    return data;
  }
}

class ActivityPackageDestination {
  String? activityPackageDestinationId;
  String? activityPackageDestinationActivityPackageId;
  String? activityPackageDestinationPlaceName;
  String? activityPackageDestinationPlaceDescription;
  String? activityPackageDestinationLatitude;
  String? activityPackageDestinationLongitude;
  String? activityPackageDestinationCode;
  String? activityPackageDestinationCreatedDate;
  String? activityPackageDestinationUpdatedDate;
  Null? activityPackageDestinationDeletedAt;

  ActivityPackageDestination(
      {this.activityPackageDestinationId,
      this.activityPackageDestinationActivityPackageId,
      this.activityPackageDestinationPlaceName,
      this.activityPackageDestinationPlaceDescription,
      this.activityPackageDestinationLatitude,
      this.activityPackageDestinationLongitude,
      this.activityPackageDestinationCode,
      this.activityPackageDestinationCreatedDate,
      this.activityPackageDestinationUpdatedDate,
      this.activityPackageDestinationDeletedAt});

  ActivityPackageDestination.fromJson(Map<String, dynamic> json) {
    activityPackageDestinationId = json['activity_package_destination_id'];
    activityPackageDestinationActivityPackageId =
        json['activity_package_destination_activity_package_id'];
    activityPackageDestinationPlaceName =
        json['activity_package_destination_place_name'];
    activityPackageDestinationPlaceDescription =
        json['activity_package_destination_place_description'];
    activityPackageDestinationLatitude =
        json['activity_package_destination_latitude'];
    activityPackageDestinationLongitude =
        json['activity_package_destination_longitude'];
    activityPackageDestinationCode =
        json['activity_package_destination_code'] != null
            ? activityPackageDestinationCode =
                json['activity_package_destination_code']
            : '';
    activityPackageDestinationCreatedDate =
        json['activity_package_destination_created_date'];
    activityPackageDestinationUpdatedDate =
        json['activity_package_destination_updated_date'];
    activityPackageDestinationDeletedAt =
        json['activity_package_destination_deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_package_destination_id'] = activityPackageDestinationId;
    data['activity_package_destination_activity_package_id'] =
        activityPackageDestinationActivityPackageId;
    data['activity_package_destination_place_name'] =
        activityPackageDestinationPlaceName;
    data['activity_package_destination_place_description'] =
        activityPackageDestinationPlaceDescription;
    data['activity_package_destination_latitude'] =
        activityPackageDestinationLatitude;
    data['activity_package_destination_longitude'] =
        activityPackageDestinationLongitude;
    data['activity_package_destination_code'] = activityPackageDestinationCode;
    data['activity_package_destination_created_date'] =
        activityPackageDestinationCreatedDate;
    data['activity_package_destination_updated_date'] =
        activityPackageDestinationUpdatedDate;
    data['activity_package_destination_deletedAt'] =
        activityPackageDestinationDeletedAt;
    return data;
  }
}
