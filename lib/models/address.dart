// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

///Class
@JsonSerializable()
class Address {
  /// declaration
  final String address;

  /// Constructor
  const Address({
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
