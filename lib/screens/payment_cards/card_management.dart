import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/app_scaffold.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/controller/stripe_card_controller.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/stripe_card.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/stripe_service.dart';
import 'package:guided/utils/ui/dialogs.dart';
import 'package:http/src/response.dart';
import 'package:intl/intl.dart';

///Card Management Screen
class CardManagementScreen extends StatefulWidget {
  ///Constructor
  const CardManagementScreen({Key? key}) : super(key: key);

  @override
  _CardManagementScreenState createState() => _CardManagementScreenState();
}

class _CardManagementScreenState extends State<CardManagementScreen> {
  final StripeCardController cardController = Get.put(StripeCardController());

  List<StripeCardModel> myCards = [];

  StripeCardModel defaultCard = StripeCardModel();

  String customerId = '';

  bool isLoadingData = true;

  @override
  void initState() {
    super.initState();
    
    customerId = UserSingleton.instance.user.user!.stripeCustomerId!;

    getCards();
  }

  Future<void> getCards() async {
    final List<StripeCardModel> result =
        await StripeServices().getCardList(customerId);

    await cardController.initCards(result);

    setState(() {
      myCards = result;
      isLoadingData =false;
    });

    await getDefaultCard();
  }

  Future<void> getDefaultCard() async {
    final String res =
        await StripeServices().getDefaultCard(customerId);

    final StripeCardModel card = myCards.firstWhere(
        (element) => element.id! == res,
        orElse: () => StripeCardModel());
    debugPrint('default CArd ${card.id!}');
    cardController.setDefaultCard(card);
    setState(() {
      defaultCard = card;
    });
  }

  Future<void> setDefaultCard(StripeCardModel card) async {
    final dynamic res =
        await StripeServices().setDefaultCard(card.id!, customerId);

    if (res.statusCode == 200) {
      setState(() {
        defaultCard = card;
      });
      cardController.setDefaultCard(card);
    } else {
      AppDialogs().showError(
          context: context,
          message: 'An Error Occurred',
          title: 'Unable to Set Default Card');
    }
  }

  Future<void> removeCard(StripeCardModel card) async {
    final dynamic res =
        await StripeServices().removeCard(card.id!, customerId);
    if (res.statusCode == 200) {
      myCards.remove(card);
      cardController.remove(card);
      Navigator.pop(context);
    } else {
      AppDialogs().showError(
          context: context,
          message: 'An Error Occurred',
          title: 'Unable to Remove Card');
    }
  }

  void _showRemoveDialog(StripeCardModel card) {
    bool _isRemovingPayment = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.r))),
              title: Text(
                'Remove Card',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w700),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Are you sure you want to remove card?',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: <Widget>[
                        Image.asset(
                            '${AssetsPath.assetsPNGPath}/card_icon_round.png',
                            height: 40.h,
                            width: 40.w),
                        Text(
                          '${AppTextConstants.endingIn} ',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(
                        '***********${card.last4!} ',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.lightRed),
                          onPressed: () {
                            removeCard(card);
                          },
                          child: Text('Confrim')),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              AppTextConstants.cancel,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            )))
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBarLeadingCallback: () => Navigator.of(context).pop(),
        appBarTitle: AppTextConstants.manageCards,
        appbarLeadingIcon: Icons.arrow_back,
        appBarColor: AppColors.gallery,
        scaffoldBgColor: AppColors.gallery,
        body: buildMCardManagementUI());
  }

  Widget buildMCardManagementUI() => GetBuilder<StripeCardController>(
          builder: (StripeCardController _controller) {
        myCards = _controller.cards;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!isLoadingData)
              Expanded(child: buildCardList())
            else
              Expanded(child: buildCardFakeUIList()),
            CustomRoundedButton(
                title: AppTextConstants.addCard,
                onpressed: () =>
                    Navigator.of(context).pushNamed('/add_new_card'))
          ],
        );
      });

  Widget buildCardList() => myCards.isNotEmpty ?  ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          return buildCardItem(myCards[index]);
        },
        itemCount: myCards.length,
      ) : Center(child: Text(AppTextConstants.nothingToDisplay),);

  Widget buildCardItem(StripeCardModel card) => Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(14),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  card.nameOnCard ?? '',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  GlobalMixin().getCardLogoUrl(card.brand!),
                  height: 35,
                  width: 35,
                )
              ],
            ),
            SizedBox(height: 4.h),
            Text('***********${card.last4!}',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Row(children: <Widget>[
              if (card.id != null && defaultCard.id != null && card.id! == defaultCard.id!)
                Expanded(
                    child: SizedBox(
                  height: 30.h,
                  width: 100.w,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryGreen),
                      child: Text(
                        'Default',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.sp),
                      )),
                ))
              else
                SizedBox(
                  height: 32.h,
                  width: 100.w,
                  child: OutlinedButton(
                      onPressed: () {
                        setDefaultCard(card);
                      },
                      style: ElevatedButton.styleFrom(primary: AppColors.white),
                      child: Text(
                        'Set As Default',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: Colors.grey),
                      )),
                ),
              Spacer(),
              SizedBox(
                  height: 32.h,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      child: Text(
                        AppTextConstants.edit,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: AppColors.primaryGreen),
                      ))),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                height: 32,
                width: 45,
                child: ElevatedButton(
                    onPressed: () {
                      _showRemoveDialog(card);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.lightRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Image.asset(
                      '${AssetsPath.assetsPNGPath}/delete_icon.png',
                    )),
              )
            ]),
          ],
        ),
      );

  Widget buildCardFakeUIList() => ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SkeletonText(
                      width: 110,
                      height: 12,
                    ),
                    SkeletonText(
                      width: 35,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SkeletonText(
                  width: 100,
                  height: 11,
                ),
                const SizedBox(height: 10),
                SkeletonText(
                  width: 60,
                  height: 20,
                ),
              ],
            ),
          );
        },
        itemCount: 5,
      );
}
