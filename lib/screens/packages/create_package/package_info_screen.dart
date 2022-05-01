// ignore_for_file: file_names, cast_nullable_to_non_nullable, always_declare_return_types, type_annotate_public_apis
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Package info screen
class PackageInfoScreen extends StatefulWidget {
  /// Constructor
  const PackageInfoScreen({Key? key}) : super(key: key);

  @override
  _PackageInfoScreenState createState() => _PackageInfoScreenState();
}

class _PackageInfoScreenState extends State<PackageInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  File? image1;

  final TextEditingController _packageName = TextEditingController();
  final TextEditingController _description = TextEditingController();

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
                  HeaderText.headerText(AppTextConstants.packageNameandDescr),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppTextConstants.packageName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextField(
                    controller: _packageName,
                    decoration: InputDecoration(
                      hintText: AppTextConstants.myPackageHint,
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
                    controller: _description,
                    maxLines: 8,
                    decoration: InputDecoration(
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
                  Text(
                    AppTextConstants.coverPhoto,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  GestureDetector(
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
                                          final XFile? image1 =
                                              await ImagePicker().pickImage(
                                                  source: ImageSource.camera,
                                                  maxHeight: 800.h,
                                                  maxWidth: 800.w,
                                                  imageQuality: 25);
                                          if (image1 == null) {
                                            return;
                                          }

                                          final File imageTemporary =
                                              File(image1.path);
                                          String file;
                                          int fileSize;
                                          file = getFileSizeString(
                                              bytes:
                                                  imageTemporary.lengthSync());
                                          if (file.contains('KB')) {
                                            fileSize = int.parse(file.substring(
                                                0, file.indexOf('K')));
                                            debugPrint('Filesize:: $fileSize');
                                            if (fileSize >= 2000) {
                                              Navigator.pop(context);
                                              AdvanceSnackBar(
                                                      message:
                                                          ErrorMessageConstants
                                                              .imageFileToSize,
                                                      bgColor: Colors.red)
                                                  .show(context);
                                              return;
                                            }
                                          } else {
                                            fileSize = int.parse(file.substring(
                                                0, file.indexOf('M')));
                                            debugPrint('Filesize:: $fileSize');
                                            if (fileSize >= 2) {
                                              Navigator.pop(context);
                                              AdvanceSnackBar(
                                                      message:
                                                          ErrorMessageConstants
                                                              .imageFileToSize,
                                                      bgColor: Colors.red)
                                                  .show(context);
                                              return;
                                            }
                                          }
                                          setState(() {
                                            this.image1 = imageTemporary;
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
                                          final XFile? image1 =
                                              await ImagePicker().pickImage(
                                                  source: ImageSource.gallery,
                                                  maxHeight: 800.h,
                                                  maxWidth: 800.w,
                                                  imageQuality: 25);

                                          if (image1 == null) {
                                            return;
                                          }

                                          final File imageTemporary =
                                              File(image1.path);
                                          String file;
                                          int fileSize = 0;
                                          int fileSizeMB = 0;

                                          file = getFileSizeString(
                                              bytes:
                                                  imageTemporary.lengthSync());

                                          if (file.contains('KB')) {
                                            fileSize = int.parse(file.substring(
                                                0, file.indexOf('K')));
                                            debugPrint('Filesize:: $fileSize');
                                            if (fileSize >= 2000) {
                                              Navigator.pop(context);
                                              AdvanceSnackBar(
                                                      message:
                                                          ErrorMessageConstants
                                                              .imageFileToSize,
                                                      bgColor: Colors.red)
                                                  .show(context);
                                              return;
                                            }
                                          } else {
                                            fileSize = int.parse(file.substring(
                                                0, file.indexOf('M')));
                                            debugPrint('Filesize:: $fileSize');
                                            if (fileSize >= 2) {
                                              Navigator.pop(context);
                                              AdvanceSnackBar(
                                                      message:
                                                          ErrorMessageConstants
                                                              .imageFileToSize,
                                                      bgColor: Colors.red)
                                                  .show(context);
                                              return;
                                            }
                                          }

                                          setState(() {
                                            this.image1 = imageTemporary;
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
                        ? Center(
                            child: Container(
                              height: 400,
                              color: AppColors.gallery,
                              child: Image.file(
                                image1!,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )
                        : Container(
                            width: width,
                            height: 87,
                            color: AppColors.gallery,
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(25.w, 20.h, 30.w, 20.h),
                              child: Image.asset(
                                AssetsPath.imagePrey,
                                height: 36.h,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 60.h),
                  SizedBox(
                    width: width,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () => navigateNumberOfTravelerScreen(
                          context, screenArguments),
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
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigate to Number of Traveler
  Future<void> navigateNumberOfTravelerScreen(
      BuildContext context, Map<String, dynamic> data) async {
    String base64Image1 = '';
    if (image1 == null) {
      AdvanceSnackBar(message: ErrorMessageConstants.emptyCoverImg)
          .show(context);
    } else {
      final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
      base64Image1 = base64Encode(await image1Bytes);
    }

    if (_packageName.text.isEmpty ||
        _description.text.isEmpty ||
        image1 == null) {
      AdvanceSnackBar(message: ErrorMessageConstants.fieldMustBeFilled)
          .show(context);
    } else {
      final Map<String, dynamic> details = Map<String, dynamic>.from(data);
      details['package_name'] = _packageName.text;
      details['description'] = _description.text;
      details['cover_img'] = base64Image1;
      details['firebase_cover_img'] = image1;
      await Navigator.pushNamed(context, '/number_of_traveler',
          arguments: details);
    }
  }
}
