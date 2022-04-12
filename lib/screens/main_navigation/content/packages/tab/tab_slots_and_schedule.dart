// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, use_raw_strings, diagnostic_describe_all_properties, always_specify_types, unused_field
import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;

/// Advertisement View Screen
class TabSlotsAndScheduleView extends StatefulWidget {
  final String id;

  /// Constructor
  const TabSlotsAndScheduleView({Key? key, required this.id}) : super(key: key);

  @override
  _TabSlotsAndScheduleViewState createState() =>
      _TabSlotsAndScheduleViewState(id);
}

class _TabSlotsAndScheduleViewState extends State<TabSlotsAndScheduleView> {
  _TabSlotsAndScheduleViewState(id);

  int selectedmonth = 0;
  final travellerMonthController = Get.put(TravellerMonthController());
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  int selectedMonth = 0;
  DateTime focusedYear = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  bool _isSelectionChanged = false;
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final DateTime dt = DateTime.parse(travellerMonthController.currentDate);
      final int mon = dt.month;
      travellerMonthController.setSelectedDate(mon);

      DateTime currentDate =
          DateTime.parse(travellerMonthController.currentDate);

      final DateTime defaultDate = DateTime(currentDate.year, currentDate.month,
          1, currentDate.hour, currentDate.minute);

      travellerMonthController.setCurrentMonth(
        defaultDate.toString(),
      );
    });
    selectedmonth = DateTime.now().month.toInt();
    selectedMonth = AppListConstants.numberList[selectedmonth - 1];
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = args.value;
        _isSelectionChanged = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Booking Date & Time',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 2.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedMonth,
                onChanged: (int? intVal) => setState(() {
                  selectedMonth = intVal!;
                  DateTime dt =
                      DateTime.parse(travellerMonthController.currentDate);

                  final DateTime plustMonth = DateTime(
                      dt.year, selectedMonth, dt.day, dt.hour, dt.minute);

                  final DateTime setLastday = DateTime(plustMonth.year,
                      plustMonth.month, 1, plustMonth.hour, plustMonth.minute);

                  travellerMonthController.setCurrentMonth(
                    setLastday.toString(),
                  );
                }),
                selectedItemBuilder: (BuildContext context) {
                  return AppListConstants.numberList.map<Widget>((int item) {
                    return Center(
                        child: Text(
                      '${AppListConstants.calendarMonths[item - 1]} ${focusedYear.year}',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ));
                  }).toList();
                },
                items: AppListConstants.numberList.map((int item) {
                  return DropdownMenuItem<int>(
                    value: item,
                    child: Center(
                        child: Text(
                            '${AppListConstants.calendarMonths[item - 1]} ${focusedYear.year}',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600))),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.dustyGrey),
                borderRadius: BorderRadius.circular(10.r)),
            child: Container(
              padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
              height: MediaQuery.of(context).size.height * 0.4,
              child: SfDateRangePicker(
                minDate: DateTime.now().subtract(Duration(days: 0)),
                maxDate: Indate.DateUtils.lastDayOfMonth(
                    DateTime.parse(travellerMonthController.currentDate)),
                initialDisplayDate:
                    DateTime.parse(travellerMonthController.currentDate),
                navigationMode: DateRangePickerNavigationMode.none,
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  dayFormat: 'E',
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(color: HexColor('#3E4242')),
                  todayTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: HexColor('#3E4242')),
                ),
                selectionTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                selectionColor: HexColor('#FFC74A'),
                todayHighlightColor: HexColor('#FFC74A'),
                headerHeight: 0,
                onSelectionChanged: _onSelectionChanged,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  navigateAddSchedule(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.silver,
                    ),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  primary: AppColors.primaryGreen,
                  onPrimary: Colors.white,
                ),
                child: Text(
                  AppTextConstants.addSchedule,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Navigate to Add Schedule
  Future<void> navigateAddSchedule(BuildContext context) async {
    if (_isSelectionChanged) {
      final Map<String, dynamic> details = {
        'id': widget.id,
        'selected_date': _selectedDate,
      };

      await Navigator.pushNamed(context, '/set_booking_date',
          arguments: details);
    } else {
      AdvanceSnackBar(message: ErrorMessageConstants.datePick).show(context);
    }
  }
}
