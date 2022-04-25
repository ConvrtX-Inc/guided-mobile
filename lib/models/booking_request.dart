// ignore_for_file: public_member_api_docs, sort_constructors_first

class BookingRequest {
  String? id;
  String? userId;
  String? fromUserId;
  String? requestMsg;
  String? activityPackageId;
  String? statusId;
  String? bookingDateStart;
  String? bookingDateEnd;
  int? numberOfPerson;
  bool? isApproved;
  String? createdDate;
  String? updatedDate;
  Null? deletedDate;
  Status? status;
  String? sEntity;

  BookingRequest(
      {this.id,
      this.userId,
      this.fromUserId,
      this.requestMsg,
      this.activityPackageId,
      this.statusId,
      this.bookingDateStart,
      this.bookingDateEnd,
      this.numberOfPerson,
      this.isApproved,
      this.createdDate,
      this.updatedDate,
      this.deletedDate,
      this.status,
      this.sEntity});

  BookingRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fromUserId = json['from_user_id'];
    requestMsg = json['request_msg'];
    activityPackageId = json['activity_package_id'];
    statusId = json['status_id'];
    bookingDateStart = json['booking_date_start'];
    bookingDateEnd = json['booking_date_end'];
    numberOfPerson = json['number_of_person'];
    isApproved = json['is_approved'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    deletedDate = json['deleted_date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    sEntity = json['__entity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['from_user_id'] = fromUserId;
    data['request_msg'] = requestMsg;
    data['activity_package_id'] = activityPackageId;
    data['status_id'] = statusId;
    data['booking_date_start'] = bookingDateStart;
    data['booking_date_end'] = bookingDateEnd;
    data['number_of_person'] = numberOfPerson;
    data['is_approved'] = isApproved;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['deleted_date'] = deletedDate;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['__entity'] = sEntity;
    return data;
  }
}

class Status {
  String? id;
  String? statusName;
  bool? isActive;
  String? createdDate;
  String? updatedDate;
  Null? deletedAt;
  String? sEntity;

  Status(
      {this.id,
      this.statusName,
      this.isActive,
      this.createdDate,
      this.updatedDate,
      this.deletedAt,
      this.sEntity});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusName = json['status_name'];
    isActive = json['is_active'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    deletedAt = json['deletedAt'];
    sEntity = json['__entity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['status_name'] = statusName;
    data['is_active'] = isActive;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['deletedAt'] = deletedAt;
    data['__entity'] = sEntity;
    return data;
  }
}
