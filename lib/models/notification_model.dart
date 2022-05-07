/// Notification Model
class NotificationModel {
  ///Initialization for strings
  String? id,
      fromUserId,
      toUserId,
      title,
      notificationMsg,
      bookingRequestId,
      type,
      transactionNo,
      createdDate,
      bookingRequestStatus,
      updatedDate;

  /// Initialization for from User
  FromUser? fromUser;

  /// Constructor
  NotificationModel(
      {this.id,
      this.fromUserId,
      this.toUserId,
      this.title,
      this.notificationMsg,
      this.bookingRequestId,
      this.type,
      this.createdDate,
      this.updatedDate,
      this.bookingRequestStatus,
      this.transactionNo,
      this.fromUser});

  /// Map Data
  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
    title = json['title'];
    notificationMsg = json['notification_msg'];
    bookingRequestId = json['booking_request_id'];
    type = json['type'];
    transactionNo = json['transaction_no'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    bookingRequestStatus = json['booking_request'] != null
        ? json['booking_request']['status'] ?? ''
        : '';
    fromUser =
        json['from_user'] != null ? FromUser.fromJson(json['from_user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['from_user_id'] = fromUserId;
    data['to_user_id'] = toUserId;
    data['title'] = title;
    data['notification_msg'] = notificationMsg;
    data['booking_request_id'] = bookingRequestId;
    data['type'] = type;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    if (fromUser != null) {
      data['from_user'] = fromUser!.toJson();
    }
    return data;
  }
}

///From user Model
class FromUser {
  ///Initialization for string
  String? id, fullName, email, profilePhotoFirebaseUrl;

  ///Constructor
  FromUser({this.id, this.fullName, this.email, this.profilePhotoFirebaseUrl});

  ///Map Data
  FromUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    profilePhotoFirebaseUrl = json['profile_photo_firebase_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['profile_photo_firebase_url'] = profilePhotoFirebaseUrl;
    return data;
  }
}
