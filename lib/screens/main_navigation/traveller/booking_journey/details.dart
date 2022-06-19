import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/activity_availability_hours.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/reviews_count.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

///
class TravellerBookingDetailsScreen extends StatefulWidget {
  ///
  const TravellerBookingDetailsScreen({Key? key, this.params})
      : super(key: key);

  final dynamic params;

  @override
  State<TravellerBookingDetailsScreen> createState() =>
      _TravellerBookingDetailsScreenState();
}

class _TravellerBookingDetailsScreenState
    extends State<TravellerBookingDetailsScreen> {
  final List<Activity> activities = StaticDataService.getActivityList();
  final PageController page_indicator_controller = PageController();

  User tourGuideDetails = User();
  ActivityPackage activityPackage = ActivityPackage();

  String bookingDate = '';

  int numberOfTraveller = 0;

  ActivityAvailabilityHours activityDate = ActivityAvailabilityHours();

  @override
  void initState() {
    super.initState();

    activityPackage = widget.params['package'];
    tourGuideDetails = widget.params['tourGuideDetails'];
    bookingDate = widget.params['selectedDate'];
    numberOfTraveller = widget.params['numberOfTraveller'];

    activityDate = widget.params['activityDateDetails'];

    debugPrint('DATE ${activityDate.activityAvailabilityId}  ${bookingDate} ${activityDate.availabilityDateHour}');

  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Details ${activityPackage.name}');

/*
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final ActivityPackage activityPackage =
        screenArguments['package'] as ActivityPackage;
    final String bookingDate = screenArguments['selectedDate'] as String;
    final int numberOfTraveller = screenArguments['numberOfTraveller'] as int;
*/
    String getTime(String date) {
      final DateTime parseDate =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
      final DateTime inputDate = DateTime.parse(parseDate.toString());
      final DateTime addHour = inputDate.add(const Duration(hours: 1));
      final DateFormat outputFormat = DateFormat('HH:mm');
      final DateFormat outputFormatDate = DateFormat('dd MMM');
      final String date1 = outputFormatDate.format(inputDate);
      final String hour1 = outputFormat.format(inputDate);
      final String hour2 = outputFormat.format(addHour);
      return '$date1 $hour1-$hour2';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildHeader(activityPackage),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  activityPackage.name!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 15.h,
                      width: 15.w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/png/marker.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        activityPackage.address!,
                        style: TextStyle(
                            color: HexColor('#979B9B'),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 28.h,
                  thickness: 2,
                  color: AppColors.gallery,
                ),
                buildTourGuideDetails(activityPackage),
                SizedBox(height: 16.h),
                Container(
                  // width: MediaQuery.of(context).size.width * 0.35,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: AppColors.aquaHaze,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 14.r,
                          backgroundImage: MemoryImage(base64.decode(
                              activityPackage.mainBadge!.imgIcon!
                                  .split(',')
                                  .last)), //here
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Text(
                        activityPackage.mainBadge!.badgeName!,
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            color: HexColor('#3E4242'),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 14.w),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Description',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.h),
                Text(
                  activityPackage.description!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        ],
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
                Container(
                  margin: EdgeInsets.only(left: 15.w, top: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '\$${activityPackage.basePrice}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' / Person',
                            style: TextStyle(
                                color: AppColors.doveGrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Text(
                        getTime(bookingDate),
                        style: TextStyle(
                            color: HexColor('#3E4242'),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 15.w),
                  width: 125.w,
                  height: 53.h,
                  child: ElevatedButton(
                    onPressed: () {
                      requestToBookScreen(context, activityPackage, bookingDate,
                          numberOfTraveller, tourGuideDetails.fullName!);
                    },
                    style: AppTextStyle.active,
                    child: const Text(
                      'Confirm',
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

  // HEADER
  Widget buildHeader(ActivityPackage activityPackage) => SizedBox(
        height: 280.h,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: page_indicator_controller,
              itemCount: activities.length,
              itemBuilder: (_, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 280.h,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: Image.network(
                            activityPackage.firebaseCoverImg!,
                            fit: BoxFit.cover,
                            gaplessPlayback: true,
                          ).image),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SmoothPageIndicator(
                  controller: page_indicator_controller,
                  count: activities.length,
                  effect: const ScrollingDotsEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white,
                    activeStrokeWidth: 2.6,
                    activeDotScale: 1.6,
                    maxVisibleDots: 5,
                    radius: 8,
                    spacing: 10,
                    dotHeight: 6,
                    dotWidth: 6,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 10.w, 0.h),
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.w, 20.h, 5.w, 0.h),
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.w, 20.h, 20.w, 0.h),
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );

  //TOUR GUIDE DETAILS
  Widget buildTourGuideDetails(ActivityPackage activityPackage) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.r,
            backgroundImage: tourGuideDetails.firebaseProfilePicUrl != ''
                ? NetworkImage(tourGuideDetails.firebaseProfilePicUrl!)
                : AssetImage(AssetsPath.defaultProfilePic) as ImageProvider,
          ),
        ),
        title: Text(
          tourGuideDetails.fullName!,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
        ),
        subtitle: const ReviewsCount(
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      );

  Future<void> requestToBookScreen(
      BuildContext context,
      ActivityPackage package,
      String? selectedDate,
      int numberOfTraveller,
      String tourGuide) async {
    final Map<String, dynamic> details = {
      'package': package,
      'selectedDate': selectedDate,
      'numberOfTraveller': numberOfTraveller,
      'tourGuide': tourGuide,
      'activityDateDetails': activityDate
    };
    if (selectedDate != null) {
      await Navigator.pushNamed(context, '/requestToBookScreen',
          arguments: details);
    }
  }
}
