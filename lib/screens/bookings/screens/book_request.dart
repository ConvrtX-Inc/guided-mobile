import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/app_scaffold.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/constants/payment_status.dart';
import 'package:guided/controller/stripe_card_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/booking_request.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/payment/payment_confirm.dart';
import 'package:guided/screens/payment/payment_receipt.dart';
import 'package:guided/screens/payment/payment_success.dart';
import 'package:guided/screens/payments/payment_failed.dart';
import 'package:guided/screens/widgets/reusable_widgets/booking_payment_details.dart';
import 'package:guided/screens/widgets/reusable_widgets/reviews_count.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/stripe_service.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';

///Book Request
class BookRequest extends StatefulWidget {
  ///Constructor
  const BookRequest({required this.params, Key? key}) : super(key: key);

  // final BookingRequest bookingRequest;

  final dynamic params;

  @override
  _BookRequestState createState() => _BookRequestState();
}

class _BookRequestState extends State<BookRequest> {
  bool isDonationEmpty = false;
  final FocusNode donationFocusNode = FocusNode();
  final TextEditingController _donationTextController =
      TextEditingController(text: '1');

  String selectedPaymentMethod = '';

  final StripeCardController _stripeCardController =
      Get.put(StripeCardController());

  String transactionNumber = '';

  double price = 150;

  Widget bookingPaymentDetails = Container();

  String googlePaymentToken = '';

  final Pay _payClient = Pay.withAssets([
    'default_payment_profile_apple_pay.json',
    'google_pay_payment_profile.json'
  ]);

  BookingRequest bookingRequest = BookingRequest();

  String serviceName = 'Tourist Service';

  String paymentDetail = '';

  double total = 0;

  double adventureFee = 0;

  double grandTotal = 0;

  String paymentMethodId = '';

  User guideDetails = User();

  ActivityPackage activityPackage = ActivityPackage();

  @override
  void initState() {
    super.initState();

    // bookingRequest = widget.bookingRequest;
    bookingRequest = widget.params['bookingRequest'];
    activityPackage = widget.params['activityPackage'];
    guideDetails = widget.params['guideDetails'];

    transactionNumber = GlobalMixin().generateTransactionNumber();

    // getTourGuideUserDetails();

    total = bookingRequest.numberOfPerson! * price;
    adventureFee = total * 0.15;
    grandTotal = adventureFee + total;
  }

  // Payment Method Selection
  Future<void> openPaymentMethodScreen() async {
    final args =
        await Navigator.of(context).pushNamed('/manage_payment_method');

    await setPaymentMethod(args.toString());
  }

  //set payment method
  Future<void> setPaymentMethod(String paymentMethod) async {
    if (paymentMethod == PaymentConfig.googlePay) {
      debugPrint('Payment Method id $googlePaymentToken');
      if (googlePaymentToken.isEmpty) {
        final result = await _payClient.showPaymentSelector(
          provider: PayProvider.google_pay,
          paymentItems: [],
        );

        debugPrint('REsult ${result}');
        final token = result['paymentMethodData']['tokenizationData']['token'];
        final tokenJson = Map.castFrom(json.decode(token));

        if (tokenJson['id'] != '') {
          final String paymentMethodFromToken = await StripeServices()
              .createPaymentMethodFromToken(tokenJson['id']);

          debugPrint('paymentMethodID  $paymentMethodFromToken');
          setState(() {
            googlePaymentToken = tokenJson['id'];
            paymentMethodId = paymentMethodFromToken;
          });
        }
      }
    }

    if (paymentMethod == PaymentConfig.bankCard) {
      setState(() {
        paymentDetail = '**********${_stripeCardController.defaultCard.last4!}';
        paymentMethodId = _stripeCardController.defaultCard.id!;
      });
    }

    setState(() {
      selectedPaymentMethod = paymentMethod;
    });
  }

