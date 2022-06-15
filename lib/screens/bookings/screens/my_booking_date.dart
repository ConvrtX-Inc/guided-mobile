import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/bookings/screens/booking_calendar.dart';
import 'package:guided/screens/bookings/widgets/booking_date_header.dart';
import 'package:guided/screens/bookings/widgets/booking_month.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<dynamic> selectBookingDates({
  required BuildContext context,
}) {
  final List<String> calendarMonths = AppListConstants.calendarMonths;
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,

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
              Expanded(child: buildDates(calendarMonths))
            ],
          ),
        );
      });
}

Widget buildDates(List<String> calendarMonths) => GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisExtent: 60,
      crossAxisSpacing: 20,
    ),
    itemCount: calendarMonths.length,
    itemBuilder: (BuildContext ctx, int index) {
      return GestureDetector(
        onTap: (){
          showBookingDateCalendar(context: ctx, selectedMonthName: calendarMonths[index] , selectedMonthNumber: index + 1);
        },
        child: bookingMonth(calendarMonths[index], index.isOdd? 0 : 2, ctx,true),
        // child: bookingMonth(calendarMonths[index], index.isOdd ? 0 : 3, context, true),
      );
    });

