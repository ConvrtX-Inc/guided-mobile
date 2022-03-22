// ignore_for_file: file_names, unused_element, always_declare_return_types, prefer_const_literals_to_create_immutables, avoid_print, diagnostic_describe_all_properties, curly_braces_in_flow_control_structures, always_specify_types, avoid_dynamic_calls, avoid_redundant_argument_values, avoid_catches_without_on_clauses, unnecessary_lambdas
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/models/image_bulk.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Adding Advertisement Screen
class EventAdd extends StatefulWidget {
  /// Constructor
  const EventAdd({Key? key}) : super(key: key);

  @override
  _EventAddState createState() => _EventAddState();
}

class _EventAddState extends State<EventAdd> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _fee = TextEditingController();
  final TextEditingController _useCurrentLocation = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _description = TextEditingController();

  File? image1;
  File? image2;
  File? image3;

  int _uploadCount = 0;
  DateTime _selectedDate = DateTime.now();

  bool _enabledImgHolder2 = false;

  Position? _currentPosition;
  String _currentAddress = '';

  bool showMainActivityChoices = false;
  dynamic mainActivity;
  String mainActivityTitle = '';
  @override
  void dispose() {
    _title.dispose();
    _fee.dispose();
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

  ListTile _choicesMainActivity(BadgesModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          mainActivity = badges;
          showMainActivityChoices = false;
          mainActivityTitle = badges.title;
        });
      },
      minLeadingWidth: 20,
      leading: Image.asset(
        badges.imageUrl,
        width: 30.w,
      ),
      title: Text(badges.title),
    );
  }

  GridView _choicesGridMainActivity() {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      children: List.generate(AppListConstants.badges.length, (int index) {
        return SizedBox(
          height: 10.h,
          width: 100.w,
          child: _choicesMainActivity(AppListConstants.badges[index]),
        );
      }),
    );
  }

  Column _mainActivityDropdown(double width) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              if (showMainActivityChoices) {
                showMainActivityChoices = false;
              } else {
                showMainActivityChoices = true;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: AppColors.grey,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            width: width,
            height: 65.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (mainActivity == null)
                  SizedBox(
                    width: 150.w,
                    height: 100.h,
                  )
                else
                  SizedBox(
                    width: 140.w,
                    height: 100.h,
                    child: _choicesMainActivity(mainActivity),
                  ),
                SizedBox(
                  width: 110.w,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          mainActivity = null;
                        });
                      },
                      child: mainActivity == null
                          ? const Icon(
                              Icons.arrow_drop_down_outlined,
                            )
                          : const Icon(Icons.close_rounded)),
                ),
              ],
            ),
          ),
        ),
        if (showMainActivityChoices)
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(12.r),
            child: SizedBox(
              height: 200.h,
              width: width,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.w, 10.h, 10.w, 20.h),
                child: _choicesGridMainActivity(),
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
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
                                  setState(() {
                                    this.image2 = imageTemporary;
                                    _uploadCount += 1;
                                    _enabledImgHolder2 = true;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.addNewEvent),
                  SizedBox(
                    height: 30.h,
                  ),
                  _mainActivityDropdown(width),
                  SizedBox(
                    height: 20.h,
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
                    controller: _fee,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.fee,
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
                  TextField(
                    controller: _country,
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
      final String formattedDate =
          '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
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
    final String? userId = UserSingleton.instance.user.user!.id;

    final Map<String, dynamic> eventDetails = {
      'user_id': userId,
      'badge_id': 'cbcfa8b8-3a25-4adb-a9c6-e325f0d0f3ae',
      'title': _title.text,
      'country': _country.text,
      'address':
          '${_street.text},${_city.text},${_province.text},${_postalCode.text}',
      'description': _description.text,
      'price': int.parse(_fee.text),
      'is_published': true
    };

    final dynamic response = await APIServices().request(
        AppAPIPath.activityEventUrl, RequestType.POST,
        needAccessToken: true, data: eventDetails);

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
                  contentIndex: 1,
                )));
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
        _currentAddress =
            '${place.locality}, ${place.postalCode}, ${place.country}';

        _country = TextEditingController(text: place.country);
        _postalCode = TextEditingController(text: place.postalCode);
        _city = TextEditingController(text: place.locality);
        _street = TextEditingController(text: place.street);
        _province = TextEditingController(text: place.administrativeArea);
      });
    } catch (e) {
      print(e);
    }
  }
}