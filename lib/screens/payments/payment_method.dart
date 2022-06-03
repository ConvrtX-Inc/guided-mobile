import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/payment_mode.dart';
import 'package:guided/screens/widgets/reusable_widgets/credit_card.dart';
import 'package:guided/utils/services/static_data_services.dart';

import 'package:pay/pay.dart' as pay;
/// returns bank card icon
String bankCardIcon = 'assets/images/png/bank_card.png';

/// Modal Bottom sheet for payment method
Future<dynamic> paymentMethod(
    {required BuildContext context,
    required Function onContinueBtnPressed,
    Function? onCreditCardSelected,
    double? price,
    int paymentMode = 0}) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        final CardController _cardController = Get.put(CardController());

        ///Initializations
        CardModel selectedCard = CardModel();

        final List<PaymentMode> paymentModes =
            StaticDataService.getPaymentModes();
        int selectedPaymentMode = paymentMode;
        Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'].toString();

        /// For pay Plugin
        final _paymentItems = [
          pay.PaymentItem(
            label: 'Total',
            amount: price.toString(),
            status: pay.PaymentItemStatus.final_price,
          )
        ];

        debugPrint(
            'Publishable Key ${dotenv.env['STRIPE_PUBLISHABLE_KEY'].toString()}');
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
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.grey.withOpacity(0.2)),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          )),
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
                          // getPaymentMethod(),
                          ///Payment Method / Mode Selection
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                for (int i = 0; i < paymentModes.length; i++)
                                  if (paymentModes[i].isEnabled)
                                    getMethods(
                                        data: paymentModes[i],
                                        isSelected: selectedPaymentMode == i,
                                        onPaymentModePressed: () {
                                          debugPrint('Selected');

                                          setState(() {
                                            selectedPaymentMode = i;
                                          });

                                          if (selectedPaymentMode == 1) {
                                            // Google Pay
                                            debugPrint('Google Pay');
                                            // handleGooglePay(context);
                                          } else {
                                            // apple pay

                                          }
                                        }),
                              ]),

                          SizedBox(
                            height: 20.h,
                          ),

                          ///Bank Card Payment Mode
                          if (selectedPaymentMode == 0)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
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
                                GetBuilder<CardController>(
                                    builder: (CardController _controller) {
                                  debugPrint('Cards:: ${_controller.cards}');
                                  if (_controller.cards.isNotEmpty) {
                                    selectedCard = _controller.cards[0];
                                  }
                                  return CarouselSlider(
                                    options: CarouselOptions(
                                        height: 178.h,
                                        enableInfiniteScroll: false,
                                        onPageChanged: (int index,
                                            CarouselPageChangedReason reason) {
                                          setState(() {
                                            selectedCard =
                                                _controller.cards[index];
                                          });

                                          if (onCreditCardSelected != null) {
                                            return onCreditCardSelected(
                                                selectedCard);
                                          }
                                        }),
                                    items:
                                        _controller.cards.map((CardModel card) {
                                      return Builder(
                                        builder: (
                                          BuildContext context,
                                        ) {
                                          return CreditCard(
                                              cardDetails: card,
                                              showRemoveBtn: false);
                                        },
                                      );
                                    }).toList(),
                                  );
                                })
                              ],
                            ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 40.h,
                    ),
                    if (selectedPaymentMode == 0)
                      CustomRoundedButton(
                        title: 'Continue',
                        onpressed: () {
                          ///For bank card
                          if (selectedPaymentMode == 0 &&
                              selectedCard.id.isNotEmpty) {
                            return onContinueBtnPressed(selectedCard);
                          } else {
                            Navigator.of(context).pushNamed('/add_card');
                          }
                        },
                      ),

                    ///Google Pay
                    if (selectedPaymentMode == 1)
                      Container(
                          height: 100.h,
                          width: MediaQuery.of(context).size.width,
                          child: pay.GooglePayButton(
                            paymentConfigurationAsset:
                                'google_pay_payment_profile.json',
                            paymentItems: _paymentItems,
                            margin: const EdgeInsets.only(top: 15),
                            onPaymentResult: (result) async {
                              final token = result['paymentMethodData']
                                  ['tokenizationData']['token'];
                              final tokenJson =
                                  Map.castFrom(json.decode(token));
                              debugPrint('Result ${result}');
                              debugPrint(
                                  'payment method ${tokenJson['card']['id']}');

                              // debugPrint('Params ${params}');
                              onContinueBtnPressed(tokenJson);
                            },
                            loadingIndicator: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            onPressed: () async {
                              // 1. Add your stripe publishable key to assets/google_pay_payment_profile.json
                              // await debugChangedStripePublishableKey();
                            },
                            childOnError: Text(
                                'Google Pay is not available in this device'),
                            onError: (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'There was an error while trying to perform the payment'),
                                ),
                              );
                            },
                          )),

                    if (selectedPaymentMode == 2)
                      Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: pay.ApplePayButton(
                          paymentConfigurationAsset:
                              'default_payment_profile_apple_pay.json',
                          paymentItems: _paymentItems,
                          // margin: const EdgeInsets.only(top: 15),
                          onPaymentResult: (result) async {
                            // debugPrint('Apple Pay Result ${result}');

                            // final TokenData token = await Stripe.instance
                            //     .createApplePayToken(result);
                            // debugPrint('Apple Token $token');
                            final jsonData = jsonDecode(result['token']);
                            print(jsonData['header']['transactionId']);
                            onContinueBtnPressed(
                                jsonData['header']['transactionId'].toString());

                            // debugPrint('Params ${params}');
                            // onContinueBtnPressed(tokenJson);
                          },
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          childOnError:
                              Text('Apple Pay is not available in this device'),
                          onError: (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'There was an error while trying to perform the payment'),
                              ),
                            );
                          },
                        ),
                      ),

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
// Widget getPaymentMethod() => Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         getMethods(name: bankCardIcon, data: 1),
//         getMethods(name: googleWallet, data: 0),
//         getMethods(name: walletAppIcon, data: 0)
//       ],
//     );

