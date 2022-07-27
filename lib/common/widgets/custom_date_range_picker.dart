import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/month_selector.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

/// Custom Date Range Picker
class CustomDateRangePicker extends StatefulWidget {
  ///Constructor
  const CustomDateRangePicker(
      {required this.onDatesSelected,
      this.onSubmitted,
      this.title = 'Select Date',
      this.submitBtnText = 'Set Filter Date',
      Key? key})
      : super(key: key);

  /// Title
  final String title;

  ///Submit Button Text
  final String submitBtnText;

  ///Submit Button Callback
  final VoidCallback? onSubmitted;

  ///Callback when date range is selected
  final Function onDatesSelected;

  @override
  _CustomDateRangePickerState createState() => _CustomDateRangePickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('submitBtnText', submitBtnText))
      ..add(DiagnosticsProperty<Function>('onDatesSelected', onDatesSelected))
      ..add(DiagnosticsProperty<Function>('onSubmitted', onSubmitted));
  }
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Select date',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          MonthSelector(
              onMonthSelected: (DateTime data) {
                setState(() {
                  selectedDate = data;
                });
                debugPrint('Select Month ${selectedDate.toString()}');
              },
              selectedDate: selectedDate),
          SfDateRangePicker(
            enablePastDates: false,
            minDate: selectedDate,
            maxDate: Indate.DateUtils.lastDayOfMonth(selectedDate),
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value.startDate != null && args.value.endDate != null) {
                widget.onDatesSelected(args);
              }
            },
            selectionMode: DateRangePickerSelectionMode.range,
            navigationMode: DateRangePickerNavigationMode.none,
            monthViewSettings: const DateRangePickerMonthViewSettings(
              dayFormat: 'E',
            ),
            headerHeight: 0,
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: TextStyle(color: HexColor('#3E4242')),
              todayTextStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: HexColor('#3E4242')),
            ),
            selectionTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            rangeSelectionColor: HexColor('#FFF2CE'),
            todayHighlightColor: HexColor('#FFC74A'),
            startRangeSelectionColor: HexColor('#FFC31A'),
            endRangeSelectionColor: HexColor('#FFC31A'),
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 153.w,
              height: 54.h,
              child: ElevatedButton(
                onPressed: widget.onSubmitted,
                style: AppTextStyle.activeGreen,
                child: Text(
                  widget.submitBtnText,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime>('selectedDate', selectedDate));
  }
}
