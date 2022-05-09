import 'package:guided/utils/mixins/global_mixin.dart';

/// SettingsAvailability Model
class BecomeAGudeModel {
  ///Constructor
  BecomeAGudeModel(
      {this.id = '',
        this.userId = '',
        this.firstName= '',
        this.lastName = '',
        this.email = '',
        this.phoneNo = '',
        this.activities = '',
        this.province = '',
        this.city = '',
        this.isApproved,
        this.goodGuideReason = '',
        this.adventuresToHost = '',
        this.adventureLocation = '',
        this.standoutReason = '',
        this.guidedReason = '',
        this.whereDidYouHearUs = '',
        this.whereDidYouHearUsReason = '',
        this.isFirstAid,
        this.certificateName = '',
        this.imageFirebaseUrl = '',
        this.certDesc = '',
      });

  /// initialization for id
  String? id;

  /// initialization for user id
  String? userId;

  /// initialization for is firstName
  String? firstName;

  /// initialization for lastName
  String? lastName;

  /// initialization for email
  String? email;

  /// initialization for phoneNo
  String? phoneNo;

  /// initialization for activities
  String? activities;

  /// initialization for province
  String? province;

  /// initialization for city
  String? city;

  /// initialization for isApproved
  bool? isApproved;

  /// initialization for goodGuideReason
  String? goodGuideReason;

  /// initialization for adventuresToHost
  String? adventuresToHost;

  /// initialization for adventureLocation
  String? adventureLocation;

  /// initialization for standoutReason
  String? standoutReason;

  /// initialization for guidedReason
  String? guidedReason;

  /// initialization for whereDidYouHearUs
  String? whereDidYouHearUs;

  /// initialization for whereDidYouHearUsReason
  String? whereDidYouHearUsReason;

  /// initialization for isFirstAid
  bool? isFirstAid;

  /// initialization for certificateName
  String? certificateName;

  /// initialization for imageFirebaseUrl
  String? imageFirebaseUrl;

  /// initialization for cert desc
  String? certDesc;

  // factory SettingsAvailabilityModel.fromJson(Map<String, dynamic> json) => SettingsAvailabilityModel(
  //   id: json['id'],
  //   userId: json['user_id'],
  //   isAvailable: json['is_available'],
  //   reason: json['reason'],
  //   returnDate: json['return_date'],
  // );

  BecomeAGudeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName= json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    activities = json['activities'];
    province = json['province'];
    city = json['city'];
    isApproved = json['is_approved'];
    goodGuideReason = json['good_guide_reason'];
    adventuresToHost = json['adventures_to_host'];
    adventureLocation = json['adventure_location'];
    standoutReason = json['standout_reason'];
    guidedReason = json['guided_reason'];
    whereDidYouHearUs = json['where_did_you_hear_us'];
    whereDidYouHearUsReason = json['where_did_you_hear_us_reason'];
    isFirstAid = json['is_first_aid'];
    certificateName = json['certificate_name'];
    imageFirebaseUrl = json['image_firebase_url'];
    certDesc = json['description'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = id;
  //   data['user_id'] = userId;
  //   data['is_approved'] = isApproved;
  //   return data;
  // }
}