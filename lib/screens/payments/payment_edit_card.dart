import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/borderless_textfield.dart';
import 'package:guided/common/widgets/country_dropdown.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/credit_card_input.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/stripe_service.dart';
import 'package:intl/intl.dart';

///Edit Card
class PaymentEditCard extends StatefulWidget {
  ///Constructor
  const PaymentEditCard({@required this.card, Key? key}) : super(key: key);

  /// Card Data passed from manage cards route
  final CardModel? card;

  @override
  _PaymentEditCardState createState() => _PaymentEditCardState();
}

class _PaymentEditCardState extends State<PaymentEditCard> {
  static final GlobalKey<FormState> _editCardGlobalFormKey =
      GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _addressController;

  late TextEditingController _cityController;
  late TextEditingController _postalCodeController;
  late TextEditingController _nameOnCardController;
  late TextEditingController _cardNumberController;
  late TextEditingController _cardCvvController;
  late TextEditingController _cardExpiryDateController;

  ///state controller for cards
  final CardController cardController = Get.put(CardController());

  String _fullName = '';
  String _address = '';
  String _city = '';
  String _postalCode = '';
  String _nameOnCard = '';
  String _cardNumber = '';
  String _cardCvv = '';
  String _cardType = '';
  String _cardExpiry = '';
  String _cardExpiryDateFormatted = '';

  late CardModel cardDetails;

  late List<CountryModel> listCountry = [];
  late CountryModel _country = CountryModel();
  bool hasError = false;
  bool isLoading = false;

