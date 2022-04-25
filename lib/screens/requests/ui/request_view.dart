// ignore_for_file: use_raw_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/user_transaction_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

import '../../../models/activity_package.dart';
import '../../../models/booking_request.dart';
import '../../../models/user_model.dart';

/// Notification Screen
class RequestViewScreen extends StatefulWidget {
  /// Constructor
  const RequestViewScreen({Key? key}) : super(key: key);

  @override
  _RequestViewScreenState createState() => _RequestViewScreenState();
}

class _RequestViewScreenState extends State<RequestViewScreen> {
  int _selectedIndex = 0;

  BookingRequest bookingRequest = BookingRequest();
  User travellerDetails = User();

  String paymentMethodId = '';
  String paymentIntentId = '';
  String fromUserId = '';

  bool isLoading = false;

  User fromUser = User();

  UserTransaction transactionDetails = UserTransaction();

  final UserProfileDetailsController _profileDetailsController =
  Get.put(UserProfileDetailsController());

  bool isAccepted = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
    ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    bookingRequest = screenArguments['bookingRequest'] as BookingRequest;
    travellerDetails = screenArguments['traveller'] as User;

    //
    // getBookingPaymentIntentId(bookingRequest.id!);
    // getBookingTransaction(bookingRequest.activityPackageId!,
    //     travellerDetails.id!);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: FutureBuilder<ActivityPackage>(
          future: APIServices()
              .getActivityPackageDetails(bookingRequest.activityPackageId!),
          builder:
              (BuildContext context, AsyncSnapshot<ActivityPackage> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset(
                          'assets/images/svg/arrow_back_with_tail.svg',
                          height: 40.h,
                          width: 40.w),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        'Requested a trip,',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        travellerDetails.fullName!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        '${travellerDetails.fullName} has requested a new booking for package ${bookingRequest.numberOfPerson}',
                        style: TextStyle(
                            color: AppColors.doveGrey,
                            fontSize: 14.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                        height: 200,
                        width: 310.w,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                base64.decode(snapshot.data!.coverImg!),
                                gaplessPlayback: true,
                                width: 20,
                                height: 20,
                              ),
                            )),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: <Color>[
                                            Colors.black.withOpacity(0.5),
                                            Colors.transparent
                                          ])),
                                )),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0, color: Colors.white),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              snapshot.data!.name ?? '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                          Text(
                                              '${bookingRequest.numberOfPerson} Traveller',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: <Widget>[
                                          const Icon(Icons.star_rate, size: 18),
                                          Text(
                                            '0',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '(67)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp),
                                            ),
                                          ),
                                          Text(
                                            '\$${snapshot.data!.basePrice}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 0,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.duckEggBlue,
                                      border: Border.all(
                                        color: AppColors.duckEggBlue,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Row(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          AssetsPath.homeFeatureCalendarIcon,
                                          height: 15,
                                          width: 15,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        // Text(
                                        //   '1 - 9',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.w500,
                                        //       color: AppColors.tropicalRainForest,
                                        //       fontSize: 14.sp,),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 50,
                                  //   height: 30,
                                  //   child: ElevatedButton(
                                  //     onPressed: () {},
                                  //     style: ElevatedButton.styleFrom(
                                  //       shape: const CircleBorder(),
                                  //       primary: Colors.white, // <-- Button color
                                  //       onPrimary: Colors.grey, // <-- Splash color
                                  //     ),
                                  //     child: Icon(Icons.edit,
                                  //         size: 15,
                                  //         color: AppColors.tropicalRainForest),
                                  //   ),
                                  // )
                                ],
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        'Message',
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        bookingRequest.requestMsg ?? '',
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Gilroy',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
               /*     Center(
                      child: SizedBox(
                        width: 315.w,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.spruce),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.r),
                              ))),
                          child: Text(
                            AppTextConstants.acceptRequest,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),*/
                    CustomRoundedButton(title: AppTextConstants.acceptRequest, onpressed: () {
                      chargePayment();
                    }, isLoading: isLoading, isEnabled: isAccepted ? false : true),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: SizedBox(
                        width: 315.w,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  HexColor('#F9F9F9')),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.r),
                              ))),
                          child: Text(
                            AppTextConstants.rejectRequest,
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Gilroy',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container();
          },
        ),
      ),
    );
  }

  Future<void> getBookingPaymentIntentId(String bookingRequestId) async {
    final result = await APIServices().getPaymentIntentId(bookingRequestId);

    debugPrint(
        "Result ${result['stripe_payment_intent_id']} ${result['stripe_payment_method_id']}");
    await getUserDetails(result['user_id']);
    setState(() {
      paymentIntentId = result['stripe_payment_intent_id'];
      paymentMethodId = result['stripe_payment_method_id'];
      fromUserId = result['user_id'];
    });
  }

  Future<void> chargePayment() async {
    setState(() {
      isLoading = true;
    });

    await getBookingPaymentIntentId(bookingRequest.id!);
    await getBookingTransaction(bookingRequest.activityPackageId!,
        travellerDetails.id!);
    final String paymentIntent = await createTransferPaymentIntent();

    if (paymentIntent.isNotEmpty) {
      final paymentRes = await APIServices()
          .chargeBookingPayment(paymentIntent, paymentMethodId);

      if (paymentRes != '') {
        debugPrint('Payment Accepted! $paymentRes');
        setState(() {
          isLoading = false;
          isAccepted = true;
        });
        await _showDialog(context);
      }
    }
  }

  Future<void> getBookingTransaction(String packageId, String userId) async {
    final UserTransaction res =
        await APIServices().getBookingTransaction(packageId, userId);

    debugPrint('Transaction booking ${res.total}');

    setState(() {
      transactionDetails = res;
    });
  }

  Future<void> getUserDetails(String fromUserId) async {
    final User userDetails = await APIServices().getUserDetails(fromUserId);

    setState(() {
      fromUser = userDetails;
    });
  }

  Future<String> createTransferPaymentIntent() async {
    final ProfileDetailsModel user =
        _profileDetailsController.userProfileDetails;
    final String res = await APIServices().createTransferPaymentIntent(
        user.stripeAccountId,
        double.parse(transactionDetails.total),
        0,
        fromUser.email!);

    return res;
  }

  Future<void> _showDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(22.r))),
            elevation: 12,
            content: SizedBox(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   mainAxisSize: MainAxisSize.min,

                  children: <Widget>[

                    Center(
                      child: Container(
                        child: Text(
                           'Booking Request Accepted!',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.sp)),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                        child: CustomRoundedButton(
                          title: 'Ok',
                          onpressed: () {
                            int count = 0;
                            Navigator.popUntil(context, (route) {
                              return count++ == 2;
                            });
                          },
                          buttonHeight: 40.h,
                          buttonWidth: 120.w,
                        ))
                  ],
                )),
          );
        });
  }


}
