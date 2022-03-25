// // ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
// /// Country Model
// class CountryModel {
//   /// Constructor
//   CountryModel({required this.countryDetails});

//   /// Country Model details
//   late List<CountryDetailsModel> countryDetails = <CountryDetailsModel>[];
// }

// /// Country Model class
// class CountryDetailsModel {
//   /// Constructor
//   CountryDetailsModel({this.id = '', this.name = '', this.code = ''});

//   /// String property initialization
//   final String id, name, code;

//   /// mapping
//   CountryDetailsModel.fromJson(Map<String, dynamic> parseJson)
//       : id = parseJson['id'],
//         name = parseJson['name'],
//         code = parseJson['code'];
// }

/// Model for Country
class CountryModel {
  /// Constructor
  CountryModel({this.id = '', this.name = '', this.code = ''});

  /// initialization for id
  final String id;

  /// initialization for name
  final String name;

  /// initialization for code
  final String code;

  static CountryModel fromJson(Map<String, dynamic> json) => CountryModel(
        id: json['id'],
        name: json['name'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
      };
}
