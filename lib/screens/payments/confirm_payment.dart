import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/common/widgets/custom_rounded_button_with_border.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/stripe_service.dart';

/// Modal Bottom sheet for confirm payment
Future<dynamic> confirmPaymentModal(
    {required BuildContext context,
    required Widget paymentDetails,
    required String serviceName,
    required String paymentMode,
    required dynamic paymentMethod,
    required Function onPaymentSuccessful,
    required double price,
    Function? onPaymentFailed,
    Function? onConfirmPaymentPressed
    }) {
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
          return ScreenUtilInit(
            builder: () => Container(
              height: 726.h,
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
                      Text(
                        AppTextConstants.confirmPayment,
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                    SizedBox(
                      height: 70.h,
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
                              spreadRadius: 1,
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
                    if(onConfirmPaymentPressed != null)
                      CustomRoundedButton(
                        title: 'Pay $price USD',
                        isLoading: isPaymentProcessing,
                        onpressed: () {
                          setState(() {
                            isPaymentProcessing = true;
                          });
                         return onConfirmPaymentPressed();
                        },
                      )
                    else
                      CustomRoundedButton(
                      title: 'Pay $price USD',
                      isLoading: isPaymentProcessing,
                      onpressed: () {
                        setState(() {
                          isPaymentProcessing = true;
                        });
                        //Handle Payment for Credit Cards
                        if (paymentMethod is CardModel) {
                          handleCardPayment(context, paymentMethod,
                              onPaymentSuccessful, price, onPaymentFailed!);
                        }

                        //handle payment for google pay
                        if (paymentMode.toLowerCase() == 'google pay') {
                          final PaymentMethodParams paymentMethodParams =
                              PaymentMethodParams.cardFromToken(
                            token: paymentMethod['id'],
                          );

                          handleWalletPayment(
                              paymentMethodParams,
                              onPaymentSuccessful,
                              context,
                              price,
                              onPaymentFailed!);
                        }

                        //handle payment for apple pay
                        if (paymentMode.toLowerCase() == 'apple pay') {
                          final TokenData tokenData = paymentMethod;

                          final PaymentMethodParams paymentMethodParams =
                              PaymentMethodParams.cardFromToken(
                            token: tokenData.id,
                          );

                          handleWalletPayment(
                              paymentMethodParams,
                              onPaymentSuccessful,
                              context,
                              price,
                              onPaymentFailed!);
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomRoundedButtonWithBorder(
                      title: AppTextConstants.cancel,
                      onpressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ),
            designSize: const Size(375, 812),
          );
        });
      });
}

Future<void> handleCardPayment(BuildContext context, CardModel card,
    Function onPaymentSuccess, double price, Function onPaymentFailed) async {
  final String paymentMethodId =
      await StripeServices().createPaymentMethod(card);

  if (paymentMethodId != '') {
    await handleChargePayment(
        price, paymentMethodId, context, onPaymentSuccess, onPaymentFailed);
  } else {
    ///Payment Failed Notif
    debugPrint('Payment Failed!');
  }
}

///Charge Payment
Future<void> handleChargePayment(double price, paymentMethodId, context,
    onPaymentSuccess, onPaymentFailed) async {
  final int amount = (price * 100).round();

  //Call Payment Api
  final APIStandardReturnFormat paymentResponse =
      await APIServices().pay(amount, paymentMethodId);

  if (paymentResponse.statusCode == 201) {
    // Navigator.of(context).pop();
    //Add function to saving other data / transactions / subscriptions on your current screen for this call back
    onPaymentSuccess();
  } else {
    ///Show payment failed modal
    onPaymentFailed();
  }
}

///Handle Google And Apple Payment Method
Future<void> handleWalletPayment(
    dynamic paymentMethodParams,
    Function onPaymentSuccess,
    BuildContext context,
    double price,
    Function onPaymentFailed) async {
  debugPrint('Wallet Payment ${paymentMethodParams}');
  //amount to pay
  final int amount = (price * 100).round();
  try {
    //get client secret by creating payment intent
    final String clientSecret = await createPaymentIntent(amount);

    debugPrint('client secret $clientSecret');

    //  Confirm wallet payment
    await Stripe.instance.confirmPayment(
      clientSecret,
      paymentMethodParams,
    );

    onPaymentSuccess();
  } on Exception catch (e) {
    ///Show payment failed modal
    onPaymentFailed();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

///Create Payment Intent Stripe
Future<String> createPaymentIntent(int amount) async {
  final APIStandardReturnFormat result =
      await APIServices().createPaymentIntent(amount);

  final dynamic data = json.decode(result.successResponse);

  return data['client_secret'];
}
