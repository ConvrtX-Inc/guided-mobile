import 'dart:io';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import '../../constants/app_colors.dart';

///Payment Method Screen
class PaymentMethodScreen extends StatefulWidget {
  ///Constructor
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = PaymentConfig.bankCard;

  final CardController _cardController = Get.put(CardController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppTextConstants.paymentMethod,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: buildPaymentMethodUI(),
    );
  }

  Widget buildPaymentMethodUI() => Container(
        padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppTextConstants.selectDefaultMethod,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
            if (_cardController.cards.isNotEmpty &&
                _cardController.defaultCard.id.isNotEmpty)
              buildPaymentMethodItem(
                  '${AssetsPath.assetsPNGPath}/credit_icon.png',
                  'Bank Card',
                  '${GlobalMixin().getFormattedCardNumber(cardNumber: _cardController.defaultCard.cardNo, startingNumber: 0)} ${_cardController.defaultCard.cardType}',
                  PaymentConfig.bankCard),
            if (Platform.isIOS)
              buildPaymentMethodItem(
                  '${AssetsPath.assetsPNGPath}/apple_pay.png',
                  'Apple Pay',
                  'testemail.com',
                  PaymentConfig.applePay),
            if (Platform.isAndroid)
              buildPaymentMethodItem(
                  '${AssetsPath.assetsPNGPath}/google_pay.png',
                  'Google Pay',
                  'testemail.com',
                  PaymentConfig.googlePay),
          ],
        ),
      );

  Widget buildPaymentMethodItem(String iconPath, String paymentMethodName,
          String paymentMethodValue, String value) =>
      Container(
          padding: EdgeInsets.all(8.w),
          margin: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2.0, 2.0),
                blurRadius: 0.2,
                spreadRadius: 0.2,
              )
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset(
              iconPath,
              height: 50,
              width: 50,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(paymentMethodName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    )),
                SizedBox(height: 8.h),
                Text(
                  paymentMethodValue,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                )
              ],
            ),
            trailing: CustomCheckBox(
              value: selectedMethod == value,
              shouldShowBorder: true,
              borderColor: AppColors.grey,
              checkedFillColor: AppColors.primaryGreen,
              borderRadius: 8.r,
              borderWidth: 1.w,
              checkBoxSize: 22,
              onChanged: (bool val) {
                setState(() {
                  selectedMethod = value;
                });
              },
            ),
          ));

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('selectedMethod', selectedMethod));
  }
}
