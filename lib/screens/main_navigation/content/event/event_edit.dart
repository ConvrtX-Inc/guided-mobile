// ignore_for_file: unnecessary_raw_strings, always_specify_types, curly_braces_in_flow_control_structures, cast_nullable_to_non_nullable

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

/// Edit Event Screen
class EventEdit extends StatefulWidget {
  /// Constructor
  const EventEdit({Key? key}) : super(key: key);

  @override
  _EventEditState createState() => _EventEditState();
}

class _EventEditState extends State<EventEdit> {
  bool isChecked = false;

  bool _isEnabledTitle = false;
  bool _isEnabledLocation = false;
  bool _isEnabledCountry = false;
  bool _isEnabledStreet = false;
  bool _isEnabledCity = false;
  bool _isEnabledProvince = false;
  bool _isEnabledPostalCode = false;
  bool _isEnabledDate = false;
  bool _isEnabledDescription = false;
  bool _isEnabledPrice = false;
  bool _isEnabledMainActivity = false;
  bool _isEnabledSubActivity = false;
  bool _isEnabledServices = false;

  TextEditingController _title = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _eventDate = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _mainactivity = TextEditingController();
  TextEditingController _subactivity = TextEditingController();
  TextEditingController _services = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _postalCodeFocus = FocusNode();
  final FocusNode _eventDateFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _mainactivityFocus = FocusNode();
  final FocusNode _subactivityFocus = FocusNode();
  final FocusNode _servicesFocus = FocusNode();

  DateTime _selectedDate = DateTime.now();
  final TextStyle txtStyle = TextStyle(fontSize: 14.sp, fontFamily: 'Poppins');
  bool isNewDate = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      _title = TextEditingController(text: screenArguments['title']);
      _price = TextEditingController(text: screenArguments['price']);
      _country = TextEditingController(text: screenArguments['country']);
      _description =
          TextEditingController(text: screenArguments['description']);
      _eventDate = TextEditingController(text: screenArguments['event_date']);
      _street = TextEditingController(text: screenArguments['street']);
      _city = TextEditingController(text: screenArguments['city']);
      _province = TextEditingController(text: screenArguments['province']);
      _postalCode = TextEditingController(text: screenArguments['zip_code']);

      _mainactivity =
          TextEditingController(text: screenArguments['main_activity']);
      _subactivity =
          TextEditingController(text: screenArguments['sub_activity']);
      _services = TextEditingController(text: screenArguments['services']);
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

    /// Activity card widget
    Card _widgetActivity() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.activity,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledMainActivity == false) {
                            _isEnabledMainActivity = true;
                          } else {
                            _isEnabledMainActivity = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledMainActivity
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
                      enabled: _isEnabledMainActivity,
                      controller: _mainactivity,
                      focusNode: _mainactivityFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['main_activity'],
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

    /// Activity card widget
    Card _widgetSubActivity() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.subActivities,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledSubActivity == false) {
                            _isEnabledSubActivity = true;
                          } else {
                            _isEnabledSubActivity = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledSubActivity
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
                      enabled: _isEnabledSubActivity,
                      controller: _subactivity,
                      focusNode: _subactivityFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['sub_activity'],
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

    /// Activity card widget
    Card _widgetServices() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.freeServices,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledServices == false) {
                            _isEnabledServices = true;
                          } else {
                            _isEnabledServices = false;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledServices
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
                      enabled: _isEnabledServices,
                      controller: _services,
                      focusNode: _servicesFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['services'],
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

    /// Fee card widget
    Card _widgetFee() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.fee,
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
                      keyboardType: TextInputType.number,
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
                          fontWeight: FontWeight.bold, height: 1.5),
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
                          controller: _eventDate,
                          focusNode: _eventDateFocus,
                          decoration: InputDecoration(
                            hintText: screenArguments['event_date'],
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
                  SizedBox(
                    height: 30.h,
                  ),
                  _widgetActivity(),
                  _widgetSubActivity(),
                  _widgetServices(),
                  _widgetImagesList(),
                  _widgetTitle(),
                  _widgetFee(),
                  _widgetLocation(),
                  _widgetProvince(),
                  _widgetPostalCode(),
                  _widgetDate(),
                  _widgetDescription(),
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
            onPressed: () async => eventEditDetail(),
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
              AppTextConstants.postEvent1,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> eventEditDetail() async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String? userId = UserSingleton.instance.user.user!.id;

    final Map<String, dynamic> eventEditDetails = {
      'user_id': userId,
      'badge_id': '764f32ae-7f8c-4d3c-b948-d7b93eaed436',
      'title': _title.text,
      'free_service': _services.text,
      'main_activities': _mainactivity.text,
      'sub_activities': _subactivity.text,
      'country': _country.text,
      'address':
          '${_street.text}, ${_city.text}, ${_province.text}, ${_country.text}, ${_postalCode.text}',
      'description': _description.text,
      'price': int.parse(_price.text),
      'event_date':
          isNewDate ? _eventDate.text : screenArguments['date_format'],
      'is_published': true,
    };

    final dynamic response = await APIServices().request(
        '${AppAPIPath.activityEventUrl}/${screenArguments['id']}',
        RequestType.PATCH,
        needAccessToken: true,
        data: eventEditDetails);

    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const MainNavigationScreen(
                  navIndex: 1,
                  contentIndex: 1,
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
        _eventDate = TextEditingController(text: formattedDate.toString());
        isNewDate = true;
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isChecked', isChecked));
  }
}
