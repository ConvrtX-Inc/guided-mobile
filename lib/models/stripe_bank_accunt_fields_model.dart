///Stripe bank account fields model
class StripeBankAccountField{
  ///Constructor
  StripeBankAccountField({
    this.country = '',
    this.code = '',
    this.requiredFields =const []
});

  ///Initialization for country
 String country;

 ///Initialization for code
 String code;

 ///Initialization for required fields
 List<String> requiredFields;

  ///Mapping
  static StripeBankAccountField fromJson(Map<String, dynamic> json) =>
      StripeBankAccountField(
          country: json['country'],
          code: json['code'] ?? '',
          requiredFields: json['required_fields'].cast<String>());
}