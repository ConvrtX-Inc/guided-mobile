// ignore_for_file: sort_constructors_first

/// User List Model
class UserListModel {
  /// Constructor
  UserListModel({required this.userDetails});

  /// advertisement details
  late List<UserDetailsModel> userDetails = <UserDetailsModel>[];

  /// mapping

  UserListModel.fromJson(List<dynamic> parseJson)
      : userDetails =
            parseJson.map((i) => UserDetailsModel.fromJson(i)).toList();
}

/// Package Details model
class UserDetailsModel {
  /// Contructor
  UserDetailsModel(
      {this.id = '',
      this.fullName = '',
      this.email = '',
      this.phoneNumber = '',
      this.firebaseImg = '',
      this.isTraveller = false,
      this.isFirstAid = false,
      this.createdDate});

  /// String property initialization
  final String id, fullName, email, phoneNumber, firebaseImg;

  /// boolean initialization
  final bool isTraveller, isFirstAid;

  final DateTime? createdDate;

  /// mapping
  UserDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'] ?? '',
        fullName = parseJson['full_name'] ?? '',
        email = parseJson['email'] ?? '',
        phoneNumber = parseJson['phone_no'] ?? '',
        firebaseImg = parseJson['profile_photo_firebase_url'] ?? '',
        isTraveller = parseJson['is_traveller'] ?? false,
        isFirstAid = parseJson['is_first_aid_trained'] ?? false,
        createdDate = DateTime.parse(parseJson['created_date']);
}
