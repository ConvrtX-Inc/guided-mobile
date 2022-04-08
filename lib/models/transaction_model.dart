import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

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

  static const String COMPLETED = "6e9ee3f9-e5c5-4820-a93f-76622c41b94e";
  static const String PENDING   = "e860cd28-cf9a-4525-aed6-fa9ad930e957";
  static const String REJECTED  = "a36819dc-d54c-4cc2-b4dc-8bbc776c240d";

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


  static Color indicatorColor(status)
  {
    switch(status)
    {
      case 0:
        return Colors.black;
      case 1:
        return AppColors.completedText;
      case 2:
        return AppColors.pendingText;
      case 3:
        return AppColors.rejectedText;
    }
    return Colors.black;
  }


}
