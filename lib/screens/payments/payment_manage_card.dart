// // ignore_for_file: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/screens/payments/payment_add_card.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/screens/widgets/reusable_widgets/credit_card.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:intl/intl.dart';

/// screen for payment manage card
class PaymentManageCard extends StatefulWidget {
  /// constructor
  const PaymentManageCard({Key? key, this.price = '', this.selectedCard, this.onPaymentClicked})
      : super(key: key);

  final String? price;

  final CardModel? selectedCard;

  final VoidCallback? onPaymentClicked;

  @override
  _PaymentManageCardState createState() => _PaymentManageCardState();
}

class _PaymentManageCardState extends State<PaymentManageCard> {
  final List<String> _cardImage = AppListConstants.cardImage;

  bool isLoading = false;

  final CardController cardController = Get.put(CardController());

  List<CardModel> myCards = [];

  int currentCard = 0;
  CardModel selectedCard = CardModel();
  final CarouselController _carouselController = CarouselController();

  late List<CountryModel> listCountry = [];

  @override
  void initState() {
    super.initState();

    if (cardController.cards.isEmpty) {
      isLoading = true;
    }

    fetchCards();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final List<CountryModel> resCountries =
          await APIServices().getCountries();

      setState(() {
        listCountry = resCountries;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          AppTextConstants.manageCards,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Gilroy'),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          const PaymentAddCard()),
                );
              },
              child: Container(
                height: 2.h,
                width: 40.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.green),
                child: const Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.deepGreen))
              : buildBody()),
           bottomNavigationBar: widget.price != '' ?  Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: CustomRoundedButton(
              title: 'Pay ${widget.price} USD',
              onpressed: ()  {
                Navigator.pop(context,true);
              }),
        ) : null
    );
  }

  Widget buildBody() =>
      GetBuilder<CardController>(builder: (CardController _controller) {
        if (_controller.cards.isNotEmpty) {
          final CardModel checkDefaultCard = _controller.cards.firstWhere(
              (CardModel card) => card.isDefault == true,
              orElse: () => CardModel());
          if (checkDefaultCard.id != '') {
            _controller.cards.remove(checkDefaultCard);
            _controller.cards.insert(0, checkDefaultCard);
          }
        }

        myCards = _controller.cards;

        if (myCards.isNotEmpty) {
          selectedCard = myCards[currentCard];
          return _buildCardsUI();
        } else {
          return const Center(child: Text("You don't have any added cards"));
        }
      });

  Widget _buildCardsUI() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                  height: 190.h,
                  enableInfiniteScroll: false,
                  onPageChanged: (int index, CarouselPageChangedReason reason) {
                    setState(() {
                      currentCard = index;
                      selectedCard = myCards[currentCard];
                    });
                  }),
              items: myCards.map((CardModel card) {
                return Builder(
                  builder: (
                    BuildContext context,
                  ) {
                    return CreditCard(
                        cardDetails: card, removeCallback: _showRemoveDialog);
                  },
                );
              }).toList(),
            )),
        SizedBox(height: 22.h),
        _cardInfo(context)
      ]);

  Widget _cardInfo(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                selectedCard.nameOnCard,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                height: 5.h,
                width: 5.w,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(5.r)),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                '${AppTextConstants.endingIn} ${selectedCard.cardNo.substring(selectedCard.cardNo.length - 4)}',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                height: 5.h,
                width: 5.w,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(5.r)),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                DateFormat('MM/yy')
                    .format(DateTime.parse(selectedCard.expiryDate)),
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 22.w),
              child: Center(
                  child: Text(
                      '${selectedCard.address} , ${selectedCard.city} , ${getCountryById(selectedCard.countryId)} , ${selectedCard.postalCode}',
                      style: TextStyle(fontSize: 14.sp)))),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!selectedCard.isDefault)
                InkWell(
                  onTap: setCardAsDefault,
                  child: Container(
                    height: 45.h,
                    width: MediaQuery.of(context).size.width / 2.5.w,
                    decoration: BoxDecoration(
                        color: HexColor('36C5F0'),
                        borderRadius: BorderRadius.circular(24.r)),
                    child: Center(
                      child: Text(
                        AppTextConstants.setAsDefaultPayment,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gilroy',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              SizedBox(width: 7.w),
              InkWell(
                onTap: _showRemoveDialog,
                child: Container(
                  height: 45.h,
                  width: MediaQuery.of(context).size.width / 5.w,
                  decoration: BoxDecoration(
                      color: HexColor('F86666'),
                      borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: Text(
                      AppTextConstants.remove,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 7.w),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/payment_edit_card', arguments: selectedCard);
                },
                child: Container(
                  height: 45.h,
                  width: MediaQuery.of(context).size.width / 5.w,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: Text(
                      AppTextConstants.edit,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _getList('Fianna Wu', '2 hr ago', r'+$600.00', () {}),
          _getList('Jolina Jones', '4 hr ago', r'-$200.00', () {}),
          _getList('Wills Smith', '4 hr ago', r'+$240.00', () {}),
        ],
      ));

  Widget _getList(
      String title, String subtitle, String trailing, dynamic ontap) {
    return Column(
      children: <Widget>[
        ListTile(
            onTap: ontap,
            leading: Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 3.w,
                ),
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const <BoxShadow>[
                  BoxShadow(blurRadius: 3, color: Colors.grey)
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35.r,
                backgroundImage: const NetworkImage(
                    'https://www.vhv.rs/dpng/d/164-1645859_selfie-clipart-groucho-glass-good-profile-hd-png.png'),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  fontFamily: 'Gilroy'),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(
                  fontFamily: 'Samsung Sharp Sans',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp),
            ),
            trailing: Text(
              trailing,
              style: TextStyle(
                  color: HexColor('29A435'),
                  fontFamily: 'Samsung Sharp Sans',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp),
            )),
      ],
    );
  }

  void _showRemoveDialog() {
    bool _isRemovingCard = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.r))),
              title: Text(
                AppTextConstants.removeCard,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w500),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      AppTextConstants.areYouSureYouWantToRemoveCard,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                            '${GlobalMixin().getCardLogoUrl(selectedCard.cardType!)}',
                            height: 40.h,
                            width: 40.w),
                        Text(
                          '${AppTextConstants.endingIn} in ${selectedCard.cardNo.substring(selectedCard.cardNo.length - 4)}',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          DateFormat('MM/yy')
                              .format(DateTime.parse(selectedCard.expiryDate)),
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
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
                            _isRemovingCard = true;
                          });
                          removeCard();
                        },
                        child: Container(
                            width: 75.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                                child: !_isRemovingCard
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

  Future<void> fetchCards() async {
    final List<CardModel> result = await APIServices().getCards();
    await cardController.initCards(result);

    setState(() {
      myCards = result;

      isLoading = false;
    });
  }

  Future<void> removeCard() async {
    final res = await APIServices().removeCard(selectedCard.id.toString());
    if (res.statusCode == 200) {
      cardController.remove(selectedCard);
      setState(() {
        currentCard = 0;
        if (myCards.isNotEmpty) {
          _carouselController.jumpToPage(currentCard);
        }
      });

      Navigator.of(context).pop();
    }
  }

  Future<void> setCardAsDefault() async {
    final APIStandardReturnFormat result =
        await APIServices().setDefaultCard(selectedCard.id);

    debugPrint('Status code ${result.statusCode}');

    if (result.statusCode == 200) {
      _showToast(context, 'Card Set As Default!');

      setState(() {
        myCards = myCards.map((e) {
          e.isDefault = false;
          return e;
        }).toList();
      });

      selectedCard.isDefault = true;
      cardController
        ..updateCard(selectedCard)
        ..setDefaultCard(selectedCard);

      _carouselController.jumpToPage(0);
    }
  }

  void _showToast(BuildContext context, String message) {
    final ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  String getCountryById(String countryId) {
    final CountryModel country = listCountry.firstWhere(
        (CountryModel country) => country.id == countryId,
        orElse: () => CountryModel());

    return country.name;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isLoading', isLoading))
      ..add(
          DiagnosticsProperty<CardController>('cardController', cardController))
      ..add(IterableProperty<CardModel>('myCards', myCards))
      ..add(IntProperty('currentCard', currentCard))
      ..add(DiagnosticsProperty<CardModel>('selectedCard', selectedCard))
      ..add(IterableProperty<CountryModel>('listCountry', listCountry));
  }
}
