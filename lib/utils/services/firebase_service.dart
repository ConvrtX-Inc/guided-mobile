import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';

/// App Firebase services
class FirebaseServices {

  Future<String> uploadImageToFirebase(File _photo,String storagePath) async {
    String filePath = '$storagePath/${DateTime.now().toString()}-${_photo.path.split("/").last}';
    String downloadUrl ='';

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