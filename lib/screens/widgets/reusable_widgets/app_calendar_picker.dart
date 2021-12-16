import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:intl/intl.dart';

/// Global widget for app calendar picker
class CalendarAppCalendar extends StatelessWidget {
  /// Constructor
  const CalendarAppCalendar(
      {String titleText = '',
      required Function onChangeDate,
      Key? key,
      required this.date})
      : _titleText = titleText,
        _onChangeDate = onChangeDate,
        super(key: key);

  final String _titleText;
  final Function _onChangeDate;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _titleText,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        SizedBox(height: 5.h),
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 2.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.novel,
              ),
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.transparent,
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  right: 0,
                  child: Icon(
                    Icons.calendar_today,
                    color: AppColors.novel,
                  ),
                ),
                DateTimePicker(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    dateMask: 'MM/dd/yyyy',
                    dateHintText: 'mm/dd/yyyy',
                    style: TextStyle(
                        color: AppColors.novel,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    // controller: _controller1,
                    initialValue: DateFormat('yyyy-MM-dd').format(date),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                    selectableDayPredicate: (DateTime date) {
                      // if (date.weekday == 6 || date.weekday == 7) {
                      //   return false;
                      // }
                      return true;
                    },
                    onChanged: (String val) {
                      _onChangeDate(val);
                    },
                    validator: (String? val) {
                      // setState(() => _valueToValidate1 = val ?? '');
                      // return null;
                    },
                    onSaved: (val) {}),
              ],
            )),
      ],
    );
  }
}
