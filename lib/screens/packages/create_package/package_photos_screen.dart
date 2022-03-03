// ignore_for_file: file_names, unused_local_variable, cast_nullable_to_non_nullable
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:image_picker/image_picker.dart';
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

  bool _enabledImgHolder2 = false;

  TextEditingController _placeName = new TextEditingController();
  TextEditingController _description = new TextEditingController();

  FocusNode _placeNameFocus = new FocusNode();
  FocusNode _descriptionFocus = new FocusNode();

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
                                      imageQuality: 1);

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
                                          imageQuality: 1);
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
                                          imageQuality: 1);

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
                    AppTextConstants.destination1,
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
                    controller: _placeName,
                    focusNode: _placeNameFocus,
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
                          AppTextConstants.addNewDescription,
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
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 23,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  )
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
          child: ElevatedButton(
            onPressed: () => navigateGuideRuleScreen(context, screenArguments),
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

  Future<void> navigateGuideRuleScreen(
      BuildContext context, Map<String, dynamic> data) async {
    final Map<String, dynamic> details = Map<String, dynamic>.from(data);

    if (_uploadCount == 1) {
      final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
      final String base64Image1 = base64Encode(await image1Bytes);

      details['snapshot_img_1'] = base64Image1;
    } else if (_uploadCount == 2) {
      final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
      final String base64Image1 = base64Encode(await image1Bytes);

      final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
      final String base64Image2 = base64Encode(await image2Bytes);

      details['snapshot_img_1'] = base64Image1;
      details['snapshot_img_2'] = base64Image2;
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
    }
    details['upload_count'] = _uploadCount;
    details['place_name'] = _placeName.text;
    details['place_description'] = _description.text;

    await Navigator.pushNamed(context, '/guide_rule', arguments: details);
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
