// ignore_for_file: file_names, unused_element, prefer_const_literals_to_create_immutables, avoid_print, diagnostic_describe_all_properties, always_declare_return_types, always_specify_types, avoid_redundant_argument_values, prefer_final_locals, avoid_catches_without_on_clauses, unnecessary_lambdas
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guided/common/widgets/country_dropdown.dart';
import 'package:guided/common/widgets/decimal_text_input_formatter.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/models/image_bulk.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Add Outfitter Screen
class OutfitterAdd extends StatefulWidget {
  /// Constructor
  const OutfitterAdd({Key? key}) : super(key: key);

  @override
  _OutfitterAddState createState() => _OutfitterAddState();
}

class _OutfitterAddState extends State<OutfitterAdd> {
  final SecureStorage secureStorage = SecureStorage();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _productLink = TextEditingController();
  final TextEditingController _useCurrentLocation = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _productLinkFocus = FocusNode();
  final FocusNode _useCurrentLocationFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _postalCodeFocus = FocusNode();
  final FocusNode _dateFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  File? image1;
  File? image2;
  File? image3;

  int _uploadCount = 0;
  DateTime _selectedDate = DateTime.now();

  Position? _currentPosition;
  String _currentAddress = '';

  late List<CountryModel> listCountry;
  late CountryModel _countryDropdown;
  bool isLocationBtnClicked = false;
  bool _isSubmit = false;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
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
  void dispose() {
    _title.dispose();
    _price.dispose();
    _productLink.dispose();
    _useCurrentLocation.dispose();
    _country.dispose();
    _street.dispose();
    _city.dispose();
    _province.dispose();
    _postalCode.dispose();
    _date.dispose();
    _description.dispose();
    super.dispose();
  }

