import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/screens/bookings/screens/booking_slots.dart';
import 'package:guided/screens/bookings/widgets/booking_date_header.dart';
import 'package:guided/screens/bookings/widgets/booking_month.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Future<dynamic> showBookingDateCalendar({
  required BuildContext context,
  required int selectedMonthNumber,
  required String selectedMonthName
}) {
  List<String> months = AppListConstants.calendarMonths;
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              bookingDateHeader(context),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.deepGreen),
                    borderRadius: BorderRadius.circular(12.r)),
                child: Center(
                  child: Text(
                    '$selectedMonthName / ${DateTime.now().year}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.deepGreen,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(height: 80, child: buildDateHeader(months, context)),
              SizedBox(height: 20.h,),
              SfDateRangePicker(
                  // enablePastDates:  false,
                  initialDisplayDate: DateTime(DateTime.now().year,selectedMonthNumber),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(color: HexColor('#3E4242')),
                    todayTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HexColor('#3E4242')),
                  ),
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        textStyle: TextStyle(
                            fontFamily: 'Gilroy',
                            color: Colors.black,
                            fontSize: 15.sp)),
                  ),
                  selectionTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  selectionColor: HexColor('#FFC74A'),

                  todayHighlightColor: HexColor('#FFC74A'),
                  initialSelectedDates: [DateTime.parse('2022-06-03'),DateTime.parse('2022-06-04')],
                  selectionMode:
                  DateRangePickerSelectionMode.multiple,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs val) {
                    debugPrint('Value: ${val.value[val.value.length -1]} ');
                    String selectedDate = val.value[val.value.length -1].toString();
                    showBookingDateSlots(context: context, selectedMonthNumber: selectedMonthNumber, selectedMonthName: selectedMonthName, selectedDate: selectedDate);

                  },
              )
            ],
          ),
        );
      });
}

Widget buildDateHeader(List<String> dates, BuildContext context) => Row(
      children: [
        Icon(Icons.arrow_back_ios),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(right: 4.w),
                  padding: EdgeInsets.only(top: 12),
                  child: bookingMonth(
                      dates[index], index.isOdd ? 0 : 2, ctx, true),
                  width: 90.w,
                );
              }),
        ),
        Icon(Icons.arrow_forward_ios),
      ],
    );
