////
class PopularGuide {
  String? userId;
  String? userFirstName;
  String? userLastName;
  String? userEmail;
  Null? userPhoneNo;
  bool? userIsForThePlanet;
  bool? userIsFirstAidTrained;
  String? activityId;
  String? activityUserId;
  String? activityMainBadgeId;
  String? activitySubBadgeIds;
  String? activityPackageNote;
  String? activityName;
  String? activityDescription;
  int? activityMaxTraveller;
  int? activityMinTraveller;
  String? activityCountry;
  String? activityAddress;
  Null? activityServices;
  String? activityCreatedDate;
  String? activityUpdatedDate;
  String? activityBasePrice;
  String? activityExtraCostPerPerson;
  int? activityMaxExtraPerson;
  String? activityCurrencyId;
  String? activityPriceNote;
  bool? activityIsPublished;
  Null? activityDeletedAt;
  String? badgeId;
  String? badgeBadgeName;
  String? badgeBadgeDescription;

  bool? badgeIsMainActivity;
  bool? badgeIsSubActivity;
  Null? badgeDeletedAt;
  int? reviews;
  double? distance;

  PopularGuide(
      {this.userId,
      this.userFirstName,
      this.userLastName,
      this.userEmail,
      this.userPhoneNo,
      this.userIsForThePlanet,
      this.userIsFirstAidTrained,
      this.activityId,
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
      this.badgeIsMainActivity,
      this.badgeIsSubActivity,
      this.badgeDeletedAt,
      this.reviews,
      this.distance});

  PopularGuide.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userFirstName = json['user_first_name'];
    userLastName = json['user_last_name'];
    userEmail = json['user_email'];
    userPhoneNo = json['user_phone_no'];
    userIsForThePlanet = json['user_is_for_the_planet'];
    userIsFirstAidTrained = json['user_is_first_aid_trained'];
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

    badgeIsMainActivity = json['badge_is_main_activity'];
    badgeIsSubActivity = json['badge_is_sub_activity'];
    badgeDeletedAt = json['badge_deletedAt'];
    reviews = json['reviews'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_first_name'] = this.userFirstName;
    data['user_last_name'] = this.userLastName;
    data['user_email'] = this.userEmail;
    data['user_phone_no'] = this.userPhoneNo;
    data['user_is_for_the_planet'] = this.userIsForThePlanet;
    data['user_is_first_aid_trained'] = this.userIsFirstAidTrained;
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

    data['badge_is_main_activity'] = this.badgeIsMainActivity;
    data['badge_is_sub_activity'] = this.badgeIsSubActivity;
    data['badge_deletedAt'] = this.badgeDeletedAt;
    data['reviews'] = this.reviews;
    data['distance'] = this.distance;
    return data;
  }
}
