import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/screens/main_navigation/settings/screens/calendar_management/settings_calendar_management_schedule.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

/// Setting Calendar Management Modal Screen
class SettingsCalendarManagementModal extends StatefulWidget {
  /// Constructor
  const SettingsCalendarManagementModal({Key? key, required this.monthId})
      : super(key: key);

  final int monthId;

  @override
  _SettingsCalendarManagementModalState createState() =>
      _SettingsCalendarManagementModalState();
}

class _SettingsCalendarManagementModalState
    extends State<SettingsCalendarManagementModal> {
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  bool isRefreshing = false;

  final ScrollController _controller = ScrollController();
  final double _width = 100.0;
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final travellerMonthController = Get.put(TravellerMonthController());
  int monthID = 0;
  int count = 0;
  DateTime plustMonth = DateTime.now();
  @override
  void initState() {
    super.initState();

    monthID = widget.monthId;
    travellerMonthController.setSelectedDate(monthID + 1);

    DateTime dt = DateTime.parse(travellerMonthController.currentDate);

    plustMonth = DateTime(dt.year, monthID + 1, dt.day, dt.hour, dt.minute);

    final DateTime setLastday = DateTime(plustMonth.year, plustMonth.month, 1,
        plustMonth.hour, plustMonth.minute);

    travellerMonthController.setCurrentMonth(
      setLastday.toString(),
    );

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _scrollController.easyScrollToIndex(index: monthID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    int recentIndexIncrease = 0;
    int recentIndexDecrease = 0;

    final ButtonStyle tbStyle = TextButton.styleFrom(
      primary: Colors.black,
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: AppTextConstants.fontGilroy),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Transform.scale(
          scale: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 40.w,
              height: 40.h,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: AppColors.harp,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              style: tbStyle,
              child: Text(AppTextConstants.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.findBookingDates),
                  SizedBox(
                    height: 60.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.primaryGreen,
                          ),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        '${AppListConstants.calendarMonths[plustMonth.month - 1]}/${plustMonth.year.toString().padLeft(4, '0')}',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if (monthID > -1) {
                            monthID = monthID - 3;
                            _scrollController.easyScrollToIndex(index: monthID);
                          } else {
                            monthID = 0;
                            _scrollController.easyScrollToIndex(index: monthID);
                          }
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: HexColor('#898A8D'),
                        ),
                      ),
                      Container(
                          color: Colors.transparent,
                          height: 80.h,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: EasyScrollToIndex(
                            controller:
                                _scrollController, // ScrollToIndexController
                            scrollDirection:
                                Axis.horizontal, // default Axis.vertical
                            itemCount: AppListConstants
                                .calendarMonths.length, // itemCount
                            itemWidth: 95,
                            itemHeight: 70,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  _scrollController.easyScrollToIndex(
                                      index: index);
                                  travellerMonthController
                                      .setSelectedDate(index + 1);
                                  DateTime dt = DateTime.parse(
                                      travellerMonthController.currentDate);

                                  setState(() {
                                    plustMonth = DateTime(dt.year, index + 1,
                                        dt.day, dt.hour, dt.minute);
                                  });

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
                                              index == 0 ? 0.w : 0.w,
                                              0.h,
                                              10.w,
                                              0.h),
                                          width: 89,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  badgeColor:
                                                      AppColors.deepGreen,
                                                  badgeContent: Text(
                                                    '2',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontFamily:
                                                            AppTextConstants
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
                      GestureDetector(
                        onTap: () {
                          if (monthID < 11) {
                            monthID = monthID + 3;
                            _scrollController.easyScrollToIndex(index: monthID);
                          } else {
                            monthID = 11;
                            _scrollController.easyScrollToIndex(index: monthID);
                          }
                        },
                        child: Icon(
                          Icons.chevron_right,
                          color: HexColor('#898A8D'),
                        ),
                      ),
                    ],
                  ),
                  GetBuilder<TravellerMonthController>(
                      id: 'calendar',
                      builder: (TravellerMonthController controller) {
                        print(controller.currentDate);
                        return Container(
                            padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Sfcalendar(
                                context, travellerMonthController.currentDate));
                      }),
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
            onPressed: _settingModalBottomSheet,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.silver,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              primary: AppColors.primaryGreen,
              onPrimary: Colors.white,
            ),
            child: Text(
              AppTextConstants.viewSchedule,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  void _settingModalBottomSheet() {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) =>
          SettingsCalendarManagementSchedule(date: plustMonth),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isRefreshing', isRefreshing));
  }
}
