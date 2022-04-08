import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:intl/intl.dart';
import '../../constants/app_colors.dart';
import '../../models/transaction_model.dart';
import '../../models/transaction_modelv2.dart';


class TransactionCustomerCard extends StatefulWidget {
  late Transaction2 transaction;
  TransactionCustomerCard(Transaction2 transaction,{Key? key}) {
    this.transaction = transaction;
  }

  @override
  State<TransactionCustomerCard> createState() => _TransactionCustomerCardState(transaction);
}

class _TransactionCustomerCardState extends State<TransactionCustomerCard> {

  late Transaction2 transaction;

   _TransactionCustomerCardState(Transaction2 transaction)
  {
    this.transaction = transaction;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 9.0.w
      ),
      padding: EdgeInsets.only(
          left: 14.0.w,
          right: 14.0.w,
          top: 18.0.w,
          bottom: 18.0.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.w),
        border: Border.all(color: AppColors.tabBorder, width: 1),
      ),
      child: Column(
        children:[
          getTopRow(),
          Divider(height: 9.0.h,color: Colors.transparent),
          getMessage(),
          Divider(height: 14.0.h,color: Colors.transparent),
          getBookingDate(),
          Divider(height: 14.0.h,color: Colors.transparent),
          getStatus()
        ],
      ),
    );
  }


  Widget getTopRow()
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getDisplayPicture(),
        Spacer(),
        getPrice()
      ],
    );

  }
  Widget getDisplayPicture()
  {
     return Container(
       decoration: BoxDecoration(
         color: Colors.white,
         shape: BoxShape.circle,
         boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 1)],
       ),
       child: CircleAvatar(
         backgroundColor: Colors.white,
         radius: 30.0,
         child: CircleAvatar(
           radius: 28.0,
           backgroundImage: AssetImage('assets/images/profile-2.jpg'),
         ),
       ),
     );
  }

  Widget getMessage()
  {
    return Row(
      children: [
        Text(
         "${transaction.user?.firstName!} ${transaction.user?.lastName!}\'s purchase is ",
          style: TextStyle(
              fontFamily: AppTextConstants.fontPoppins,
              fontWeight: FontWeight.w600,
              height: 1.5,
              fontSize: 12.0.sp
          ),
        )
      ],
    );
  }
  Widget getBookingDate()
  {
    return Row(
      children: [
        Text(
          "Booking Date "+DateFormat.d().format(transaction.bookDate!)+" "+DateFormat.MMMM().format(transaction.bookDate!)+" "+DateFormat.y().format(transaction.bookDate!),
          style: TextStyle(
              fontFamily: AppTextConstants.fontPoppins,
              fontWeight: FontWeight.w400,
              height: 1.5,
              fontSize: 11.0.sp
          ),
        )
      ],
    );
  }

  Widget getStatus()
  {
    return Row(
      children: [
        statusImage(),
        VerticalDivider(width: 9.0.w),
        Text(
          statusMessage(),
          style: TextStyle(
              color:statusColor(),
              fontFamily: AppTextConstants.fontPoppins,
              fontWeight: FontWeight.w400,
              height: 1.5,
              fontSize: 12.0.sp
          ),
        )
      ],
    );
  }

  Widget getPrice()
  {

    return Container(
                child: Text(
                  '\$ '+transaction.total.toString(),
                  style: TextStyle(
                      fontFamily: AppTextConstants.fontPoppins,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      fontSize: 16.0.sp
                  ),
                )
              );
  }
  Color statusColor()
  {
    switch(transaction.statusId)
    {

      case Transaction.COMPLETED:
        return AppColors.completedText;
      case Transaction.PENDING:
        return AppColors.pendingText;
      case Transaction.REJECTED:
        return AppColors.rejectedText;
    }
    return AppColors.rejectedText;
  }

  Image statusImage()
  {
    switch(transaction.statusId)
    {

      case Transaction.COMPLETED:
        return Image.asset("assets/images/complete.png");
      case Transaction.PENDING:
        return Image.asset("assets/images/pending.png");
      case Transaction.REJECTED:
        return Image.asset("assets/images/rejected.png");
    }
    return Image.asset("assets/images/rejected.png");
  }


  String statusMessage()
  {
    switch(transaction.statusId)
    {
      case Transaction.COMPLETED:
        return "Payment Completed";
      case Transaction.PENDING:
        return "Patment Pending";
      case Transaction.REJECTED:
        return "Payment Rejected";
    }
    return "Payment Rejected";
  }

  String status()
  {
    switch(transaction.statusId)
    {
      case Transaction.COMPLETED:
        return "completed";
      case Transaction.PENDING:
        return "pending";
      case Transaction.REJECTED:
        return "rejected";
    }
    return "rejected";
  }



}