  @override
  void initState() {
    cardDetails = widget.card!;
    _fullNameController = TextEditingController(text: cardDetails.fullName);
    _addressController = TextEditingController(text: cardDetails.address);
    _cityController = TextEditingController(text: cardDetails.city);
    _postalCodeController = TextEditingController(text: cardDetails.postalCode);
    // _countryController = TextEditingController(text: cardDetails.countryId);
    _nameOnCardController = TextEditingController(text: cardDetails.nameOnCard);
    _cardNumberController = TextEditingController(text: cardDetails.cardNo);
    _cardCvvController =
        TextEditingController(text: cardDetails.cvv.toString());
    _cardExpiryDateController = TextEditingController(
        text:
            DateFormat('MM/yy').format(DateTime.parse(cardDetails.expiryDate)));

    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final List<CountryModel> resCountries =
          await APIServices().getCountries();
      setState(() {
        listCountry = resCountries;
        if (listCountry.isNotEmpty) {
          _country = listCountry.firstWhere(
              (CountryModel country) => country.id == cardDetails.countryId);
        }
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
          AppTextConstants.editCard,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: Form(key: _editCardGlobalFormKey, child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 37),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                AppTextConstants.billingInformation,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
              ),
            ),
            _getBillingInfo(),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                AppTextConstants.cardInformation,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
              ),
            ),
            _getCardInfo(),
          ],
        ),
      ),
    );
  }

  Widget _getBillingInfo() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        BorderlessTextField(
          controller: _fullNameController,
          title: AppTextConstants.fullName,
          hint: 'Aycan Doganlar',
          onValidate: (String val) {
            if (val.trim().isEmpty) {
              return '${AppTextConstants.fullName} is required';
            }
            return null;
          },
          onSaved: (String val) {
            _fullName = val.trim();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BorderlessTextField(
          controller: _addressController,
          title: AppTextConstants.address,
          hint: '3819 Lynden Road',
          onValidate: (String val) {
            if (val.trim().isEmpty) {
              return '${AppTextConstants.address} is required';
            }
            return null;
          },
          onSaved: (String val) {
            _address = val.trim();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.8,
              child: BorderlessTextField(
                controller: _cityController,
                title: AppTextConstants.city,
                hint: 'Canada',
                onValidate: (String val) {
                  if (val.trim().isEmpty) {
                    return '${AppTextConstants.city} is required';
                  }
                  return null;
                },
                onSaved: (String val) {
                  _city = val.trim();
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.8,
              child: BorderlessTextField(
                controller: _postalCodeController,
                title: AppTextConstants.postalCode,
                hint: 'L0B 1M0',
                onValidate: (String val) {
                  if (val.trim().isEmpty) {
                    return '${AppTextConstants.postalCode} is required';
                  }
                  return null;
                },
                onSaved: (String val) {
                  _postalCode = val.trim();
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        /* BorderlessTextField(
          title: AppTextConstants.country,
          hint: '3819 Lynden Road',
        ),*/
        DropDownCountry(
          value: _country,
          setCountry: setCountry,
          list: listCountry,
        ),
      ],
    );
  }

  Widget _getCardInfo() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        BorderlessTextField(
          controller: _nameOnCardController,
          title: AppTextConstants.nameOnCard,
          hint: 'Aycan Doganlar',
          onValidate: (String val) {
            if (val.trim().isEmpty) {
              return '${AppTextConstants.nameOnCard} is required';
            }
            return null;
          },
          onSaved: (String val) {
            _nameOnCard = val.trim();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BorderlessTextField(
          controller: _cardNumberController,
          title: AppTextConstants.cardNumber,
          hint: '1234 4567 7890 1234',
          onValidate: (String val) {
            if (val.trim().isEmpty) {
              return '${AppTextConstants.cardNumber} is required';
            }
            return null;
          },
          onSaved: (String val) {
            _cardNumber = val.trim();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: CreditCardAppInput(
                    controller: _cardExpiryDateController,
                    inputTitleText: AppTextConstants.expiryDate,
                    inputPlaceholder: 'MM/YY',
                    onSaved: (String onSavedVal) {
                      final DateTime date =
                          DateFormat('MM/yy').parse(onSavedVal);
                      setState(() {
                        _cardExpiryDateFormatted =
                            DateFormat('MM/dd/yyyy').format(date);
                        _cardExpiry = onSavedVal;
                      });
                    },
                    onValidate: (String onValidateVal) {
                      if (onValidateVal.isEmpty) {
                        return '${AppTextConstants.expiryDate} is required';
                      }

                      try {
                        final DateTime d =
                            DateFormat('MM/yy').parse(onValidateVal);
                      } on Exception catch (e) {
                        return '${AppTextConstants.expiryDate} is invalid';
                      }
                    },
                    onChanged: (String onChangedVal) {},
                    inputFormatters: CreditCardExpirationDateFormatter())),
            SizedBox(width: 10.w),
            Expanded(
                child: CreditCardAppInput(
                    controller: _cardCvvController,
                    inputPlaceholder: '000',
                    isCvv: true,
                    inputTitleText: AppTextConstants.cvc,
                    onSaved: (String onSavedVal) {
                      _cardCvv = onSavedVal.toString().trim();
                    },
                    onValidate: (String onValidateVal) {
                      if (onValidateVal.isEmpty) {
                        return '${AppTextConstants.cvc} is required';
                      }

                      if (onValidateVal.length < 3) {
                        return 'Invalid ${AppTextConstants.cvc}';
                      }
                      return null;
                    },
                    onChanged: (String onChangedVal) {},
                    inputFormatters: CreditCardCvcInputFormatter())),
          ],
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20.h),
            child: CustomRoundedButton(
                title: AppTextConstants.editCard,
                onpressed: editCard,
                isLoading: isLoading))
      ],
    );
  }


  Future<void> editCard() async {
    if (validateAndSave()) {
      setState(() {
        isLoading = !isLoading;
      });

      debugPrint('COLOr ${cardDetails.cardColor}');
      final CardModel cardDetailParams = CardModel(
          id: cardDetails.id,
          fullName: _fullName,
          nameOnCard: _nameOnCard,
          address: _address,
          city: _city,
          isDefault: cardDetails.isDefault,
          postalCode: _postalCode,
          countryId: _country.id,
          cardNo: _cardNumber,
          cvv: int.parse(_cardCvv),
          cardType: _cardType,
          cardColor: cardDetails.cardColor,
          expiryDate: _cardExpiryDateFormatted);

      if (_cardCvv.length > 3) {
        _showToast(context, 'Invalid CVV');
        setState(() {
          isLoading = false;
        });
        return;
      }

      //For Stripe Validation
      final List<String> expiryMonthAndYear =
      _cardExpiryDateFormatted.split('/');

      final dynamic result = await StripeServices()
          .createCardToken(cardDetailParams, expiryMonthAndYear);

      if (result['id'] != null) {
        final String cardType = result['card']['brand'];


        //Validate JCB Card Length
        if (cardType == 'JCB' &&
            cardDetailParams.cardNo.length > 16) {
          _showToast(context, 'Invalid Card Number!');
          setState(() {
            isLoading = false;
          });

          return;
        }

        //Validate Visa Card Length
        if ((cardType == 'Visa' &&
            cardDetailParams.cardNo.length != 13) &&
            (cardType == 'Visa' &&
                cardDetailParams.cardNo.length != 16)) {
          _showToast(context, 'Invalid Card Number!');
          setState(() {
            isLoading = false;
          });

          return;
        }

        //Validate Union Pay Card Length
        if (cardType == 'UnionPay' &&
            cardDetailParams.cardNo.length < 16)  {
          _showToast(context, 'Invalid Card Number!');
          setState(() {
            isLoading = false;
          });

          return;
        }

        //Check if card already exists
        if (cardDetailParams.cardNo != widget.card!.cardNo) {
          final CardModel existingCard = cardController.cards
              .firstWhere(
                  (CardModel c) =>
              c.cardNo == cardDetailParams.cardNo &&
                  c.cardType == cardType,
              orElse: () => CardModel());

          if (existingCard.id != '') {
            _showToast(context, 'Card Already Exists');
            setState(() {
              isLoading = false;
            });

            return;
          }
        }

        final CardModel res =
        await APIServices().editCard(cardDetailParams, cardType);

        if (res.id != '') {
          cardController.updateCard(res);
          Navigator.of(context).pop();
        }
      } else {
        setState(() {
          isLoading = false;
        });

        _showToast(context, '${result['error']['message']}');
      }
    }
  }

  bool validateAndSave() {
    final FormState? form = _editCardGlobalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
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

  void setCountry(dynamic value) {
    setState(() {
      _country = value;
    });
  }


}
