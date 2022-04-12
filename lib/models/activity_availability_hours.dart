/// ActivityAvailability Model
// ignore_for_file: public_member_api_docs, sort_constructors_first

class ActivityAvailability {
  String? id;
  String? activityPackageId;
  String? availabilityDate;
  String? createdDate;
  String? updatedDate;
  Null? deletedDate;
  String? sEntity;
  List<ActivityAvailabilityHours>? activityAvailabilityHours;

  ActivityAvailability(
      {this.id,
      this.activityPackageId,
      this.availabilityDate,
      this.createdDate,
      this.updatedDate,
      this.deletedDate,
      this.sEntity,
      this.activityAvailabilityHours});

  ActivityAvailability.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityPackageId = json['activity_package_id'];
    availabilityDate = json['availability_date'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    deletedDate = json['deleted_date'];
    sEntity = json['__entity'];
    if (json['activity_availability_hours'] != null) {
      activityAvailabilityHours = <ActivityAvailabilityHours>[];
      json['activity_availability_hours'].forEach((v) {
        activityAvailabilityHours!.add(ActivityAvailabilityHours.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['activity_package_id'] = activityPackageId;
    data['availability_date'] = availabilityDate;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['deleted_date'] = deletedDate;
    data['__entity'] = sEntity;
    if (activityAvailabilityHours != null) {
      data['activity_availability_hours'] =
          activityAvailabilityHours!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityAvailabilityHours {
  String? id;
  String? activityAvailabilityId;
  String? availabilityDateHour;
  int? slots;
  String? createdDate;
  String? updatedDate;
  Null? deletedDate;
  String? sEntity;

  ActivityAvailabilityHours(
      {this.id,
      this.activityAvailabilityId,
      this.availabilityDateHour,
      this.slots,
      this.createdDate,
      this.updatedDate,
      this.deletedDate,
      this.sEntity});

  ActivityAvailabilityHours.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityAvailabilityId = json['activity_availability_id'];
    availabilityDateHour = json['availability_date_hour'];
    slots = json['slots'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    deletedDate = json['deleted_date'];
    sEntity = json['__entity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['activity_availability_id'] = activityAvailabilityId;
    data['availability_date_hour'] = availabilityDateHour;
    data['slots'] = slots;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['deleted_date'] = deletedDate;
    data['__entity'] = sEntity;
    return data;
  }
}
