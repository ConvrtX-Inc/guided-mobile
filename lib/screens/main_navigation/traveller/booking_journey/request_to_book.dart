import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/user_transaction_model.dart';
import 'package:guided/screens/payments/confirm_payment.dart';
import 'package:guided/screens/payments/payment_failed.dart';
import 'package:guided/screens/payments/payment_manage_card.dart';
import 'package:guided/screens/payments/payment_method.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/screens/refunds/traveler/request_refund.dart';
import 'package:guided/screens/widgets/reusable_widgets/booking_payment_details.dart';
import 'package:guided/screens/widgets/reusable_widgets/credit_card.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/stripe_service.dart';

import 'package:guided/models/activity_package.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/user_model.dart';

import 'package:intl/intl.dart';

import '../../../../constants/app_colors.dart';

/// Screen for RequestToBookScreen
class RequestToBookScreen extends StatefulWidget {
  /// Constructor
  const RequestToBookScreen({Key? key}) : super(key: key);

  @override
  State<RequestToBookScreen> createState() => _RequestToBookScreenState();
}

class _RequestToBookScreenState extends State<RequestToBookScreen> {
  dynamic paymentMethodDetails;
  String paymentMode = '';
  Widget bookingPaymentDetails = Container();
  double price = 0;
  final String serviceName = 'Tourist Service';
  String transactionNumber = '';

  ActivityPackage activityPackage = ActivityPackage();
  String selectedDate = '';

  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    activityPackage = screenArguments['package'] as ActivityPackage;

    final int numberOfTraveller = screenArguments['numberOfTraveller'] as int;
    selectedDate = screenArguments['selectedDate'] as String;

    price =
        getTotalHours(selectedDate) * double.parse(activityPackage.basePrice!);

