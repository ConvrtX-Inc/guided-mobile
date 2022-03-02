import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/common/widgets/custom_rounded_button_with_border.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/payments/payment_manage_card.dart';

/// Modal Bottom sheet for successful payment
Future<dynamic> paymentSuccessful(BuildContext context) {
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
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.withOpacity(0.2)),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        AppTextConstants.paymentSuccessful,
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                    SizedBox(
                      height: 40.h,
                    ),
                    Center(child: Image.asset(AssetsPath.roundedCheck)),
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              getData(AppTextConstants.company, 'Guided'),
                              SizedBox(
                                height: 20.h,
                              ),
                              getData(AppTextConstants.orderNumber, '1229000B3HN'),
                              SizedBox(
                                height: 20.h,
                              ),
                              getData(AppTextConstants.service, 'Travel Service'),
                              SizedBox(
                                height: 20.h,
                              ),
                              getData(AppTextConstants.bookingDate, '09. 10. 2021'),
                              SizedBox(
                                height: 20.h,
                              ),
                              getData(AppTextConstants.slots, '08'),
                              SizedBox(
                                height: 20.h,
                              ),
                              getData(AppTextConstants.card, 'Credit Card'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomRoundedButton(
                        title: AppTextConstants.ok,
                        onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    const PaymentManageCard()),
                          );
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

/// data
Widget getData(String title, String data) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: Colors.grey),
        ),
        SizedBox(
          height: 7.h,
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );