// ignore_for_file: file_names, unused_local_variable, cast_nullable_to_non_nullable, always_specify_types, avoid_dynamic_calls
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:advance_notification/advance_notification.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/activity_destination_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

const kGoogleApiKey = 'AIzaSyCxWY8eJW_V4xuVTapXfYDZeSXN41g42t4';

/// Package photo screen
class TabDestinationEditScreen extends StatefulWidget {
  /// Constructor
  const TabDestinationEditScreen({Key? key}) : super(key: key);

  @override
  _TabDestinationEditScreenState createState() =>
      _TabDestinationEditScreenState();
}

class _TabDestinationEditScreenState extends State<TabDestinationEditScreen> {
  File? image1;
  File? image2;
  File? image3;
  int _uploadCount = 0;
  bool _enabledImgHolder2 = false;
  bool _didClickedImage1 = false;
  bool _didClickedImage2 = false;
  bool _didClickedImage3 = false;
  bool _isEnabledImage = true;
  String img1Id = '';
  String img2Id = '';
  String img3Id = '';
  bool _isSubmit = false;
  TextEditingController _placeName = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  FocusNode _placeNameFocus = new FocusNode();
  FocusNode _descriptionFocus = new FocusNode();

  late List<ActivityDestinationModel> destinationList;

  final String _destinationPath = 'destinationImg';

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
            padding: const EdgeInsets.all(5),
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

  String latitude = '';
  String longitude = '';

