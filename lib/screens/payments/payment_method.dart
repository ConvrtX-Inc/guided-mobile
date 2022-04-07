import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/payment_mode.dart';
import 'package:guided/screens/payments/payment_manage_card.dart';
import 'package:guided/screens/widgets/reusable_widgets/credit_card.dart';
import 'package:guided/utils/services/static_data_services.dart';

/// returns google wallet
String googleWallet = 'assets/images/png/google_wallet.png';

/// returns wallet app icon
String walletAppIcon = 'assets/images/png/wallet_app_icon.png';

/// returns bank card icon
String bankCardIcon = 'assets/images/png/bank_card.png';

final CardController _cardController = Get.put(CardController());

/// Modal Bottom sheet for payment method
Future<dynamic> paymentMethod(
    {required BuildContext context,
    required Function onContinueBtnPressed,
    Function? onCreditCardSelected}) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        ///Initializations
        CardModel selectedCard = _cardController.cards[0];
        final List<PaymentMode> paymentModes =
            StaticDataService.getPaymentModes();
        int selectedPaymentMode = 0;
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
                          // getPaymentMethod(),
                          ///Payment Method / Mode Selection
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                for (int i = 0; i < paymentModes.length; i++)
                                  getMethods(
                                      data: paymentModes[i],
                                      isSelected: selectedPaymentMode == i,
                                      onPaymentModePressed: () {
                                        debugPrint('Selected');
                                        // setState(() {
                                        //   selectedPaymentMode = i;
                                        // });
                                        setState((){
                                          selectedPaymentMode = i;
                                        });
                                      }),
                              ]),

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
                    Container(
                        child: CarouselSlider(
                      options: CarouselOptions(
                          height: 190.h,
                          enableInfiniteScroll: false,
                          onPageChanged:
                              (int index, CarouselPageChangedReason reason) {
                            setState(() {
                              selectedCard = _cardController.cards[index];
                            });

                            if (onCreditCardSelected != null) {
                              return onCreditCardSelected(selectedCard);
                            }

                            // setState(() {
                            //   currentCard = index;
                            //   selectedCard = myCards[currentCard];
                            // });
                          }),
                      items: _cardController.cards.map((CardModel card) {
                        return Builder(
                          builder: (
                            BuildContext context,
                          ) {
                            return CreditCard(
                                cardDetails: card, showRemoveBtn: false);
                          },
                        );
                      }).toList(),
                    )),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomRoundedButton(
                      title: 'Continue',
                      onpressed: (){
                        ///For bank card
                        if(selectedPaymentMode == 0){
                          return onContinueBtnPressed(selectedCard);
                        }
                      },
                      /* onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    const PaymentManageCard()),
                          );
                        }*/
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

/// Bank card
Widget getBankCard() => Container(
        child: CarouselSlider(
      options: CarouselOptions(
          height: 190.h,
          enableInfiniteScroll: false,
          onPageChanged: (int index, CarouselPageChangedReason reason) {
            // setState(() {
            //   currentCard = index;
            //   selectedCard = myCards[currentCard];
            // });
          }),
      items: _cardController.cards.map((CardModel card) {
        return Builder(
          builder: (
            BuildContext context,
          ) {
            return CreditCard(cardDetails: card, showRemoveBtn: false);
          },
        );
      }).toList(),
    ));

/// widget for carousel
Widget buildcardImage(String cardImage, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      color: Colors.grey,
    );

/// widet for payment method
Widget getMethods({required PaymentMode data, required VoidCallback onPaymentModePressed, bool isSelected = false}) {

    return InkWell(
      onTap:  onPaymentModePressed,

      child: Container(
        height: 65.h,
        width: 95.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border:  isSelected
                ? Border.all(width: 1.w,color: AppColors.deepGreen)
                : Border.all(
                    width: 1.w,
                    color: Colors.grey.withOpacity(0.5),
                  ),
            borderRadius: BorderRadius.circular(12)),
        child: Stack(clipBehavior: Clip.none, children: <Widget>[
          Center(child: Image.asset(data.logo)),
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