    return Scaffold(
      backgroundColor: HexColor('#ECEFF0'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 220.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              AppTextConstants.requestToBook,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 100.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                // image: const DecorationImage(
                                //   image: AssetImage(
                                //       'assets/images/png/activity1.png'),
                                //   fit: BoxFit.cover,
                                // ),
                                image: DecorationImage(
                                    image: Image.memory(
                                  base64.decode(activityPackage.coverImg!
                                      .split(',')
                                      .last),
                                  fit: BoxFit.fill,
                                  gaplessPlayback: true,
                                ).image),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    activityPackage.address!,
                                    style: TextStyle(
                                        color: HexColor('#979B9B'),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  Text(
                                    activityPackage.name!,
                                    style: TextStyle(
                                        color: HexColor('#181B1B'),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Text(
                                    'Hunt',
                                    style: TextStyle(
                                        color: HexColor('#181B1B'),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.star,
                                        size: 14,
                                        color: AppColors.deepGreen,
                                      ),
                                      Text(
                                        '16 reviews',
                                        style: TextStyle(
                                            color: HexColor('#979B9B'),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              sectionTwo(screenArguments),
              sectionThree(),
              if (PaymentConfig.isPaymentEnabled) sectionFour(),
              sectionFive(),
              sectionSix(),
              sectionSeven(screenArguments),
            ],
          ),
        ),
      ),
    );
  }

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
    return '$date1 $hour1 - $hour2';
  }

  Widget sectionTwo(Map<String, dynamic> screenArguments) {
    final String bookingDate = screenArguments['selectedDate'] as String;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Description',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Date',
                    style: TextStyle(
                      color: HexColor('#3E4242'),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    getTime(bookingDate),
                    style: TextStyle(
                      color: HexColor('#696D6D'),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              Spacer(),
              Text(
                'Edit',
                style: TextStyle(
                  color: HexColor('#3E4242'),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Activity',
                  style: TextStyle(
                    color: HexColor('#3E4242'),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Hunting',
                  style: TextStyle(
                    color: HexColor('#696D6D'),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionThree() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 320.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price details',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 43.h,
            width: 101.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              image: DecorationImage(
                image: AssetImage(AssetsPath.forThePlanet),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                height: 47.h,
                width: 236.w,
                decoration: BoxDecoration(
                  color: HexColor('#C5FFCF'),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'A minimum of \$1 payment will be donated to 1% For The Planet',
                    style: TextStyle(
                      color: HexColor('#066028'),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                height: 47.h,
                width: 65.w,
                decoration: BoxDecoration(
                  color: HexColor('#ECEFF0'),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    '\$1',
                    style: TextStyle(
                      color: HexColor('#696D6D'),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: <Widget>[
              Text(
                '${activityPackage.basePrice} X ${getTotalHours(selectedDate)} hours',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '\$360',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: <Widget>[
              Text(
                'Discount 20%',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '-\$60',
                style: TextStyle(
                  color: HexColor('#066028'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: <Widget>[
              Text(
                'Adventure Fee: ',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '\$54',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: <Widget>[
              Text(
                'Total',
                style: TextStyle(
                  color: HexColor('#3E4242'),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '\$354',
                style: TextStyle(
                  color: HexColor('#3E4242'),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget sectionFour() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      // height: 210.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Pay with',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            children: <Widget>[
              Text(
                'Payment method',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                ),
              ),
              const Spacer(),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: paymentMode.isNotEmpty
                        ? Colors.white
                        : HexColor('#007749'),
                  ),
                  onPressed: paymentMode.isEmpty ? selectPaymentMethod : null,
                  child: Text('Add',
                      style: TextStyle(
                          color: paymentMode.isNotEmpty ? null : Colors.white)))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: selectPaymentMethod,
                  child: Container(
                    height: 36.h,
                    width: 84.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/png/card1.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: Platform.isAndroid
                      ? () {
                          selectPaymentMethod(selectedPaymentMode: 1);
                        }
                      : null,
                  child: Container(
                    height: 36.h,
                    width: 84.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/png/card2.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: Platform.isIOS
                      ? () {
                          selectPaymentMethod(selectedPaymentMode: 2);
                        }
                      : null,
                  child: Container(
                    height: 36.h,
                    width: 84.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/png/card3.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(color: Colors.grey),
          if (paymentMode.isNotEmpty)
            Container(
                margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                child: Text(paymentMethodDetails is CardModel
                    ? GlobalMixin().getFormattedCardNumber(
                        startingNumber: 0,
                        cardNumber: paymentMethodDetails.cardNo)
                    : paymentMode)),
          Text(
            'Enter a coupon',
            style: TextStyle(
              color: HexColor('#181B1B'),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          )
        ],
      ),
    );
  }

  Widget sectionFive() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 255.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Required for your trip',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Message the guide',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: HexColor('#3E4242'),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Located northwest if Montreal in Quebec’s the Laurentian Mountains',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: HexColor('#696D6D'),
                ),
              ),
            ),
            trailing: TextButton(
              style: TextButton.styleFrom(
                primary: HexColor('#181B1B'),
                onSurface: Colors.yellow,
                side: BorderSide(color: HexColor('#696D6D'), width: 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Text('Add',
                    style: TextStyle(
                        color: HexColor('#181B1B'),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Phone Number',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: HexColor('#3E4242'),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Located northwest if Montreal in Quebec’s the Laurentian Mountains',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: HexColor('#696D6D'),
                ),
              ),
            ),
            trailing: TextButton(
              style: TextButton.styleFrom(
                primary: HexColor('#181B1B'),
                onSurface: Colors.yellow,
                side: BorderSide(color: HexColor('#696D6D'), width: 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Text('Add',
                    style: TextStyle(
                        color: HexColor('#181B1B'),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget sectionSix() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Cancellation policy',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Located northwest if Montreal in Quebec’s the Laurentian Mountains, Mont-Tremblant is best known for its skiing, specifically Mont.  ',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
                TextSpan(
                  text: 'Learn more!',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#181B1B'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Make sure this guide cancellaion policy works for you.',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#181B1B'),
                  ),
                ),
                TextSpan(
                  text:
                      'Mont-Tremblant is best known for its skiing, specifically Mont.  ',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
                TextSpan(
                  text: 'Learn more!',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#181B1B'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget sectionSeven(Map<String, dynamic> screenArguments) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.h,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Your booking won’t be confirmed until the host accepts your request (within 24 hours?) ',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#181B1B'),
                  ),
                ),
                TextSpan(
                  text: 'You won’t be charged until then.',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          if (PaymentConfig.isPaymentEnabled && paymentMode.isEmpty)
            SizedBox(
              height: 60.h,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: HexColor('#979B9B'),
                  backgroundColor: HexColor('#ECEFF0'),
                ),
                onPressed: () async {
                  final dynamic args =
                      await Navigator.pushNamed(context, '/goToPaymentMethod');
                  debugPrint('Go To payment method $args ');
                  if (args == 'openPaymentMethod') {
                    selectPaymentMethod();
                  }
                },
                child: Text(
                  AppTextConstants.requestToBook,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#979B9B'),
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: 60.h,
              child: CustomRoundedButton(
                isLoading: isLoading,
                title: AppTextConstants.requestToBook,
                onpressed: () async {
                  if (PaymentConfig.isPaymentEnabled) {
                    dynamic paymentClicked = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PaymentManageCard(
                                price: '$price',
                              )),
                    );

                    if (paymentClicked != null) {
                      handleConfirmPayment(screenArguments);
                    }
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    await goToPaymentMethod(context, screenArguments);
                  }
                },
              ),
            )
        ],
      ),
    );
  }

  Future<void> goToPaymentMethod(
      BuildContext context, Map<String, dynamic> screenArguments) async {
    final ActivityPackage activityPackage =
        screenArguments['package'] as ActivityPackage;
    final String bookingDate = screenArguments['selectedDate'] as String;
    final int numberOfTraveller = screenArguments['numberOfTraveller'] as int;
    final Map<String, dynamic> details = {
      'user_id': activityPackage.userId,
      'from_user_id': UserSingleton.instance.user.user!.id,
      'request_msg': activityPackage.name,
      'activity_package_id': activityPackage.id,
      'status_id': 'b0d8e728-e0f3-4db2-af0f-f90d124c482c',
      'booking_date_start': bookingDateStart(bookingDate),
      'booking_date_end': bookingDateEend(bookingDate),
      'number_of_person': numberOfTraveller,
      'is_approved': false
    };
    print(details);

    final UserTransaction transactionDetails = UserTransaction(
        userId: UserSingleton.instance.user.user!.id!,
        activityPackageId: activityPackage.id!,
        tourGuideId: activityPackage.userId!,
        statusId: 'b0d8e728-e0f3-4db2-af0f-f90d124c482c',
        bookDate: bookingDateStart(bookingDate),
        serviceName: serviceName,
        numberOfPeople: numberOfTraveller.toString(),
        transactionNumber: transactionNumber,
        total: price.toString());

    if (PaymentConfig.isPaymentEnabled) {
      // final String paymentIntent = await handlePayment(price);
      final String paymentMethodId = await handlePayment(price);

      if (paymentMethodId.isNotEmpty) {
        await APIServices()
            .requestBooking(details)
            .then((APIStandardReturnFormat value) async {
          if (value.status == 'success') {
            final dynamic result = json.decode(value.successResponse);

            ///save transaction
            final UserTransaction transaction =
                await APIServices().addUserTransaction(transactionDetails);

            ///Save payment intent here
            await saveStripePaymentIntent(
                'paymentIntent', result['id'], paymentMethodId);

            Navigator.pop(context);
            await paymentSuccessful(
                context: context,
                paymentDetails: bookingPaymentDetails,
                paymentMethod: paymentMode,
                onOkBtnPressed: () {
                  // show transaction details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RequestRefund(
                              paymentDetails: paymentMethodDetails,
                              paymentMode: paymentMode,
                              transactionDetails: transaction,
                              activityPackageDetails: activityPackage,
                            )),
                  );
                });
          }
        });
      } else {
        await paymentFailed(
            context: context,
            paymentDetails: bookingPaymentDetails,
            paymentMethod: paymentMode);
      }
    } else {
      await APIServices()
          .requestBooking(details)
          .then((APIStandardReturnFormat value) async {
        if (value.status == 'success') {
          final dynamic result = json.decode(value.successResponse);

          ///save transaction
          final UserTransaction transaction =
              await APIServices().addUserTransaction(transactionDetails);

          setState(() {
            isLoading = false;
          });

         await _showDialog(context);
        }
      });
    }
  }

  String bookingDateStart(String date) {
    final DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    final DateTime inputDate = DateTime.parse(parseDate.toString());

    final DateFormat outputFormatDate = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String bookingDateStart = outputFormatDate.format(inputDate);
    return bookingDateStart;
  }

  String bookingDateEend(String date) {
    final DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    final DateTime inputDate = DateTime.parse(parseDate.toString());
    final DateTime addHour = inputDate.add(const Duration(hours: 1));
    final DateFormat outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String bookingDateEend = outputFormat.format(addHour);
    return bookingDateEend;
  }

  selectPaymentMethod({int selectedPaymentMode = 0}) {
    //please update price when api is integrated
    paymentMethod(
        context: context,
        onCreditCardSelected: (CardModel card) {
          debugPrint('Payment Method:: ${card.cardNo}');
        },
        onContinueBtnPressed: (dynamic data) {
          String mode = '';
          if (data is CardModel) {
            mode = 'Credit Card';
          } else {
            mode = Platform.isAndroid ? 'Google Pay' : 'Apple Pay';
          }

          setState(() {
            paymentMethodDetails = data;
            paymentMode = mode;
          });
          Navigator.of(context).pop();
          debugPrint('Payment Method details $paymentMethodDetails');
        },
        price: price,
        paymentMode: selectedPaymentMode);
  }

  // Create payment method id first for Credit Card Payments
  Future<String> createCreditCardPaymentMethodId() async {
    final CardModel card = paymentMethodDetails;
    final String paymentMethodId =
        await StripeServices().createPaymentMethod(card);

    return paymentMethodId;
  }

  // Handle payment
  Future<String> handlePayment(double price) async {
    String paymentMethodId = '';

    ///For Credit Card Payments
    if (paymentMethodDetails is CardModel) {
      // create payment method first before creating payment intent
      paymentMethodId = await createCreditCardPaymentMethodId();
    } else {
      /// For google pay and apple
      String tokenId = '';
      if (paymentMode == 'Google Pay') {
        tokenId = paymentMethodDetails['id'];
      } else {
        final TokenData tokenData = paymentMethodDetails;
        tokenId = tokenData.id;
      }
      //create payment method first
      paymentMethodId =
          await StripeServices().createPaymentMethodFromToken(tokenId);
    }

    //please update price when api is integrated
    /*final int amount = (price * 100).round();

    final String paymentIntentId =
        await createPaymentIntent(amount, paymentMethodId);

    return paymentIntentId;*/

    return paymentMethodId;
  }

  ///Create Payment Intent Stripe
  Future<String> createPaymentIntent(int amount, paymentMethodId) async {
    final APIStandardReturnFormat result =
        await APIServices().createPaymentIntent(amount);

    debugPrint('Payment Method id : $paymentMethodId');

    final dynamic data = json.decode(result.successResponse);

    return data['id'];
  }

  ///save stripe payment intent to database
  Future<void> saveStripePaymentIntent(String paymentIntentId,
      String bookingRequestId, String paymentMethodId) async {
    final APIStandardReturnFormat result = await APIServices()
        .savePaymentIntent(paymentIntentId, bookingRequestId, paymentMethodId);

    debugPrint('Result ${result}');
  }

  handleConfirmPayment(screenArgs) {
    setState(() {
      transactionNumber = GlobalMixin().generateTransactionNumber();
    });

    final int numberOfTraveller = screenArgs['numberOfTraveller'] as int;
    final String tourGuide = screenArgs['tourGuide'] as String;

    setState(() {
      bookingPaymentDetails = BookingPaymentDetails(
          transactionNumber: transactionNumber,
          price: price.toStringAsFixed(2),
          serviceName: serviceName,
          tour: activityPackage.name!,
          tourGuide: tourGuide,
          bookingDate: getTime(selectedDate),
          numberOfPeople: numberOfTraveller);
    });

    confirmPaymentModal(
        context: context,
        paymentDetails: bookingPaymentDetails,
        serviceName: serviceName,
        paymentMode: paymentMode,
        paymentMethod: paymentMethod,
        onPaymentSuccessful: () {
          /// Book Request
        },
        onConfirmPaymentPressed: () {
          goToPaymentMethod(context, screenArgs);
        },
        price: price);
  }

  int getTotalHours(String selectedDate) {
    final DateTime startDate = DateTime.parse(bookingDateStart(selectedDate));
    final DateTime endDate = DateTime.parse(bookingDateEend(selectedDate));

    return endDate.difference(startDate).inHours;
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
                            'Booking Request Sent!',
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
                              Navigator.of(context).pushNamed('/traveller_tab');
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