  @override
  void initState() {
    super.initState();

    destinationList = [];

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      latitude = screenArguments['latitude'];
      longitude = screenArguments['longitude'];
      _placeName = TextEditingController(text: screenArguments['place_name']);
      _description =
          TextEditingController(text: screenArguments['place_description']);
    });
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

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Widget image1Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () {
          if (_isEnabledImage) {
            showMaterialModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Color.fromARGB(0, 61, 56, 56),
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
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);
                                  if (image1 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image1.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  if (file.contains('KB')) {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('K')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2000) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  } else {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('M')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
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
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);

                                  if (image1 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image1.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  if (file.contains('KB')) {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('K')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2000) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  } else {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('M')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
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
                    )));
          }
        },
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
        onTap: () => _isEnabledImage
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
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);

                                  if (image2 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image2.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  if (file.contains('KB')) {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('K')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2000) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  } else {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('M')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
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
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);
                                  if (image2 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image2.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  if (file.contains('KB')) {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('K')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2000) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  } else {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('M')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  }
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
        onTap: () => _isEnabledImage
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
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);

                                  if (image3 == null) {
                                    return;
                                  }
                                  final File imageTemporary = File(image3.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  if (file.contains('KB')) {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('K')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2000) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  } else {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('M')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
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
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);

                                  if (image3 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image3.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  if (file.contains('KB')) {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('K')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2000) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  } else {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('M')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
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

    Stack _presetDefault1() {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ExtendedImage.network(
              screenArguments['image_list'][0],
              fit: BoxFit.cover,
              gaplessPlayback: true,
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isEnabledImage) {
                      image1 = null;
                      _uploadCount -= 1;
                      _didClickedImage1 = true;
                      img1Id = screenArguments['image_id_list'][0];
                    }
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
      );
    }

    Stack _presetDefault2() {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ExtendedImage.network(
              screenArguments['image_list'][1],
              fit: BoxFit.cover,
              gaplessPlayback: true,
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isEnabledImage) {
                      image2 = null;
                      _uploadCount -= 1;
                      _didClickedImage2 = true;
                      img2Id = screenArguments['image_id_list'][1];
                    }
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
      );
    }

    Stack _presetDefault3() {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ExtendedImage.network(
              screenArguments['image_list'][2],
              fit: BoxFit.cover,
              gaplessPlayback: true,
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isEnabledImage) {
                      image3 = null;
                      _uploadCount -= 1;
                      _didClickedImage3 = true;
                      img3Id = screenArguments['image_id_list'][2];
                    }
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
      );
    }

    Row _3rowImage() {
      return Row(
        children: <Widget>[
          if (_didClickedImage1)
            image1Placeholder(context)
          else
            _presetDefault1(),
          SizedBox(
            width: 5.w,
          ),
          if (_didClickedImage2)
            image2Placeholder(context)
          else
            _presetDefault2(),
          SizedBox(
            width: 5.w,
          ),
          if (_didClickedImage3)
            image3Placeholder(context)
          else
            _presetDefault3(),
        ],
      );
    }

    Row _2rowImage() {
      return Row(
        children: <Widget>[
          if (_didClickedImage1)
            image1Placeholder(context)
          else
            _presetDefault1(),
          SizedBox(
            width: 5.w,
          ),
          if (_didClickedImage2)
            image2Placeholder(context)
          else
            _presetDefault2(),
          SizedBox(
            width: 5.w,
          ),
          image3Placeholder(context)
        ],
      );
    }

    Row _1rowImage() {
      return Row(
        children: <Widget>[
          if (_didClickedImage1)
            image1Placeholder(context)
          else
            _presetDefault1(),
          SizedBox(
            width: 5.w,
          ),
          image2Placeholder(context),
          SizedBox(
            width: 5.w,
          ),
          image3Placeholder(context)
        ],
      );
    }

    Row _0rowImage() {
      return Row(
        children: <Widget>[
          image1Placeholder(context),
          SizedBox(
            width: 5.w,
          ),
          image2Placeholder(context),
          SizedBox(
            width: 5.w,
          ),
          image3Placeholder(context)
        ],
      );
    }

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
                  Text(
                    'Destination',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
                  ),
                  SizedBox(height: 20.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (screenArguments['image_count'] == 3) _3rowImage(),
                        if (screenArguments['image_count'] == 2) _2rowImage(),
                        if (screenArguments['image_count'] == 1) _1rowImage(),
                        if (screenArguments['image_count'] == 0) _0rowImage(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  if (_uploadCount == 3)
                    Center(
                      child: Text(
                        AppTextConstants.maximumImage,
                        style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: 'Gilroy',
                            color: AppColors.osloGrey),
                      ),
                    )
                  else
                    const Text(''),
                  SizedBox(height: 20.h),
                  TextField(
                    onTap: _handlePressButton,
                    readOnly: true,
                    controller: _placeName,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: screenArguments['place_name'],
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
                    controller: _description,
                    focusNode: _descriptionFocus,
                    maxLines: 10,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: screenArguments['place_description'],
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
          height: 60,
          child: LoadingElevatedButton(
            onPressed: () => _isSubmit ? null : saveDestination(),
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
            isLoading: _isSubmit,
            loadingChild: const Text(
              'Loading',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

  Future<void> saveDestination() async {
    setState(() {
      _isSubmit = true;
    });

    if (_placeName.text.isEmpty || _description.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.fieldMustBeFilled)
          .show(context);
      setState(() {
        _isSubmit = false;
      });
    } else if (_didClickedImage1) {
      if (image1 == null) {
        AdvanceSnackBar(message: ErrorMessageConstants.destinationImgEmpty)
            .show(context);
      } else {
        setState(() {
          _isSubmit = true;
        });
        final Map<String, dynamic> screenArguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

        final Map<String, dynamic> destinationDetails = {
          'activity_package_id': screenArguments['activity_package_id'],
          'place_name': _placeName.text,
          'place_description': _description.text,
          'latitude': latitude,
          'longitude': longitude
        };

        final dynamic response = await APIServices().request(
            '${AppAPIPath.activityDestinationDetails}/${screenArguments['activity_package_destination_id']}',
            RequestType.PATCH,
            needAccessToken: true,
            data: destinationDetails);

        _imageUpdate(screenArguments['activity_package_destination_id'],
            screenArguments['image_count']);

        await Navigator.pushReplacement(
            context,
            MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const MainNavigationScreen(
                      navIndex: 1,
                      contentIndex: 0,
                    )));
      }
    } else {
      setState(() {
        _isSubmit = true;
      });
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final Map<String, dynamic> destinationDetails = {
        'activity_package_id': screenArguments['activity_package_id'],
        'place_name': _placeName.text,
        'place_description': _description.text,
        'latitude': latitude,
        'longitude': longitude
      };

      final dynamic response = await APIServices().request(
          '${AppAPIPath.activityDestinationDetails}/${screenArguments['activity_package_destination_id']}',
          RequestType.PATCH,
          needAccessToken: true,
          data: destinationDetails);

      _imageUpdate(screenArguments['activity_package_destination_id'],
          screenArguments['image_count']);

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const MainNavigationScreen(
                    navIndex: 1,
                    contentIndex: 0,
                  )));
    }
  }

  void _imageUpdate(String id, int imageCount) {
    if (imageCount == 3) {
      _3image(id);
    }
    if (imageCount == 2) {
      _2image(id);
    }
    if (imageCount == 1) {
      _1image(id);
    }
    if (imageCount == 0) {
      _0image(id);
    }
  }

  Future<void> _3image(String id) async {
    if (_didClickedImage3) {
      if (image3 != null) {
        /// Save image to firebase
        String ImgUrl = '';

        ImgUrl = await FirebaseServices()
            .uploadImageToFirebase(image3!, _destinationPath);
        final Map<String, dynamic> img3Details = {
          'activity_package_destination_id': id,
          'snapshot_img': '',
          'firebase_snapshot_img': ImgUrl
        };
        final dynamic img3response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img3Id', RequestType.PATCH,
            needAccessToken: true, data: img3Details);
      } else {
        /// Delete the outfitter image
        final dynamic img3response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img3Id',
            RequestType.DELETE,
            needAccessToken: true);
      }
    }
    if (_didClickedImage2) {
      if (image2 != null) {
        /// Save image to firebase
        String ImgUrl = '';

        ImgUrl = await FirebaseServices()
            .uploadImageToFirebase(image2!, _destinationPath);
        final Map<String, dynamic> img2Details = {
          'activity_package_destination_id': id,
          'snapshot_img': '',
          'firebase_snapshot_img': ImgUrl
        };
        final dynamic img2response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img2Id', RequestType.PATCH,
            needAccessToken: true, data: img2Details);
      } else {
        /// Delete the outfitter image
        final dynamic img2response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img2Id',
            RequestType.DELETE,
            needAccessToken: true);
      }
    }
    if (_didClickedImage1) {
      if (image1 != null) {
        /// Save image to firebase
        String ImgUrl = '';

        ImgUrl = await FirebaseServices()
            .uploadImageToFirebase(image1!, _destinationPath);
        final Map<String, dynamic> img1Details = {
          'activity_package_destination_id': id,
          'snapshot_img': '',
          'firebase_snapshot_img': ImgUrl
        };
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img1Id', RequestType.PATCH,
            needAccessToken: true, data: img1Details);
      } else {
        /// Delete the outfitter image
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img1Id',
            RequestType.DELETE,
            needAccessToken: true);
      }
    }
  }

  Future<void> _2image(String id) async {
    if (image3 != null) {
      /// Save image to firebase
      String ImgUrl = '';

      ImgUrl = await FirebaseServices()
          .uploadImageToFirebase(image3!, _destinationPath);
      final Map<String, dynamic> img3Details = {
        'activity_package_destination_id': id,
        'snapshot_img': '',
        'firebase_snapshot_img': ImgUrl
      };
      final dynamic img3response = await APIServices().request(
          AppAPIPath.activityDestinationImage, RequestType.POST,
          needAccessToken: true, data: img3Details);
    }
    if (_didClickedImage2) {
      if (image2 != null) {
        /// Save image to firebase
        String ImgUrl = '';

        ImgUrl = await FirebaseServices()
            .uploadImageToFirebase(image2!, _destinationPath);
        final Map<String, dynamic> img2Details = {
          'activity_package_destination_id': id,
          'snapshot_img': '',
          'firebase_snapshot_img': ImgUrl
        };
        final dynamic img2response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img2Id', RequestType.PATCH,
            needAccessToken: true, data: img2Details);
      } else {
        /// Delete the outfitter image
        final dynamic img2response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img2Id',
            RequestType.DELETE,
            needAccessToken: true);
      }
    }
    if (_didClickedImage1) {
      if (image1 != null) {
        /// Save image to firebase
        String ImgUrl = '';

        ImgUrl = await FirebaseServices()
            .uploadImageToFirebase(image1!, _destinationPath);
        final Map<String, dynamic> img1Details = {
          'activity_package_destination_id': id,
          'snapshot_img': '',
          'firebase_snapshot_img': ImgUrl
        };
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img1Id', RequestType.PATCH,
            needAccessToken: true, data: img1Details);
      } else {
        /// Delete the outfitter image
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img1Id',
            RequestType.DELETE,
            needAccessToken: true);
      }
    }
  }

  Future<void> _1image(String id) async {
    if (image3 != null) {
      final Future<Uint8List> image3Bytes = File(image3!.path).readAsBytes();
      final String base64Image3 = base64Encode(await image3Bytes);

      /// Save image to firebase
      String ImgUrl = '';

      ImgUrl = await FirebaseServices()
          .uploadImageToFirebase(image3!, _destinationPath);
      final Map<String, dynamic> img3Details = {
        'activity_package_destination_id': id,
        'snapshot_img': '',
        'firebase_snapshot_img': ImgUrl
      };
      final dynamic img3response = await APIServices().request(
          AppAPIPath.activityDestinationImage, RequestType.POST,
          needAccessToken: true, data: img3Details);
    }
    if (image2 != null) {
      /// Save image to firebase
      String ImgUrl = '';

      ImgUrl = await FirebaseServices()
          .uploadImageToFirebase(image2!, _destinationPath);
      final Map<String, dynamic> img2Details = {
        'activity_package_destination_id': id,
        'snapshot_img': '',
        'firebase_snapshot_img': ImgUrl
      };
      final dynamic img2response = await APIServices().request(
          AppAPIPath.activityDestinationImage, RequestType.POST,
          needAccessToken: true, data: img2Details);
    }
    if (_didClickedImage1) {
      if (image1 != null) {
        /// Save image to firebase
        String ImgUrl = '';

        ImgUrl = await FirebaseServices()
            .uploadImageToFirebase(image1!, _destinationPath);
        final Map<String, dynamic> img1Details = {
          'activity_package_destination_id': id,
          'snapshot_img': '',
          'firebase_snapshot_img': ImgUrl
        };
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img1Id', RequestType.PATCH,
            needAccessToken: true, data: img1Details);
      } else {
        /// Delete the outfitter image
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.activityDestinationImage}/$img1Id',
            RequestType.DELETE,
            needAccessToken: true);
      }
    }
  }

  Future<void> _0image(String id) async {
    if (image3 != null) {
      /// Save image to firebase
      String ImgUrl = '';

      ImgUrl = await FirebaseServices()
          .uploadImageToFirebase(image3!, _destinationPath);
      final Map<String, dynamic> img3Details = {
        'activity_package_destination_id': id,
        'snapshot_img': '',
        'firebase_snapshot_img': ImgUrl
      };
      final dynamic img3response = await APIServices().request(
          AppAPIPath.activityDestinationImage, RequestType.POST,
          needAccessToken: true, data: img3Details);
    }
    if (image2 != null) {
      /// Save image to firebase
      String ImgUrl = '';

      ImgUrl = await FirebaseServices()
          .uploadImageToFirebase(image2!, _destinationPath);
      final Map<String, dynamic> img2Details = {
        'activity_package_destination_id': id,
        'snapshot_img': '',
        'firebase_snapshot_img': ImgUrl
      };
      final dynamic img2response = await APIServices().request(
          AppAPIPath.activityDestinationImage, RequestType.POST,
          needAccessToken: true, data: img2Details);
    }
    if (image1 != null) {
      /// Save image to firebase
      String ImgUrl = '';

      ImgUrl = await FirebaseServices()
          .uploadImageToFirebase(image1!, _destinationPath);
      final Map<String, dynamic> img1Details = {
        'activity_package_destination_id': id,
        'snapshot_img': '',
        'firebase_snapshot_img': ImgUrl
      };
      final dynamic img1response = await APIServices().request(
          AppAPIPath.activityDestinationImage, RequestType.POST,
          needAccessToken: true, data: img1Details);
    }
  }

  Future<void> _handlePressButton() async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      radius: 10000000,
      types: [],
      strictbounds: false,
      mode: Mode.overlay,
      language: 'en',
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, screenArguments['code'])],
    );

    await displayPrediction(p, context);
  }

  Future<void> displayPrediction(Prediction? p, BuildContext context) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      final PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      setState(() {
        _placeName = TextEditingController(text: p.description);
        latitude = lat.toString();
        longitude = lng.toString();
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<File?>('image2', image2))
      ..add(DiagnosticsProperty<File?>('image1', image1))
      ..add(DiagnosticsProperty<File?>('image3', image3));
  }
}
