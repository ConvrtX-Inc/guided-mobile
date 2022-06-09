import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/screens/bookings/widgets/booking_date_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Future<dynamic> showBookingDateSlots(
    {required BuildContext context,
    required int selectedMonthNumber,
    required String selectedMonthName,
    required String selectedDate}) {
  List<String> months = AppListConstants.calendarMonths;
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              bookingDateHeader(context),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.deepGreen),
                    borderRadius: BorderRadius.circular(12.r)),
                child: Center(
                  child: Text(
                    DateFormat("d / MMMM / yyyy")
                        .format(DateTime.parse(selectedDate)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.deepGreen,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // SizedBox(height: 80, child: buildDateHeader(months, context)),
              SizedBox(
                height: 20.h,
              ),
              Expanded(child: buildTimeSlots())
            ],
          ),
        );
      });
}

Widget buildTimeSlots() => Container(
      child: ListView.separated(
          itemCount: 12,
          separatorBuilder: (BuildContext ctx, int i) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return buildSlotDetail(
              time: '${index + 7} am - ${index + 7 + 1} am',
              hasSlot: index.isOdd,
            );
          }),
    );

Widget buildSlotDetail({String time = '', bool hasSlot = false}) =>
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        time,
        style: TextStyle(
            color: hasSlot ? AppColors.deepGreen : Colors.grey,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600),
      ),
      Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.gallery,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow:   <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: const Offset(
                  -2,2), // changes position of shadow
            ),
          ]
        ) ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 25,
              width: 25,
              child: CircleAvatar(
                backgroundImage: AssetImage(AssetsPath.defaultProfilePic),
              ),
            ),
            SizedBox(width: 12.w),
            Text('John Doe',style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600
            ),),
            SizedBox(width: 10.w),
          ],
        ),
      ),
      // SizedBox(width: 12,)
    ]);
