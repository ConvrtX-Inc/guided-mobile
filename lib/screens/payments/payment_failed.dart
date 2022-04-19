import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/screens/widgets/reusable_widgets/payment_detail.dart';

/// Modal Bottom sheet for payment failed payment
Future<dynamic> paymentFailed(
    {required BuildContext context,
    required Widget paymentDetails,
    required String paymentMethod}) {
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
                          onTap: () {
                            int count = 0;
                            Navigator.popUntil(context, (route) {
                              return count++ == 2;
                            });
                          },
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
                        'Payment Failed',
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                    SizedBox(
                      height: 40.h,
                    ),
                    Center(
                        child: Container(
                            height: 128.h,
                            width: 120.w,
                            padding: EdgeInsets.all(18.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HexColor('#FFC5C5'),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor('#FF4848'),
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 44,
                              ),
                            ))),
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.5,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              paymentDetails,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    PaymentDetail(
                                        label: AppTextConstants.paymentMethod,
                                        content: paymentMethod),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomRoundedButton(
                        title: AppTextConstants.ok,
                        onpressed: () {
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
                        }),
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
