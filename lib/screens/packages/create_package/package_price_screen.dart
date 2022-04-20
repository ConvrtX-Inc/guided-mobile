// ignore_for_file: file_names, cast_nullable_to_non_nullable
import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/currencies_model.dart';
import 'package:guided/models/preset_form_model.dart';
import 'package:guided/screens/packages/create_package/widget/dropdown_currency.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Package Price Screen
class PackagePriceScreen extends StatefulWidget {
  /// Constructor
  const PackagePriceScreen({Key? key}) : super(key: key);

  @override
  _PackagePriceScreenState createState() => _PackagePriceScreenState();
}

class _PackagePriceScreenState extends State<PackagePriceScreen> {
  late List<Currency> listCurrency;
  late Currency _currency;

  TextEditingController _basePrice = TextEditingController();
  TextEditingController _extraCost = TextEditingController();
  TextEditingController _maxPerson = TextEditingController();
  TextEditingController _additionalNotes = TextEditingController();

  FocusNode _basePriceFocus = FocusNode();
  FocusNode _extraCostFocus = FocusNode();
  FocusNode _maxPersonFocus = FocusNode();
  FocusNode _additionalNotesFocus = FocusNode();

  String _local_law = '';
  String _local_law_id = '';

  bool _isSubmit = false;

  void setCurrency(dynamic value) {
    setState(() {
      _currency = value;
    });
  }

  @override
  void initState() {
    super.initState();

    listCurrency = <Currency>[Currency('', '', '', '')];
    _currency = listCurrency[0];

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final List<Currency> resCurrency = await APIServices().getCurrencies();
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        listCurrency = resCurrency;
        _currency = listCurrency[8];

        _maxPerson = TextEditingController(text: screenArguments['maximum']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(
                      AppTextConstants.headerPriceYourPackage),
                  SizedBox(
                    height: 30.h,
                  ),
                  SubHeaderText.subHeaderText(
                      AppTextConstants.subheaderPriceYourPackage),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _basePrice,
                    focusNode: _basePriceFocus,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.basedPrice,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _extraCost,
                    focusNode: _extraCostFocus,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.extraCostHint,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _maxPerson,
                    focusNode: _maxPersonFocus,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.maximumPerson,
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppTextConstants.currency,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  DropDownCurrency(
                      list: listCurrency,
                      value: _currency,
                      setCurrency: setCurrency),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    maxLines: 10,
                    controller: _additionalNotes,
                    focusNode: _additionalNotesFocus,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.additionalNotes,
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
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: 60.h,
          child: ElevatedButton(
            onPressed: () async => _isSubmit
                ? null
                : navigateLocalLawTaxesScreen(context, screenArguments),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.silver,
                ),
                borderRadius: BorderRadius.circular(18.r),
              ),
              primary: AppColors.primaryGreen,
              onPrimary: Colors.white,
            ),
            child: _isSubmit
                ? const Center(child: CircularProgressIndicator())
                : Text(
                    AppTextConstants.next,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> navigateLocalLawTaxesScreen(
      BuildContext context, Map<String, dynamic> data) async {
    setState(() {
      _isSubmit = true;
    });
    final List<PresetFormModel> resForm =
        await APIServices().getTermsAndCondition('local_laws');
    if (resForm.isNotEmpty) {
      _local_law = resForm[0].description;
      _local_law_id = resForm[0].id;
    } else {
      _local_law = AppTextConstants.longLoremIpsum;
      _local_law_id = '';
    }

    final Map<String, dynamic> details = Map<String, dynamic>.from(data);

    if (_basePrice.text.isEmpty ||
        _extraCost.text.isEmpty ||
        _maxPerson.text.isEmpty ||
        _additionalNotes.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.fieldMustBeFilled)
          .show(context);
    } else {
      details['base_price'] = _basePrice.text;
      details['extra_cost'] = _extraCost.text;
      details['max_person'] = _maxPerson.text;
      details['currency_id'] = _currency.id;
      details['additional_notes'] = _additionalNotes.text;
      details['preset_local_law'] = _local_law;
      details['preset_local_law_id'] = _local_law_id;

      await Navigator.pushNamed(context, '/local_law_taxes',
          arguments: details);
    }
  }
}
