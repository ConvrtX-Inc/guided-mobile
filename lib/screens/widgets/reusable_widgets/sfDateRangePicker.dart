import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Widget Sfcalendar(BuildContext context, String date) {
  return Container(
    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
    height: MediaQuery.of(context).size.height * 0.4,
    child: SfDateRangePicker(
      minDate: DateTime.parse(date),
      maxDate: Indate.DateUtils.lastDayOfMonth(DateTime.parse(date)),
      initialDisplayDate: DateTime.parse(date),
      navigationMode: DateRangePickerNavigationMode.none,
      monthViewSettings: const DateRangePickerMonthViewSettings(
        dayFormat: 'E',
      ),
      monthCellStyle: DateRangePickerMonthCellStyle(
        textStyle: TextStyle(color: HexColor('#3E4242')),
        todayTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: HexColor('#3E4242')),
      ),
      selectionTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      selectionColor: HexColor('#FFC74A'),
      todayHighlightColor: HexColor('#FFC74A'),
      headerHeight: 0,
      selectionMode: DateRangePickerSelectionMode.multiple,
    ),
  );
}
