import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/common/widgets/custom_rounded_button_with_border.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/screens/payments/payment_successful.dart';

/// Modal Bottom sheet for confirm payment
Future<dynamic> confirmPaymentModal(
    {required BuildContext context,
    required Widget paymentDetails,
    required Function onPaymentConfirm,
    required String serviceName,
    required String paymentMode,
    required dynamic paymentMethod,
required Function onPaymentSuccessful
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
                        height: MediaQuery.of(context).size.height / 2,
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
                    CustomRoundedButton(
                      title: AppTextConstants.confirmPayment,
                      onpressed: () => confirmPayment(
                          context, paymentDetails, paymentMode,paymentMethod,onPaymentSuccessful),
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

/// Confirm Payment
void confirmPayment(
    BuildContext context, Widget paymentDetails, String paymentMode, dynamic paymentMethod, Function onPaymentSuccess) {

  if(paymentMethod is CardModel){
    debugPrint('Payment Method ${paymentMethod.cardNo}');
  }
  //Add Payment Process Here & redirect to Payment Success Screen if Successful...


  //Add function to saving other data / transactions on your current screen for this call back
  onPaymentSuccess();

  paymentSuccessful(
      context: context,
      paymentDetails: paymentDetails,
      paymentMethod: paymentMode);
}
