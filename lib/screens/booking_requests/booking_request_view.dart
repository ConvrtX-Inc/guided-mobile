import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/common/widgets/app_scaffold.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/booking_request.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/fcm_services.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/ui/dialogs.dart';

///Screen
class BookingRequestView extends StatefulWidget {
  ///Constructor
  const BookingRequestView({required this.bookingRequest, Key? key})
      : super(key: key);

  /// Booking Request Route Param
  final BookingRequest bookingRequest;

  @override
  _BookingRequestViewState createState() => _BookingRequestViewState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<BookingRequest>('bookingRequest', bookingRequest));
  }
}

class _BookingRequestViewState extends State<BookingRequestView> {
  BookingRequest _bookingRequest = BookingRequest();
  bool isLoading = false;

  PackageDetailsModel packageDetails = PackageDetailsModel();

  bool isLoadingPackageDetails = true;

  late double total = 0;

  @override
  void initState() {
    super.initState();
    _bookingRequest = widget.bookingRequest;

    getActivityPackage();
  }

  Future<void> getActivityPackage() async {
    final PackageModelData res = await APIServices()
        .getPackageDataById(_bookingRequest.activityPackageId!);

    if (res.packageDetails.isNotEmpty) {
      setState(() {
        packageDetails = res.packageDetails[0];
        total = _bookingRequest.numberOfPerson! *
            double.parse(packageDetails.basePrice);
      });
    }

    setState(() {
      isLoadingPackageDetails = false;
    });
  }

  Future<void> acceptBookingRequest() async {
    setState(() {
      isLoading = true;
    });

    final APIStandardReturnFormat res =
        await APIServices().approveBookingRequest(_bookingRequest.id!);

    debugPrint('Status Code ${res.statusCode}');

    if (res.statusCode == 200) {
      const String notificationTitle = 'Booking Request Approved';
      const String notificationStatus = 'approved';
      final String notificationBody =
          '${UserSingleton.instance.user.user!.fullName!} Approved your Booking Request. Please click to proceed payment';
      sendPushNotification(
          notificationTitle, notificationStatus, notificationBody);
      AppDialogs().showSuccess(
          context: context,
          message: 'Booking Request Accepted',
          title: 'Success',
          onOkPressed: () => Navigator.pop(context, 'Pending'));
    } else {
      AppDialogs().showError(
          context: context,
          message: 'An Error Occurred. Please try again.',
          title: 'Unable to Accept Booking Request');
    }
    setState(() {
      isLoading = false;
    });
  }


  void sendPushNotification(String title, String status, String body) {
    final dynamic _request = _bookingRequest.toJson();
    final dynamic data = {
      'type': 'booking_request',
      'status': status,
      'role': 'traveler',
      'booking_request': _request
    };
    FCMServices().sendNotification(
        'ezleuw9rRvCodQykBPpKHK:APA91bHvRzwNRmDG76IGy9HLiIajvpQwdCIbbcg2-p_P7x1ICJbDhtoSELs2TxWXENPsqLHkKOUHLmZrdI9sfnirBB1pE-S7OYAavxWKmTBspIDcEDe7LU-3WyjoOAJ3WZflRS7qpReP',
        title,
        body,
        data);
  }
  Future<void> rejectBookingRequest() async {
    final APIStandardReturnFormat res =
        await APIServices().rejectBookingRequest(_bookingRequest.id!);

     Navigator.pop(context);
    if (res.statusCode == 200) {
      const String notificationTitle = 'Booking Request Rejected';
      const String notificationStatus = 'rejected';
      final String notificationBody =
          '${UserSingleton.instance.user.user!.fullName!} Rejected your Booking Request.';
      sendPushNotification(
          notificationTitle, notificationStatus, notificationBody);
      AppDialogs().showSuccess(
          context: context,
          message: '',
          title: 'Booking Request Rejected',
          onOkPressed: () => Navigator.pop(context, 'Pending'));
    } else {
      AppDialogs().showError(
          context: context,
          message: '',
          title: 'Unable to Reject Booking Request');
    }
  }

  void showRejectDialog() {
    bool _isRejectingRequest = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (ctx, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.r))),
              title: Text(
                'Reject Request',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Are you sure you want to reject this booking request?',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: 75.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.deepGreen, width: 1.w),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                                child: Text(
                              AppTextConstants.cancel,
                              style: TextStyle(
                                  color: AppColors.deepGreen,
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w700),
                            ))),
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            _isRejectingRequest = true;
                          });
                          await rejectBookingRequest();
                        },
                        child: Container(
                            width: 75.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                                child: !_isRejectingRequest
                                    ? Text(
                                        AppTextConstants.confirm,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w700),
                                      )
                                    : const SizedBox(
                                        height: 12,
                                        width: 12,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        )))),
                      ),
                    ]),
                SizedBox(
                  height: 20.h,
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBarLeadingButton: IconButton(
          icon: SvgPicture.asset('assets/images/svg/arrow_back_with_tail.svg',
              height: 40.h, width: 40.w),
          onPressed: () {
            Navigator.pop(context, 'Pending');
          },
        ),
        body: SingleChildScrollView(
          child: buildRequestViewUI(),
        ));
  }

  Widget buildRequestViewUI() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Requested a trip ,',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
              fontFamily: 'Gilroy',
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            _bookingRequest.fromUserFullName!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
              fontFamily: 'Gilroy',
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            '${_bookingRequest.fromUserFullName!} has requested a new booking for ${_bookingRequest.activityPackageName!}',
            style: TextStyle(
                color: AppColors.doveGrey, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 25.h,
          ),
          Text('Selected gig',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
          SizedBox(
            height: 25.h,
          ),
          if (!isLoadingPackageDetails)
            buildPackageDetails()
          else
            SkeletonText(
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
          SizedBox(height: 25.h),
          Text(
            'Message',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
          SizedBox(height: 25.h),
          Text(
            _bookingRequest.requestMsg!,
            style: TextStyle(
                color: AppColors.doveGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 35.h),
          CustomRoundedButton(
              isLoading: isLoading,
              title: AppTextConstants.acceptRequest,
              onpressed: () {
                acceptBookingRequest();
              }),
          SizedBox(height: 14.h),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(20)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(HexColor('#F9F9F9')),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ))),
              onPressed: showRejectDialog,
              child: Text(
                AppTextConstants.rejectRequest,
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Gilroy',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      );

  Widget buildPackageDetails() => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: Container(
                height: 255.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        packageDetails.firebaseCoverImg,
                      ),
                      fit: BoxFit.cover),
                ),
              )),
              Positioned(
                  bottom: 0,
                  child: Container(
                    // height: 72.h,
                    padding: EdgeInsets.all(14),
                    width: MediaQuery.of(context).size.width - 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom:
                            BorderSide(width: 1.5, color: AppColors.platinum),
                        left: BorderSide(width: 1.5, color: AppColors.platinum),
                        right:
                            BorderSide(width: 1.5, color: AppColors.platinum),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _bookingRequest.activityPackageName!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15.sp),
                            ),
                            Text(
                              '${_bookingRequest.numberOfPerson!.toString()} Tourists',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '${PaymentConfig.currencyCode} ${total.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BookingRequest>(
          '_bookingRequest', _bookingRequest))
      ..add(DiagnosticsProperty<bool>('isLoading', isLoading))
      ..add(DiagnosticsProperty<PackageDetailsModel>(
          'packageDetails', packageDetails))
      ..add(DiagnosticsProperty<bool>(
          'isLoadingPackageDetails', isLoadingPackageDetails))
      ..add(DoubleProperty('total', total));
  }
}
