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
  String? coverImg;
  int? maxTraveller;
  int? minTraveller;
  String? country;
  String? address;
  String? services;
  String? createdDate;
  String? updatedDate;
  String? basePrice;
  String? extraCostPerPerson;
  int? maxExtraPerson;
  String? currencyId;
  String? priceNote;
  bool? isPublished;
  bool? isPost;
  Null? deletedAt;
  Destination? destination;
  String? sEntity;
  String? distance;
  String? timeToTravel;

  ActivityPackage(
      {this.id,
      this.userId,
      this.mainBadgeId,
      this.subBadgeIds,
      this.packageNote,
      this.name,
      this.description,
      this.coverImg,
      this.maxTraveller,
      this.minTraveller,
      this.country,
      this.address,
      this.services,
      this.createdDate,
      this.updatedDate,
      this.basePrice,
      this.extraCostPerPerson,
      this.maxExtraPerson,
      this.currencyId,
      this.priceNote,
      this.isPublished,
      this.isPost,
      this.deletedAt,
      this.destination,
      this.sEntity,
      this.distance,
      this.timeToTravel});

  ActivityPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mainBadgeId = json['main_badge_id'];
    subBadgeIds = json['sub_badge_ids'];
    packageNote = json['package_note'];
    name = json['name'];
    description = json['description'];
    coverImg = json['cover_img'];
    maxTraveller = json['max_traveller'];
    minTraveller = json['min_traveller'];
    country = json['country'];
    address = json['address'];
    services = json['services'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    basePrice = json['base_price'];
    extraCostPerPerson = json['extra_cost_per_person'];
    maxExtraPerson = json['max_extra_person'];
    currencyId = json['currency_id'];
    priceNote = json['price_note'];
    isPublished = json['is_published'];
    isPost = json['is_post'];
    deletedAt = json['deletedAt'];
    destination = json['destination'] != null
        ? new Destination.fromJson(json['destination'])
        : null;
    sEntity = json['__entity'];
    distance = json['distance'];
    timeToTravel = json['time_to_travel'];
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
    data['cover_img'] = this.coverImg;
    data['max_traveller'] = this.maxTraveller;
    data['min_traveller'] = this.minTraveller;
    data['country'] = this.country;
    data['address'] = this.address;
    data['services'] = this.services;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['base_price'] = this.basePrice;
    data['extra_cost_per_person'] = this.extraCostPerPerson;
    data['max_extra_person'] = this.maxExtraPerson;
    data['currency_id'] = this.currencyId;
    data['price_note'] = this.priceNote;
    data['is_published'] = this.isPublished;
    data['is_post'] = this.isPost;
    data['deletedAt'] = this.deletedAt;
    if (this.destination != null) {
      data['destination'] = this.destination!.toJson();
    }
    data['__entity'] = this.sEntity;
    data['distance'] = this.distance;
    data['time_to_travel'] = this.timeToTravel;
    return data;
  }
}

class Destination {
  String? id;
  String? activityPackageId;
  String? placeName;
  String? placeDescription;
  String? latitude;
  String? longitude;
  String? createdDate;
  String? updatedDate;
  Null? deletedAt;
  DestinationImage? destinationImage;

  Destination(
      {this.id,
      this.activityPackageId,
      this.placeName,
      this.placeDescription,
      this.latitude,
      this.longitude,
      this.createdDate,
      this.updatedDate,
      this.deletedAt,
      this.destinationImage});

  Destination.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityPackageId = json['activity_package_id'];
    placeName = json['place_name'];
    placeDescription = json['place_description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    deletedAt = json['deletedAt'];
    destinationImage = json['destinationImage'] != null
        ? new DestinationImage.fromJson(json['destinationImage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activity_package_id'] = this.activityPackageId;
    data['place_name'] = this.placeName;
    data['place_description'] = this.placeDescription;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['deletedAt'] = this.deletedAt;
    if (this.destinationImage != null) {
      data['destinationImage'] = this.destinationImage!.toJson();
    }
    return data;
  }
}

class DestinationImage {
  String? id;
  String? activityPackageDestinationId;
  SnapshotImg? snapshotImg;
  String? createdDate;
  String? updatedDate;
  Null? deletedAt;

  DestinationImage(
      {this.id,
      this.activityPackageDestinationId,
      this.snapshotImg,
      this.createdDate,
      this.updatedDate,
      this.deletedAt});

  DestinationImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityPackageDestinationId = json['activity_package_destination_id'];
    snapshotImg = json['snapshot_img'] != null
        ? new SnapshotImg.fromJson(json['snapshot_img'])
        : null;
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activity_package_destination_id'] = this.activityPackageDestinationId;
    if (this.snapshotImg != null) {
      data['snapshot_img'] = this.snapshotImg!.toJson();
    }
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

class SnapshotImg {
  String? type;
  List<int>? data;

  SnapshotImg({this.type, this.data});

  SnapshotImg.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    return data;
  }
}