final List<String> _cardImage = AppListConstants.cardImage;

/// widget for carousel
Widget buildcardImage(String cardImage, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      color: Colors.grey,
    );

/// widet for payment method
Widget getMethods({
  required PaymentMode data,
  required VoidCallback onPaymentModePressed,
  bool isSelected = false,
}) {
  return InkWell(
    onTap: data.isEnabled ? onPaymentModePressed : null,
    child: Container(
      height: 65.h,
      width: 95.w,
      decoration: BoxDecoration(
          color: Colors.white,
          border: isSelected
              ? Border.all(width: 1.w, color: AppColors.deepGreen)
              : Border.all(
                  width: 1.w,
                  color: Colors.grey.withOpacity(0.5),
                ),
          borderRadius: BorderRadius.circular(12)),
      child: Stack(clipBehavior: Clip.none, children: <Widget>[
        Center(
            child: Container(
          decoration: BoxDecoration(
            // child: Image.asset(data.logo)
            image: DecorationImage(image: AssetImage(data.logo)),
          ),
        )),
        if (isSelected)
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
}

/// For Google Pay
Future<void> handleGooglePay(context) async {
  debugPrint('Handle Google Pay');

  try {
    // 1. fetch Intent Client Secret from backend

    // 2.present google pay sheet
    await Stripe.instance.initGooglePay(GooglePayInitParams(
        testEnv: true,
        merchantName: "Example Merchant Name",
        countryCode: 'us'));

    await Stripe.instance.presentGooglePay(
      const PresentGooglePayParams(
          clientSecret:
              'sk_test_51K6QgjKn5tIlJ89hpKNuYDHqBxmc6l2BRG2REm11slivu6QzrRdyYB8DbGa3ObMTo2dyskjQ83GClkk5DVWrRRuO00RKZQAYm1'),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google Pay payment succesfully completed')),
    );
  } catch (e) {
    debugPrint('ERROR ${e}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}
