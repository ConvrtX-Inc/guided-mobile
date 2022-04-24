import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

imagePickerBottomSheet(
    BuildContext context,
    Function onImagePicked) {
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
                  uploadFromCamera(onImagePicked);
                }),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                uploadFromGallery(onImagePicked);
              },
            ),
          ],
        );
      });
}

Future<void> uploadFromCamera(Function onImagePicked) async {
  try {
    final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 800.h,
        maxWidth: 800.w,
        imageQuality: 25);

    if (image == null) {
      return;
    }

    final File imageTemporary = File(image.path);
  /*  final Future<Uint8List> image1Bytes =
    File(imageTemporary.path).readAsBytes();*/

    // return image path
    return onImagePicked(imageTemporary);

  } on PlatformException catch (e) {
    debugPrint('Failed to pick image: $e');
  }
}

Future<void> uploadFromGallery(Function onImagePicked) async {
  try {
    final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 800.h,
        maxWidth: 800.w,
        imageQuality: 25);

    if (image == null) {
      return;
    }

    final File imageTemporary = File(image.path);

    // return image path
    return onImagePicked(imageTemporary);
   } on PlatformException catch (e) {
    debugPrint('Failed to pick image: $e');
  }
}



