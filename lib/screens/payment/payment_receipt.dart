import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/models/booking_request.dart';
import 'package:guided/models/user_model.dart';
import 'package:intl/intl.dart';

Future<dynamic> showPaymentReceipt(
    {required BuildContext context,
    required BookingRequest bookingRequest,
    required String paymentMethod,
    required String paymentDetail,
    required String transactionNumber,
    required double price}) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        final double subTotal =
            getSubtotal(price, bookingRequest.numberOfPerson!);
        final double adventureFee = getAdventureFee(subTotal);
        final double grandTotal = getGrandTotal(adventureFee, subTotal);
        final String paymentMethodLabel = getPaymentDetails(paymentMethod);
        return Container(
            height: MediaQuery.of(context).size.height - 40,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 42.h),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Row(children: <Widget>[
                    InkWell(
                        onTap: () {
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey.withOpacity(0.2)),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        )),
                    Expanded(
                      child: Text(
                        'Receipt',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ]),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: AppColors.concrete,
                        border: Border.all(color: AppColors.tabBorder),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    height: MediaQuery.of(context).size.height - 210,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          leading: buildProfilePicture(),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                UserSingleton.instance.user.user!.fullName!,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Transaction Number:',
                                style: TextStyle(
                                    color: AppColors.osloGrey, fontSize: 12.sp),
                              ),
                              Text(
                                transactionNumber,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                              Text('Booking Date',
                                  style: TextStyle(
                                      color: AppColors.osloGrey,
                                      fontSize: 12.sp)),
                              Text(getStartAndEndDate(bookingRequest),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          height: MediaQuery.of(context).size.height * 0.28,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              // color: Colors.white
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    '${AssetsPath.assetsPNGPath}/receipt_bg.png',
                                  ))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Traveler Paid',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              buildDetails(
                                  'Number of People',
                                  '${bookingRequest.numberOfPerson!} People',
                                  false),
                              buildDetails(
                                  'Price Per Person',
                                  'CAD $price x ${bookingRequest.numberOfPerson!}',
                                  false),
                              buildDetails(
                                  'Subtotal:', subTotal.toString(), true),
                              buildDetails('Adventure Service Fee 15%',
                                  'CAD ${adventureFee.toString()}', false),
                              buildDetails('Grand Total: ',
                                  'CAD ${grandTotal.toString()}', true),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Payment Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              buildDetails(
                                  'Payment Method', paymentMethodLabel, false),
                              if (paymentMethod == PaymentConfig.bankCard)
                                buildDetails(
                                    'Credit Card Number', paymentDetail, false),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomRoundedButton(
                      title: 'Ok',
                      onpressed: () => {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/traveller_tab',
                                (Route<dynamic> route) => false)
                          })
                ])));
      });
}

Widget buildDetails(String label, String value, bool highlightLabel) =>
    Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
                color: AppColors.osloGrey,
                fontSize: 12.sp,
                fontWeight:
                    highlightLabel ? FontWeight.w700 : FontWeight.normal),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
                fontSize: 11.sp,
                fontWeight: highlightLabel ? FontWeight.w700 : FontWeight.w400),
          )
        ],
      ),
    );

Widget buildProfilePicture() => Container(
        child: Stack(
      children: <Widget>[
        Container(
          width: 65.w,
          height: 65.h,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1.5,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: const <BoxShadow>[
              BoxShadow(blurRadius: 3, color: Colors.grey)
            ],
          ),
          child: UserSingleton.instance.user.user!.firebaseProfilePicUrl != null
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  backgroundImage: NetworkImage(
                      UserSingleton.instance.user.user!.firebaseProfilePicUrl!))
              : CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  backgroundImage: AssetImage(AssetsPath.defaultProfilePic),
                ),
        ),
        Positioned(
            top: 8,
            right: 2,
            child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: Image.asset(
                  AssetsPath.greenCheck,
                  height: 25,
                  width: 25,
                )))
      ],
    ));

double getSubtotal(double price, int numberOfPerson) {
  return price * numberOfPerson;
}

double getAdventureFee(double total) {
  return total * .15;
}

double getGrandTotal(double adventureFee, double subTotal) {
  return adventureFee + subTotal;
}

String getStartAndEndDate(BookingRequest bookingRequest) {
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

String getPaymentDetails(String method) {
  String paymentMethodLabel = '';
  switch (method) {
    case 'BANK_CARD':
      paymentMethodLabel = 'Credit Card';
      break;
    case 'GOOGLE_PAY':
      paymentMethodLabel = 'Google Pay';
      break;
    case 'APPLE_PAY':
      paymentMethodLabel = 'Apple Pay';
      break;
  }
  return paymentMethodLabel;
}
