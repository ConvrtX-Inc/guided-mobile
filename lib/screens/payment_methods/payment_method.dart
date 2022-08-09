import 'dart:io';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/app_scaffold.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/controller/payment_method_controller.dart';
import 'package:guided/controller/stripe_card_controller.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import '../../constants/app_colors.dart';

///Payment Method Screen
class PaymentMethodScreen extends StatefulWidget {
  ///Constructor
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = '';

  final StripeCardController _cardController = Get.put(StripeCardController());

  final PaymentMethodController _paymentMethodController =
      Get.put(PaymentMethodController());

  @override
  void initState() {
    super.initState();
  }

  Future<void> setDefaultPaymentMethod(String paymentMethod) async {
    final dynamic res =
        await APIServices().setUserDefaultPaymentMethod(paymentMethod);

    debugPrint('Response: $res');

    // if(res.statusCode == 200){
    //   _paymentMethodController.setDefaultPaymentMethod(paymentMethod);
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBarLeadingCallback: () => Navigator.pop(context),
        appBarTitle: AppTextConstants.paymentMethod,
        centerAppBarTitle: true,
        body: buildPaymentMethodUI());
  }

  Widget buildPaymentMethodUI() => GetBuilder<PaymentMethodController>(
          builder: (PaymentMethodController _controller) {
        selectedMethod = _controller.paymentMethod;
        return Column(
          children: <Widget>[
            Expanded(
                child: ListView(
              children: <Widget>[
                Text(
                  AppTextConstants.selectDefaultMethod,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                ),
                if (_cardController.cards.isNotEmpty &&
                    _cardController.defaultCard.id != null)
                  buildPaymentMethodItem(
                      '${AssetsPath.assetsPNGPath}/credit_icon.png',
                      'Bank Card',
                      '************${_cardController.defaultCard.last4!} ${_cardController.defaultCard.brand!}',
                      PaymentConfig.bankCard),
                if (Platform.isIOS)
                  buildPaymentMethodItem(
                      '${AssetsPath.assetsPNGPath}/apple_pay.png',
                      'Apple Pay',
                      '',
                      PaymentConfig.applePay),
                if (Platform.isAndroid)
                  buildPaymentMethodItem(
                      '${AssetsPath.assetsPNGPath}/google_pay.png',
                      'Google Pay',
                      '',
                      PaymentConfig.googlePay),
              ],
            )),
            CustomRoundedButton(
                title: AppTextConstants.continueText,
                onpressed: selectedMethod.isNotEmpty
                    ? () => Navigator.pop(context, selectedMethod)
                    : null)
          ],
        );
      });

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
                offset: Offset(2, 2),
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
              value: selectedMethod.toLowerCase() == value.toLowerCase(),
              shouldShowBorder: true,
              borderColor: AppColors.grey,
              checkedFillColor: AppColors.primaryGreen,
              borderRadius: 8.r,
              borderWidth: 1.w,
              checkBoxSize: 22,
              onChanged: (bool val) {
                _paymentMethodController.setDefaultPaymentMethod(value);
                setDefaultPaymentMethod(value);
              },
            ),
          ));

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('selectedMethod', selectedMethod));
  }
}
