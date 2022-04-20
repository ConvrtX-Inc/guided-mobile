import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/borderless_textfield.dart';
import 'package:guided/common/widgets/country_dropdown.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/credit_card_input.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/stripe_service.dart';
import 'package:intl/intl.dart';

/// screen for adding payment card
class PaymentAddCard extends StatefulWidget {
  /// constructor
  const PaymentAddCard({Key? key}) : super(key: key);

  @override
  _PaymentAddCardState createState() => _PaymentAddCardState();
}

class _PaymentAddCardState extends State<PaymentAddCard> {
  final GlobalKey<FormState> _addCardGlobalFormKey = GlobalKey<FormState>();

  String _fullName = '';
  String _address = '';
  String _city = '';
  String _postalCode = '';
  String _nameOnCard = '';
  String _cardNumber = '';
  int _cardCvv = 0;
  String _cardExpiry = '';
  bool isLoading = false;
  String _cardExpiryDateFormatted = '';

  late List<CountryModel> listCountry = [];
  late CountryModel _country = CountryModel();
  final CardController _cardController = Get.put(CardController());
  final TextEditingController _cardCvvController = TextEditingController();
  final TextEditingController _cardExpiryDateController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final List<CountryModel> resCountries =
          await APIServices().getCountries();

      setState(() {
        listCountry = resCountries;
        if (listCountry.isNotEmpty) {
          _country = listCountry[38];
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
          AppTextConstants.addCard,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: Form(key: _addCardGlobalFormKey,child:  _buildBody()),
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

           Expanded(child:  CreditCardAppInput(
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
                      _cardCvv = int.parse(onSavedVal.toString().trim());
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
          child:
        CustomRoundedButton(
            title: AppTextConstants.addCard,
            onpressed: addCard,
            isLoading: isLoading))
      ],
    );
  }

  bool validateAndSave() {
    final FormState? form = _addCardGlobalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> addCard() async {

    if (validateAndSave()) {
      setState(() {
        isLoading = !isLoading;
      });

      final CardModel cardDetailParams = CardModel(
          fullName: _fullName,
          nameOnCard: _nameOnCard,
          address: _address,
          city: _city,
          postalCode: _postalCode,
          countryId: _country.id,
          cardNo: _cardNumber,
          cvv: _cardCvv,
          isDefault: _cardController.cards.isEmpty || true,
          expiryDate: _cardExpiryDateFormatted);



      //For Stripe Validation
      final List<String> expiryMonthAndYear =
      _cardExpiryDateFormatted.split('/');

      final dynamic result = await StripeServices()
          .createCardToken(cardDetailParams, expiryMonthAndYear);

      if (result['id'] != null) {
        final String cardType = result['card']['brand'];

        ///Check if card already exists
        final CardModel existingCard = _cardController.cards.firstWhere(
                (CardModel c) =>
            c.cardNo == cardDetailParams.cardNo && c.cardType == cardType,
            orElse: () => CardModel());

        if (existingCard.id != '') {
          _showToast(context, 'Card Already Exists');
          setState(() {
            isLoading = false;
          });

          return;
        }

        //for visa validation
        if ((cardType == 'Visa' && cardDetailParams.cardNo.length != 13) &&
            (cardType == 'Visa' && cardDetailParams.cardNo.length != 16)) {
          _showToast(context, 'Invalid Card Number!');
          setState(() {
            isLoading = false;
          });

          return;
        }

        ///Validate Union Pay Card Length
        if (cardType == 'UnionPay' &&
            cardDetailParams.cardNo.length < 16)  {
          _showToast(context, 'Invalid Card Number!');
          setState(() {
            isLoading = false;
          });

          return;
        }

        //JCB validation
        if (cardType == 'JCB' && cardDetailParams.cardNo.length > 16) {
          _showToast(context, 'Invalid Card Number!');
          setState(() {
            isLoading = false;
          });

          return;
        }


        final CardModel res =
        await APIServices().addCard(cardDetailParams, cardType);
        if (res.id != '') {
          _cardController.addCard(res);

          if (_cardController.defaultCard.id == '') {
            _cardController.setDefaultCard(res);
          }
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