  // proceed to payment callback - check if payment method is selected first
  Future<void> proceedToPayment() async {
    if (selectedPaymentMethod.isEmpty) {
      final args = await Navigator.of(context).pushNamed('/goToPaymentMethod');

      if (args == 'openPaymentMethod') {
        await openPaymentMethodScreen();
      }
    } else {
      debugPrint('Should open payment Method..');
      if (_donationTextController.text.isEmpty) {
        setState(() {
          isDonationEmpty = true;
        });
        donationFocusNode.requestFocus();
      } else {
        if (int.parse(_donationTextController.text) < 1) {
          isDonationEmpty = true;
          donationFocusNode.requestFocus();
          return;
        } else {
          await processPayment();
        }
      }
    }
  }

// Payment Flow
  Future<void> processPayment() async {
    bookingPaymentDetails = BookingPaymentDetails(
        transactionNumber: transactionNumber,
        price: grandTotal.toString(),
        serviceName: serviceName,
        tour: bookingRequest.activityPackageName!,
        tourGuide: guideDetails.fullName!,
        bookingDate: getStartAndEndDate(),
        numberOfPeople: bookingRequest.numberOfPerson!);

    await paymentConfirmModal(
        context: context,
        bookingRequestId: bookingRequest.id!,
        paymentDetails: bookingPaymentDetails,
        guideStripeAccountId: guideDetails.stripeAccountId!,
        adventureFee: adventureFee,
        serviceName: serviceName,
        paymentMode: selectedPaymentMethod,
        onPaymentFailed: onPaymentFailed,
        // paymentMethod: _stripeCardController.defaultCard.id,
        paymentMethod: paymentMethodId,
        onPaymentSuccessful: onPaymentSuccessful,
        onConfirmPaymentPressed: () {
          // goToPaymentMethod(context, screenArgs);
        },
        price: grandTotal);
  }

  /// Update payment status  (Completed/Rejected)
  Future<void> updateBookingPaymentStatus(
      String paymentStatus, String bookingRequestId) async {
    final APIStandardReturnFormat res = await APIServices()
        .updateBookingPaymentStatus(bookingRequestId, paymentStatus);

    debugPrint('Response ${res}');
  }

  void onPaymentFailed() {
    updateBookingPaymentStatus(PaymentStatus.rejected, bookingRequest.id!);
    paymentFailed(
        context: context,
        paymentDetails: bookingPaymentDetails,
        paymentMethod: selectedPaymentMethod);
  }

  void onPaymentSuccessful() {
    updateBookingPaymentStatus(PaymentStatus.completed, bookingRequest.id!);
    showPaymentSuccess(
        context: context,
        btnText: 'View Receipt',
        paymentDetails: BookingPaymentDetails(
            backgroundColor: AppColors.concrete,
            showPrice: false,
            transactionNumber: transactionNumber,
            price: price.toStringAsFixed(2),
            serviceName: serviceName,
            tour: bookingRequest.activityPackageName!,
            tourGuide: guideDetails.fullName!,
            bookingDate: getStartAndEndDate(),
            numberOfPeople: bookingRequest.numberOfPerson!),
        paymentMethod: selectedPaymentMethod,
        onBtnPressed: () {
          // show transaction details
          debugPrint('Payment Receipt Show');

          // showPaymentReceipt(context);
          showPaymentReceipt(
              context: context,
              transactionNumber: transactionNumber,
              price: price,
              paymentDetail: paymentDetail,
              paymentMethod: selectedPaymentMethod,
              bookingRequest: bookingRequest);
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
        appBarTitle: AppTextConstants.requestToBook,
        appBarLeadingCallback: () => Navigator.of(context).pop(),
        centerAppBarTitle: true,
        appbarLeadingIcon: Icons.arrow_back,
        bodyPaddingHorizontal: 0,
        bodyPaddingVertical: 0,
        body: buildBookRequestUI());
  }

  Widget buildBookRequestUI() => SingleChildScrollView(
          child: Column(
        children: <Widget>[
          buildBasicPackageDetails(),
          buildDivider(),
          priceDetailsSection(),
          buildDivider(),
          paymentMethodSection(),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomRoundedButton(
                title: 'Proceed To Payment', onpressed: proceedToPayment),
          ),
          const SizedBox(
            height: 22,
          ),
        ],
      ));

