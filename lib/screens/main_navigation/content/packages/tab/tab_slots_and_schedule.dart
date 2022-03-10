// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, use_raw_strings
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/home.dart';
import 'package:guided/screens/main_navigation/content/packages/widget/package_destination_features.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/utils/home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Advertisement View Screen
class TabSlotsAndScheduleView extends StatefulWidget {
  /// Constructor
  const TabSlotsAndScheduleView({Key? key}) : super(key: key);

  @override
  _TabSlotsAndScheduleViewState createState() =>
      _TabSlotsAndScheduleViewState();
}

class _TabSlotsAndScheduleViewState extends State<TabSlotsAndScheduleView> {
  int selectedmonth = 0;
  final travellerMonthController = Get.put(TravellerMonthController());
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  int selectedMonth = 0;
  DateTime focusedYear = DateTime.now();
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
            child: GetBuilder<TravellerMonthController>(
                id: 'calendar',
                builder: (TravellerMonthController controller) {
                  return Sfcalendar(
                      context, travellerMonthController.currentDate);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/set_booking_date');
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

  /// Navigate to Outfitter Edit
  // Future<void> navigateEditAdvertisementDetails(
  //     BuildContext context, Map<String, dynamic> screenArguments) async {
  //   final Map<String, dynamic> details = {
  //     'id': screenArguments['id'],
  //     'title': screenArguments['title'],
  //     'price': screenArguments['price'].toString().substring(1),
  //     'product_link': screenArguments['product_link'],
  //     'country': screenArguments['country'],
  //     'description': screenArguments['description'],
  //     'date': screenArguments['date'],
  //     'availability_date': screenArguments['availability_date'],
  //     'address': screenArguments['address'],
  //     'street': screenArguments['street'],
  //     'city': screenArguments['city'],
  //     'province': screenArguments['province'],
  //     'zip_code': screenArguments['zip_code']
  //   };

  //   await Navigator.pushNamed(context, '/advertisement_edit',
  //       arguments: details);
  // }
}
