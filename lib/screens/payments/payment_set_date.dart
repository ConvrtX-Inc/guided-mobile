import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/payments/payment_manage_card.dart';

/// Modal Bottom sheet for finding booking dates with calendar
Future<dynamic> paymentSetDate(BuildContext context) {
  // late final DateTime _focusedDay = DateTime.now();
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
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey.withOpacity(0.2)),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          AppTextConstants.payment,
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border:
                                  Border.all(color: Colors.green, width: 1.w)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 8.h),
                            child: Text(
                              AppTextConstants.bookingHistory,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: Colors.green,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      AppTextConstants.setupTheTimeDurationForTheEvents,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          fontFamily: 'Gilroy'),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      AppTextConstants.startDate,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          fontFamily: 'Gilroy'),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () => pickDateRange(context),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                width: 1.w,
                                color: Colors.grey.withOpacity(0.7))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: <Widget>[
                              Text(AppTextConstants.startDate),
                              const Spacer(),
                              const Icon(
                                Icons.date_range,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      AppTextConstants.endDate,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          fontFamily: 'Gilroy'),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () => pickDateRange(context),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                width: 1.w,
                                color: Colors.grey.withOpacity(0.7))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: <Widget>[
                              Text(AppTextConstants.endDate),
                              const Spacer(),
                              const Icon(
                                Icons.date_range,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Center(
                      child: Container(
                        width: 300.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppTextConstants.amount,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Gilroy',
                                    color: Colors.grey),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 50.h),
                                child: Center(
                                  child: Text(
                                    r'$00.00',
                                    style: TextStyle(
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Gilroy',
                                        color: Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomRoundedButton(
                        title: AppTextConstants.next,
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

Future pickDateRange(BuildContext context) async {
  DateTimeRange dateRange;
  final initialDateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(hours: 24 * 3)));
  final newDateRange = await showDateRangePicker(
    context: context,
    firstDate: DateTime(DateTime.now().year - 5),
    lastDate: DateTime(DateTime.now().year + 5),
    // initialDateRange: dateRange ?? initialDateRange,
  );
}

/// widet for months
Widget getMonths({required String name, required int data}) {
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 38.h,
        width: 89.w,
        decoration: BoxDecoration(
            color: data >= 1 ? Colors.yellow : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12)),
        child: Stack(clipBehavior: Clip.none, children: <Widget>[
          Center(
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: data >= 1 ? FontWeight.w700 : FontWeight.w500),
            ),
          ),
          if (data >= 1)
            Positioned(
              right: -5,
              top: -7,
              child: Container(
                height: 28.h,
                width: 28.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,
                ),
                child: Center(
                    child: Text(
                  '$data',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                )),
              ),
            )
        ]),
      ),
    );
  });
}
