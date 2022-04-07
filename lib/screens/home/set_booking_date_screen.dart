// ignore_for_file: file_names, always_specify_types, avoid_dynamic_calls, avoid_redundant_argument_values, cascade_invocations, cast_nullable_to_non_nullable
import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/hourly_item.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/set_booking_date_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/event.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:table_calendar/table_calendar.dart';

/// Set Booking Date Screen
class SetBookingDateScreen extends StatefulWidget {
  /// Constructor
  const SetBookingDateScreen({Key? key}) : super(key: key);

  @override
  _SetBookingDateScreenState createState() => _SetBookingDateScreenState();
}

class _SetBookingDateScreenState extends State<SetBookingDateScreen> {
  late DateTime _preSelectedDay = DateTime.now();
  late DateTime _prefocusedDay = DateTime.now();
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();

  bool isRefreshing = false;
  bool _didPickedDate = false;
  bool isSubmit = false;

  late List<dynamic> setbookingtime = [];
  late List<dynamic> listTime = [];
  @override
  void initState() {
    super.initState();
    listTime = AppListConstants.timeList;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.setBookingDates),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    width: width,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed('/guide_rule');
                      },
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
                    children: [
                      InkWell(
                        // inkwell color
                        child: const Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onTap: () {
                          setState(() {
                            _focusedDay =
                                _focusedDay.subtract(Duration(days: 7));
                          });
                        },
                      ),
                      Expanded(
                        child: TableCalendar(
                          locale: 'en',
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                                isRefreshing = true;
                                _didPickedDate = true;
                              });

                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                setState(() {
                                  isRefreshing = false;
                                });
                              });
                            });
                          },
                          calendarFormat: CalendarFormat.week,
                          currentDay:
                              _didPickedDate ? _selectedDay : _preSelectedDay,
                          headerVisible: false,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                          ),
                          daysOfWeekVisible: false,
                          firstDay: DateTime.utc(2010, 10, 16),
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
                            _focusedDay = _focusedDay.add(Duration(days: 7));
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
                    ListView(
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
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 30.w,
                                                      height: 40.h,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: listTime[i]
                                                                      [1]
                                                                  ? AppColors
                                                                      .osloGrey
                                                                  : AppColors
                                                                      .deepGreen),
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: IconButton(
                                                          icon: Icon(
                                                            Icons.remove,
                                                            color: listTime[i]
                                                                    [1]
                                                                ? AppColors
                                                                    .osloGrey
                                                                : AppColors
                                                                    .primaryGreen,
                                                            size: 15,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (listTime[i]
                                                                      [1] ==
                                                                  false) {
                                                                if (listTime[i]
                                                                        [2] !=
                                                                    0) {
                                                                  listTime[i]
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
                                                              fontSize: 20.sp),
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
                                                              color: listTime[i]
                                                                      [1]
                                                                  ? AppColors
                                                                      .osloGrey
                                                                  : AppColors
                                                                      .deepGreen),
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: IconButton(
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: listTime[i]
                                                                    [1]
                                                                ? AppColors
                                                                    .osloGrey
                                                                : AppColors
                                                                    .primaryGreen,
                                                            size: 15,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (listTime[i]
                                                                      [1] ==
                                                                  false) {
                                                                listTime[i]
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
                                                  message: ErrorMessageConstants
                                                      .slotIsZero)
                                              .show(context);
                                        } else {
                                          setState(() {
                                            listTime[i][1] = value!;
                                          });
                                          _onCheckedSelected(i, listTime[i][1],
                                              listTime[i][0], listTime[i][2]);
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

  void _onCheckedSelected(int id, bool selected, String time, int counter) {
    if (selected) {
      setbookingtime.add(listTime[id]);
    } else {
      setbookingtime.remove(listTime[id]);
    }
  }

  Future<void> setBookingDates() async {
    if (setbookingtime.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.selectTime).show(context);
    } else {
      setState(() {
        isSubmit = true;
      });

      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      DateTime _date;

      if (_didPickedDate) {
        _date = _selectedDay;
      } else {
        _date = _preSelectedDay;
      }

      final Map<String, dynamic> availabilityDateDetails = {
        'activity_package_id': screenArguments['id'],
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
        });
      }
      setbookingtime.clear();

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
