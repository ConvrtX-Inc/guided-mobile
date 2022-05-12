import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:image_picker/image_picker.dart';

imagePickerBottomSheet(BuildContext context, Function onImagePicked) {
  return showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            SizedBox(height: 10.h),
            Padding(
                padding: EdgeInsets.all(12.w),
                child: const Text(
                  'Upload image from :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  uploadFromCamera(onImagePicked, context);
                }),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                uploadFromGallery(onImagePicked, context);
              },
            ),
          ],
        );
      });
}

Future<void> uploadFromCamera(
    Function onImagePicked, BuildContext context) async {
  try {
    final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 800.h,
        maxWidth: 800.w,
        imageQuality: 50);

    if (image == null) {
      return;
    }

    final File imageTemporary = File(image.path);
    String file;
    int fileSize;
    file = getFileSizeString(bytes: imageTemporary.lengthSync());
    if (file.contains('KB')) {
      fileSize = int.parse(file.substring(0, file.indexOf('K')));
      debugPrint('Filesize:: $fileSize');
      if (fileSize >= 2000) {
        Navigator.pop(context);
        AdvanceSnackBar(
                message: ErrorMessageConstants.imageFileToSize,
                bgColor: Colors.red)
            .show(context);
        return;
      }
    } else {
      fileSize = int.parse(file.substring(0, file.indexOf('M')));
      debugPrint('Filesize:: $fileSize');
      if (fileSize >= 2) {
        Navigator.pop(context);
        AdvanceSnackBar(
                message: ErrorMessageConstants.imageFileToSize,
                bgColor: Colors.red)
            .show(context);
        return;
      }
    }
    return onImagePicked(imageTemporary);
  } on PlatformException catch (e) {
    debugPrint('Failed to pick image: $e');
  }
}

Future<void> uploadFromGallery(
    Function onImagePicked, BuildContext context) async {
  try {
    final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 800.h,
        maxWidth: 800.w,
        imageQuality: 50);

    if (image == null) {
      return;
    }

    final File imageTemporary = File(image.path);
    String file;
    int fileSize;
    file = getFileSizeString(bytes: imageTemporary.lengthSync());
    if (file.contains('KB')) {
      fileSize = int.parse(file.substring(0, file.indexOf('K')));
      debugPrint('Filesize:: $fileSize');
      if (fileSize >= 2000) {
        Navigator.pop(context);
        AdvanceSnackBar(
                message: ErrorMessageConstants.imageFileToSize,
                bgColor: Colors.red)
            .show(context);
        return;
      }
    } else {
      fileSize = int.parse(file.substring(0, file.indexOf('M')));
      debugPrint('Filesize:: $fileSize');
      if (fileSize >= 2) {
        Navigator.pop(context);
        AdvanceSnackBar(
                message: ErrorMessageConstants.imageFileToSize,
                bgColor: Colors.red)
            .show(context);
        return;
      }
    }
    // return image path
    return onImagePicked(imageTemporary);
  } on PlatformException catch (e) {
    debugPrint('Failed to pick image: $e');
  }
}

// Format File Size
String getFileSizeString({required int bytes, int decimals = 0}) {
  if (bytes <= 0) return "0 Bytes";
  const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
}
