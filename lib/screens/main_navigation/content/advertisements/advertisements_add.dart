// ignore_for_file: file_names, unused_element, always_declare_return_types
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/image_bulk.dart';
import 'package:guided/screens/main_navigation/content/content_main.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Adding Advertisement Screen
class AdvertisementAdd extends StatefulWidget {
  /// Constructor
  const AdvertisementAdd({Key? key}) : super(key: key);

  @override
  _AdvertisementAddState createState() => _AdvertisementAddState();
}

class _AdvertisementAddState extends State<AdvertisementAdd> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _useCurrentLocation = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _province = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();

  // ignore: diagnostic_describe_all_properties
  File? image1;
  // ignore: diagnostic_describe_all_properties
  File? image2;
  // ignore: diagnostic_describe_all_properties
  File? image3;

  int _uploadCount = 0;
  DateTime _selectedDate = DateTime.now();

  bool _enabledImgHolder2 = false;

  @override
  void dispose() {
    _title.dispose();
    _useCurrentLocation.dispose();
    _country.dispose();
    _street.dispose();
    _city.dispose();
    _province.dispose();
    _postalCode.dispose();
    _date.dispose();
    _description.dispose();
    _price.dispose();
    super.dispose();
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
                                      maxHeight: 202.h,
                                      maxWidth: 270.w,
                                      imageQuality: 25);
                              if (image1 == null) {
                                return;
                              }

                              final File imageTemporary = File(image1.path);
                              setState(() {
                                this.image1 = imageTemporary;
                                _uploadCount += 1;
                              });
                            } on PlatformException catch (e) {
                              // ignore: avoid_print
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
                                      maxHeight: 202.h,
                                      maxWidth: 270.w,
                                      imageQuality: 25);

                              if (image1 == null) {
                                return;
                              }

                              final File imageTemporary = File(image1.path);
                              setState(() {
                                this.image1 = imageTemporary;
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
                ))),
        child: image1 != null
            ? Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image1!,
                      width: 100,
                      height: 100,
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
            : Stack(
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
              ),
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
                                          maxHeight: 202.h,
                                          maxWidth: 270.w,
                                          imageQuality: 25);

                                  if (image2 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image2.path);
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
                          ListTile(
                              leading: const Icon(Icons.photo_album),
                              title: const Text('Photo Gallery'),
                              onTap: () async {
                                try {
                                  final XFile? image2 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery,
                                          maxHeight: 202.h,
                                          maxWidth: 270.w,
                                          imageQuality: 25);
                                  if (image2 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image2.path);
                                  setState(() {
                                    this.image2 = imageTemporary;
                                    _uploadCount += 1;
                                    _enabledImgHolder2 = true;
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
                      width: 100,
                      height: 100,
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
            : Stack(
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
              ),
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
                                          maxHeight: 202.h,
                                          maxWidth: 270.w,
                                          imageQuality: 25);

                                  if (image3 == null) {
                                    return;
                                  }
                                  final File imageTemporary = File(image3.path);
                                  setState(() {
                                    this.image3 = imageTemporary;
                                    _uploadCount += 1;
                                  });
                                } on PlatformException catch (e) {
                                  // ignore: avoid_print
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
                                          maxHeight: 202.h,
                                          maxWidth: 270.w,
                                          imageQuality: 25);

                                  if (image3 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image3.path);
                                  setState(() {
                                    this.image3 = imageTemporary;
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
        child: image3 != null
            ? Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image3!,
                      width: 100,
                      height: 100,
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
            : Stack(
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
              ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.advertisement),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    AppTextConstants.uploadImages,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.osloGrey),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      image1Placeholder(context),
                      image2Placeholder(context),
                      image3Placeholder(context)
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _title,
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
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _useCurrentLocation,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.pin_drop,
                        color: Colors.black,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.useCurrentLocation,
                      hintStyle: const TextStyle(
                        color: Colors.black,
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
                    controller: _country,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.canada,
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
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      AppTextConstants.streetHint,
                      style: AppTextStyle.greyStyle,
                    ),
                  ),
                  SizedBox(height: 20.h),
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
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _province,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.provinceHint,
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
                    controller: _postalCode,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.postalCodeHint,
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
                        keyboardType: TextInputType.datetime,
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
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _description,
                    maxLines: 10,
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
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _price,
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
                  ),
                  SizedBox(height: 20.h)
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
            onPressed: () async => advertisementDetail(),
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
              AppTextConstants.createAdvertisement,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
    if (picked != null && picked != _selectedDate) {
      final String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
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

    // ignore: always_specify_types
    final Map<String, dynamic> image = {
      'activity_advertisement_id': id,
      'snapshot_img': base64Image1
    };

    await APIServices().request(AppAPIPath.imageUrl, RequestType.POST,
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

    // ignore: always_specify_types
    final List<OutfitterImageList> list = [objImg1, objImg2];

    final Map<String, List<dynamic>> finalJson = {
      'bulk': encodeToJsonOutfitter(list)
    };

    await APIServices().request(AppAPIPath.bulkImageUrl, RequestType.POST,
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

    await APIServices().request(AppAPIPath.bulkImageUrl, RequestType.POST,
        needAccessToken: true, data: finalJson);
  }

  Future<void> advertisementDetail() async {
    final String userId =
        await SecureStorage.readValue(key: SecureStorage.userIdKey);

    // ignore: always_specify_types
    final Map<String, dynamic> outfitterDetails = {
      'user_id': userId,
      'title': _title.text,
      'country': _country.text,
      'address': _street.text + _city.text + _province.text + _postalCode.text,
      'ad_date': _date.text,
      'description': _description.text,
      'price': int.parse(_price.text),
      'is_published': false
    };

    final dynamic response = await APIServices().request(
        AppAPIPath.createAdvertisementUrl, RequestType.POST,
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

    await Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const MainContent(initIndex: 3)),
    );
  }
}
