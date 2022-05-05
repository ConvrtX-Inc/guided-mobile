import 'package:guided/utils/mixins/global_mixin.dart';

/// SettingsAvailability Model
class SettingsAvailabilityModel {
  ///Constructor
  SettingsAvailabilityModel(
      {this.id = '',
        this.userId = '',
        this.isAvailable=false,
        this.reason = '',
        this.returnDate,
      });

  /// initialization for id
  String? id;

  /// initialization for user id
  String? userId;

  /// initialization for is available
  bool? isAvailable;

  /// initialization for reason
  String? reason;

  /// initialization for return date
  String? returnDate;

  // factory SettingsAvailabilityModel.fromJson(Map<String, dynamic> json) => SettingsAvailabilityModel(
  //   id: json['id'],
  //   userId: json['user_id'],
  //   isAvailable: json['is_available'],
  //   reason: json['reason'],
  //   returnDate: json['return_date'],
  // );

  SettingsAvailabilityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    isAvailable = json['is_available'];
    reason = json['reason'];
    returnDate = json['return_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['is_available'] = isAvailable;
    data['reason'] = reason;
    data['return_date'] = returnDate;
    return data;
  }
}