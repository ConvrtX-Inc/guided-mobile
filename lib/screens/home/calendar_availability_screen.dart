// ignore_for_file: file_names, cast_nullable_to_non_nullable, unused_local_variable, avoid_dynamic_calls
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

/// Calendar Availability Screen
class CalendarAvailabilityScreen extends StatefulWidget {
  /// Constructor
  const CalendarAvailabilityScreen({Key? key}) : super(key: key);

  @override
  _CalendarAvailabilityScreenState createState() =>
      _CalendarAvailabilityScreenState();
}

class _CalendarAvailabilityScreenState
    extends State<CalendarAvailabilityScreen> {
  TextEditingController txtMinimum = TextEditingController();
  final travellerMonthController = Get.put(TravellerMonthController());
  int minimum = 0;
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  bool _isSelectionChanged = false;
  DateTime focusedYear = DateTime.now();
  int selectedMonth = 0;
  int selectedmonth = 0;
  List<String> splitDates = [];
  List<String> splitId = [];
  List<DateTime> listDate = [];
  bool _isStatic = true;
  int count = 1;
  TextEditingController txtCount = TextEditingController();
  @override
  void initState() {
    super.initState();

    txtMinimum = TextEditingController(text: minimum.toString());

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
      _selectedDate = screenArguments['availability_date'][0];
      setState(() {
        txtCount =
            TextEditingController(text: screenArguments['slots'].toString());
      });
      count = screenArguments['slots'];
    });
    selectedmonth = DateTime.now().month.toInt();
    selectedMonth = AppListConstants.numberList[selectedmonth - 1];
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    List<DateTime> splitDates = screenArguments['availability_date'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.headerAvailability),
                  SizedBox(
                    height: 30.h,
                  ),
                  SubHeaderText.subHeaderText(
                      AppTextConstants.subheaderAvailability),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (_isStatic)
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
                            selectionMode:
                                DateRangePickerSelectionMode.multiple),
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
                                    'Please choose one (1) date in order to proceed',
                                    style: TextStyle(
                                        color: AppColors.doveGrey,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp)),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Gilroy',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isStatic = false;
                                      });
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: Text('OK',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Gilroy',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                            child: SizedBox(
                              height: 500.h,
                              width: 500.w,
                              child: const DecoratedBox(
                                decoration:
                                    BoxDecoration(color: Colors.transparent),
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
                    padding:
                        EdgeInsets.only(left: 20.w, top: 10.h, right: 20.w),
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
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.2.w),
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
                                if (count !=
                                    screenArguments['number_of_tourist']) {
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
                            child:
                                Icon(Icons.add, color: AppColors.primaryGreen),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: 60.h,
          child: ElevatedButton(
            onPressed: () => navigateAvailabilityBookingDates(context),
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
              AppTextConstants.next,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigate to Add Schedule
  Future<void> navigateAvailabilityBookingDates(BuildContext context) async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // final List<ActivityAvailabilityHour> resForm = await APIServices()
    //       .getActivityAvailabilityHour(activityPackageId[num]);

    print(_selectedDate);
    final Map<String, dynamic> details = {
      'id': screenArguments['id'],
      'selected_date': _selectedDate,
      'package_id': screenArguments['package_id'],
      'number_of_tourist': count
    };

    await Navigator.pushNamed(context, '/availability_booking_dates',
        arguments: details);
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // print(args.value);
    setState(() {
      // listDate = args.value;
      // _selectedDate = listDate[listDate.length - 1];
      _selectedDate = args.value;
      _isSelectionChanged = true;
    });
    print(_selectedDate);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TextEditingController>('txtMinimum', txtMinimum));
    properties.add(IntProperty('minimum', minimum));
  }
}
