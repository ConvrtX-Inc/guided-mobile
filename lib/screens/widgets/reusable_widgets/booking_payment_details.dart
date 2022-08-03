import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/screens/widgets/reusable_widgets/payment_detail.dart';

///Booking Payment Details
class BookingPaymentDetails extends StatelessWidget {
  ///Constructor
  const BookingPaymentDetails(
      {required this.transactionNumber,
      required this.price,
      required this.serviceName,
      required this.tour,
      required this.tourGuide,
      required this.bookingDate,
      required this.numberOfPeople,
      Key? key})
      : super(key: key);

  ///transaction number
  final String transactionNumber;

  /// Price
  final String price;

  ///Service name
  final String serviceName;

  ///Tour
  final String tour;

  ///Tour Guide
  final String tourGuide;

  ///Booking Date
  final String bookingDate;

  ///Number of people
  final int numberOfPeople;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: AppColors.concrete,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'CAD',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  price.split('.')[0],
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(bottom: 8.h),
                //   child: Text(
                //     '.${price.split('.')[1]}${PaymentConfig.currencyCode}',
                //     style: TextStyle(
                //       fontSize: 26.sp,
                //       fontWeight: FontWeight.w600,
                //       fontFamily: 'Poppins',
                //     ),
                //   ),
                // ),
              ]),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PaymentDetail(
                    label: AppTextConstants.company, content: 'Guided'),
                SizedBox(
                  height: 20.h,
                ),
                PaymentDetail(
                    label: AppTextConstants.transactionNumber,
                    content: transactionNumber),
                SizedBox(
                  height: 20.h,
                ),
                PaymentDetail(
                    label: AppTextConstants.service, content: serviceName),
                SizedBox(
                  height: 20.h,
                ),
                PaymentDetail(label: AppTextConstants.tour, content: tour),
                SizedBox(
                  height: 20.h,
                ),
                PaymentDetail(
                    label: AppTextConstants.tourGuide, content: tourGuide),
                SizedBox(
                  height: 20.h,
                ),
                PaymentDetail(
                    label: AppTextConstants.bookingDate, content: bookingDate),
                SizedBox(
                  height: 20.h,
                ),
                PaymentDetail(
                    label: AppTextConstants.numberOfPeople,
                    content: '$numberOfPeople'),
                SizedBox(
                  height: 20.h,
                ),
              ]),
        )
      ],
    );
  }
}
