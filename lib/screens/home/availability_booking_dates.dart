// ignore_for_file: file_names, always_specify_types, avoid_dynamic_calls, avoid_redundant_argument_values, cascade_invocations, cast_nullable_to_non_nullable, prefer_final_in_for_each, type_annotate_public_apis, always_declare_return_types, unnecessary_statements, curly_braces_in_flow_control_structures
import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/activity_availability_hours_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/screens/widgets/reusable_widgets/time_loading.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:table_calendar/table_calendar.dart';

/// Set Booking Date Screen
class AvailabilityBookingDateScreen extends StatefulWidget {
  /// Constructor
  const AvailabilityBookingDateScreen({Key? key}) : super(key: key);

  @override
  _AvailabilityBookingDateScreenState createState() =>
      _AvailabilityBookingDateScreenState();
}

class _AvailabilityBookingDateScreenState
    extends State<AvailabilityBookingDateScreen> {
  late DateTime _preSelectedDay = DateTime.now();
  late DateTime _prefocusedDay = DateTime.now();
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();

  bool isRefreshing = false;
  bool _didPickedDate = false;
  bool isSubmit = false;
  bool _didInitialSave = false;
  bool _newDate = false;
  bool _isLoading = true;

  late List<dynamic> setbookingtime = [];
  late List<dynamic> listTime;
  late List<dynamic> time = [];
  List<String> splitId = [];
  List<DateTime?> splitAvailabilityDateHour = [];
  List<int> splitSlot = [];
  @override
  void initState() {
    super.initState();
    listTime = AppListConstants.timeList;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      getActivityAvailabilityHours(
          screenArguments['id'], listTime, screenArguments['selected_date']);
      _isLoading = false;
    });
  }

  Future<void> getActivityAvailabilityHours(List<String> activityAvailabilityId,
      List<dynamic> listTime, DateTime selectedDate) async {
    String hourFormat;
    String selectedDateFormat;
    String splitDateFormat;
    selectedDateFormat =
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';

    for (int num = 0; num < activityAvailabilityId.length; num++) {
      final List<ActivityAvailabilityHour> resForm = await APIServices()
          .getActivityAvailabilityHour(activityAvailabilityId[num]);

      if (resForm.isEmpty) {
        final dynamic response2 = await APIServices().request(
            '${AppAPIPath.activityAvailability}/${activityAvailabilityId[num]}',
            RequestType.DELETE,
            needAccessToken: true);
      }

      for (int index = 0; index < resForm.length; index++) {
        splitId.add(resForm[index].id);
        splitAvailabilityDateHour.add(resForm[index].availability_date_hour);
        splitSlot.add(resForm[index].slots);
      }

      for (int index = 0; index < splitAvailabilityDateHour.length; index++) {
        splitDateFormat =
            '${splitAvailabilityDateHour[index]?.year}-${splitAvailabilityDateHour[index]?.month}-${splitAvailabilityDateHour[index]?.day}';
        if (selectedDateFormat == splitDateFormat) {
          _newDate = false;
          hourFormat =
              '${splitAvailabilityDateHour[index]?.hour.toString()}:00:00';
          for (int timeIndex = 0; timeIndex < listTime.length; timeIndex++) {
            setState(() {
              listTime[timeIndex][6] = activityAvailabilityId[num];
            });
            if (hourFormat == listTime[timeIndex][3]) {
              setState(() {
                listTime[timeIndex][1] = true;
                listTime[timeIndex][2] = splitSlot[index];
                listTime[timeIndex][5] = splitId[index];
              });
              setbookingtime.add(listTime[timeIndex]);
            }
          }
        } else {
          _newDate = true;
        }
      }
      splitId.clear();
      splitAvailabilityDateHour.clear();
      splitSlot.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _preSelectedDay = screenArguments['selected_date'];
    _prefocusedDay = screenArguments['selected_date'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            for (int index = 0; index < listTime.length; index++) {
              setState(() {
                listTime[index][1] = false;
                listTime[index][2] = 0;
                listTime[index][5] = '';
                listTime[index][6] = '';
              });
            }
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
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.setBookingDates),
                  SizedBox(
                    height: 30.h,
                  ),
                  if (_isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: SkeletonText(
                          height: 60,
                          width: 500,
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      width: width,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
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
                          _didPickedDate
                              ? '${_selectedDay.day}/${AppListConstants.calendarMonths.elementAt(_selectedDay.month - 1)}/ ${_selectedDay.year}'
                              : '${_preSelectedDay.day}/${AppListConstants.calendarMonths.elementAt(_preSelectedDay.month - 1)}/ ${_preSelectedDay.year}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primaryGreen,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        // inkwell color
                        child: const Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onTap: () {
                          final DateTime temp =
                              _focusedDay.subtract(const Duration(days: 7));

                          if (temp.compareTo(DateTime.now()) > 0) {
                            setState(() {
                              _focusedDay =
                                  _focusedDay.subtract(const Duration(days: 7));
                            });
                          }
                        },
                      ),
                      if (_isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: SkeletonText(
                              width: 400,
                              height: 40,
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: TableCalendar(
                            locale: 'en',
                            onDaySelected: (selectedDay, focusedDay) {
                              if (setbookingtime.isNotEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            Text(AppTextConstants.saveChanges),
                                        content: StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                SizedBox(height: 5.h),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 24.w,
                                                      vertical: 2.h),
                                                  child: Text(AppTextConstants
                                                      .saveChangesDesc),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _didInitialSave =
                                                              true;
                                                        });
                                                        setInitialDate(
                                                            screenArguments[
                                                                'id'],
                                                            listTime,
                                                            selectedDay,
                                                            focusedDay);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            color: AppColors
                                                                .silver,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        primary: AppColors
                                                            .primaryGreen,
                                                        onPrimary: Colors.white,
                                                      ),
                                                      child: _didInitialSave
                                                          ? const Center(
                                                              child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ))
                                                          : const Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                    ),
                                                    SizedBox(
                                                      width: 20.w,
                                                    ),
                                                    if (_didInitialSave)
                                                      Container()
                                                    else
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color: AppColors
                                                                  .silver,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                          primary: AppColors
                                                              .primaryGreen,
                                                          onPrimary:
                                                              Colors.white,
                                                        ),
                                                        child: const Text(
                                                          'No',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    barrierDismissible: false);
                              } else {
                                setState(() {
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                    isRefreshing = true;
                                    _didPickedDate = true;
                                  });

                                  Future.delayed(
                                      const Duration(milliseconds: 100), () {
                                    setState(() {
                                      isRefreshing = false;
                                    });
                                  });

                                  for (int index = 0;
                                      index < listTime.length;
                                      index++) {
                                    setState(() {
                                      listTime[index][1] = false;
                                      listTime[index][2] = 0;
                                      listTime[index][5] = '';
                                      listTime[index][6] = '';
                                    });
                                  }

                                  getActivityAvailabilityHours(
                                      screenArguments['id'],
                                      listTime,
                                      _selectedDay);
                                });
                              }
                            },
                            calendarFormat: CalendarFormat.week,
                            currentDay:
                                _didPickedDate ? _selectedDay : _preSelectedDay,
                            headerVisible: false,
                            headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                            ),
                            daysOfWeekVisible: false,
                            firstDay: DateTime.now(),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay:
                                _didPickedDate ? _focusedDay : _prefocusedDay,
                            calendarStyle: CalendarStyle(
                              todayDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.brightSun,
                              ),
                              todayTextStyle: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      InkWell(
                        // inkwell color
                        child: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onTap: () {
                          setState(() {
                            _focusedDay =
                                _focusedDay.add(const Duration(days: 7));
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (isRefreshing)
                    const SizedBox()
                  else
                    _isLoading
                        ? const TimeLoading()
                        : ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                                listTime.length,
                                (i) => SingleChildScrollView(
                                      child: Card(
                                        child: CheckboxListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(
                                                listTime[i][0],
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: AppListConstants
                                                            .timeList[i][1]
                                                        ? AppColors.deepGreen
                                                        : AppColors.osloGrey,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Gilroy'),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              SizedBox(
                                                  child: Wrap(
                                                      alignment: WrapAlignment
                                                          .spaceBetween,
                                                      children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          width: 30.w,
                                                          height: 40.h,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: listTime[
                                                                          i][1]
                                                                      ? AppColors
                                                                          .osloGrey
                                                                      : AppColors
                                                                          .deepGreen),
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: IconButton(
                                                              icon: Icon(
                                                                Icons.remove,
                                                                color: listTime[
                                                                        i][1]
                                                                    ? AppColors
                                                                        .osloGrey
                                                                    : AppColors
                                                                        .primaryGreen,
                                                                size: 15,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  if (listTime[
                                                                              i]
                                                                          [1] ==
                                                                      false) {
                                                                    if (listTime[i]
                                                                            [
                                                                            2] !=
                                                                        0) {
                                                                      listTime[
                                                                              i]
                                                                          [2]--;
                                                                    }
                                                                  }
                                                                });
                                                              }),
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Container(
                                                          height: 40.h,
                                                          width: 40.w,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .osloGrey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r)),
                                                          child: Center(
                                                            child: Text(
                                                              ' ${listTime[i][2]}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20.sp),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Container(
                                                          width: 30.w,
                                                          height: 40.h,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: listTime[
                                                                          i][1]
                                                                      ? AppColors
                                                                          .osloGrey
                                                                      : AppColors
                                                                          .deepGreen),
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: IconButton(
                                                              icon: Icon(
                                                                Icons.add,
                                                                color: listTime[
                                                                        i][1]
                                                                    ? AppColors
                                                                        .osloGrey
                                                                    : AppColors
                                                                        .primaryGreen,
                                                                size: 15,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  if (listTime[
                                                                              i]
                                                                          [1] ==
                                                                      false) {
                                                                    if (listTime[i]
                                                                            [
                                                                            2] <
                                                                        screenArguments[
                                                                            'number_of_tourist'])
                                                                      listTime[
                                                                              i]
                                                                          [2]++;
                                                                  }
                                                                });
                                                              }),
                                                        )
                                                      ],
                                                    ),
                                                  ]))
                                            ],
                                          ),
                                          onChanged: (bool? value) {
                                            if (listTime[i][2] == 0) {
                                              AdvanceSnackBar(
                                                      message:
                                                          ErrorMessageConstants
                                                              .slotIsZero)
                                                  .show(context);
                                            } else {
                                              setState(() {
                                                listTime[i][1] = value!;
                                              });
                                              _onCheckedSelected(
                                                  i,
                                                  listTime[i][1],
                                                  listTime[i][0],
                                                  listTime[i][2]);
                                            }
                                          },
                                          value: listTime[i][1],
                                        ),
                                      ),
                                    ))),
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
            onPressed: isSubmit ? null : setBookingDates,
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
            child: isSubmit
                ? const Center(child: CircularProgressIndicator())
                : Text(
                    AppTextConstants.submit,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _onCheckedSelected(
      int id, bool selected, String time, int counter) async {
    if (selected) {
      setbookingtime.add(listTime[id]);
    } else {
      if (listTime[id][5].toString().isNotEmpty) {
        final dynamic response = await APIServices().request(
            '${AppAPIPath.createSlotAvailabilityHour}/${listTime[id][5]}',
            RequestType.DELETE,
            needAccessToken: true);
      }
      setbookingtime.remove(listTime[id]);
    }
  }

  Future<void> timeSave() async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    DateTime _date;

    if (_didPickedDate) {
      _date = _selectedDay;
    } else {
      _date = _preSelectedDay;
    }

    if (_newDate) {
      if (setbookingtime.isNotEmpty) {
        final Map<String, dynamic> availabilityDateDetails = {
          'activity_package_id': screenArguments['package_id'],
          'availability_date':
              '${_date.year.toString().padLeft(4, '0')}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')} ${setbookingtime[0][3]}',
          'slots': setbookingtime[0][2],
        };

        final dynamic response = await APIServices().request(
            AppAPIPath.createSlotAvailability, RequestType.POST,
            needAccessToken: true, data: availabilityDateDetails);

        if (setbookingtime.length > 1) {
          final String activityAvailabilityId =
              response['response']['data']['details']['id'];

          for (var i = 1; i < setbookingtime.length; i++) {
            final Map<String, dynamic> availabilityDateHourDetails = {
              'activity_availability_id': activityAvailabilityId,
              'availability_date_hour':
                  '${_date.year.toString().padLeft(4, '0')}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')} ${setbookingtime[i][3]}',
              'slots': setbookingtime[i][2],
            };

            final dynamic response1 = await APIServices().request(
                AppAPIPath.createSlotAvailabilityHour, RequestType.POST,
                needAccessToken: true, data: availabilityDateHourDetails);
          }
        }

        for (var i = 0; i < setbookingtime.length; i++) {
          int id = setbookingtime[i][4];
          setState(() {
            listTime[id][1] = false;
            listTime[id][2] = 0;
            listTime[id][5] = '';
            listTime[id][6] = '';
          });
        }
        setbookingtime.clear();
      }
    } else {
      if (setbookingtime.isNotEmpty) {
        for (var i = 0; i < setbookingtime.length; i++) {
          if (setbookingtime[i][5].toString().isNotEmpty) {
            final Map<String, dynamic> availabilityDateHourDetails = {
              'activity_availability_id': setbookingtime[i][6],
              'availability_date_hour':
                  '${_date.year.toString().padLeft(4, '0')}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')} ${setbookingtime[i][3]}',
              'slots': setbookingtime[i][2],
            };

            final dynamic response = await APIServices().request(
                '${AppAPIPath.createSlotAvailabilityHour}/${setbookingtime[i][5]}',
                RequestType.PATCH,
                needAccessToken: true,
                data: availabilityDateHourDetails);
          } else {
            final Map<String, dynamic> availabilityDateDetails = {
              'activity_availability_id': setbookingtime[i][6],
              'availability_date_hour':
                  '${_date.year.toString().padLeft(4, '0')}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')} ${setbookingtime[i][3]}',
              'slots': setbookingtime[i][2],
            };

            final dynamic response = await APIServices().request(
                AppAPIPath.createSlotAvailabilityHour, RequestType.POST,
                needAccessToken: true, data: availabilityDateDetails);
          }
        }

        for (var i = 0; i < setbookingtime.length; i++) {
          int id = setbookingtime[i][4];
          setState(() {
            listTime[id][1] = false;
            listTime[id][2] = 0;
            listTime[id][5] = '';
            listTime[id][6] = '';
          });
        }
        setbookingtime.clear();
      }
    }
  }

  Future<void> setInitialDate(List<String> id, List<dynamic> listTime,
      DateTime selectedDay, DateTime focusedDay) async {
    await timeSave();
    await getActivityAvailabilityHours(id, listTime, selectedDay);
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _didPickedDate = true;
      _didInitialSave = false;
    });
    Navigator.pop(context);
  }

  Future<void> setBookingDates() async {
    if (setbookingtime.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.selectTime).show(context);
    } else {
      setState(() {
        isSubmit = true;
      });
      await timeSave();
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const MainNavigationScreen(
                    navIndex: 1,
                    contentIndex: 0,
                  )));
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isRefreshing', isRefreshing));
  }
}
