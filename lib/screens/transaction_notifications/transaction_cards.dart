import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
import '../../constants/app_colors.dart';
import '../../models/transaction_model.dart';

class TransactionCustomerCard extends StatefulWidget {
  late Transaction transaction;
  TransactionCustomerCard(Transaction transaction,{Key? key}) {
    this.transaction = transaction;
  }

  @override
  State<TransactionCustomerCard> createState() => _TransactionCustomerCardState(transaction);
}

class _TransactionCustomerCardState extends State<TransactionCustomerCard> {

  late Transaction transaction;

   _TransactionCustomerCardState(Transaction transaction)
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
          Divider(height: 9.0.h,color: Colors.transparent,),
          getMessage(),
          Divider(height: 14.0.h,color: Colors.transparent,),
          getBookingDate(),
          Divider(height: 14.0.h,color: Colors.transparent,),
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
          "Anne Sasha's purchase is pending",
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
          "Booking Date 16 May 2021",
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
                  '\$'+transaction.total.toString(),
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
    switch(int.parse(transaction.statusId))
    {

      case 1:
        return AppColors.completedText;
      case 2:
        return AppColors.pendingText;
      case 3:
        return AppColors.rejectedText;
    }
    return AppColors.rejectedText;
  }

  Image statusImage()
  {
    switch(int.parse(transaction.statusId))
    {

      case 1:
        return Image.asset("assets/images/complete.png");
      case 2:
        return Image.asset("assets/images/pending.png");
      case 3:
        return Image.asset("assets/images/rejected.png");
    }
    return Image.asset("assets/images/rejected.png");
  }


  String statusMessage()
  {
    switch(int.parse(transaction.statusId))
    {

      case 1:
        return "Payment Completed";
      case 2:
        return "Patment Pending";
      case 3:
        return "Payment Rejected";
    }
    return "Payment Rejected";
  }

}
