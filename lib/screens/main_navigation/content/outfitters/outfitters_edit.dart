// ignore_for_file: always_specify_types, cast_nullable_to_non_nullable, unnecessary_raw_strings, curly_braces_in_flow_control_structures
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/content/content_main.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:intl/intl.dart';

/// Edit Outfitter Screen
class OutfitterEdit extends StatefulWidget {
  /// Constructor
  const OutfitterEdit({Key? key}) : super(key: key);

  @override
  _OutfitterEditState createState() => _OutfitterEditState();
}

class _OutfitterEditState extends State<OutfitterEdit> {
  bool isChecked = false;
  bool _isEnabledTitle = false;
  bool _isEnabledPrice = false;
  bool _isEnabledProductLink = false;
  bool _isEnabledDescription = false;
  bool _isEnabledLocation = false;
  bool _isEnabledCountry = false;
  bool _isEnabledStreet = false;
  bool _isEnabledCity = false;
  bool _isEnabledProvince = false;
  bool _isEnabledPostalCode = false;
  bool _isEnabledDate = false;

  TextEditingController _title = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _productLink = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _date = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _productLinkFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _postalCodeFocus = FocusNode();
  final FocusNode _dateFocus = FocusNode();

  DateTime _selectedDate = DateTime.now();
  final TextStyle txtStyle = TextStyle(fontSize: 14.sp, fontFamily: 'Poppins');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final String removedDollar =
          screenArguments['price'].toString().substring(0);
      final String removedDecimal =
          removedDollar.substring(0, removedDollar.indexOf('.'));
      final String price = removedDecimal.replaceAll(RegExp(r'[,]'), '');

