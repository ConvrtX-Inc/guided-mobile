import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/common/widgets/custom_rounded_button_with_border.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/constants/payment_status.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/stripe_service.dart';

/// Modal Bottom sheet for confirm payment
Future<dynamic> paymentConfirmModal(
    {required BuildContext context,
    required Widget paymentDetails,
    required String serviceName,
    required String paymentMode,
    required dynamic paymentMethod,
    required Function onPaymentSuccessful,
    required double price,
    required double adventureFee,
    required String guideStripeAccountId,
    required String bookingRequestId,
    Function? onPaymentFailed,
    Function? onConfirmPaymentPressed}) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        bool isPaymentProcessing = false;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height - 20,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 42.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey.withOpacity(0.2)),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        )),
                    SizedBox(width: 20.w),
                    Align(
                      child: Text(
                        AppTextConstants.confirmPayment,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 25.h,
                  ),
                  Center(
                    child: Container(
                      width: 300.w,
                      // height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: paymentDetails,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  if (onConfirmPaymentPressed != null)
                    CustomRoundedButton(
                      title: 'Confirm Payment',
                      isLoading: isPaymentProcessing,
                      onpressed: () {
                        setState(() {
                          isPaymentProcessing = true;
                        });

                        if (paymentMode == PaymentConfig.bankCard ||
                            paymentMode == PaymentConfig.googlePay) {
                          handleChargePayment(
                              price,
                              paymentMethod,
                              context,
                              onPaymentSuccessful,
                              onPaymentFailed,
                              guideStripeAccountId,
                              adventureFee);
                        }

                        if (paymentMode == PaymentConfig.applePay) {
                          // handle apple pay
                        }
                      },
                    )
                ],
              ),
            ),
          );
        });
      });
}

///Charge Payment (Stripe Connect)
Future<void> handleChargePayment(
    double price,
    String paymentMethodId,
    BuildContext context,
    dynamic onPaymentSuccess,
    dynamic onPaymentFailed,
    String guideStripeAccountId,
    double applicationFee) async {
  // Stripe Connect Payment Intent create API
  final String paymentIntent = await createTransferPaymentIntent(
      guideStripeAccountId, price, applicationFee);

  if (paymentIntent.isNotEmpty) {
    //Stripe Connect Charge Api
    final paymentRes = await APIServices()
        .chargeBookingPayment(paymentIntent, paymentMethodId);
    debugPrint('payment Response $paymentRes');
    if (paymentRes != null) {
      Navigator.of(context).pop();
      onPaymentSuccess();
    } else {
      onPaymentFailed();
    }
  } else {
    onPaymentFailed();
  }
}

/// Create Stripe Transfer Payment Intent
Future<String> createTransferPaymentIntent(
    String guideStripeAccountId, double total, double applicationFee) async {
  final double guideFee = total - applicationFee;

  debugPrint('Guide Fee $guideFee Application Fee $applicationFee');
  final String res = await APIServices().createTransferPaymentIntent(
      guideStripeAccountId,
      guideFee,
      applicationFee,
      UserSingleton.instance.user.user!.email!);

  return res;
}
