import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/controller/bank_account_controller.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/bank_account_model.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/url_launcher.dart';

///Manage Payment Screen
class ManagePayment extends StatefulWidget {
  ///Constructor
  const ManagePayment({Key? key}) : super(key: key);

  @override
  _ManagePaymentState createState() => _ManagePaymentState();
}

class _ManagePaymentState extends State<ManagePayment> {
  List<BankAccountModel> bankAccounts = <BankAccountModel>[];

  final BankAccountController _bankAccountController =
      Get.put(BankAccountController());

  List<CardModel> cards = <CardModel>[];

  final CardController _cardController = Get.put(CardController());

  bool isLoading = false;
  bool isSettingUpStripe = false;

  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());

  String stripeAcctId = '';

  @override
  void initState() {
    super.initState();

    isLoading = true;
    stripeAcctId = _profileDetailsController.userProfileDetails.stripeAccountId;

    debugPrint(
        'Profile Details:: ${_profileDetailsController.userProfileDetails.id}  Stripe account id: ${_profileDetailsController.userProfileDetails.stripeAccountId} ');

    getPaymentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Manage Payment',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Gilroy'),
        ),
      ),
      // body: buildPaymentUI(),
      body: (stripeAcctId.isEmpty && PaymentConfig.isPaymentEnabled)
          ? buildSetupStripeAccount()
          : buildPaymentUI(),
    );
  }

  Widget buildPaymentUI() => isLoading
      ? buildFakePaymentDataUI()
      : Container(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildPaymentCards(),
              SizedBox(height: 20.h),
              Divider(color: Colors.grey),
              SizedBox(height: 20.h),
              buildPaymentBanks(),
            ],
          )),
        );

  ///Manage Cards
  Widget buildPaymentCards() =>
      GetBuilder<CardController>(builder: (CardController _controller) {
        cards = _controller.cards;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Credit/Debit Card',
                style: TextStyle(fontSize: 14.sp, color: AppColors.grey)),
            SizedBox(height: 16.h),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: cards.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final CardModel _card = cards[index];
                  return buildCreditCardItem(_card);
                }),
            SizedBox(height: 12.h),
            buildAddPaymentItem('Add Card', () {
              Navigator.of(context).pushNamed('/add_card');
            })
          ],
        );
      });

  ///Manage Bank Accounts
  Widget buildPaymentBanks() => GetBuilder<BankAccountController>(
          builder: (BankAccountController _controller) {
        bankAccounts = _controller.bankAccounts;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Bank Account',
                style: TextStyle(fontSize: 14.sp, color: AppColors.grey)),
            SizedBox(height: 16.h),
            ListView.builder(
                itemCount: bankAccounts.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final BankAccountModel bankAccount = bankAccounts[index];
                  return buildBankItem(bankAccount);
                }),
            SizedBox(height: 12.h),
            buildAddPaymentItem('Add Bank', () {
              Navigator.of(context).pushNamed('/add_bank_account');
            })
          ],
        );
      });

  Widget buildCreditCardItem(CardModel card) => Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: AppColors.gallery,
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: ListTile(
        // contentPadding: EdgeInsets.zero,
        leading: Image.asset(GlobalMixin().getCardLogoUrl(card.cardType!),
            height: 40.h),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(GlobalMixin().getFormattedCardNumber(cardNumber: card.cardNo)),
            SizedBox(height: 10.h),
            Text(
                'Expires ${DateFormat('MM/yy').format(DateTime.parse(card.expiryDate))}',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey))
          ],
        ),
        trailing: IconButton(
            icon: SvgPicture.asset('${AssetsPath.assetsSVGPath}/trash.svg'),
            color: AppColors.lightRed,
            onPressed: () {
              String logo = GlobalMixin().getCardLogoUrl(card.cardType!);
              String cardNo = card.cardNo.substring(card.cardNo.length - 4);
              _showRemoveDialog(
                  type: 'Card',
                  id: card.id,
                  number: cardNo,
                  logoUrl: logo,
                  expiryDate: card.expiryDate);
            }),
      ));

  Widget buildBankItem(BankAccountModel bankAccount) => Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: AppColors.gallery,
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: ListTile(
        // contentPadding: EdgeInsets.zero,
        leading:
            Image.asset('${AssetsPath.assetsPNGPath}/bank.png', height: 40.h),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(bankAccount.accountNumber),
            SizedBox(height: 10.h),
            Text(bankAccount.bankName,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey))
          ],
        ),
        trailing: IconButton(
            icon: SvgPicture.asset('${AssetsPath.assetsSVGPath}/trash.svg'),
            color: AppColors.lightRed,
            onPressed: () {
              String accountNo = bankAccount.accountNumber
                  .substring(bankAccount.accountNumber.length - 3);
              String logo = '${AssetsPath.assetsPNGPath}/bank.png';
              _showRemoveDialog(
                  type: 'Bank',
                  id: bankAccount.id,
                  number: accountNo,
                  logoUrl: logo,
                  bankName: bankAccount.bankName);
            }),
      ));

  Widget buildAddPaymentItem(String title, VoidCallback onPressed) => InkWell(
      onTap: onPressed,
      child: DottedBorder(
        color: const Color.fromRGBO(0, 119, 73, 0.14),
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: [6],
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Container(
            height: 78.h,
            color: Color.fromRGBO(6, 96, 40, 0.04),
            child: Center(
              child: Text(
                '+ $title',
                style: TextStyle(fontSize: 24.sp, color: AppColors.deepGreen),
              ),
            ),
          ),
        ),
      ));

  Future<void> getPaymentData() async {
    final List<BankAccountModel> bankAccountsResult =
        await APIServices().getUserBankAccounts();
    await _bankAccountController.initBankAccounts(bankAccountsResult);

    final List<CardModel> cardsResult = await APIServices().getCards();

    await _cardController.initCards(cardsResult);

    setState(() {
      isLoading = false;
    });
  }

  void _showRemoveDialog(
      {required String type,
      required String id,
      required String number,
      String logoUrl = '',
      String expiryDate = '',
      String bankName = ''}) {
    bool _isRemovingPayment = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.r))),
              title: Text(
                'Remove $type',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w500),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80.8,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Are you sure you want to remove $type ?',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(logoUrl, height: 40.h, width: 40.w),
                        Text(
                          '${AppTextConstants.endingIn} in $number',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          type == AppTextConstants.card
                              ? DateFormat('MM/yy')
                                  .format(DateTime.parse(expiryDate))
                              : bankName,
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ))
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
                        onTap: () {
                          debugPrint('Remove Card');
                          setState(() {
                            _isRemovingPayment = true;
                          });
                          if (type == AppTextConstants.card) {
                            removeCard(id);
                          } else {
                            removeBankAccount(id);
                          }
                        },
                        child: Container(
                            width: 75.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                                child: !_isRemovingPayment
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

  Widget buildFakePaymentDataUI() => ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.r))),
              child: ListTile(
                leading: SkeletonAnimation(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300]),
                    )),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SkeletonAnimation(
                        curve: Curves.linear,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[300]),
                        )),
                    SizedBox(height: 8.h),
                    SkeletonAnimation(
                        curve: Curves.linear,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[300]),
                        ))
                  ],
                ),
              ));
        },
      );

  Future<void> removeCard(String id) async {
    final CardModel card = cards.firstWhere((item) => item.id == id);
    final dynamic res = await APIServices().removeCard(id);
    if (res.statusCode == 200) {
      _cardController.remove(card);

      Navigator.of(context).pop();
    }
  }

  Future<void> removeBankAccount(String id) async {
    final BankAccountModel bankAccount =
        bankAccounts.firstWhere((item) => item.id == id);
    final dynamic res = await APIServices().removeBankAccount(id);
    if (res.statusCode == 200) {
      _bankAccountController.remove(bankAccount);

      Navigator.of(context).pop();
    }
  }

  Widget buildSetupStripeAccount() => Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'GuidED partners with Stripe for secure payments and financial services. In order to start getting paid, you need to set up a Stripe account.'),
          SizedBox(height: 22.h),
          CustomRoundedButton(
              title: 'Setup Now',
              onpressed: () async {
                final dynamic result = await Navigator.of(context)
                    .pushNamed('/setup_stripe_account');
                if (result != null) {
                  setState(() {
                    stripeAcctId = result;
                  });
                }
              }),
          SizedBox(height: 22.h),
        ],
      ));

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<BankAccountModel>('bankAccounts', bankAccounts))
      ..add(IterableProperty<CardModel>('cards', cards))
      ..add(DiagnosticsProperty<bool>('isLoading', isLoading));
  }
}
