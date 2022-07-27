import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/screens/widgets/reusable_widgets/reviews_count.dart';
import 'package:intl/intl.dart';

///Activity Package Basic Info
class ActivityPackageBasicInfo extends StatelessWidget {
  ///Constructor
  const ActivityPackageBasicInfo(
      { this.onCloseButtonPressed,
      required this.activityPackage,
      this.activityAvailableDates = const [],
      this.height = 120,
      this.blurRadius = 10,
      Key? key})
      : super(key: key);
  final ActivityPackage activityPackage;

  final double height;

  final double blurRadius;

  final  Function? onCloseButtonPressed;

  final List<DateTime> activityAvailableDates;
  @override
  Widget build(BuildContext context) {
    return    InkWell(
        onTap: () {
      Navigator.of(context)
          .pushNamed('/activity_package_info', arguments: activityPackage);
    },
    child:  Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w),
        height: height,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: blurRadius,
            offset: const Offset(0, 10), // changes position of shadow
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 123,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r)),
                    image: DecorationImage(
                        image: NetworkImage(activityPackage.firebaseCoverImg!),
                        fit: BoxFit.cover),
                  ),
                ),
                InkWell(
                  onTap: (){
                    onCloseButtonPressed!();
                  },
                  child: Container(
                    margin: EdgeInsets.all(4.w),
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle),
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                )
              ],
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Text(
                    activityPackage.name!,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                  )),
                  if (activityAvailableDates.isNotEmpty)
                    Text(activityAvailableDates.length > 1
                        ? '${DateFormat("MMM dd -").format(activityAvailableDates[0])} ${activityAvailableDates[activityAvailableDates.length - 1].day}'
                        : DateFormat("MMM dd")
                            .format(activityAvailableDates[0])),
                  SizedBox(height: 5.h),
                  Expanded(
                      child: Row(
                    children: <Widget>[
                      Expanded(child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: '\$ ${activityPackage.basePrice}',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16.sp)),
                        TextSpan(
                            text: ' / person',
                            style: TextStyle(fontSize: 16.sp)),
                      ]))),
                       ReviewsCount()
                    ],
                  ))
                ],
              ),
            ))
          ],
        ),
      ))
    ;
  }
}