  Stack _default() {
    return Stack(
      children: <Widget>[
        Container(
          width: 100.w,
          height: 87.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.gallery,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.gallery,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: <Widget>[
                Image.asset(
                  AssetsPath.imagePrey,
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 3.w,
          top: 3.h,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(
              Icons.add,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }

  // Format File Size
  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    Widget image1Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () => showMaterialModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) => SafeArea(
                top: false,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                          leading: const Icon(Icons.photo_camera),
                          title: const Text('Camera'),
                          onTap: () async {
                            try {
                              final XFile? image1 = await ImagePicker()
                                  .pickImage(
                                      source: ImageSource.camera,
                                      imageQuality: 25);

                              if (image1 == null) {
                                return;
                              }

                              final File imageTemporary = File(image1.path);
                              String file;
                              int fileSize;
                              file = getFileSizeString(
                                  bytes: imageTemporary.lengthSync());
                              fileSize = int.parse(
                                  file.substring(0, file.indexOf('K')));
                              if (fileSize >= 100) {
                                AdvanceSnackBar(
                                        message: ErrorMessageConstants
                                            .imageFileToSize)
                                    .show(context);
                                return;
                              }
                              setState(() {
                                this.image1 = imageTemporary;
                                _uploadCount += 1;
                              });
                            } on PlatformException catch (e) {
                              print('Failed to pick image: $e');
                            }
                            Navigator.of(context).pop();
                          }),
                      ListTile(
                          leading: const Icon(Icons.photo_album),
                          title: const Text('Photo Gallery'),
                          onTap: () async {
                            try {
                              final XFile? image1 = await ImagePicker()
                                  .pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 10);

                              if (image1 == null) {
                                return;
                              }

                              final File imageTemporary = File(image1.path);
                              String file;
                              int fileSize;
                              file = getFileSizeString(
                                  bytes: imageTemporary.lengthSync());
                              fileSize = int.parse(
                                  file.substring(0, file.indexOf('K')));
                              if (fileSize >= 100) {
                                AdvanceSnackBar(
                                        message: ErrorMessageConstants
                                            .imageFileToSize)
                                    .show(context);
                                return;
                              }
                              setState(() {
                                this.image1 = imageTemporary;
                                _uploadCount += 1;
                              });
                            } on PlatformException catch (e) {
                              print('Failed to pick image: $e');
                            }
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ))),
        child: image1 != null
            ? Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image1!,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            image1 = null;
                            _uploadCount -= 1;
                          });
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 14.r,
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.close, color: Colors.black),
                          ),
                        ),
                      ))
                ],
              )
            : _default(),
      );
    }

    Widget image2Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () => _uploadCount == 1
            ? showMaterialModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) => SafeArea(
                    top: false,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              leading: const Icon(Icons.photo_camera),
                              title: const Text('Camera'),
                              onTap: () async {
                                try {
                                  final XFile? image2 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 25);

                                  if (image2 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image2.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  fileSize = int.parse(
                                      file.substring(0, file.indexOf('K')));
                                  if (fileSize >= 100) {
                                    AdvanceSnackBar(
                                            message: ErrorMessageConstants
                                                .imageFileToSize)
                                        .show(context);
                                    return;
                                  }
                                  setState(() {
                                    this.image2 = imageTemporary;
                                    _uploadCount += 1;
                                  });
                                } on PlatformException catch (e) {
                                  print('Failed to pick image: $e');
                                }
                                Navigator.of(context).pop();
                              }),
                          ListTile(
                              leading: const Icon(Icons.photo_album),
                              title: const Text('Photo Gallery'),
                              onTap: () async {
                                try {
                                  final XFile? image2 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 10);
                                  if (image2 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image2.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  fileSize = int.parse(
                                      file.substring(0, file.indexOf('K')));
                                  if (fileSize >= 100) {
                                    AdvanceSnackBar(
                                            message: ErrorMessageConstants
                                                .imageFileToSize)
                                        .show(context);
                                    return;
                                  }
                                  setState(() {
                                    this.image2 = imageTemporary;
                                    _uploadCount += 1;
                                  });
                                } on PlatformException catch (e) {
                                  // ignore: avoid_print
                                  print('Failed to pick image: $e');
                                }
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    )))
            : null,
        child: image2 != null
            ? Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image2!,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            image2 = null;
                            _uploadCount -= 1;
                          });
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 14.r,
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.close, color: Colors.black),
                          ),
                        ),
                      ))
                ],
              )
            : _default(),
      );
    }

    Widget image3Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () => _uploadCount == 2
            ? showMaterialModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) => SafeArea(
                    top: false,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              leading: const Icon(Icons.photo_camera),
                              title: const Text('Camera'),
                              onTap: () async {
                                try {
                                  final XFile? image3 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 25);

                                  if (image3 == null) {
                                    return;
                                  }
                                  final File imageTemporary = File(image3.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  fileSize = int.parse(
                                      file.substring(0, file.indexOf('K')));
                                  if (fileSize >= 100) {
                                    AdvanceSnackBar(
                                            message: ErrorMessageConstants
                                                .imageFileToSize)
                                        .show(context);
                                    return;
                                  }
                                  setState(() {
                                    this.image3 = imageTemporary;
                                    _uploadCount += 1;
                                  });
                                } on PlatformException catch (e) {
                                  print('Failed to pick image: $e');
                                }
                                Navigator.of(context).pop();
                              }),
                          ListTile(
                              leading: const Icon(Icons.photo_album),
                              title: const Text('Photo Gallery'),
                              onTap: () async {
                                try {
                                  final XFile? image3 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 10);

                                  if (image3 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image3.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  fileSize = int.parse(
                                      file.substring(0, file.indexOf('K')));
                                  if (fileSize >= 100) {
                                    AdvanceSnackBar(
                                            message: ErrorMessageConstants
                                                .imageFileToSize)
                                        .show(context);
                                    return;
                                  }
                                  setState(() {
                                    this.image3 = imageTemporary;
                                    _uploadCount += 1;
                                  });
                                } on PlatformException catch (e) {
                                  print('Failed to pick image: $e');
                                }
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    )))
            : null,
        child: image3 != null
            ? Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image3!,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            image3 = null;
                            _uploadCount -= 1;
                          });
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 14.r,
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.close, color: Colors.black),
                          ),
                        ),
                      ))
                ],
              )
            : _default(),
      );
    }

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
              padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
              child: FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HeaderText.headerText(AppTextConstants.outfitters),
                    SizedBox(height: 50.h),
                    Text(
                      AppTextConstants.uploadImages,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.osloGrey),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        image1Placeholder(context),
                        image2Placeholder(context),
                        image3Placeholder(context),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    FormBuilderTextField(
                      controller: _title,
                      focusNode: _titleFocus,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                        hintText: AppTextConstants.title,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      name: 'title',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(height: 20.h),
                    FormBuilderTextField(
                      controller: _price,
                      focusNode: _priceFocus,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                        hintText: AppTextConstants.price,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      name: 'price',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2),
                        FilteringTextInputFormatter.allow(RegExp('[0-9.0-9]')),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {}
                          return oldValue;
                        }),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    FormBuilderTextField(
                      controller: _productLink,
                      focusNode: _productLinkFocus,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                        hintText: AppTextConstants.productLink,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      name: 'productLink',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ElevatedButton(
                      onPressed: () => _getCurrentLocation(),
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
                    SizedBox(height: 20.h),
                    TextField(
                      controller: _street,
                      focusNode: _streetFocus,
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
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        AppTextConstants.streetHint,
                        style: AppTextStyle.greyStyle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextField(
                      controller: _city,
                      focusNode: _cityFocus,
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
                    SizedBox(height: 20.h),
                    TextField(
                      controller: _province,
                      focusNode: _provinceFocus,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                        hintText: AppTextConstants.provinceState,
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
                      controller: _postalCode,
                      focusNode: _postalCodeFocus,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                        hintText: AppTextConstants.postalCode,
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
                    GestureDetector(
                      onTap: () => _showDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _date,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                            hintText: AppTextConstants.date,
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
                      ),
                    ),
                    SizedBox(height: 20.h),
                    FormBuilderTextField(
                      controller: _description,
                      focusNode: _descriptionFocus,
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                        hintText: AppTextConstants.description,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      name: 'description',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
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
            onPressed: () {
              _formKey.currentState?.save();
              if (_formKey.currentState!.validate()) {
                _isSubmit ? null : outfitterDetail();
              } else {
                print('validation failed');
              }
            },
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
                    AppTextConstants.createOutfitter,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
          ),
        ),
      ),
    );
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
    debugPrint('PickedDate: $picked');
    if (picked != null && picked != _selectedDate) {
      final String formattedDate =
          '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        _selectedDate = picked;
        _date.value = TextEditingValue(text: formattedDate.toString());
      });
    }
  }

  Future<void> saveImage(String id) async {
    final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
    final String base64Image1 = base64Encode(await image1Bytes);

    final Map<String, dynamic> image = {
      'activity_outfitter_id': id,
      'snapshot_img': base64Image1
    };

    await APIServices().request(AppAPIPath.outfitterImageUrl, RequestType.POST,
        needAccessToken: true, data: image);
  }

  Future<void> save2Image(String id) async {
    final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
    final String base64Image1 = base64Encode(await image1Bytes);

    final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
    final String base64Image2 = base64Encode(await image2Bytes);

    final OutfitterImageList objImg1 =
        OutfitterImageList(id: id, img: base64Image1);
    final OutfitterImageList objImg2 =
        OutfitterImageList(id: id, img: base64Image2);

    final List<OutfitterImageList> list = [objImg1, objImg2];

    final Map<String, List<dynamic>> finalJson = {
      'bulk': encodeToJsonOutfitter(list)
    };

    await APIServices().request(
        AppAPIPath.outfitterBulkImageUrl, RequestType.POST,
        needAccessToken: true, data: finalJson);
  }

  Future<void> saveBulkImage(String id) async {
    final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
    final String base64Image1 = base64Encode(await image1Bytes);

    final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
    final String base64Image2 = base64Encode(await image2Bytes);

    final Future<Uint8List> image3Bytes = File(image3!.path).readAsBytes();
    final String base64Image3 = base64Encode(await image3Bytes);

    final OutfitterImageList objImg1 =
        OutfitterImageList(id: id, img: base64Image1);
    final OutfitterImageList objImg2 =
        OutfitterImageList(id: id, img: base64Image2);
    final OutfitterImageList objImg3 =
        OutfitterImageList(id: id, img: base64Image3);

    final List<OutfitterImageList> list = [objImg1, objImg2, objImg3];

    final Map<String, List<dynamic>> finalJson = {
      'bulk': encodeToJsonOutfitter(list)
    };

    await APIServices().request(
        AppAPIPath.outfitterBulkImageUrl, RequestType.POST,
        needAccessToken: true, data: finalJson);
  }

  Future<void> outfitterDetail() async {
    String countryFinal = '';

    if (isLocationBtnClicked) {
      countryFinal = _country.text;
    } else {
      countryFinal = _countryDropdown.name;
    }

    if (image1 == null) {
      AdvanceSnackBar(message: ErrorMessageConstants.outfitterImageEmpty)
          .show(context);
    } else if (_date.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.dateEmpty).show(context);
    } else if (_street.text.isEmpty ||
        _city.text.isEmpty ||
        _province.text.isEmpty ||
        _postalCode.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.locationEmpty)
          .show(context);
    } else {
      setState(() {
        _isSubmit = true;
      });
      final String? userId = UserSingleton.instance.user.user!.id;

      String price = _price.text.replaceAll(new RegExp(r'[,]'), '');

      final Map<String, dynamic> outfitterDetails = {
        'user_id': userId,
        'title': _title.text,
        'price': double.parse(price),
        'product_link': _productLink.text,
        'country': countryFinal,
        'address':
            '${_street.text}, ${_city.text}, ${_province.text}, ${_postalCode.text}, $countryFinal',
        'street': _street.text,
        'city': _city.text,
        'province': _province.text,
        'zip_code': _postalCode.text,
        'availability_date': _date.text,
        'description': _description.text,
        'is_published': true
      };

      final dynamic response = await APIServices().request(
          AppAPIPath.createOutfitterUrl, RequestType.POST,
          needAccessToken: true, data: outfitterDetails);

      // ignore: avoid_dynamic_calls
      final String activityOutfitterId = response['id'];
      if (_uploadCount == 1) {
        await saveImage(activityOutfitterId);
      } else if (_uploadCount == 2) {
        await save2Image(activityOutfitterId);
      } else if (_uploadCount == 3) {
        await saveBulkImage(activityOutfitterId);
      }

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const MainNavigationScreen(
                    navIndex: 1,
                    contentIndex: 2,
                  )));
    }
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
      // ignore: unnecessary_lambdas
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
          _postalCode = TextEditingController(text: '');
          _city = TextEditingController(text: '');
          _street = TextEditingController(text: '');
          _province = TextEditingController(text: '');
        } else {
          isLocationBtnClicked = true;
          _currentAddress =
              '${place.locality}, ${place.postalCode}, ${place.country}';

          _country = TextEditingController(text: place.country);
          _postalCode = TextEditingController(text: place.postalCode);
          _city = TextEditingController(text: place.locality);
          _street = TextEditingController(text: place.street);
          _province = TextEditingController(text: place.administrativeArea);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<SecureStorage>('secureStorage', secureStorage));
  }
}