  Widget buildBasicPackageDetails() => Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(14),
      child: Row(children: <Widget>[
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage(activityPackage.firebaseCoverImg!),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                activityPackage.address!,
                style: TextStyle(
                    color: AppColors.dustyGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                bookingRequest.activityPackageName!,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(activityPackage.mainBadge!.badgeName!),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const <Widget>[
                  ReviewsCount(),
                  Spacer(),
                  // Text('Apr 8, 2021')
                ],
              )
            ],
          ),
        )
      ]));

  Widget priceDetailsSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
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
            width: 85.w,
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
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                width: 236.w,
                decoration: BoxDecoration(
                  color: !isDonationEmpty
                      ? HexColor('#C5FFCF')
                      : HexColor('#FFD0D0'),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    r'A minimum of $1 payment will be donated to 1% For The Planet',
                    style: TextStyle(
                      color:
                          !isDonationEmpty ? HexColor('#066028') : Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Container(
                width: 60.w,
                child: TextField(
                  focusNode: donationFocusNode,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  controller: _donationTextController,
                  onChanged: (val) {
                    if (int.parse(val.trim()) >= 1) {
                      setState(() {
                        isDonationEmpty = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: r'$1',
                    prefix: _donationTextController.text.isNotEmpty
                        ? Text(r'$')
                        : null,
                    contentPadding: EdgeInsets.all(8.w),
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            !isDonationEmpty ? Colors.grey : AppColors.lightRed,
                      ),
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
                'Price per person',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                price.toString(),
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
                'Number of Person',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                bookingRequest.numberOfPerson!.toString(),
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
                '${PaymentConfig.currencyCode} ${total.toStringAsFixed(2)}',
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

  Widget paymentMethodSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
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
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                  onTap: () => setPaymentMethod(PaymentConfig.bankCard),
                  child: buildPaymentMethodBtn(
                    isSelected: selectedPaymentMethod == PaymentConfig.bankCard,
                    iconUrl: '${AssetsPath.assetsPNGPath}/credit_card_icon.png',
                  )),
              if (Platform.isAndroid)
                GestureDetector(
                    onTap: () => setPaymentMethod(PaymentConfig.googlePay),
                    child: buildPaymentMethodBtn(
                      isSelected:
                          selectedPaymentMethod == PaymentConfig.googlePay,
                      isEnabled: Platform.isAndroid,
                      iconUrl:
                          '${AssetsPath.assetsPNGPath}/google_wallet_icon.png',
                    )),
              if (Platform.isIOS)
                GestureDetector(
                    onTap: () => setPaymentMethod(PaymentConfig.applePay),
                    child: buildPaymentMethodBtn(
                      isSelected:
                          selectedPaymentMethod == PaymentConfig.applePay,
                      isEnabled: Platform.isIOS,
                      iconUrl:
                          '${AssetsPath.assetsPNGPath}/apple_wallet_icon.png',
                    )),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const Divider(color: Colors.grey),
          SizedBox(
            height: 10.h,
          ),
          if (selectedPaymentMethod == PaymentConfig.bankCard)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('**********${_stripeCardController.defaultCard.last4!}'),
                Text(
                    '${_stripeCardController.defaultCard.expMonth} / ${_stripeCardController.defaultCard.expYear.toString().replaceRange(0, 2, '')}')
              ],
            ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Enter a coupon',
            style: TextStyle(
              color: HexColor('#181B1B'),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentMethodBtn(
          {bool isSelected = false,
          String iconUrl = '',
          bool isEnabled = true}) =>
      SizedBox(
          height: 45.h,
          width: 90.w,
          child: Stack(children: <Widget>[
            Align(
              child: Container(
                height: 38.h,
                width: 84.w,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected ? AppColors.deepGreen : Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                // child: Center(child: Image.asset(iconUrl)),
                child: isEnabled
                    ? Image.asset(iconUrl)
                    : Center(
                        child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              AppColors.gallery,
                              BlendMode.saturation,
                            ),
                            child: Image.asset(iconUrl))),
              ),
            ),
            if (isSelected)
              Positioned(
                right: -8,
                top: -6,
                child: SvgPicture.asset(
                    '${AssetsPath.assetsSVGPath}/check_green_circle.svg'),
              ),
          ]));

  Widget buildDivider() => Divider(
        color: AppColors.gallery,
        thickness: 10,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isDonationEmpty', isDonationEmpty))
      ..add(DiagnosticsProperty<FocusNode>(
          'donationFocusNode', donationFocusNode))
      ..add(StringProperty('selectedPaymentMethod', selectedPaymentMethod))
      ..add(
          DiagnosticsProperty<BookingRequest>('bookingRequest', bookingRequest))
      ..add(StringProperty('googlePaymentToken', googlePaymentToken))
      ..add(DoubleProperty('price', price))
      ..add(StringProperty('transactionNumber', transactionNumber))
      ..add(StringProperty('serviceName', serviceName))
      ..add(StringProperty('paymentDetail', paymentDetail))
      ..add(DoubleProperty('total', total))
      ..add(DoubleProperty('adventureFee', adventureFee))
      ..add(DoubleProperty('grandTotal', grandTotal));
  }
}
