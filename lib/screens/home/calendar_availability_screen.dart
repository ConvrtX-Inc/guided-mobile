// ignore_for_file: file_names, cast_nullable_to_non_nullable, unused_local_variable
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/screens/home/set_booking_date_screen.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;

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
                  // Container(
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.grey.shade400),
                  //       borderRadius: BorderRadius.circular(10.r)),
                  //   child: GetBuilder<TravellerMonthController>(
                  //       id: 'calendar',
                  //       builder: (TravellerMonthController controller) {
                  //         return Sfcalendar(
                  //             context, travellerMonthController.currentDate);
                  //       }),
                  // ),
                  Container(
                    height: 50.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: selectedMonth,
                        onChanged: (int? intVal) => setState(() {
                          selectedMonth = intVal!;
                          DateTime dt = DateTime.parse(
                              travellerMonthController.currentDate);

                          final DateTime plustMonth = DateTime(dt.year,
                              selectedMonth, dt.day, dt.hour, dt.minute);

                          final DateTime setLastday = DateTime(
                              plustMonth.year,
                              plustMonth.month,
                              1,
                              plustMonth.hour,
                              plustMonth.minute);

                          travellerMonthController.setCurrentMonth(
                            setLastday.toString(),
                          );
                        }),
                        selectedItemBuilder: (BuildContext context) {
                          return AppListConstants.numberList
                              .map<Widget>((int item) {
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
                        enablePastDates: false,
                        minDate: DateTime.parse(
                            travellerMonthController.currentDate),
                        maxDate: Indate.DateUtils.lastDayOfMonth(DateTime.parse(
                            travellerMonthController.currentDate)),
                        // initialDisplayDate: DateTime.parse(
                        //     travellerMonthController.currentDate),
                        initialSelectedDates: splitDates,
                        navigationMode: DateRangePickerNavigationMode.none,
                        monthViewSettings:
                            const DateRangePickerMonthViewSettings(
                          dayFormat: 'E',
                        ),
                        monthCellStyle: DateRangePickerMonthCellStyle(
                          textStyle: TextStyle(color: HexColor('#3E4242')),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HexColor('#3E4242')),
                        ),
                        selectionTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        selectionColor: HexColor('#FFC74A'),
                        todayHighlightColor: HexColor('#FFC74A'),
                        headerHeight: 0,
                        // onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.multiple,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20),
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: 60.h,
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         Navigator.pushNamed(context, '/set_booking_date');
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //           side: BorderSide(
                  //             color: AppColors.silver,
                  //           ),
                  //           borderRadius: BorderRadius.circular(18.r),
                  //         ),
                  //         primary: AppColors.primaryGreen,
                  //         onPrimary: Colors.white,
                  //       ),
                  //       child: Text(
                  //         AppTextConstants.addSchedule,
                  //         style: const TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 16),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Card(
                  //   child: Padding(
                  //     padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
                  //     child: TableCalendar(
                  //       onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  //         setState(() {
                  //           _selectedDay = selectedDay;
                  //           _focusedDay =
                  //               focusedDay; // update `_focusedDay` here as well
                  //         });
                  //       },
                  //       currentDay: _selectedDay,
                  //       headerVisible: false,
                  //       firstDay: DateTime.utc(2010, 10, 16),
                  //       lastDay: DateTime.utc(2030, 3, 14),
                  //       focusedDay: _focusedDay,
                  //       calendarStyle: CalendarStyle(
                  //         todayDecoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: AppColors.brightSun,
                  //         ),
                  //         todayTextStyle: const TextStyle(
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // HeaderText.headerText(
                  //   AppTextConstants.headerNumberOfPeople
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: EdgeInsets.only(top: 5.h),
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             minimum = minimum - 1;
                  //             txtMinimum.text = minimum.toString();
                  //           });
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //           shape: CircleBorder(
                  //             side: BorderSide(
                  //                 color: AppColors.primaryGreen),
                  //           ),
                  //           padding: const EdgeInsets.all(8),
                  //           primary: Colors.white, // <-- Button color
                  //           onPrimary: Colors.green, // <-- Splash color
                  //         ),
                  //         child: Icon(
                  //             Icons.remove,
                  //             color: AppColors.primaryGreen),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         children: <Widget>[
                  //           TextField(
                  //             controller: txtMinimum,
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.only(top: 10.h),
                  //               hintStyle: TextStyle(
                  //                 color: AppColors.grey,
                  //               ),
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(16.r),
                  //                 borderSide: const BorderSide(
                  //                     color: Colors.grey, width: 0.2),
                  //               ),
                  //             ),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //           const SizedBox(
                  //             height: 5,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5),
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             minimum = minimum + 1;
                  //             txtMinimum.text = minimum.toString();
                  //           });
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //           shape: CircleBorder(
                  //             side: BorderSide(
                  //                 color: AppColors.primaryGreen),
                  //           ),
                  //           padding: const EdgeInsets.all(8),
                  //           primary: Colors.white, // <-- Button color
                  //           onPrimary: Colors.green, // <-- Splash color
                  //         ),
                  //         child: Icon(Icons.add,
                  //             color: AppColors.primaryGreen),
                  //       ),
                  //     )
                  //   ],
                  // ),
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
            onPressed: () {
              Navigator.of(context).pushNamed('/availability_booking_dates');
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
              AppTextConstants.next,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value);
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = args.value;
        _isSelectionChanged = true;
      }
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TextEditingController>('txtMinimum', txtMinimum));
    properties.add(IntProperty('minimum', minimum));
  }
}
