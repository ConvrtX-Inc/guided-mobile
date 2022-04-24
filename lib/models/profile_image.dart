///User Profile Image Model
class UserProfileImage {
  ///Constructor
  UserProfileImage(
      {this.id = '',
      this.userId = '',
      this.imageUrl1 = '',
      this.imageUrl2 = '',
      this.imageUrl3 = '',
      this.imageUrl4 = '',
      this.imageUrl5 = '',
      this.imageUrl6 = '',
      this.createdDate = ''});

  ///Initialization for id
  String id;

  ///Initialization for user id
  String userId;

  ///Initialization for image url 1
  String imageUrl1;

  ///Initialization for image url 2
  String imageUrl2;

  ///Initialization for image url 3
  String imageUrl3;

  ///Initialization for image url 4
  String imageUrl4;

  ///Initialization for image url 5
  String imageUrl5;

  ///Initialization for image url 6
  String imageUrl6;

  /// Initialization for created date
  String createdDate;

  ///Map data
  static UserProfileImage fromJson(Map<String, dynamic> json) =>
      UserProfileImage(
          id: json['id'],
          userId: json['user_id'],
          imageUrl1: json['image_firebase_url_1'] ?? '',
          imageUrl2: json['image_firebase_url_2'] ?? '',
          imageUrl3: json['image_firebase_url_3'] ?? '',
          imageUrl4: json['image_firebase_url_4'] ?? '',
          imageUrl5: json['image_firebase_url_5'] ?? '',
          imageUrl6: json['image_firebase_url_6'] ?? '',
          createdDate: json['created_date']);
}
