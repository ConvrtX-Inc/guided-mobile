import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/app_scaffold.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/booking_request.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/reviews_count.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

///Screen
class BookingRequestPackageDetails extends StatefulWidget {
  ///Constructor
  const BookingRequestPackageDetails({required this.bookingRequest, Key? key})
      : super(key: key);

  final BookingRequest bookingRequest;

  @override
  _BookingRequestPackageDetailsState createState() =>
      _BookingRequestPackageDetailsState();
}

class _BookingRequestPackageDetailsState
    extends State<BookingRequestPackageDetails> {
  ActivityPackage activityPackage = ActivityPackage();

  final PageController page_indicator_controller = PageController();

  BookingRequest bookingRequest = BookingRequest();

  PackageDetailsModel packageDetails = PackageDetailsModel();

  bool isLoadingPackageDetails = true;

  User guideDetails = User();

  @override
  void initState() {
    super.initState();

    bookingRequest = widget.bookingRequest;

    getActivityPackage();
    getTourGuideUserDetails();
  }

  Future<void> getActivityPackage() async {
    final ActivityPackage res = await APIServices()
        .getActivityPackageDetails(bookingRequest.activityPackageId!);

    debugPrint('Bookng request ${bookingRequest.activityPackageId!}');

    if (res.id!.isNotEmpty) {
      setState(() {
        activityPackage = res;
      });
    }

    setState(() {
      isLoadingPackageDetails = false;
    });
  }

  Future<void> getTourGuideUserDetails() async {
    final User res = await APIServices().getUserDetails(bookingRequest.userId!);

    setState(() {
      guideDetails = res;
    });

    debugPrint('USER DATA ${res.stripeAccountId} ${res.fullName}');
  }

  String getStartAndEndDate() {
    String date = '';
    if (DateTime.parse(bookingRequest.bookingDateStart!).day ==
        DateTime.parse(bookingRequest.bookingDateStart!).day) {
      date =
          '${DateFormat("MMM dd hh:mm a").format(DateTime.parse(bookingRequest.bookingDateStart!))} - ${DateFormat("hh:mm a").format(DateTime.parse(bookingRequest.bookingDateEnd!))}';
    } else {
      date =
          '${DateFormat("MMM dd").format(DateTime.parse(bookingRequest.bookingDateStart!))} - ${DateFormat("MMM dd").format(DateTime.parse(bookingRequest.bookingDateEnd!))}';
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: buildPackageDetails(),
      bodyPaddingVertical: 0,
      bodyPaddingHorizontal: 0,
      showAppBar: false,
      showFooter: true,
      footer: buildFooter(),
      appBarLeadingCallback: () => Navigator.of(context).pop(),
    );
  }

  Widget buildPackageDetails() => SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildHeader(),
            if (isLoadingPackageDetails)
              Center(
                  child: CircularProgressIndicator(
                color: AppColors.mediumGreen,
              ))
            else
              buildBody(),
          ],
        ),
      ));

  Widget buildBody() => Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              activityPackage.name!,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: Colors.black),
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
                  /* Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14.r,
                      backgroundImage: MemoryImage(base64.decode(activityPackage
                          .mainBadge!.imgIcon!
                          .split(',')
                          .last)), //here
                    ),
                  ),*/
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
            )
          ],
        ),
      );

  // HEADER
  Widget buildHeader() => SizedBox(
        height: 280.h,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: page_indicator_controller,
              itemCount: 1,
              itemBuilder: (_, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: !isLoadingPackageDetails
                          ? Container(
                              height: 280.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: Image.network(
                                  activityPackage.firebaseCoverImg!,
                                  fit: BoxFit.cover,
                                ).image),
                              ),
                            )
                          : SkeletonText(
                              height: 280.h,
                              width: MediaQuery.of(context).size.width,
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
                  count: 1,
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

  Widget buildFooter() => SafeArea(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        getStartAndEndDate(),
                        style: TextStyle(
                            color: HexColor('#3E4242'),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(right: 15.w),
                  // width: MediaQuery.of(context).size.width,
                  height: 53.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/book_request', arguments: {
                        'bookingRequest': bookingRequest,
                        'activityPackage': activityPackage,
                        'guideDetails': guideDetails
                      });
                    },
                    style: AppTextStyle.active,
                    child: const Text(
                      'Proceed to Payment',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                )),
                // deepGreen
              ],
            ),
          ),
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
            backgroundImage: guideDetails.firebaseProfilePicUrl != ''
                ? NetworkImage(guideDetails.firebaseProfilePicUrl!)
                : AssetImage(AssetsPath.defaultProfilePic) as ImageProvider,
          ),
        ),
        title: Text(
          guideDetails.fullName!,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
        ),
        subtitle: const ReviewsCount(
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      );
}
