import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/borderless_textfield.dart';
import 'package:guided/common/widgets/country_dropdown.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/country_currency_model.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:url_launcher/url_launcher.dart';

///Setup stripe account
class SetupStripeAccount extends StatefulWidget {
  ///Constructor
  const SetupStripeAccount({Key? key}) : super(key: key);

  @override
  _SetupStripeAccountState createState() => _SetupStripeAccountState();
}

class _SetupStripeAccountState extends State<SetupStripeAccount> {
  String _email = '';
  String _companyName = '';
  String _firstName = '';
  String _lastName = '';

  late List<CountryModel> listCountry = [];
  late CountryModel _country = CountryModel(name: 'Canada', code: 'CA');

  final GlobalKey<FormState> _setupStripeGlobalFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  List<CountryCurrencyModel> currencies = [];

  String _dialCode = '+1';
  bool isPhoneValid = false;
  TextEditingController phoneController = TextEditingController();

  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());

  bool isSettingUpStripe = false;

  @override
  void initState() {
    super.initState();

    getCountries();
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
          'Setup Stripe Account',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: Form(key: _setupStripeGlobalFormKey, child: buildSetupStripeUI()),
    );
  }

  Widget buildSetupStripeUI() => Container(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.h),
                    BorderlessTextField(
                      title: AppTextConstants.firstName,
                      hint: AppTextConstants.firstName,
                      onValidate: (String val) {
                        if (val.trim().isEmpty) {
                          return '${AppTextConstants.firstName} is required';
                        }
                        return null;
                      },
                      onSaved: (String val) {
                        _firstName = val.trim();
                      },
                    ),
                    SizedBox(height: 20.h),
                    BorderlessTextField(
                      title: AppTextConstants.lastName,
                      hint: AppTextConstants.lastName,
                      onValidate: (String val) {
                        if (val.trim().isEmpty) {
                          return '${AppTextConstants.lastName} is required';
                        }
                        return null;
                      },
                      onSaved: (String val) {
                        _lastName = val.trim();
                      },
                    ),
                    SizedBox(height: 20.h),
                    BorderlessTextField(
                      title: AppTextConstants.companyName,
                      hint: AppTextConstants.companyName,
                      onValidate: (String val) {
                        if (val.trim().isEmpty) {
                          return '${AppTextConstants.companyName} is required';
                        }
                        return null;
                      },
                      onSaved: (String val) {
                        _companyName = val.trim();
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text('Phone Number'),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: AppTextConstants.phoneNumberHint,
                        prefixIcon: SizedBox(
                          child: CountryCodePicker(
                            onChanged: _onCountryChange,
                            initialSelection: AppTextConstants.defaultCountry,
                            favorite: ['+1', 'US'],
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    DropDownCountry(
                      fontSize: 16.sp,
                      value: _country,
                      setCountry: setCountry,
                      list: listCountry,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            CustomRoundedButton(
                isLoading: isSettingUpStripe,
                title: !isSettingUpStripe
                    ? AppTextConstants.submit
                    : AppTextConstants.pleaseWait,
                onpressed: setupStripeAccount),
            SizedBox(height: 30.h),
          ],
        ),
      );

  Future<void> setupStripeAccount() async {
    if (validateAndSave()) {
      setState(() {
        isSettingUpStripe = true;
      });
      final String? email = UserSingleton.instance.user.user?.email;
      debugPrint('Phone ${phoneController.text}');
      final params = jsonEncode(<String, String>{
        'email': email!,
        'country': _country.code,
        'company_name': _companyName,
        'first_name': _firstName,
        'last_name': _lastName,
        'phone': phoneController.text,
        'product_description': 'Provide tour services'
      });

      debugPrint('Response Body: $params');

      final setupStripeResult = await APIServices().createStripeAccount(params);

      debugPrint('Response Body: ${setupStripeResult.statusCode}');

      if (setupStripeResult.statusCode == 201) {
        debugPrint('New Account ${setupStripeResult.body.toString()}');
        final res = await APIServices()
            .getOnboardAccountLink(setupStripeResult.body.toString());

        final onBoardAccountRes = json.decode(res.body);
        debugPrint('Onboard Account REs $onBoardAccountRes');
        if (res.statusCode == 201) {
          final ProfileDetailsModel _profileDetails = _profileDetailsController
              .userProfileDetails
            ..stripeAccountId = setupStripeResult.body.toString();
          _profileDetailsController.setUserProfileDetails(_profileDetails);
          setState(() {
            isSettingUpStripe = false;
          });
          await launch(onBoardAccountRes['url']);
          Navigator.pop(context, setupStripeResult.body.toString());
        }
      } else {
        final setupStripeResponseBody = jsonDecode(setupStripeResult.body);
        print('setupStripeResponseBody $setupStripeResponseBody');
        // final String errorMessage = onBoardAccountRes['errors']['account'];
        setState(() {
          isSettingUpStripe = false;
        });
        _showToast(context, setupStripeResponseBody['errors']['account']);
      }
    }
  }

  Future<void> getCountries() async {
    final String response =
        await rootBundle.loadString('assets/currencies.json');
    final data = await json.decode(response);

    for (dynamic res in data) {
      listCountry.add(
          CountryModel(code: res['countryCode'], name: res['countryName']));
    }

    setState(() {
      _country = listCountry[0];
    });
  }

  bool validateAndSave() {
    final FormState? form = _setupStripeGlobalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void setCountry(dynamic value) {
    setState(() {
      _country = value;
    });
  }

  void _showToast(BuildContext context, String message) {
    final ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  /// Country code
  void _onCountryChange(CountryCode countryCode) =>
      _dialCode = countryCode.dialCode.toString();
}
