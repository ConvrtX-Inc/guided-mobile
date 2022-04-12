///User Subscription Model
class UserSubscription {
  ///Constructor
  UserSubscription(
      {this.userId = '',
      this.paymentReferenceNo = '',
      this.name = '',
      this.message = '',
      this.startDate = '',
      this.endDate = '',
      this.createdAt = ''});

  ///Initialization
  String userId,
      name,
      paymentReferenceNo,
      startDate,
      endDate,
      message,
      createdAt;
}
