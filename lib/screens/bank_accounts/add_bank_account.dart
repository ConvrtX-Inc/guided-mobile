import 'dart:convert';
import 'dart:io';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/borderless_textfield.dart';
import 'package:guided/common/widgets/country_dropdown.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/bank_account_controller.dart';
import 'package:guided/controller/stripe_bank_account_controller.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/bank_account_model.dart';
import 'package:guided/models/country_currency_model.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/models/stripe_bank_account_model.dart';
import 'package:guided/models/stripe_bank_accunt_fields_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/stripe_service.dart';
import 'package:intl/intl.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';

///Add bank Account
class AddBankAccountScreen extends StatefulWidget {
  ///Constructor
  const AddBankAccountScreen({Key? key}) : super(key: key);

  @override
  _AddBankAccountScreenState createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  late List<CountryModel> listCountry = [];
  late CountryModel _country = CountryModel();

  final GlobalKey<FormState> addBankAccountGlobalFormKey =
      GlobalKey<FormState>();

  bool isLoading = false;

  String _accountName = '';
  String _bankName = '';
  String _accountNumber = '';
  String _bankRoutingNumber = '';

  List<CountryCurrencyModel> currencies = [];
  CountryCurrencyModel _currency = CountryCurrencyModel();

  final BankAccountController _bankAccountController =
      Get.put(BankAccountController());

  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());

  List<StripeBankAccountField> stripeBankFieldsPerCountry = [];
  List<String> requiredBankFields = [];
  List<String> requiredBankFieldValues = [];

  final StripeBankAccountController _stripeBankAccountController =
      Get.put(StripeBankAccountController());

  @override
  void initState() {
    super.initState();

    getCurrencies();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final List<CountryModel> resCountries =
          await APIServices().getCountries();

      setState(() {
        listCountry = resCountries;
        if (listCountry.isNotEmpty) {
          _country = listCountry[38];
          if (_country.id != '') {
            _currency = currencies.firstWhere((CountryCurrencyModel item) =>
                item.countryCode == _country.code);
          }
          getStripeFields();
        }
      });
    });
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
          'Add Bank Account',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: Form(
          key: addBankAccountGlobalFormKey, child: buildAddBankAccountUI()),
    );
  }

  Widget buildAddBankAccountUI() => Container(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        // decoration: const BoxDecoration(
        //   color: Colors.white
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                  SizedBox(height: 20.h),
                  Text(AppTextConstants.bankInformation,
                      style: TextStyle(fontSize: 18.sp)),
                  SizedBox(height: 40.h),
                  BorderlessTextField(
                    title: AppTextConstants.accountName,
                    hint: AppTextConstants.typeHere,
                    onValidate: (String val) {
                      if (val.trim().isEmpty) {
                        return '${AppTextConstants.accountName} is required';
                      }
                      return null;
                    },
                    onSaved: (String val) {
                      _accountName = val.trim();
                    },
                  ),

                  SizedBox(height: 20.h),
                  BorderlessTextField(
                    title: AppTextConstants.bankName,
                    hint: 'Enter your ${AppTextConstants.bankName}',
                    onValidate: (String val) {
                      if (val.trim().isEmpty) {
                        return '${AppTextConstants.bankName} is required';
                      }
                      return null;
                    },
                    onSaved: (String val) {
                      _bankName = val.trim();
                    },
                  ),
                  SizedBox(height: 20.h),
                  BorderlessTextField(
                    title: AppTextConstants.accountNumber,
                    hint: 'Enter your ${AppTextConstants.accountNumber}',
                    onValidate: (String val) {
                      if (val.trim().isEmpty) {
                        return '${AppTextConstants.accountNumber} is required';
                      }
                      return null;
                    },
                    onSaved: (String val) {
                      _accountNumber = val.trim();
                    },
                  ),
                  SizedBox(height: 20.h),
                  if (requiredBankFields.isNotEmpty)
                    for (int i = 0; i < requiredBankFields.length; i++)
                      Column(
                        children: [
                          BorderlessTextField(
                            title: requiredBankFields[i],
                            hint: 'Enter your ${requiredBankFields[i]}',
                            onValidate: (String val) {
                              if (val.trim().isEmpty) {
                                return '${requiredBankFields[i]} is required';
                              }
                              return null;
                            },
                            onChanged: (String val) {
                              requiredBankFieldValues[i] = val.trim();
                            },
                            onSaved: (String val) {
                              debugPrint('ONSAVED');
                              setState(() {
                                requiredBankFieldValues[i] = val.trim();
                              });
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                  /*   BorderlessTextField(
                    title: AppTextConstants.bankRoutingNumber,
                    hint: 'Enter your ${AppTextConstants.bankRoutingNumber}',
                    onValidate: (String val) {
                      if (val.trim().isEmpty) {
                        return '${AppTextConstants.bankRoutingNumber} is required';
                      }
                      return null;
                    },
                    onSaved: (String val) {
                      _bankRoutingNumber = val.trim();
                    },
                  ),
                  SizedBox(height: 20.h),*/

                  DropDownCountry(
                    fontSize: 16.sp,
                    value: _country,
                    setCountry: setCountry,
                    list: listCountry,
                  ),
                  SizedBox(height: 20.h),
                ]))),
            CustomRoundedButton(
                isLoading: isLoading,
                title: AppTextConstants.save,
                onpressed: addBankAccount),
            SizedBox(height: 30.h),
          ],
        ),
      );

  void setCountry(dynamic value) {
    setState(() {
      _country = value;
      _currency = currencies.firstWhere(
          (CountryCurrencyModel item) => item.countryCode == _country.code);
    });

    setStripeFields();
  }

  Future<void> addBankAccount() async {
    final String routingNumber = requiredBankFieldValues.join('-');
    if (validateAndSave()) {
      setState(() {
        isLoading = true;
      });

      final BankAccountModel bankAccountParams = BankAccountModel(
          accountName: _accountName,
          accountNumber: _accountNumber,
          bankName: _bankName,
          bankRoutingNumber: routingNumber,
          countryId: _country.id,
          countryCode: _country.code,
          currency: _currency.currencyCode);

      final StripeBankAccountModel existingBankModel =
          _stripeBankAccountController.bankAccounts.firstWhere(
              (item) =>
                  item.accountNumber == bankAccountParams.accountNumber &&
                  item.routingNumber == routingNumber,
              orElse: () => StripeBankAccountModel());

      if (existingBankModel.id.isNotEmpty) {
        _showToast(context, 'Bank Account Already Exists');
        setState(() {
          isLoading = false;
        });
        return;
      }

      ///Validate details on stripe
      final dynamic stripeValidationResult =
          await StripeServices().createBankAccountToken(bankAccountParams);

      if (stripeValidationResult['id'] != null) {
        /// Add bank account to stripe connect
        await addBankAccountToStripeAccount(stripeValidationResult['id']);
      } else {
        AdvanceSnackBar(message: stripeValidationResult['error']['message'])
            .show(context);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  bool validateAndSave() {
    final FormState? form = addBankAccountGlobalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _showDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(22.r))),
            elevation: 12,
            content: SizedBox(
                height: 280.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 180.h,
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                  '${AssetsPath.assetsPNGPath}/confetti.png')),
                          SizedBox(height: 30.h),
                          Positioned(
                              top: 5,
                              left: 40,
                              right: 40,
                              child: Image.asset(
                                  '${AssetsPath.assetsPNGPath}/bank.png'))
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Text(
                            AppTextConstants.successfullyLinkedYourBankAccount,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.sp)),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                        child: CustomRoundedButton(
                      title: 'Close',
                      onpressed: () {
                        int count = 0;
                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                      },
                      buttonHeight: 40.h,
                      buttonWidth: 120.w,
                    ))
                  ],
                )),
          );
        });
  }

  void _showWarningDialog({String title = '', String message = ''}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.r))),
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500),
                ),
              ],
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
                            AppTextConstants.ok,
                            style: TextStyle(
                                color: AppColors.deepGreen,
                                fontSize: 12.sp,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w700),
                          ))),
                    ),
                  ]),
              SizedBox(
                height: 20.h,
              ),
            ],
          );
        });
  }

  Future<void> getCurrencies() async {
    final String response =
        await rootBundle.loadString('assets/currencies.json');
    final data = await json.decode(response);

    for (dynamic res in data) {
      currencies.add(CountryCurrencyModel.fromJson(res));
    }
  }

  Future<void> getStripeFields() async {
    final String response =
        await rootBundle.loadString('assets/stripe_bank_country_fields.json');
    final data = await json.decode(response);

    for (dynamic res in data) {
      stripeBankFieldsPerCountry.add(StripeBankAccountField.fromJson(res));
    }
    setStripeFields();
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

  void setStripeFields() {
    final StripeBankAccountField matchCountry =
        stripeBankFieldsPerCountry.firstWhere(
            (element) =>
                element.code.toLowerCase() == _country.code.toLowerCase(),
            orElse: () => StripeBankAccountField());
    debugPrint('Matched Country ${matchCountry.country} ');

    if (matchCountry.country.isNotEmpty) {
      setState(() {
        requiredBankFields = matchCountry.requiredFields;
      });
    } else {
      setState(() {
        requiredBankFields = ['Routing Number'];
      });
    }

    setState(() {
      requiredBankFieldValues = List.filled(requiredBankFields.length, '');
    });
  }

  Future<void> addBankAccountToStripeAccount(String bankToken) async {
    final res = await APIServices().addBankAccountToStripeAccount(
        _profileDetailsController.userProfileDetails.stripeAccountId,
        bankToken);
    final jsonData = jsonDecode(res.body);
    if (res.statusCode == 400) {
      setState(() {
        isLoading = false;
      });
      _showWarningDialog(
          title: 'Unable to Add Bank Account', message: jsonData['message']);
    } else {
      final StripeBankAccountModel params = StripeBankAccountModel(
          id: jsonData['id'],
          bankName: _bankName,
          accountNumber: _accountNumber);

      final StripeBankAccountModel updateMetadataRes = await StripeServices()
          .updateAccount(params,
              _profileDetailsController.userProfileDetails.stripeAccountId);
      _stripeBankAccountController.addBankAccount(updateMetadataRes);
      debugPrint(
          'response bank account: $res  Meta data update ${updateMetadataRes.accountNumber}');

      await _showDialog(context);
    }
  }
}
