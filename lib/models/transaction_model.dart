/// Transaction Model
class TransactionModelData{
  /// Constructor
  TransactionModelData({required this.transactions});
  /// Transactions
  late List<Transaction> transactions = <Transaction>[];
  /// Mapping
  TransactionModelData.fromJSON(List<dynamic> parseJson) : transactions = parseJson.map((i)=>Transaction.fromJson(i)).toList();
}

class Transaction {

  final String id, userId, activityPackageId,tourGuideId,serviceName,transactionNumber,statusId;
  final double total;
  final int numberOfPeople;
  final DateTime? bookDate, createdDate, updatedDate;

  ///Constructor
  Transaction({
    this.id = '',
    this.userId = '',
    this.activityPackageId = '',
    this.tourGuideId = '',
    this.serviceName = '',
    this.transactionNumber = '',
    this.statusId = '',
    this.total = 0.0,
    this.numberOfPeople = 0,
    this.bookDate = null,
    this.createdDate = null,
    this.updatedDate = null
  });

  Transaction.fromJson(Map<String,dynamic> parseJson)
  : id = parseJson['id'],
    userId = parseJson['user_id'],
    activityPackageId = parseJson['activity_package_id'],
    tourGuideId = parseJson['tour_guide_id'],
    serviceName = parseJson['service_name'],
    transactionNumber = parseJson['transaction_number'],
    statusId = parseJson['status_id'],
    total = parseJson['total'],
    numberOfPeople = parseJson['number_of_people'],
    bookDate = parseJson['book_date'],
    createdDate = parseJson['created_date'],
    updatedDate = parseJson['updated_date'];

}
