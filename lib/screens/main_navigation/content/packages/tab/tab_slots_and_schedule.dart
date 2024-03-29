// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, use_raw_strings, diagnostic_describe_all_properties, always_specify_types, unused_field, no_logic_in_create_state, always_put_required_named_parameters_first, public_member_api_docs, sort_constructors_first
import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;

/// Advertisement View Screen
class TabSlotsAndScheduleView extends StatefulWidget {
  final String id;
  final int numberOfTourist;
  final List<String> availabilityId;
  final List<DateTime> availabilityDate;
  final int slots;

  /// Constructor
  const TabSlotsAndScheduleView(
      {Key? key,
      required this.id,
      required this.numberOfTourist,
      required this.availabilityId,
      required this.availabilityDate,
      required this.slots})
      : super(key: key);

  @override
  _TabSlotsAndScheduleViewState createState() =>
      _TabSlotsAndScheduleViewState();
}

class _TabSlotsAndScheduleViewState extends State<TabSlotsAndScheduleView> {
  _TabSlotsAndScheduleViewState();

  int selectedmonth = 0;
  final travellerMonthController = Get.put(TravellerMonthController());
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  int selectedMonth = 0;
  DateTime focusedYear = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  bool _isSelectionChanged = false;
  bool _isStatic = true;
  bool _isLoadingDone = false;
  int count = 1;
  TextEditingController txtCount = TextEditingController();
  late List<DateTime> splitDates;
  @override
  void initState() {
    super.initState();
    count = widget.slots;

    setState(() {
      selectedmonth = DateTime.now().month.toInt();
      selectedMonth = AppListConstants.numberList[selectedmonth - 1];
      splitDates = widget.availabilityDate;
      _isLoadingDone = true;
      txtCount = TextEditingController(text: widget.slots.toString());
    });
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
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
          if (_isLoadingDone)
            if (_isStatic && splitDates.isNotEmpty)
              Stack(children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: SfDateRangePicker(
                      enablePastDates: false,
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
                      initialSelectedDates: splitDates,
                      selectionMode: DateRangePickerSelectionMode.multiple),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Edit Slots & Schedules',
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp)),
                          content: Text(
                              'You are about to edit the Booking Dates. Proceed?',
                              style: TextStyle(
                                  color: AppColors.doveGrey,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp)),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'No'),
                              child: Text(
                                'No',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Gilroy',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isStatic = false;
                                });
                                Navigator.pop(context, 'Yes');
                              },
                              child: Text('Yes',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Gilroy',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                      ),
                      child: SizedBox(
                        height: 500.h,
                        width: 500.w,
                        child: const DecoratedBox(
                          decoration: BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                    ))
              ])
            else
              Container(
                padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
                height: MediaQuery.of(context).size.height * 0.4,
                child: SfDateRangePicker(
                  enablePastDates: false,
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
                  onSelectionChanged: _onSelectionChanged,
                ),
              )
          else
            const SkeletonText(
              width: 600,
              height: 300,
              radius: 10,
            ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Text(
              AppTextConstants.headerNumberOfPeople,
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 10.h, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (count != 1) {
                          count--;
                          txtCount.text = count.toString();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(
                        side: count == 1
                            ? BorderSide(color: AppColors.grey)
                            : BorderSide(color: AppColors.primaryGreen),
                      ),
                      padding: const EdgeInsets.all(11),
                      primary: Colors.white,
                      onPrimary: Colors.green,
                    ),
                    child: Icon(Icons.remove,
                        color: count == 1
                            ? AppColors.grey
                            : AppColors.primaryGreen),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        enabled: false,
                        controller: txtCount,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.2.w),
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (count != widget.numberOfTourist) {
                          count++;
                        }
                        txtCount.text = count.toString();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(
                        side: BorderSide(color: AppColors.primaryGreen),
                      ),
                      padding: const EdgeInsets.all(11),
                      primary: Colors.white,
                      onPrimary: Colors.green,
                    ),
                    child: Icon(Icons.add, color: AppColors.primaryGreen),
                  ),
                )
              ],
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
        'package_id': widget.id,
        'selected_date': _selectedDate,
        'number_of_tourist': count,
        'availability_id': widget.availabilityId
      };

      await Navigator.pushNamed(context, '/set_booking_date',
          arguments: details);
    } else {
      AdvanceSnackBar(message: ErrorMessageConstants.datePick).show(context);
    }
  }
}
