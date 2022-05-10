///Model For Payment Transaction
class PaymentTransactionModel {
  ///Constructor
  PaymentTransactionModel(
      {this.id = '',
      this.userId = '',
      this.transactionId = '',
      this.transactionNumber = '',
      this.paymentMethod = '',
      this.serviceName = '',
      this.createdDate = '',
      this.amount = '',
      this.type =''});

  ///Initialization
  String id,
      transactionId,
      userId,
      amount,
      transactionNumber,
      paymentMethod,
      serviceName,
      type,
      createdDate;

  /// Map Data
  PaymentTransactionModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        transactionId = parseJson['transaction_id'] ?? '',
        userId = parseJson['user_id'],
        transactionNumber = parseJson['transaction_number'],
        paymentMethod = parseJson['payment_method'],
        serviceName = parseJson['service_name'],
        createdDate = parseJson['created_date'],
        type = parseJson['type'] ?? '',
        amount = parseJson['amount'];
}
