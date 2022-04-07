///Country Currency Model
class CountryCurrencyModel {
  ///Constructor
  CountryCurrencyModel(
      {this.countryCode = '', this.currencyCode = '', this.countryName = ''});

  ///Initialization for country code
  String countryCode;

  ///Initialization for country name
  String countryName;

  ///Initialization for currency code
  String currencyCode;

  ///Mapping
  static CountryCurrencyModel fromJson(Map<String, dynamic> json) =>
      CountryCurrencyModel(
          countryCode: json['countryCode'],
          currencyCode: json['currencyCode'],
          countryName: json['countryName']);
}
