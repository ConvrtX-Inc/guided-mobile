/// User
// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_collection_literals, unnecessary_question_mark, prefer_void_to_null

class UserModel {
  String? token;
  User? user;

  UserModel({this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? countryCode;
  Null? isGuide;
  bool? isTraveller;
  bool? isForThePlanet;
  bool? isFirstAidTrained;
  String? about;
  bool? isTermsConditionsAgreed;
  Null? releaseWaiverData;
  String? userTypeId;
  String? provider;
  String? socialId;
  bool? isVerified;
  bool? isOnline;
  String? createdDate;
  String? updatedDate;
  Null? deletedAt;
  Null? photo;
  Null? status;
  String? sEntity;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNo,
      this.countryCode,
      this.isGuide,
      this.isTraveller,
      this.isForThePlanet,
      this.isFirstAidTrained,
      this.about,
      this.isTermsConditionsAgreed,
      this.releaseWaiverData,
      this.userTypeId,
      this.provider,
      this.socialId,
      this.isVerified,
      this.isOnline,
      this.createdDate,
      this.updatedDate,
      this.deletedAt,
      this.photo,
      this.status,
      this.sEntity});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    countryCode = json['country_code'];
    isGuide = json['is_guide'];
    isTraveller = json['is_traveller'];
    isForThePlanet = json['is_for_the_planet'];
    isFirstAidTrained = json['is_first_aid_trained'];
    about = json['about'];
    isTermsConditionsAgreed = json['is_terms_conditions_agreed'];
    releaseWaiverData = json['release_waiver_data'];
    userTypeId = json['user_type_id'];
    provider = json['provider'];
    socialId = json['socialId'];
    isVerified = json['is_verified'];
    isOnline = json['is_online'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    deletedAt = json['deleted_at'];
    photo = json['photo'];
    status = json['status'];
    sEntity = json['__entity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_no'] = phoneNo;
    data['country_code'] = countryCode;
    data['is_guide'] = isGuide;
    data['is_traveller'] = isTraveller;
    data['is_for_the_planet'] = isForThePlanet;
    data['is_first_aid_trained'] = isFirstAidTrained;
    data['about'] = about;
    data['is_terms_conditions_agreed'] = isTermsConditionsAgreed;
    data['release_waiver_data'] = releaseWaiverData;
    data['user_type_id'] = userTypeId;
    data['provider'] = provider;
    data['socialId'] = socialId;
    data['is_verified'] = isVerified;
    data['is_online'] = isOnline;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['deleted_at'] = deletedAt;
    data['photo'] = photo;
    data['status'] = status;
    data['__entity'] = sEntity;
    return data;
  }
}

class UserSingleton {
  static final UserSingleton _singleton = UserSingleton._internal();
  UserSingleton._internal();
  static UserSingleton get instance => _singleton;
  late UserModel user;
}
