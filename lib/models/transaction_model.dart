import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/status.dart';
import 'package:guided/models/user_model.dart';


/// Transaction Model
class TransactionModelData{
  /// Constructor
  TransactionModelData({required this.transactions});
  /// Transactions
  late List<Transaction> transactions = <Transaction>[];
  /// Mapping
  TransactionModelData.fromJSON(List<dynamic> parseJson) : transactions = parseJson.map((i)=>Transaction.fromJson(i)).toList();

}

class Transaction{


  static const String COMPLETED = "Completed";
  static const String PENDING = "Pending";
  static const String REJECTED = "Rejected";

  final String id, userId,activityPackageId,total,tourGuideId,serviceName,transactionNumber,statusId;
  final int numberOfPeople;
  final DateTime? bookDate,createdDate,updatedDate,deletedAt;
  final User? user;
  final PackageDetailsModel? activityPackage;
  final Status? status;

  ///Constructor
  Transaction({
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
    this.activityPackage = null,
    this.status = null
  });

  Transaction.fromJson(Map<String,dynamic> parseJson)
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
        activityPackage =  PackageDetailsModel.fromJson(parseJson['activity_package']),
          status = Status.fromJson(parseJson['status']
        );


  static Color indicatorColor(int status)
  {
    switch(status)
    {
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

