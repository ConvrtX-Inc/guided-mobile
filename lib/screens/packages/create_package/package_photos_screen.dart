// ignore_for_file: file_names, unused_local_variable, cast_nullable_to_non_nullable, always_specify_types, public_member_api_docs
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/activity_destination_model.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Package photo screen
class PackagePhotosScreen extends StatefulWidget {
  /// Constructor
  const PackagePhotosScreen({Key? key}) : super(key: key);

  @override
  _PackagePhotosScreenState createState() => _PackagePhotosScreenState();
}

class _PackagePhotosScreenState extends State<PackagePhotosScreen> {
  File? image1;
  File? image2;
  File? image3;

  int _uploadCount = 0;
  int destinationCount = 1;
  bool _enabledImgHolder2 = false;

  TextEditingController _placeName = new TextEditingController();
  TextEditingController _description = new TextEditingController();

  FocusNode _placeNameFocus = new FocusNode();
  FocusNode _descriptionFocus = new FocusNode();

  late List<ActivityDestinationModel> destinationList;

  final String _destinationPath = 'destinationImg';
  bool _isSubmit = false;
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

  String latitute = '';
  String longitude = '';

  @override
  void initState() {
    super.initState();

    destinationList = [];
  }

  // Format File Size
  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return '0 Bytes';
    const suffixes = [' Bytes', 'KB', 'MB', 'GB', 'TB'];
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
                                  final XFile? image3 =
                                      await ImagePicker().pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 25,
                                    maxHeight: 800.h,
                                    maxWidth: 800.w,
                                  );

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
                  HeaderText.headerText(AppTextConstants.headerUploadPhoto),
                  SizedBox(height: 30.h),
                  SubHeaderText.subHeaderText(
                      AppTextConstants.subheaderUploadPhoto),
                  SizedBox(height: 20.h),
                  Text(
                    'Destination $destinationCount',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      image1Placeholder(context),
                      image2Placeholder(context),
                      image3Placeholder(context)
                    ],
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
                      hintText: AppTextConstants.placeNameHint,
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
                  SizedBox(height: 20.h),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          AppTextConstants.addNewDestination,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.primaryGreen,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: AppColors.primaryGreen,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: addDestination,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 23,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                  if (destinationList.isNotEmpty)
                    _gridKeyword()
                  else
                    const SizedBox(),
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
            onPressed: () => _isSubmit
                ? null
                : navigateGuideRuleScreen(context, screenArguments),
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

  Future<void> addDestination() async {
    if (_placeName.text.isEmpty || _description.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.fieldMustBeFilled)
          .show(context);
    } else {
      setState(() {
        destinationCount++;
      });

      if (_uploadCount == 1) {
        final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
        final String base64Image1 = base64Encode(await image1Bytes);

        destinationList.add(ActivityDestinationModel(
          placeName: _placeName.text,
          placeDescription: _description.text,
          img1Holder: base64Image1,
          latitude: latitute,
          longitude: longitude,
          uploadCount: _uploadCount,
        ));
      } else if (_uploadCount == 2) {
        final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
        final String base64Image1 = base64Encode(await image1Bytes);

        final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
        final String base64Image2 = base64Encode(await image2Bytes);

        destinationList.add(ActivityDestinationModel(
          placeName: _placeName.text,
          placeDescription: _description.text,
          img1Holder: base64Image1,
          img2Holder: base64Image2,
          latitude: latitute,
          longitude: longitude,
          uploadCount: _uploadCount,
        ));
      } else if (_uploadCount == 3) {
        final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
        final String base64Image1 = base64Encode(await image1Bytes);

        final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
        final String base64Image2 = base64Encode(await image2Bytes);

        final Future<Uint8List> image3Bytes = File(image3!.path).readAsBytes();
        final String base64Image3 = base64Encode(await image3Bytes);

        destinationList.add(ActivityDestinationModel(
          placeName: _placeName.text,
          placeDescription: _description.text,
          img1Holder: base64Image1,
          img2Holder: base64Image2,
          img3Holder: base64Image3,
          latitude: latitute,
          longitude: longitude,
          uploadCount: _uploadCount,
        ));
      }
      setState(() {
        _placeName = TextEditingController(text: '');
        _description = TextEditingController(text: '');
        image1 = null;
        image2 = null;
        image3 = null;
        _uploadCount = 0;
        latitute = '';
        longitude = '';
      });
    }
  }

  GridView _gridKeyword() {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      children: List.generate(destinationList.length, (int index) {
        return Padding(
          padding:
              EdgeInsets.only(right: 5.w, left: 5.w, top: 10.h, bottom: 10.h),
          child: Container(
            width: 15.w,
            height: 25.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.grey,
                  spreadRadius: 0.8,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        destinationList[index].placeName.substring(
                            0, destinationList[index].placeName.indexOf(',')),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        destinationList.removeAt(index);
                        destinationCount--;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> navigateGuideRuleScreen(
      BuildContext context, Map<String, dynamic> data) async {
    setState(() {
      _isSubmit = true;
    });

    final Map<String, dynamic> details = Map<String, dynamic>.from(data);
    String snapshotUrl1 = '';
    String snapshotUrl2 = '';
    String snapshotUrl3 = '';

    if (_placeName.text.isEmpty || _description.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.fieldMustBeFilled)
          .show(context);
      setState(() {
        _isSubmit = false;
      });
    } else {
      if (_uploadCount == 1) {
        final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
        final String base64Image1 = base64Encode(await image1Bytes);

        details['snapshot_img_1'] = base64Image1;
        snapshotUrl1 = await FirebaseServices()
            .uploadImageToFirebase(image1!, _destinationPath);
        details['firebase_snapshot_img_1'] = snapshotUrl1;
        destinationList.add(ActivityDestinationModel(
            placeName: _placeName.text,
            placeDescription: _description.text,
            img1Holder: base64Image1,
            img1FirebaseHolder: snapshotUrl1,
            latitude: latitute,
            longitude: longitude,
            uploadCount: _uploadCount));
      } else if (_uploadCount == 2) {
        final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
        final String base64Image1 = base64Encode(await image1Bytes);

        final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
        final String base64Image2 = base64Encode(await image2Bytes);

        details['snapshot_img_1'] = base64Image1;
        details['snapshot_img_2'] = base64Image2;
        details['firebase_snapshot_img_1'] = image1;
        details['firebase_snapshot_img_2'] = image2;
        snapshotUrl1 = await FirebaseServices()
            .uploadImageToFirebase(image1!, _destinationPath);
        snapshotUrl2 = await FirebaseServices()
            .uploadImageToFirebase(image2!, _destinationPath);

        destinationList.add(ActivityDestinationModel(
            placeName: _placeName.text,
            placeDescription: _description.text,
            img1Holder: base64Image1,
            img2Holder: base64Image2,
            img1FirebaseHolder: snapshotUrl1,
            img2FirebaseHolder: snapshotUrl2,
            latitude: latitute,
            longitude: longitude,
            uploadCount: _uploadCount));
      } else if (_uploadCount == 3) {
        final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
        final String base64Image1 = base64Encode(await image1Bytes);

        final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
        final String base64Image2 = base64Encode(await image2Bytes);

        final Future<Uint8List> image3Bytes = File(image3!.path).readAsBytes();
        final String base64Image3 = base64Encode(await image3Bytes);

        details['snapshot_img_1'] = base64Image1;
        details['snapshot_img_2'] = base64Image2;
        details['snapshot_img_3'] = base64Image3;
        details['firebase_snapshot_img_1'] = image1;
        details['firebase_snapshot_img_2'] = image2;
        details['firebase_snapshot_img_3'] = image3;
        snapshotUrl1 = await FirebaseServices()
            .uploadImageToFirebase(image1!, _destinationPath);
        snapshotUrl2 = await FirebaseServices()
            .uploadImageToFirebase(image2!, _destinationPath);
        snapshotUrl3 = await FirebaseServices()
            .uploadImageToFirebase(image3!, _destinationPath);
        destinationList.add(ActivityDestinationModel(
          placeName: _placeName.text,
          placeDescription: _description.text,
          img1Holder: base64Image1,
          img2Holder: base64Image2,
          img3Holder: base64Image3,
          img1FirebaseHolder: snapshotUrl1,
          img2FirebaseHolder: snapshotUrl2,
          img3FirebaseHolder: snapshotUrl3,
          latitude: latitute,
          longitude: longitude,
          uploadCount: _uploadCount,
        ));
      }

      details['upload_count'] = _uploadCount;
      details['place_name'] = _placeName.text;
      details['place_description'] = _description.text;
      details['destination_list'] = destinationList;
      await Navigator.pushNamed(context, '/guide_rule', arguments: details);
    }
  }

  Future<void> _handlePressButton() async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: dotenv.env['GOOGLE_MAPS_API_KEY'].toString(),
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
      components: [
        Component(Component.country, screenArguments['country_code'])
      ],
    );

    await displayPrediction(p, context);
  }

  Future<void> displayPrediction(Prediction? p, BuildContext context) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: dotenv.env['GOOGLE_MAPS_API_KEY'].toString(),
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      final PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      setState(() {
        _placeName = TextEditingController(text: p.description);
        latitute = lat.toString();
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
