////
class PopularGuide {
  String? activityId;
  String? activityUserId;
  String? activityMainBadgeId;
  Null? activitySubBadgeIds;
  String? activityPackageNote;
  String? activityName;
  String? activityDescription;
  int? activityMaxTraveller;
  int? activityMinTraveller;
  String? activityCountry;
  String? activityAddress;
  String? activityServices;
  String? activityCreatedDate;
  String? activityUpdatedDate;
  String? activityBasePrice;
  String? activityExtraCostPerPerson;
  int? activityMaxExtraPerson;
  String? activityCurrencyId;
  String? activityPriceNote;
  bool? activityIsPublished;
  Null? activityDeletedAt;
  Null? badgeId;
  Null? badgeBadgeName;
  Null? badgeBadgeDescription;
  Null? badgeImgIcon;
  Null? badgeIsMainActivity;
  Null? badgeIsSubActivity;
  Null? badgeDeletedAt;
  int? reviews;
  double? distance;

  PopularGuide(
      {this.activityId,
      this.activityUserId,
      this.activityMainBadgeId,
      this.activitySubBadgeIds,
      this.activityPackageNote,
      this.activityName,
      this.activityDescription,
      this.activityMaxTraveller,
      this.activityMinTraveller,
      this.activityCountry,
      this.activityAddress,
      this.activityServices,
      this.activityCreatedDate,
      this.activityUpdatedDate,
      this.activityBasePrice,
      this.activityExtraCostPerPerson,
      this.activityMaxExtraPerson,
      this.activityCurrencyId,
      this.activityPriceNote,
      this.activityIsPublished,
      this.activityDeletedAt,
      this.badgeId,
      this.badgeBadgeName,
      this.badgeBadgeDescription,
      this.badgeImgIcon,
      this.badgeIsMainActivity,
      this.badgeIsSubActivity,
      this.badgeDeletedAt,
      this.reviews,
      this.distance});

  PopularGuide.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    activityUserId = json['activity_user_id'];
    activityMainBadgeId = json['activity_main_badge_id'];
    activitySubBadgeIds = json['activity_sub_badge_ids'];
    activityPackageNote = json['activity_package_note'];
    activityName = json['activity_name'];
    activityDescription = json['activity_description'];
    activityMaxTraveller = json['activity_max_traveller'];
    activityMinTraveller = json['activity_min_traveller'];
    activityCountry = json['activity_country'];
    activityAddress = json['activity_address'];
    activityServices = json['activity_services'];
    activityCreatedDate = json['activity_created_date'];
    activityUpdatedDate = json['activity_updated_date'];
    activityBasePrice = json['activity_base_price'];
    activityExtraCostPerPerson = json['activity_extra_cost_per_person'];
    activityMaxExtraPerson = json['activity_max_extra_person'];
    activityCurrencyId = json['activity_currency_id'];
    activityPriceNote = json['activity_price_note'];
    activityIsPublished = json['activity_is_published'];
    activityDeletedAt = json['activity_deletedAt'];
    badgeId = json['badge_id'];
    badgeBadgeName = json['badge_badge_name'];
    badgeBadgeDescription = json['badge_badge_description'];
    badgeImgIcon = json['badge_img_icon'];
    badgeIsMainActivity = json['badge_is_main_activity'];
    badgeIsSubActivity = json['badge_is_sub_activity'];
    badgeDeletedAt = json['badge_deletedAt'];
    reviews = json['reviews'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_id'] = this.activityId;
    data['activity_user_id'] = this.activityUserId;
    data['activity_main_badge_id'] = this.activityMainBadgeId;
    data['activity_sub_badge_ids'] = this.activitySubBadgeIds;
    data['activity_package_note'] = this.activityPackageNote;
    data['activity_name'] = this.activityName;
    data['activity_description'] = this.activityDescription;

    data['activity_max_traveller'] = this.activityMaxTraveller;
    data['activity_min_traveller'] = this.activityMinTraveller;
    data['activity_country'] = this.activityCountry;
    data['activity_address'] = this.activityAddress;
    data['activity_services'] = this.activityServices;
    data['activity_created_date'] = this.activityCreatedDate;
    data['activity_updated_date'] = this.activityUpdatedDate;
    data['activity_base_price'] = this.activityBasePrice;
    data['activity_extra_cost_per_person'] = this.activityExtraCostPerPerson;
    data['activity_max_extra_person'] = this.activityMaxExtraPerson;
    data['activity_currency_id'] = this.activityCurrencyId;
    data['activity_price_note'] = this.activityPriceNote;
    data['activity_is_published'] = this.activityIsPublished;
    data['activity_deletedAt'] = this.activityDeletedAt;
    data['badge_id'] = this.badgeId;
    data['badge_badge_name'] = this.badgeBadgeName;
    data['badge_badge_description'] = this.badgeBadgeDescription;
    data['badge_img_icon'] = this.badgeImgIcon;
    data['badge_is_main_activity'] = this.badgeIsMainActivity;
    data['badge_is_sub_activity'] = this.badgeIsSubActivity;
    data['badge_deletedAt'] = this.badgeDeletedAt;
    data['reviews'] = this.reviews;
    data['distance'] = this.distance;
    return data;
  }
}
