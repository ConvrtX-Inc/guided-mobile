// ignore_for_file: sort_constructors_first, public_member_api_docs, diagnostic_describe_all_properties

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/month_selector.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/activity_availability_hours.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/available_date_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';


///
class CheckActivityAvailabityScreen extends StatefulWidget {
  ////
  const CheckActivityAvailabityScreen({Key? key, this.params})
      : super(key: key);

  // final ActivityPackage activityPackage;

  final dynamic params;

  @override
  State<CheckActivityAvailabityScreen> createState() =>
      _CheckActivityAvailabityScreenState();
}

class _CheckActivityAvailabityScreenState
    extends State<CheckActivityAvailabityScreen> {
  final List<Activity> activities = StaticDataService.getActivityList();
  final PageController page_indicator_controller = PageController();
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final TravellerMonthController travellerMonthController =
      Get.put(TravellerMonthController());
  final DateTime now = DateTime.now();

  List<AvailableDateModel> dates = [];

  List<ActivityHourAvailability> availableHours = [];
  List<DateTime> availableDates = [];
  List<String> availableDateSlots = [];

  ActivityPackage activityPackage = ActivityPackage();

  final ScrollController _monthsScrollController = ScrollController();

  int currentScrollIndex = 0;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    debugPrint('Mars - Started check Availability: ${availableDates}');
    debugPrint('Mars - Started check Availability: ${widget.params['availableDates']}');
    initializeDateFormatting('en', null);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      /*Future.delayed(const Duration(seconds: 1), () {
        _scrollController.easyScrollToIndex(index: 0);
      });*/
      final DateTime dt = DateTime.parse(travellerMonthController.currentDate);
      final int mon = dt.month;
      travellerMonthController.setSelectedDate(mon);
    });

    super.initState();

    activityPackage = widget.params['activityPackage'];
    availableHours = widget.params['availableDateSlots'];
    dates = List.from(AppListConstants().availableDates, growable: true);

    getAvailableSlots();

    // debugPrint('Activity Date ${activityPackage.name!} SLOTS ${availableHours.length}');
  }

  @override
  void dispose() {
    travellerMonthController.setSelectedDate(0);
    travellerMonthController.setCurrentMonth(DateTime.now().toString());
    travellerMonthController.selectedDates.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 10.w, 0.h),
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AppColors.porcelain,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Select date',
                  style: TextStyle(
                      color: HexColor('#181B1B'),
                      fontSize: 27.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Add your activity dates for exact pricing.',
                  style: TextStyle(
                      color: HexColor('#696D6D'),
                      fontSize: 14.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.w, 20.h, 0.w, 0.h),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide(color: AppColors.tealGreen),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                  ),
                  onPressed: null,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                    child: Obx(
                      () => Text(
                        travellerMonthController.selectedDates.isNotEmpty
                            ? travellerMonthController.selectedDates.length > 1
                                ? '${DateFormat('d/MMMM/yyyy').format(travellerMonthController.selectedDates.first)} - ${DateFormat('d/MMMM/yyyy').format(travellerMonthController.selectedDates.last)}'
                                : DateFormat('d/MMMM/yyyy').format(
                                    travellerMonthController
                                        .selectedDates.first)
                            : DateFormat('d/MMMM/yyyy')
                                .format(now), // 28/03/2020,
                        style: TextStyle(
                            color: AppColors.tealGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            MonthSelector(
              onMonthSelected: (date) {
                travellerMonthController
                    .setSelectedDate(date.month);
                DateTime dt = DateTime.parse(
                    travellerMonthController.currentDate);
                final DateTime plustMonth = DateTime(dt.year,
                    date.month, dt.day, dt.hour, dt.minute);

                final DateTime setLastday = DateTime(
                    plustMonth.year,
                    plustMonth.month,
                    1,
                    plustMonth.hour,
                    plustMonth.minute);

                travellerMonthController.setCurrentMonth(
                  setLastday.toString(),
                );

                setState(() {
                  selectedDate = date;
                });

              },

              selectedDate: selectedDate,

            ),

            SizedBox(
              height: 20.h,
            ),
            GetBuilder<TravellerMonthController>(
                id: 'calendar',
                builder: (TravellerMonthController controller) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Sfcalendar(
                        context, travellerMonthController.currentDate,
                        (List<DateTime> value) {
                      travellerMonthController.selectedDates.clear();

                      debugPrint(
                          'Selected Dates: ${travellerMonthController.selectedDates.length}');
                      travellerMonthController.setSelectedDates(value);
                    },
                        // availableDates,
                        widget.params['availableDates']),
                  );
                }),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60.h,
                  child: ElevatedButton(
                      onPressed:
                          travellerMonthController.selectedDates.isNotEmpty
                              ? () {
                                  checkAvailability(context, activityPackage,
                                      travellerMonthController.selectedDates);
                                }
                              : null,
                      style: AppTextStyle.activeGreen,
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
//fd11c3aa-3230-4dd4-babb-96b3a68728d4
  Future<void> getAvailableSlots() async {
    availableHours.forEach((ActivityHourAvailability e) {
      final int monthNumber = DateTime.parse(e.availabilityDate!).month;

      AvailableDateModel slot = dates
          .firstWhere((AvailableDateModel item) => item.month == monthNumber);

      final List<DateTime> availableDates =
          List.from(slot.availableDates, growable: true)
            ..add(DateTime.parse(e.availabilityDate!));

      slot.availableDates = availableDates;
      final int index = dates.indexOf(slot);
      setState(() {
        dates[index] = slot;
      });
    });

    setState(() {
      dates = dates
          .where((AvailableDateModel e) => e.month >= DateTime.now().month)
          .toList();
      availableDates = dates
          .firstWhere(
              (AvailableDateModel item) => item.month == DateTime.now().month)
          .availableDates;
    });
  }

  Future<void> checkAvailability(BuildContext context, ActivityPackage package,
      List<DateTime> selectedDates) async {
    selectedDates.sort((DateTime a, DateTime b) => a.compareTo(b));
    final Map<String, dynamic> details = {
      'package': package,
      'selectedDates': selectedDates,
    };
    if (selectedDates.length > 0) {
      await Navigator.pushNamed(context, '/checkAvailability',
          arguments: details);
    }
  }
}
