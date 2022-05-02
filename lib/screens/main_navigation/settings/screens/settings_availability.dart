// ignore_for_file: cascade_invocations, library_prefixes, always_specify_types

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/availability_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/settings_availability.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:in_date_utils/in_date_utils.dart' as Indate;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../utils/services/rest_api_service.dart';

/// Screen for settings contact us
class SettingsAvailability extends StatefulWidget {
  /// Constructor
  const SettingsAvailability({Key? key}) : super(key: key);

  @override
  _SettingsAvailability createState() => _SettingsAvailability();
}

class _SettingsAvailability extends State<SettingsAvailability> {
  final User? user = UserSingleton.instance.user.user;

  bool _isActive = true;
  String availabilityId = '';
  bool isLoading = true;
  DateTime _selDate = DateTime.now();
  final TextEditingController _reasonController = TextEditingController();
  final FocusNode _reasonFocus = FocusNode();
  final DateRangePickerController _dateController = DateRangePickerController();

  int selectedmonth = 0;
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final AvailabilityController availabilityController = Get.put(AvailabilityController());

  var result;
  @override
  void initState() {
    getSettingsAvailability();
    super.initState();
  }

  Future<void> getSettingsAvailability() async {
    setState(() => isLoading = true);
    final SettingsAvailabilityModel res = await APIServices().getSettingsAvailability();
    print('hello world from screen $res');


    availabilityController.setSelectedDate(DateTime.parse(res.returnDate!).toString());
    _reasonController.text = res.reason!;
    setState(() {
      _isActive = res.isAvailable!;
      _selDate = DateTime.parse(res.returnDate!);
      availabilityId = res.id!;
    });
    print('first load date $_selDate');

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _initData();
    });

    setState(() => isLoading = false);
  }

  Future<void> toggleUpdateStatus(String id) async {
    setState(() => isLoading = true);
    final SettingsAvailabilityModel res = await APIServices().updateSettingsAvailability(
        _isActive, _reasonController.text, _selDate, id);

    availabilityController.setSelectedDate(DateTime.parse(res.returnDate!).toString());
    setState(() {
      _selDate = DateTime.parse(res.returnDate!);
    });

    print('seldate $_selDate');

    _initData();

    setState(() => isLoading = false);
  }

  void _initData() {
      final RxString _currentDate = _selDate.toString().obs;
      final DateTime dt = DateTime.parse(_currentDate.value);
      availabilityController.setSelectedDate(_currentDate.value.toString());
      availabilityController.setIndexMonth(dt.month);

      final DateTime currentDate =
          DateTime.parse(_currentDate.value);

      final DateTime defaultDate = DateTime(currentDate.year, currentDate.month,
          1, currentDate.hour, currentDate.minute);

      availabilityController.setCurrentMonth(
        defaultDate.toString(),
      );

  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        print('date test ${args.value}');
        _selDate = args.value;
      }
    });
    availabilityController.setSelectedDate(_selDate.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/svg/arrow_back_with_tail.svg',
                height: 29.h, width: 34.w),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppTextConstants.availability,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Column(
                    children: isLoading == false ? [
                      Align(
                    alignment: Alignment.centerLeft,
                      child: SizedBox(
                      // width: double.maxFinite, // set width to maxFinite
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 25.h, 0, 25.h),
                        child: OutlinedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.dirtyWhite),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          child: Row(
                            children: <Widget> [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(_isActive ? 'Set yourself as unavailable' : 'Set yourself as available',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black
                                  ),
                                  textAlign: TextAlign.left
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Switch(
                                  value: _isActive,
                                  activeColor: const Color(0xFF00C853),
                                  onChanged: (bool value) {
                                    setState(() {
                                      _isActive = value;
                                      print('value $value');
                                      toggleUpdateStatus(availabilityId);
                                    });
                                  }
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Visibility(
                      visible: _isActive ? false : true,
                      child: TextField(
                        controller: _reasonController,
                        focusNode: _reasonFocus,
                        minLines:
                            6, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            hintText: AppTextConstants.why),
                      )
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: SizedBox(
                      // width: double.maxFinite, // set width to maxFinite
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 25.h, 0, 25.h),
                        child: Visibility(
                          visible: _isActive ? false : true,
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.all(26)),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      AppColors.dirtyWhite),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                              child: Row(
                                children: <Widget> [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(AppTextConstants.returnDate,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.left
                                    ),
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Visibility(
                                      child: Text(DateFormat('dd MMMM yyyy').format(_selDate),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        // fontWeight: FontWeight.w700,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.right
                                    ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                  result = showMaterialModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    expand: false,
                                    context: context,
                                    backgroundColor: Colors.white,
                                    builder: (BuildContext context) => SafeArea(
                                      top: false,
                                      child: Container(
                                        height: MediaQuery.of(context).size.height *
                                            0.72,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Align(
                                              child: Image.asset(
                                                AssetsPath.horizontalLine,
                                                width: 60.w,
                                                height: 5.h,
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: 15.h,
                                            // ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20.w, 20.h, 20.w, 20.h),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Select date',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 24.sp,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.chevron_left,
                                                  color: HexColor('#898A8D'),
                                                ),
                                                Container(
                                                    color: Colors.transparent,
                                                    height: 80.h,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.7,
                                                    child: EasyScrollToIndex(
                                                      controller:
                                                          _scrollController, // ScrollToIndexController
                                                      scrollDirection: Axis
                                                          .horizontal, // default Axis.vertical
                                                      itemCount: AppListConstants
                                                          .calendarMonths
                                                          .length, // itemCount
                                                      itemWidth: 95,
                                                      itemHeight: 70,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            _scrollController
                                                                .easyScrollToIndex(
                                                                    index: index);
                                                            availabilityController
                                                                .setIndexMonth(
                                                                    index + 1);
                                                            final DateTime dt = DateTime.parse(
                                                                availabilityController
                                                                    .currentDate);

                                                            final DateTime
                                                                plustMonth =
                                                                DateTime(
                                                                    dt.year,
                                                                    index + 1,
                                                                    dt.day,
                                                                    dt.hour,
                                                                    dt.minute);

                                                            final DateTime
                                                                setLastday =
                                                                DateTime(
                                                                    plustMonth.year,
                                                                    plustMonth
                                                                        .month,
                                                                    1,
                                                                    plustMonth.hour,
                                                                    plustMonth
                                                                        .minute);
                                                            availabilityController
                                                                .setCurrentMonth(
                                                              setLastday.toString(),
                                                            );
                                                          },
                                                          child: Obx(
                                                            () => Stack(
                                                              children: <Widget>[
                                                                Align(
                                                                  child: Container(
                                                                    margin: EdgeInsets
                                                                        .fromLTRB(
                                                                            index ==
                                                                                    0
                                                                                ? 0.w
                                                                                : 0.w,
                                                                            0.h,
                                                                            10.w,
                                                                            0.h),
                                                                    width: 89,
                                                                    height: 45,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            borderRadius:
                                                                                const BorderRadius
                                                                                    .all(
                                                                              Radius.circular(
                                                                                  10),
                                                                            ),
                                                                            border: Border.all(
                                                                                color: index == availabilityController.selectedMonth - 1
                                                                                    ? HexColor(
                                                                                        '#FFC74A')
                                                                                    : HexColor(
                                                                                        '#C4C4C4')),
                                                                            color: index ==
                                                                                    availabilityController.selectedMonth - 1
                                                                                ? HexColor('#FFC74A')
                                                                                : Colors.white),
                                                                    child: Center(
                                                                        child: Text(
                                                                            AppListConstants
                                                                                .calendarMonths[index])),
                                                                  ),
                                                                ),
                                                                // Positioned(
                                                                //     right: 2,
                                                                //     top: 2,
                                                                //     child: index
                                                                //             .isOdd
                                                                //         ? Badge(
                                                                //             padding:
                                                                //                 const EdgeInsets.all(8),
                                                                //             badgeColor:
                                                                //                 AppColors.deepGreen,
                                                                //             badgeContent:
                                                                //                 Text(
                                                                //               '2',
                                                                //               style: TextStyle(
                                                                //                   color: Colors.white,
                                                                //                   fontSize: 12.sp,
                                                                //                   fontWeight: FontWeight.w800,
                                                                //                   fontFamily: AppTextConstants.fontPoppins),
                                                                //             ),
                                                                //           )
                                                                //         : Container()),
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
                                            GetBuilder<AvailabilityController>(
                                            id: 'calendar',
                                            builder: (AvailabilityController
                                                controller) {
                                              // print(controller.currentDate);
                                              return Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20.w, 0.h, 20.w, 0.h),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  child: Container(
                                                        padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
                                                        height: MediaQuery.of(context).size.height * 0.4,
                                                        child: SfDateRangePicker(
                                                            enablePastDates: false,
                                                          controller: _dateController,
                                                          minDate: DateTime.parse(availabilityController.currentDate),
                                                          maxDate: Indate.DateUtils.lastDayOfMonth(DateTime.parse(availabilityController.currentDate)),
                                                          initialDisplayDate: DateTime.parse(_selDate.toString()),
                                                            initialSelectedDate: DateTime.parse(_selDate.toString()),
                                                          navigationMode: DateRangePickerNavigationMode.none,
                                                          monthViewSettings: const DateRangePickerMonthViewSettings(
                                                            dayFormat: 'E',
                                                          ),
                                                          monthCellStyle: DateRangePickerMonthCellStyle(
                                                            textStyle: TextStyle(color: HexColor('#3E4242')),
                                                            todayTextStyle:
                                                                TextStyle(fontWeight: FontWeight.bold, color: HexColor('#3E4242')),
                                                          ),
                                                          selectionTextStyle: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          selectionColor: HexColor('#FFC74A'),
                                                          todayHighlightColor: HexColor('#FFC74A'),
                                                          headerHeight: 0,
                                                          onSelectionChanged: _onSelectionChanged
                                                        ),
                                                      )
                                                );
                                            }),
                                            // SizedBox(
                                            //   height: 20.h,
                                            // ),
                                            SizedBox(
                                              width: 153.w,
                                              height: 54.h,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  print(UserSingleton.instance.user.user?.id);
                                                  toggleUpdateStatus(availabilityId);
                                                  Navigator.pop(context);
                                                },
                                                style: AppTextStyle.activeGreen,
                                                child: const Text(
                                                  'Set Date',
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
                                    ),
                                  ).whenComplete(() {
                                    _scrollController.easyScrollToIndex(index: 0);
                                  });
                                  Future.delayed(const Duration(seconds: 1), () {
                                    _scrollController.easyScrollToIndex(
                                        index:
                                            availabilityController.selectedMonth -
                                                1);

                                    // setState(() {
                                    //   selectedmonth = 7;
                                    // });
                                  });
                                },
                            ),
                        )
                      ),
                    ),
                  )
                  ] : [ Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: CircularProgressIndicator(),
                          )
                        ],
                      ),
                    ] ,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('selectedmonth', selectedmonth));
    properties.add(DiagnosticsProperty<AvailabilityController>('availabilityController', availabilityController));
    properties.add(DiagnosticsProperty('result', result));
    properties.add(DiagnosticsProperty<User?>('user', user));
    properties.add(StringProperty('availabilityId', availabilityId));
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
  }
}