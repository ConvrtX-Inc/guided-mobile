import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/screens/payments/payment_manage_card.dart';

/// returns google wallet
String googleWallet = 'assets/images/png/google_wallet.png';

/// returns wallet app icon
String walletAppIcon = 'assets/images/png/wallet_app_icon.png';

/// returns bank card icon
String bankCardIcon = 'assets/images/png/bank_card.png';

/// Modal Bottom sheet for payment method
Future<dynamic> paymentMethod(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return ScreenUtilInit(
            builder: () => Container(
              height: 726.h,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 42.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.withOpacity(0.2)),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        'Payment Method',
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                    SizedBox(
                      height: 40.h,
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Please setup your payment method to get better delivery service',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Payment methods',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Expanded(child: Divider(thickness: 2))
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          getPaymentMethod(),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Bank card',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Expanded(child: Divider(thickness: 2))
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                    getBankCard(),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomRoundedButton(
                        title: 'Continue',
                        onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    const PaymentManageCard()),
                          );
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
            designSize: const Size(375, 812),
          );
        });
      });
}

/// payment method
Widget getPaymentMethod() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        getMethods(name: bankCardIcon, data: 1),
        getMethods(name: googleWallet, data: 0),
        getMethods(name: walletAppIcon, data: 0)
      ],
    );

final List<String> _cardImage = AppListConstants.cardImage;

/// Bank card
Widget getBankCard() => SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Expanded(
            child: CarouselSlider.builder(
                itemCount: _cardImage.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  final String cardImage = _cardImage[index];
                  return buildcardImage(cardImage, index);
                },
                options: CarouselOptions(height: 200.h)),
          ),
        ],
      ),
    );

/// widget for carousel
Widget buildcardImage(String cardImage, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      color: Colors.grey,
    );

/// widet for payment method
Widget getMethods({required String name, required int data}) {
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 65.h,
        width: 95.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: data >= 1
                ? Border.all(width: 1.w)
                : Border.all(
                    width: 1.w,
                    color: Colors.grey.withOpacity(0.5),
                  ),
            borderRadius: BorderRadius.circular(12)),
        child: Stack(clipBehavior: Clip.none, children: <Widget>[
          Center(child: Image.asset(name)),
          if (data >= 1)
            Positioned(
              right: -5,
              top: -7,
              child: Container(
                height: 20.h,
                width: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,
                ),
                child: Center(
                    child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12.sp,
                )),
              ),
            )
        ]),
      ),
    );
  });
}
