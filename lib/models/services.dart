// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'services.g.dart';

///Class
@JsonSerializable()
class Services {
  /// declaration
  final String services;

  /// Constructor
  const Services({
    required this.services,
  });

  factory Services.fromJson(Map<String, dynamic> json) => _$ServicesFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}
