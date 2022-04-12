// ignore_for_file: file_names, cast_nullable_to_non_nullable, unused_local_variable
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:guided/constants/app_colors.dart';
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

  @override
  void initState() {
    super.initState();
    txtMinimum = TextEditingController(text: minimum.toString());

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.dustyGrey),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SfDateRangePicker(
                        minDate: DateTime.now().subtract(Duration(days: 0)),
                        maxDate: Indate.DateUtils.lastDayOfMonth(DateTime.parse(
                            travellerMonthController.currentDate)),
                        initialDisplayDate: DateTime.parse(
                            travellerMonthController.currentDate),
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
                        onSelectionChanged: _onSelectionChanged,
                      ),
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