      _title = TextEditingController(text: screenArguments['title']);
      _price = TextEditingController(text: price);
      _productLink =
          TextEditingController(text: screenArguments['product_link']);
      _description =
          TextEditingController(text: screenArguments['description']);
      _country = TextEditingController(text: screenArguments['country']);
      _street = TextEditingController(text: screenArguments['street']);
      _city = TextEditingController(text: screenArguments['city']);
      _province = TextEditingController(text: screenArguments['province']);
      _postalCode = TextEditingController(text: screenArguments['zip_code']);
      _date = TextEditingController(
          text: screenArguments['availability_date'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    /// Image List card widget
    Card _widgetImagesList() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.images,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    Text(
                      AppTextConstants.edit,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        color: AppColors.primaryGreen,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      AppTextConstants.sampleImage,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        color: AppColors.primaryGreen,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      AppTextConstants.sampleImage,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        color: AppColors.primaryGreen,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

    /// Title card widget
    Card _widgetTitle() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledTitle == false) {
                            _isEnabledTitle = true;
                          } else {
                            _isEnabledTitle = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledTitle
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledTitle,
                      controller: _title,
                      focusNode: _titleFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['title'],
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Price card widget
    Card _widgetPrice() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledPrice == false) {
                            _isEnabledPrice = true;
                          } else {
                            _isEnabledPrice = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledPrice
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledPrice,
                      controller: _price,
                      focusNode: _priceFocus,
                      decoration: InputDecoration(
                        hintText: '\$${screenArguments['price']}',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Product Link card widget
    Card _widgetProductLink() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.productLink,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledProductLink == false) {
                            _isEnabledProductLink = true;
                          } else {
                            _isEnabledProductLink = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledProductLink
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledProductLink,
                      controller: _productLink,
                      focusNode: _productLinkFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['product_link'],
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Description card widget
    Card _widgetDescription() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledDescription == false) {
                            _isEnabledDescription = true;
                          } else {
                            _isEnabledDescription = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledDescription
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledDescription,
                      controller: _description,
                      focusNode: _descriptionFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['description'],
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Location card widget
    Card _widgetLocation() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.location,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledLocation == false) {
                            _isEnabledLocation = true;
                            _isEnabledCountry = true;
                            _isEnabledStreet = true;
                            _isEnabledCity = true;
                          } else {
                            _isEnabledLocation = false;
                            _isEnabledCountry = false;
                            _isEnabledStreet = false;
                            _isEnabledCity = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledLocation
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 2.h,
                    ),
                    TextField(
                      enabled: _isEnabledCountry,
                      controller: _country,
                      focusNode: _countryFocus,
                      decoration: InputDecoration(
                        hintText: 'Country: ${screenArguments['country']}',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextField(
                      enabled: _isEnabledStreet,
                      controller: _street,
                      focusNode: _streetFocus,
                      decoration: InputDecoration(
                        hintText: 'Street: ${screenArguments['street']}',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextField(
                      enabled: _isEnabledCity,
                      controller: _city,
                      focusNode: _cityFocus,
                      decoration: InputDecoration(
                        hintText: 'City: ${screenArguments['city']}',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Province card widget
    Card _widgetProvince() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.province,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledProvince == false) {
                            _isEnabledProvince = true;
                          } else {
                            _isEnabledProvince = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledProvince
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledProvince,
                      controller: _province,
                      focusNode: _provinceFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['province'],
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Postal Code card widget
    Card _widgetPostalCode() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.postalCode,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledPostalCode == false) {
                            _isEnabledPostalCode = true;
                          } else {
                            _isEnabledPostalCode = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledPostalCode
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledPostalCode,
                      controller: _postalCode,
                      focusNode: _postalCodeFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['zip_code'],
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Date card widget
    Card _widgetDate() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.date,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledDate == false) {
                            _isEnabledDate = true;
                          } else {
                            _isEnabledDate = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledDate
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () => _isEnabledDate ? _showDate(context) : null,
                      child: AbsorbPointer(
                        child: TextField(
                          enabled: _isEnabledDate,
                          keyboardType: TextInputType.datetime,
                          controller: _date,
                          focusNode: _dateFocus,
                          decoration: InputDecoration(
                            hintText: screenArguments['date'],
                            hintStyle: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          ),
                          style: txtStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Transform.scale(
          scale: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 40.w,
              height: 40.h,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: AppColors.harp,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.editsummaryTitle),
                  SizedBox(height: 30.h),
                  _widgetImagesList(),
                  _widgetTitle(),
                  _widgetPrice(),
                  _widgetProductLink(),
                  _widgetDescription(),
                  _widgetLocation(),
                  _widgetProvince(),
                  _widgetPostalCode(),
                  _widgetDate(),
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
            onPressed: () async => outfitterEditDetail(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.silver,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              primary: AppColors.primaryGreen,
              onPrimary: Colors.white,
            ),
            child: Text(
              AppTextConstants.post,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> outfitterEditDetail() async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String? userId = UserSingleton.instance.user.user!.id;

    final Map<String, dynamic> outfitterEditDetails = {
      'title': _title.text,
      'price': int.parse(_price.text),
      'product_link': _productLink.text,
      'country': _country.text,
      'address':
          '${_street.text}, ${_city.text}, ${_province.text}, ${_postalCode.text}, ${_country.text}',
      'street': _street.text,
      'city': _city.text,
      'province': _province.text,
      'zip_code': _postalCode.text,
      'availability_date': _date.text,
      'description': _description.text
    };

    final dynamic response = await APIServices().request(
        '${AppAPIPath.outfitterUrl}/${screenArguments['id']}',
        RequestType.PATCH,
        needAccessToken: true,
        data: outfitterEditDetails);

    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const MainNavigationScreen(
                  navIndex: 1,
                  contentIndex: 2,
                )));
  }

  Future<void> _showDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1901),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.green,
            splashColor: AppColors.primaryGreen,
          ),
          child: child ?? const Text(''),
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      final String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        _selectedDate = picked;
        _date = TextEditingController(text: formattedDate.toString());
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isChecked', isChecked))
      ..add(DiagnosticsProperty<TextStyle>('txtStyle', txtStyle));
  }
}
