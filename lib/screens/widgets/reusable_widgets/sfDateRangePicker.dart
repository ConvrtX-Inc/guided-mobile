import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Widget Sfcalendar(
    BuildContext context,
    String date,
    ValueSetter<List<DateTime>> onPressed,
    List<DateTime> initialSelectedDates,
    ) {
  debugPrint('Mars - SFCalendar ${initialSelectedDates}');

  return Container(

    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
    height: MediaQuery.of(context).size.height * 0.4,
    child: SfDateRangePicker(
      enablePastDates: false,

      minDate: DateTime.parse(date),
      maxDate: Indate.DateUtils.lastDayOfMonth(DateTime.parse(date)),
      initialDisplayDate: DateTime.parse(date),
      navigationMode: DateRangePickerNavigationMode.none,
      monthViewSettings:   DateRangePickerMonthViewSettings(
        dayFormat: 'E',
      ),
      monthCellStyle: DateRangePickerMonthCellStyle(
        textStyle: TextStyle(color: HexColor('#3E4242')),
        todayTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: HexColor('#3E4242')),
          specialDatesDecoration: BoxDecoration(
              color: AppColors.lightningYellow,
              shape: BoxShape.circle),
          /*specialDatesDecoration: BoxDecoration(
              border: Border.all(color: AppColors.dirtyWhite, width: 2.5),
              shape: BoxShape.circle),*/
          blackoutDateTextStyle: TextStyle(color: Colors.white, decoration: TextDecoration.none)
      ),
      selectionTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      selectionColor: HexColor('#FFC74A'),
      todayHighlightColor: HexColor('#FFC74A'),
      headerHeight: 0,
      selectionMode: DateRangePickerSelectionMode.multiple,
      // initialSelectedDates: [],
      // initialSelectedDates: initialSelectedDates,
      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
        onPressed(args.value);
      },
      selectableDayPredicate: (DateTime dt){
        return initialSelectedDates.contains(dt);
      }
    ),
  );


}

