import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Widget BookingDatePicker(
    BuildContext context,
    String date,
    ValueSetter<List<DateTime>> onPressed,
    List<DateTime> initialSelectedDates,
    List<DateTime> schedule,
    List<DateTime> blackOut
    ) {

  debugPrint("MARS-1102 BookingDatePicker date: ${date}");
  debugPrint("MARS-1102 BookingDatePicker initialSelectedDates: ${initialSelectedDates}");
  debugPrint("MARS-1102 BookingDatePicker schedule: ${schedule}");



  return Container(
    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
    height: MediaQuery.of(context).size.height * 0.4,
    child: SfDateRangePicker(
      enablePastDates: false,
      allowViewNavigation: false,
      minDate: DateTime.parse(date),
      maxDate: Indate.DateUtils.lastDayOfMonth(DateTime.parse(date)),
      initialDisplayDate: DateTime.parse(date),
      navigationMode: DateRangePickerNavigationMode.none,
      monthViewSettings:   DateRangePickerMonthViewSettings(
        dayFormat: 'E',
        blackoutDates: blackOut
        // specialDates: initialSelectedDates,

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
          blackoutDateTextStyle: TextStyle(color: Colors.grey, decoration: TextDecoration.none)
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
      // selectableDayPredicate: (DateTime dt){
      //   debugPrint("MARS-1102 selectable predicate: ${dt}");
      //   return schedule.contains(dt);
      // },

    ),
  );
}
