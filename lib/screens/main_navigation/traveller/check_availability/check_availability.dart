import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activity_availability_hours.dart';
import 'package:guided/models/chat_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/message/message_screen_traveler.dart';

// import 'package:horizontal_center_date_picker/datepicker_controller.dart';
// import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../../models/activity_package.dart';
import '../../../../models/booking_hours.dart';
import '../../../../utils/services/rest_api_service.dart';
import 'package:collection/collection.dart';

/// Check Availability
class CheckAvailability extends StatefulWidget {
  ///constructor
  const CheckAvailability({Key? key, this.screenArguments}) : super(key: key);

  final dynamic screenArguments;

  @override
  State<CheckAvailability> createState() => _CheckAvailabilityState();
}

class _CheckAvailabilityState extends State<CheckAvailability> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));
  int _selectedDay = 0;
  int _selectedScheduleIndex = 999;
  int _numberOfTravellers = 0;
  int _slotsAvailable = 0;
  ActivityAvailabilityHours _activityAvailabilityHours =
      ActivityAvailabilityHours();
  late List<BookingHours> listTime = [];

  User guideDetails = User();

  List<Message> messageHistory = [];
  late Map<String, dynamic> screenArguments;

  ActivityPackage activityPackage = ActivityPackage();

  @override
  void initState() {
    initializeDateFormatting('en', null);
    listTime = AppListConstants.bookingHours;
    super.initState();

    debugPrint('Arguments : ${widget.screenArguments}');
    screenArguments = widget.screenArguments;
    activityPackage = screenArguments['package'] as ActivityPackage;

    getGuideDetails(activityPackage.userId!);

    getMessageHistory(activityPackage.userId!);
  }

  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic> screenArguments =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<DateTime> ListDates =
        List<DateTime>.from(screenArguments['selectedDates'] as List);
    // final ActivityPackage activityPackage =
    //     screenArguments['package'] as ActivityPackage;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.keyboard_backspace,
            size: 30,
            color: Colors.black,
          ),

        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Clear',
              style: TextStyle(
                  color: HexColor('#181B1B'),
                  fontSize: 15.sp,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              setState(() {
                _numberOfTravellers  = 0;
                _selectedScheduleIndex = 999;
              });
            },
          )
        ],
      ),
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
                    Text(
                      'Select date',
                      style: TextStyle(
                          color: HexColor('#181B1B'),
                          fontSize: 27.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700),
                    ),
                    /*Container(
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
                    ),*/
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
                      formatDateMonthYear(ListDates[_selectedDay]),
                      style: TextStyle(
                          color: HexColor('#181B1B'),
                          fontSize: 20.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\$${activityPackage.basePrice}',
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
                            _selectedScheduleIndex = 999;
                            _numberOfTravellers = 0;
                            _slotsAvailable = 0;
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
                FutureBuilder<List<ActivityHourAvailability>>(
                  future: APIServices().getActivityHours(
                      formatDate(ListDates.first),
                      formatDate(ListDates.last),
                      activityPackage.id!),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ActivityHourAvailability>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        final String month =
                            formatDate(ListDates[_selectedDay]);
                        final ActivityHourAvailability? outputList = snapshot
                            .data!
                            .firstWhereOrNull((ActivityHourAvailability a) =>
                                a.availabilityDate == month);
                        if (outputList != null) {
                          return Column(
                            children: List<Widget>.generate(
                              listTime.length,
                              (int index) {
                                return Column(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      child: Row(children: <Widget>[
                                        Text(
                                          '${listTime[index].startHour} - ${listTime[index].endHour}',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'Gilroy',
                                              fontWeight: checkDateIfAvailable(
                                                      outputList
                                                          .activityAvailabilityHours!,
                                                      stringDateToDateTime(
                                                          month,
                                                          listTime[index]
                                                              .hour24format))
                                                  ? FontWeight.bold
                                                  : FontWeight.w500),
                                        ),
                                        SizedBox(width: 20.w),
                                        if (checkDateIfAvailable(
                                            outputList
                                                .activityAvailabilityHours!,
                                            stringDateToDateTime(month,
                                                listTime[index].hour24format)))
                                          Text(
                                            getSlots(
                                                outputList
                                                    .activityAvailabilityHours!,
                                                stringDateToDateTime(
                                                    month,
                                                    listTime[index]
                                                        .hour24format)),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: 'Gilroy',
                                                color: AppColors.deepGreen,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        Spacer(),
                                        if (checkDateIfAvailable(
                                                outputList
                                                    .activityAvailabilityHours!,
                                                stringDateToDateTime(
                                                    month,
                                                    listTime[index]
                                                        .hour24format)) &&
                                            _selectedScheduleIndex != index)
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedScheduleIndex =
                                                      index;
                                                  _numberOfTravellers = 0;
                                                  _slotsAvailable = availableSlot(
                                                      outputList
                                                          .activityAvailabilityHours!,
                                                      stringDateToDateTime(
                                                          month,
                                                          listTime[index]
                                                              .hour24format));
                                                  _activityAvailabilityHours =
                                                      getSelectedActivityAvailabilityHours(
                                                          outputList
                                                              .activityAvailabilityHours!,
                                                          stringDateToDateTime(
                                                              month,
                                                              listTime[index]
                                                                  .hour24format))!;
                                                });
                                              },
                                              child: Icon(
                                                Icons.radio_button_unchecked,
                                                color: AppColors.deepGreen,
                                              )),
                                        if (_selectedScheduleIndex == index)
                                          Icon(
                                            Icons.radio_button_checked,
                                            color: AppColors.deepGreen,
                                          )
                                      ]),
                                    ),
                                    const Divider(),
                                  ],
                                );
                              },
                            ),
                          );
                        } else {
                          return noAvailableTime();
                        }
                      } else {
                        return noAvailableTime();
                      }
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return noAvailableTime();
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
                      onPressed: _numberOfTravellers > 0
                          ? () {
                              setState(() {
                                _numberOfTravellers--;
                              });
                            }
                          : null,
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: _numberOfTravellers > 0
                            ? AppColors.deepGreen
                            : AppColors.gallery,
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
                      onPressed: _numberOfTravellers < _slotsAvailable
                          ? () {
                              setState(() {
                                _numberOfTravellers++;
                              });
                            }
                          : null,
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: _numberOfTravellers < _slotsAvailable
                            ? AppColors.deepGreen
                            : AppColors.gallery,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await getGuideDetails(activityPackage.userId!);

                    final ChatModel message =
                        await getMessageHistory(activityPackage.userId!);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MessageScreenTraveler(
                                  message: message,
                                )));
                  },
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        '${AssetsPath.assetsPNGPath}/messageTyping.png',
                        height: 22.h,
                        width: 22.w,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Contact Your Guide',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 125.w,
                  height: 53.h,
                  child: ElevatedButton(
                    onPressed: _numberOfTravellers > 0
                        ? () async {
                            await travellerBookingDetailsScreen(
                                context,
                                activityPackage,
                                _activityAvailabilityHours.availabilityDateHour,
                                _numberOfTravellers);
                          }
                        : null,
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

  Future<void> travellerBookingDetailsScreen(
      BuildContext context,
      ActivityPackage package,
      String? selectedDate,
      int numberOfTraveller) async {
    final Map<String, dynamic> details = {
      'package': package,
      'selectedDate': selectedDate,
      'numberOfTraveller': numberOfTraveller,
      'tourGuideDetails': guideDetails
    };
    if (selectedDate != null) {
      await Navigator.pushNamed(context, '/travellerBookingDetailsScreen',
          arguments: details);
    }
  }

  Widget noAvailableTime() {
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
                        fontWeight: FontWeight.w500),
                  ),
                  title: null,
                  trailing: null),

              const Divider(),
            ],
          );
        },
      ),
    );
  }

  bool checkDateIfAvailable(
      List<ActivityAvailabilityHours> availability, String dateTime) {
    ActivityAvailabilityHours? result = availability.firstWhereOrNull(
        (ActivityAvailabilityHours a) =>
            removeSeconds(a.availabilityDateHour!) == dateTime);
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  String getSlots(
      List<ActivityAvailabilityHours> availability, String dateTime) {
    ActivityAvailabilityHours? result = availability.firstWhereOrNull(
        (ActivityAvailabilityHours a) =>
            removeSeconds(a.availabilityDateHour!) == dateTime);
    if (result != null) {
      return '${result.slots} Traveler Limit Left';
    } else {
      return '';
    }
  }

  int availableSlot(
      List<ActivityAvailabilityHours> availability, String dateTime) {
    ActivityAvailabilityHours? result = availability.firstWhereOrNull(
        (ActivityAvailabilityHours a) =>
            removeSeconds(a.availabilityDateHour!) == dateTime);
    if (result != null) {
      return result.slots!;
    } else {
      return 0;
    }
  }

  ActivityAvailabilityHours? getSelectedActivityAvailabilityHours(
      List<ActivityAvailabilityHours> availability, String dateTime) {
    final ActivityAvailabilityHours? result = availability.firstWhereOrNull(
        (ActivityAvailabilityHours a) =>
            removeSeconds(a.availabilityDateHour!) == dateTime);
    if (result != null) {
      return result;
    } else {
      return null;
    }
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

  String formatDateMonthYear(DateTime date) {
    final DateFormat formatter = DateFormat('MMM yyyy');
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

  String removeSeconds(String date) {
    final DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    final DateTime inputDate = DateTime.parse(parseDate.toString());
    final DateFormat outputFormat = DateFormat("yyy-MM-dd'T'HH:mm:ss");
    final String outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String stringDateToDateTime(String date, String time24Format) {
    final String stringDate = '${date}T$time24Format';
    final DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(stringDate);
    final DateTime inputDate = DateTime.parse(parseDate.toString());
    final DateFormat outputFormat = DateFormat("yyy-MM-dd'T'HH:mm:ss");
    final String outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  Future<void> getGuideDetails(String guideId) async {
    final User result = await APIServices().getUserDetails(guideId);

    setState(() {
      guideDetails = result;
    });
  }

  Future<ChatModel> getMessageHistory(String guideId) async {
    final List<ChatModel> res = await APIServices()
        .getChatMessages(UserSingleton.instance.user.user!.id!, 'all');

    final ChatModel chat = res.firstWhere(
        (ChatModel element) => element.receiver!.id! == guideId,
        orElse: () => ChatModel());

    setState(() {
      if (chat.messages != null) {
        messageHistory = chat.messages!;
      } else {
        messageHistory = [];
      }
    });

    return ChatModel(
        receiver: Receiver(
            fullName: guideDetails.fullName,
            id: activityPackage.userId,
            avatar: guideDetails.firebaseProfilePicUrl),
        messages: messageHistory,
        isBlocked: chat.isBlocked);
  }
}
