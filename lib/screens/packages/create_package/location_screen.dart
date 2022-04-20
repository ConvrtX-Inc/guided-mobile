// ignore_for_file: file_names, cast_nullable_to_non_nullable, unnecessary_lambdas, always_specify_types, avoid_print, always_declare_return_types, avoid_redundant_argument_values, avoid_catches_without_on_clauses, prefer_final_locals
import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guided/common/widgets/country_dropdown.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Location Screen
class LocationScreen extends StatefulWidget {
  /// Constructor
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController _country = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _zipCode = TextEditingController();

  Position? _currentPosition;
  String _currentAddress = '';
  String _countryCode = '';

  late List<CountryModel> listCountry;
  late CountryModel _countryDropdown;
  bool isLocationBtnClicked = false;

  @override
  void initState() {
    super.initState();
    listCountry = <CountryModel>[CountryModel()];
    _countryDropdown = listCountry[0];

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final List<CountryModel> resCountries =
          await APIServices().getCountries();

      setState(() {
        listCountry = resCountries;
        _countryDropdown = listCountry[38];
        _countryCode = listCountry[38].code;
      });
    });
  }

  void setCountry(dynamic value) {
    setState(() {
      _countryDropdown = value;
      debugPrint(_countryDropdown.id);
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
                  HeaderText.headerText(AppTextConstants.headerLocation),
                  SizedBox(
                    height: 30.h,
                  ),
                  SubHeaderText.subHeaderText(
                      AppTextConstants.subheaderLocation),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _getCurrentLocation();
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: BorderSide(color: AppColors.osloGrey)),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        elevation: MaterialStateProperty.all<double>(0)),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.pin_drop,
                          color: Colors.black,
                        ),
                        if (isLocationBtnClicked)
                          Text(
                            AppTextConstants.removeCurrentLocation,
                            style: const TextStyle(color: Colors.black),
                          )
                        else
                          Text(
                            AppTextConstants.useCurrentLocation,
                            style: const TextStyle(color: Colors.black),
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (isLocationBtnClicked)
                    TextField(
                      controller: _country,
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                        hintText: AppTextConstants.country,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                    )
                  else
                    DropDownCountry(
                      value: _countryDropdown,
                      setCountry: setCountry,
                      list: listCountry,
                    ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _street,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.street,
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
                    height: 5.h,
                  ),
                  Align(
                    child: Text(
                      AppTextConstants.placeHint,
                      style: TextStyle(
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _city,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.city,
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
                  TextField(
                    controller: _state,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.state,
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
                  TextField(
                    controller: _zipCode,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.zipCode,
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
            onPressed: () =>
                navigateFreeServiceScreen(context, screenArguments),
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
            child: Text(
              AppTextConstants.next,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.checkPermission();
    Geolocator.requestPermission();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];

      setState(() {
        if (isLocationBtnClicked) {
          isLocationBtnClicked = false;
          _currentAddress = '';

          _country = TextEditingController(text: '');
          _zipCode = TextEditingController(text: '');
          _city = TextEditingController(text: '');
          _street = TextEditingController(text: '');
          _state = TextEditingController(text: '');
          _countryCode = _countryDropdown.code;
        } else {
          isLocationBtnClicked = true;
          _currentAddress =
              '${place.locality}, ${place.postalCode}, ${place.country}';

          _country = TextEditingController(text: place.country);
          _zipCode = TextEditingController(text: place.postalCode);
          _city = TextEditingController(text: place.locality);
          _street = TextEditingController(text: place.street);
          _state = TextEditingController(text: place.administrativeArea);
          _countryCode = place.isoCountryCode!;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> navigateFreeServiceScreen(
      BuildContext context, Map<String, dynamic> data) async {
    final Map<String, dynamic> details = Map<String, dynamic>.from(data);

    String countryFinal = '';

    if (isLocationBtnClicked) {
      countryFinal = _country.text;
    } else {
      countryFinal = _countryDropdown.name;
    }

    if (countryFinal.isEmpty ||
        _street.text.isEmpty ||
        _city.text.isEmpty ||
        _state.text.isEmpty ||
        _zipCode.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.fieldMustBeFilled)
          .show(context);
    } else {
      details['country'] = countryFinal;
      details['street'] = _street.text;
      details['city'] = _city.text;
      details['state'] = _state.text;
      details['zip_code'] = _zipCode.text;
      details['country_code'] = _countryCode;

      await Navigator.pushNamed(context, '/free_service', arguments: details);
    }
  }
}
