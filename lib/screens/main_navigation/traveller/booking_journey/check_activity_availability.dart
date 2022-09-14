// ignore_for_file: sort_constructors_first, public_member_api_docs, diagnostic_describe_all_properties

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/app_list.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/app_texts.dart';
import '../../../../controller/traveller_controller.dart';
import '../../../widgets/reusable_widgets/easy_scroll_to_index.dart';

///
class CheckActivityAvailabityScreen extends StatefulWidget {
  ////
  const CheckActivityAvailabityScreen({Key? key}) : super(key: key);

  @override
  State<CheckActivityAvailabityScreen> createState() =>
      _CheckActivityAvailabityScreenState();
}

class _CheckActivityAvailabityScreenState
    extends State<CheckActivityAvailabityScreen> {
  final List<Activity> activities = StaticDataService.getActivityList();
  final PageController page_indicator_controller = PageController();
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final travellerMonthController = Get.put(TravellerMonthController());
  final DateTime now = DateTime.now();

  @override
  void initState() {
    initializeDateFormatting('en', null);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        _scrollController.easyScrollToIndex(
            index: travellerMonthController.selectedDate - 1);
      });
      final DateTime dt = DateTime.parse(travellerMonthController.currentDate);
      final int mon = dt.month;
      travellerMonthController.setSelectedDate(mon);
    });

    super.initState();
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
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final ActivityPackage activityPackage =
        screenArguments['package'] as ActivityPackage;
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
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 10.w, 0.h),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      side: BorderSide(color: AppColors.tealGreen),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    onPressed: () {
                      print('Pressed');
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Text('Booking History',
                          style: TextStyle(
                              color: AppColors.tealGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
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
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.chevron_left,
                  color: HexColor('#898A8D'),
                ),
                Container(
                    color: Colors.transparent,
                    height: 80.h,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: EasyScrollToIndex(
                      controller: _scrollController, // ScrollToIndexController
                      scrollDirection: Axis.horizontal, // default Axis.vertical
                      itemCount:
                          AppListConstants.calendarMonths.length, // itemCount
                      itemWidth: 95,
                      itemHeight: 70,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            _scrollController.easyScrollToIndex(index: index);
                            travellerMonthController.setSelectedDate(index + 1);
                            DateTime dt = DateTime.parse(
                                travellerMonthController.currentDate);

                            final DateTime plustMonth = DateTime(
                                dt.year, index + 1, dt.day, dt.hour, dt.minute);

                            final DateTime setLastday = DateTime(
                                plustMonth.year,
                                plustMonth.month,
                                1,
                                plustMonth.hour,
                                plustMonth.minute);

                            travellerMonthController.setCurrentMonth(
                              setLastday.toString(),
                            );
                          },
                          child: Obx(
                            () => Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        index == 0 ? 0.w : 0.w, 0.h, 10.w, 0.h),
                                    width: 89,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: index ==
                                                    travellerMonthController
                                                            .selectedDate -
                                                        1
                                                ? HexColor('#FFC74A')
                                                : HexColor('#C4C4C4'),
                                            width: 1),
                                        color: index ==
                                                travellerMonthController
                                                        .selectedDate -
                                                    1
                                            ? HexColor('#FFC74A')
                                            : Colors.white),
                                    child: Center(
                                        child: Text(AppListConstants
                                            .calendarMonths[index])),
                                  ),
                                ),
                                Positioned(
                                    right: 2,
                                    top: 2,
                                    child: index.isOdd
                                        ? Badge(
                                            padding: const EdgeInsets.all(8),
                                            badgeColor: AppColors.deepGreen,
                                            badgeContent: Text(
                                              '2',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: AppTextConstants
                                                      .fontPoppins),
                                            ),
                                          )
                                        : Container()),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                Icon(
                  Icons.chevron_right,
                  color: HexColor('#898A8D'),
                ),
              ],
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
                      context,
                      travellerMonthController.currentDate,
                      (List<DateTime> value) {
                        travellerMonthController.selectedDates.clear();
                        travellerMonthController.setSelectedDates(value);
                      },
                    ),
                  );
                }),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40.h,
              child: ElevatedButton(
                onPressed: () {
                  checkAvailability(context, activityPackage,
                      travellerMonthController.selectedDates);
                },
                style: AppTextStyle.activeGreen,
                child: const Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkAvailability(BuildContext context, ActivityPackage package,
      List<DateTime> selectedDates) async {
    selectedDates.sort((a, b) => a.compareTo(b));
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
