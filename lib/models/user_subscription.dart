///User Subscription Model
class UserSubscription {
  ///Constructor
  UserSubscription(
      {this.id = '',
      this.userId = '',
      this.paymentReferenceNo = '',
      this.name = '',
      this.message = '',
      this.startDate = '',
      this.endDate = '',
      this.createdAt = '',

      this.price = ''});

  ///Initialization
  String id,
      userId,
      name,
      paymentReferenceNo,
      startDate,
      endDate,
      message,
  price,
      createdAt;

  static UserSubscription fromJson(Map<String, dynamic> json) =>
      UserSubscription(
          id: json['id'],
          userId: json['user_id'],
          paymentReferenceNo: json['payment_reference_no'],
          startDate: json['start_date'],
          endDate: json['end_date'],
          message: json['message'] ?? '',
          price: json['price'],
          createdAt: json['created_date']);
}
