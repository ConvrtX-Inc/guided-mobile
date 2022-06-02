import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
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
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
              Text(
                price.split('.')[0],
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  '.${price.split('.')[1]}USD',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ]),
            Divider(
              thickness: 1.sp,
            ),
            SizedBox(
              height: 20.h,
            ),
            PaymentDetail(label: AppTextConstants.company, content: 'Guided'),
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
            PaymentDetail(
                label: AppTextConstants.tour, content: tour),
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
                label: AppTextConstants.numberOfPeople, content: '$numberOfPeople'),
          ],
        ));
  }
}
