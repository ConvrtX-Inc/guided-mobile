import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/screens/transaction_notifications/transaction_cards.dart';
import 'package:guided/screens/transaction_notifications/transaction_post_cards.dart';

import '../../constants/app_colors.dart';
import '../../models/transaction_model.dart';

class TransactionPostList extends StatefulWidget {
  const TransactionPostList({Key? key}) : super(key: key);

  @override
  State<TransactionPostList> createState() => _TransactionPostListState();
}

class _TransactionPostListState extends State<TransactionPostList> {

  List<Transaction> transactions = List.empty(growable: true);
  void generateTestData()
  {
    transactions.add(Transaction(id : '0001', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0001', transactionNumber : 'tn-0001', statusId : '1', total : 50.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null));
    transactions.add(Transaction(id : '0002', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0002', transactionNumber : 'tn-0002', statusId : '1', total : 60.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null));
    transactions.add(Transaction(id : '0003', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0003', transactionNumber : 'tn-0003', statusId : '1', total : 70.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null));
    transactions.add(Transaction(id : '0004', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0004', transactionNumber : 'tn-0004', statusId : '2', total : 80.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null));
    transactions.add(Transaction(id : '0005', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0005', transactionNumber : 'tn-0005', statusId : '2', total : 90.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null));
    transactions.add(Transaction(id : '0006', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0006', transactionNumber : 'tn-0006', statusId : '2', total : 100.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null));
    transactions.add(Transaction(id : '0007', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0007', transactionNumber : 'tn-0007', statusId : '3', total : 110.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null));
    transactions.add(Transaction(id : '0008', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0008', transactionNumber : 'tn-0008', statusId : '3', total : 120.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null));
    transactions.add(Transaction(id : '0009', userId : 'u-0001', activityPackageId : 'p-0001', tourGuideId : 'u-0002', serviceName : 'Test Service 0009', transactionNumber : 'tn-0009', statusId : '3', total : 130.0, numberOfPeople : 1, bookDate : DateTime.now(), createdDate :null, updatedDate : null));

  }
  @override
  void initState() {
    super.initState();
    generateTestData();

  }
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
        itemCount: transactions.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 10.0.h,color: Colors.transparent);
        },
        itemBuilder: (BuildContext context, int index) {
          return  TransactionPostCard(transactions[index]);
        }
    );

  }
}
