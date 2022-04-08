import 'package:guided/models/package_model.dart';
import 'package:guided/models/transaction_model.dart';
import 'package:guided/models/user_model.dart';


/// Transaction Model
class TransactionModelData{
  /// Constructor
  TransactionModelData({required this.transactions});
  /// Transactions
  late List<Transaction2> transactions = <Transaction2>[];
  /// Mapping
  TransactionModelData.fromJSON(List<dynamic> parseJson) : transactions = parseJson.map((i)=>Transaction2.fromJson(i)).toList();

}

class Transaction2{

  final String id, userId,activityPackageId,total,tourGuideId,serviceName,transactionNumber,statusId;
  final int numberOfPeople;
  final DateTime? bookDate,createdDate,updatedDate,deletedAt;
  final User? user;
  final PackageDetailsModel? activityPackage;

  ///Constructor
  Transaction2({
    this.id = '',
    this.userId = '',
    this.activityPackageId = '',
    this.total = '',
    this.tourGuideId = '',
    this.serviceName = '',
    this.transactionNumber = '',
    this.statusId = '',
    this.numberOfPeople = 0,
    this.bookDate = null,
    this.createdDate = null,
    this.updatedDate = null,
    this.deletedAt = null,
    this.user = null,
    this.activityPackage = null
  });

  Transaction2.fromJson(Map<String,dynamic> parseJson)
  :id=parseJson['id'],
        userId=parseJson['user_id'],
        activityPackageId=parseJson['activity_package_id'],
        total=parseJson['total'],
        tourGuideId=parseJson['tour_guide_id'],
        serviceName=parseJson['service_name'],
        transactionNumber=parseJson['transaction_number'],
        statusId=parseJson['status_id'],
        numberOfPeople=parseJson['number_of_people'],
        bookDate = parseJson['book_date']==null?null:DateTime.tryParse(parseJson['book_date']) ,
        createdDate =parseJson['created_date']==null?null: DateTime.tryParse(parseJson['created_date']),
        updatedDate = parseJson['updated_date']==null?null:DateTime.tryParse(parseJson['updated_date']),
        deletedAt = parseJson['deleted_at']==null?null:DateTime.tryParse(parseJson['deleted_at']),
        user = User.fromJson(parseJson['user']),
        activityPackage =  PackageDetailsModel.fromJson(parseJson['activity_package']);

}