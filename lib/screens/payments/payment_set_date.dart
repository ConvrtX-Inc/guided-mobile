import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/screens/payments/payment_manage_card.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

/// Modal Bottom sheet for setting date of payment
Future<dynamic> paymentSetDate(
    {required BuildContext context, required Function onContinueBtnPressed}) {
  return showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      // isScrollControlled: true,
      builder: (BuildContext context) {
        bool showDateRangePicker = false;
        String startDate = '';
        String endDate = '';
        double amount = 0;

        return Material(child: StatefulBuilder(
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
                          onTap: () {
                            setState(() {
                              showDateRangePicker = !showDateRangePicker;
                            });
                          },
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
                                  Text(startDate.isEmpty
                                      ? AppTextConstants.startDate
                                      : startDate),
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
                        if (showDateRangePicker)
                          SfDateRangePicker(
                            onSelectionChanged:
                                (DateRangePickerSelectionChangedArgs args) {
                              setState(() {
                                startDate = '';
                                endDate = '';
                              });
                              if (args.value.startDate != null &&
                                  args.value.endDate != null) {
                                debugPrint('Start Date ${args.value.startDate}');
                                debugPrint('End Date ${args.value}');

                                setState(() => {
                                  startDate = DateFormat('MM/dd/yyy')
                                      .format(args.value.startDate)
                                      .toString(),
                                  endDate = DateFormat('MM/dd/yy')
                                      .format(args.value.endDate)
                                      .toString(),
                                  amount = 120.00
                                });
                              }

                              if (endDate.isNotEmpty) {
                                setState(() {
                                  showDateRangePicker = false;
                                });
                              }
                            },
                            selectionMode: DateRangePickerSelectionMode.range,
                            monthCellStyle: DateRangePickerMonthCellStyle(
                              textStyle: TextStyle(color: HexColor('#3E4242')),
                              todayTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#3E4242')),
                            ),
                            selectionShape: DateRangePickerSelectionShape.circle,
                            selectionTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            rangeSelectionColor: HexColor('#FFF2CE'),
                            todayHighlightColor: HexColor('#FFC74A'),
                            startRangeSelectionColor: HexColor('#FFC31A'),
                            endRangeSelectionColor: HexColor('#FFC31A'),
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
                          // onTap: () => pickDateRange(context),
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
                                  Text(endDate.isEmpty
                                      ? AppTextConstants.endDate
                                      : endDate),
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
                                        amount > 0
                                            ? '\$${amount.toStringAsFixed(2)}'
                                            : '\$0.00',
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
                            title: AppTextConstants.continueText,
                            onpressed: startDate.isNotEmpty && endDate.isNotEmpty && amount > 0 ? () {
                              final dynamic data = {
                                'amount' : amount,
                                'startDate': startDate,
                                'endDate': endDate
                              };

                              onContinueBtnPressed(data);

                            } : null),
                        SizedBox(
                          height: 40.h,
                        ),
                      ],
                    ),
                  ),
                ),
                designSize: const Size(375, 812),
              );
            }));
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



