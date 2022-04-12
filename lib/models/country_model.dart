// // ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
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
