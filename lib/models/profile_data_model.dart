/// Profile Details Model
// ignore_for_file: sort_constructors_first

class ProfileDetailsModel {
  /// Constructor
  ProfileDetailsModel(
      {this.id = '',
      this.fullName = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.phoneNumber = '',
      this.countryCode = '',
      this.about = '',
      this.firebaseProfilePicUrl = ''
      });

  /// String initialization
  final String id,
      fullName,
      firstName,
      lastName,
      email,
      phoneNumber,
      countryCode,
      about,
  firebaseProfilePicUrl;

  /// mapping
  ProfileDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        fullName = parseJson['full_name'] ?? '',
        firstName = parseJson['first_name'] ?? '',
        lastName = parseJson['last_name'] ?? '',
        email = parseJson['email'] ?? '',
        phoneNumber = parseJson['phone_no'] ?? '',
        countryCode = parseJson['country_code'] ?? '',
        about = parseJson['about'] ?? '',
        firebaseProfilePicUrl = parseJson['profile_photo_firebase_url'] ?? ''
  ;
}
