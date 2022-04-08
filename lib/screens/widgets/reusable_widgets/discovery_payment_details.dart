import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/widgets/reusable_widgets/payment_detail.dart';

///Discovery payment details
class DiscoveryPaymentDetails extends StatelessWidget {
  ///Constructor
  const DiscoveryPaymentDetails(
      {required this.transactionNumber,
      Key? key,
      this.paymentMode = '',
     })
      : super(key: key);

  ///Transaction number
  final String transactionNumber;

  ///Payment mode
  final String paymentMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
              Text(
                '5',
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  '.99USD',
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
                label: AppTextConstants.orderNumber,
                content: transactionNumber),
            SizedBox(
              height: 20.h,
            ),
            PaymentDetail(
                label: AppTextConstants.service, content: 'Discovery Subscription'),

            ],
        ));
  }
}
