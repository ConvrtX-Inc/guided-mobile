import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

/// App Firebase services
class FirebaseServices {
  static Future<String> uploadImageToFirebase2(XFile file) async {
    return FirebaseServices().uploadImageToFirebase(File(file.path), 'images');
  }

  Future<String> uploadImageToFirebase(File _photo, String storagePath) async {
    final String filePath =
        '$storagePath/${DateTime.now().toString()}-${_photo.path.split("/").last}';
    String downloadUrl = '';

    try {
      firebase_storage.TaskSnapshot uploadTask = await firebase_storage
          .FirebaseStorage.instance
          .ref(filePath)
          .putFile(_photo);
      downloadUrl = await uploadTask.ref.getDownloadURL();
    } on firebase_storage.FirebaseException catch (e) {
      debugPrint('Error $e');
    }

    return downloadUrl;
  }
}
