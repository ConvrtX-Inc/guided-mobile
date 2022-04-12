import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activity_availability_hours.dart';
// import 'package:horizontal_center_date_picker/datepicker_controller.dart';
// import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../../models/booking_hours.dart';
import '../../../../utils/services/rest_api_service.dart';

/// Check Availability
class CheckAvailability extends StatefulWidget {
  ///constructor
  const CheckAvailability({Key? key}) : super(key: key);

  @override
  State<CheckAvailability> createState() => _CheckAvailabilityState();
}

class _CheckAvailabilityState extends State<CheckAvailability> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));
  int _selectedDay = 0;
  int _numberOfTravellers = 0;
  late List<BookingHours> listTime = [];
  @override
  void initState() {
    initializeDateFormatting('en', null);
    listTime = AppListConstants.bookingHours;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<DateTime> ListDates =
        List<DateTime>.from(screenArguments['selectedDates'] as List);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.keyboard_backspace,
                        size: 30,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Clear',
                        style: TextStyle(
                            color: HexColor('#181B1B'),
                            fontSize: 15.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Select date',
                      style: TextStyle(
                          color: HexColor('#181B1B'),
                          fontSize: 27.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border:
                              Border.all(color: HexColor('#007749'), width: 1),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          'Booking History',
                          style: TextStyle(
                              color: HexColor('#007749'),
                              fontSize: 14.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Add your activity dates for exact pricing.',
                  style: TextStyle(
                      color: HexColor('#181B1B'),
                      fontSize: 14.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Jun 2021',
                      style: TextStyle(
                          color: HexColor('#181B1B'),
                          fontSize: 20.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\$60',
                      style: TextStyle(
                          color: HexColor('#181B1B'),
                          fontSize: 30.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children:
                          List<Widget>.generate(ListDates.length, (int i) {
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedDay = i;
                          }), // Handle
                          child: Container(
                            margin: EdgeInsets.only(right: 15.w),
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: i == _selectedDay
                                  ? HexColor('#FFC74A')
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                getDay(ListDates[i]),
                                style: TextStyle(
                                    color: HexColor('#181B1B'),
                                    fontSize: 17.sp,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                FutureBuilder<List<ActivityAvailability>>(
                  future: APIServices().getActivityHours(
                      formatDate(ListDates.first),
                      formatDate(ListDates.last),
                      screenArguments['packageid']),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ActivityAvailability>> snapshot) {
                    if (snapshot.hasData) {
                      return Text(getTime(snapshot
                          .data!
                          .first
                          .activityAvailabilityHours!
                          .first
                          .availabilityDateHour!));
                      // return Text(listTime[1][1]);
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: List.generate(
                        listTime.length,
                        (int index) {
                          return Column(
                            children: <Widget>[
                              // padding: EdgeInsets.fromLTRB(0, 15.h, 0, 15.h),
                              ListTile(
                                  leading: Text(
                                    '${listTime[index].startHour} - ${listTime[index].endHour}',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'Gilroy',
                                        fontWeight: index == 0 || index == 4
                                            ? FontWeight.bold
                                            : FontWeight.w500),
                                  ),
                                  title: index == 0
                                      ? Text(
                                          '  8 Traveler Limit Left',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'Gilroy',
                                              color: AppColors.deepGreen,
                                              fontWeight: FontWeight.w700),
                                        )
                                      : index == 4
                                          ? Text(
                                              '4 Traveler Limit Left',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: 'Gilroy',
                                                color: AppColors.deepGreen,
                                              ),
                                            )
                                          : Container(),
                                  trailing: index == 0
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: AppColors.deepGreen,
                                        )
                                      : index == 4
                                          ? Icon(
                                              Icons.radio_button_unchecked,
                                              color: AppColors.deepGreen,
                                            )
                                          : null),

                              const Divider(),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Number of people',
                  style: TextStyle(
                      color: HexColor('#181B1B'),
                      fontSize: 27.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        if (_numberOfTravellers > 0) {
                          setState(() {
                            _numberOfTravellers--;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: AppColors.deepGreen,
                      ),
                      iconSize: 46,
                    ),
                    Container(
                      width: 187.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.platinum,
                          ),
                          borderRadius: BorderRadius.circular(
                              20) // use instead of BorderRadius.all(Radius.circular(20))
                          ),
                      child: Center(
                        child: Text(
                          _numberOfTravellers.toString(),
                          style: TextStyle(
                              color: AppColors.rangooGreen,
                              fontSize: 18.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _numberOfTravellers++;
                        });
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: AppColors.deepGreen,
                      ),
                      iconSize: 46,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    '(How many Travelers can you accommodate for this tour?).',
                    style: TextStyle(
                        color: AppColors.osloGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.101,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.5, color: HexColor('#ECEFF0')),
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  '${AssetsPath.assetsPNGPath}/messageTyping.png',
                  height: 22.h,
                  width: 22.w,
                ),
                Text(
                  'Contact Tourist Guide',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.deepGreen,
                  ),
                ),
                SizedBox(
                  width: 125.w,
                  height: 53.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/travellerBookingDetailsScreen');
                    },
                    style: AppTextStyle.active,
                    child: const Text(
                      'Book Now',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ),
                // deepGreen
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDay(DateTime date) {
    final DateFormat formatter = DateFormat('d');
    final String formatted = formatter.format(date);

    return formatted;
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    return formatted;
  }

  String getTime(String date) {
    final DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    final DateTime inputDate = DateTime.parse(parseDate.toString());
    final DateFormat outputFormat = DateFormat('HH:mm:ss');
    final String outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
