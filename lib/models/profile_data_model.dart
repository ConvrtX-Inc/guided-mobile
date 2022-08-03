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
      this.firebaseProfilePicUrl = '',
      this.stripeAccountId = '',
      this.isFirstAidTrained,
      this.isForThePlanet,
      this.createdDate,
      this.birthDate = '',
      this.addressLine1 = '',
      this.addressLine2 = '',
      this.stripeCustomerId = '',
      this.country = '',
      this.defaultPaymentMethod = ''});

  /// String initialization
  String id,
      fullName,
      firstName,
      lastName,
      email,
      phoneNumber,
      countryCode,
      about,
      firebaseProfilePicUrl,
      stripeAccountId,
      birthDate,
      addressLine1,
      addressLine2,
      country,
      stripeCustomerId,
      defaultPaymentMethod;

  ///bool initialization
  bool? isForThePlanet, isFirstAidTrained;

  DateTime? createdDate;

  /// mapping
  ProfileDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        fullName = parseJson['full_name'] ??
            '${parseJson['first_name']} ${parseJson['last_name']}',
        firstName = parseJson['first_name'] ?? '',
        lastName = parseJson['last_name'] ?? '',
        email = parseJson['email'] ?? '',
        phoneNumber = parseJson['phone_no'] ?? '',
        countryCode = parseJson['country_code'] ?? '',
        about = parseJson['about'] ?? '',
        stripeAccountId = parseJson['stripe_account_id'] ?? '',
        firebaseProfilePicUrl = parseJson['profile_photo_firebase_url'] ?? '',
        isForThePlanet = parseJson['is_for_the_planet'] ?? '',
        isFirstAidTrained = parseJson['is_first_aid_trained'] ?? '',
        createdDate = DateTime.parse(parseJson['created_date']),
        addressLine1 = parseJson['address_line1'] ?? '',
        addressLine2 = parseJson['address_line2'] ?? '',
        birthDate = parseJson['birth_date'] ?? '',
        country = parseJson['country'] ?? '',
        stripeCustomerId = parseJson['stripe_customer_id'],
        defaultPaymentMethod = parseJson['default_payment_method'] ?? '';
}
