import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_cvc_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_expiration_input_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/app_scaffold.dart';
import 'package:guided/common/widgets/borderless_textfield.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_input_formatter.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/controller/stripe_card_controller.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/stripe_card.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/credit_card_input.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/stripe_service.dart';
import 'package:guided/utils/ui/dialogs.dart';
import 'package:intl/intl.dart';

///Add New Card Screen
class AddNewCard extends StatefulWidget {
  ///Constructor
  const AddNewCard({Key? key}) : super(key: key);

  @override
  _AddNewCardState createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  String _nameOnCard = '';
  String _cardNumber = '';
  String _cardExpiry = '';
  int _cardCvv = 0;
  bool isLoading = false;

  String errorTitle = 'Unable to Add Card';

  final GlobalKey<FormState> _addCardGlobalFormKey = GlobalKey<FormState>();
  final StripeCardController _cardController = Get.put(StripeCardController());

  String _cardExpiryDateFormatted = '';
  final TextEditingController _cardCvvController = TextEditingController();
  final TextEditingController _cardExpiryDateController =
      TextEditingController();

  Future<void> addCard() async {
    if (validateAndSave()) {
      setState(() {
        isLoading = !isLoading;
      });

      final CardModel cardDetailParams = CardModel(
          nameOnCard: _nameOnCard,
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
        /*   final StripeCardModel existingCard = _cardController.cards.firstWhere(
            (StripeCardModel c) =>
                c.cardNo == cardDetailParams.cardNo && c.cardType == cardType,
            orElse: () => StripeCardModel());

        if (existingCard.id != '') {
          AppDialogs().showError(
              context: context,
              title: errorTitle,
              message: 'Card Already Exists');
          setState(() {
            isLoading = false;
          });

          return;
        }*/

        //for visa validation
        if ((cardType == 'Visa' && cardDetailParams.cardNo.length != 13) &&
            (cardType == 'Visa' && cardDetailParams.cardNo.length != 16)) {
          AppDialogs().showError(
              context: context,
              title: errorTitle,
              message: 'Invalid Card Number!');
          setState(() {
            isLoading = false;
          });

          return;
        }

        ///Validate Union Pay Card Length
        if (cardType == 'UnionPay' && cardDetailParams.cardNo.length < 16) {
          AppDialogs().showError(
              context: context,
              title: errorTitle,
              message: 'Invalid Card Number!');
          setState(() {
            isLoading = false;
          });

          return;
        }

        //JCB validation
        if (cardType == 'JCB' && cardDetailParams.cardNo.length > 16) {
          AppDialogs().showError(
              context: context,
              title: errorTitle,
              message: 'Invalid Card Number!');
          setState(() {
            isLoading = false;
          });

          return;
        }

        final StripeCardModel res = await StripeServices().addCard(result['id'],
            UserSingleton.instance.user.user!.stripeCustomerId!, _nameOnCard);

        if (res.id != '') {
          _cardController.addCard(res);

          AppDialogs().showSuccess(
              context: context,
              title: '',
              message: 'Card Added Successfully',
              onOkPressed: () => Navigator.pop(context));
        } else {
          AppDialogs().showError(
            context: context,
            title: errorTitle,
            message: 'An error occurred',
          );
        }
        setState(() {
          isLoading = false;
        });

        debugPrint('DATA ${res.id}');
      }
    }
  }

  bool validateAndSave() {
    final FormState? form = _addCardGlobalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBarTitle: AppTextConstants.addCard,
        centerAppBarTitle: true,
        appBarLeadingCallback: () => Navigator.of(context).pop(),
        body: Form(key: _addCardGlobalFormKey, child: buildAddNewCardUI()));
  }

  Widget buildAddNewCardUI() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Expanded(
            child: ListView(
          children: <Widget>[
            Text(
              AppTextConstants.cardDetails,
              style: TextStyle(fontSize: 18.sp),
            ),
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
              inputFormatters: [AppInputFormatters.name],
            ),
            const SizedBox(
              height: 20,
            ),
            BorderlessTextField(
              title: AppTextConstants.cardNumber,
              textInputType: TextInputType.number,
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
          ],
        )),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20.h),
            child: CustomRoundedButton(
                title: AppTextConstants.addCard,
                onpressed: addCard,
                isLoading: isLoading)),
      ]);
}
