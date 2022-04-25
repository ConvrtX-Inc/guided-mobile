import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activity_availability_hours_model.dart';
import 'package:guided/models/activity_availability_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Popular Guides Traveler Limit Schedules
class PopularGuidesTravelerLimitSchedules extends StatefulWidget {
  /// Constructor
  const PopularGuidesTravelerLimitSchedules(
      {Key? key, required this.packageId, required this.price})
      : super(key: key);

  final String packageId;
  final String price;

  @override
  State<PopularGuidesTravelerLimitSchedules> createState() =>
      _PopularGuidesTravelerLimitSchedulesState();
}

class _PopularGuidesTravelerLimitSchedulesState
    extends State<PopularGuidesTravelerLimitSchedules>
    with AutomaticKeepAliveClientMixin<PopularGuidesTravelerLimitSchedules> {
  @override
  bool get wantKeepAlive => true;
  String date = 'Loading...';
  String time = 'Loading...';
  int slots = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      List<ActivityAvailability> resAvailabilityDate =
          await APIServices().getActivityAvailability(widget.packageId);
      List<ActivityAvailabilityHour> resAvailabilityTime = await APIServices()
          .getActivityAvailabilityHour(resAvailabilityDate[0].id);

      DateTime? tempDate = resAvailabilityTime[0].availability_date_hour;

      setState(() {
        slots = resAvailabilityTime[0].slots;
        date = '${tempDate!.month}. ${tempDate.day}. ${tempDate.year}';
        if (tempDate.hour <= 11) {
          time = '${tempDate.hour}:00 AM to ${tempDate.hour + 1} AM';
        } else {
          time = '${tempDate.hour}:00 PM to ${tempDate.hour + 1} PM';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: EdgeInsets.only(left: 0.w, top: 40.h, bottom: 17.h, right: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              'Traveler Limit',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cloud),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Center(
                child: Text(
                  slots.toString(),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              'Time',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cloud),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Center(
                child: Text(
                  time,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              'Date',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cloud),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Center(
                child: Text(
                  date,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              'Cost Per Person',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cloud),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Center(
                child: Text(
                  '\$${widget.price}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ))));
  }
}
