import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/models/profile_photo_model.dart';

///ProfilePhoto controller
class ProfilePhotoController extends GetxController {
  /// ProfilePhotos
  RxList<ProfilePhoto> photos = RxList<ProfilePhoto>([]);

  /// add ProfilePhoto function
  void addProfilePhoto(ProfilePhoto data) {
    photos.add(data);
    update();
  }

  /// update ProfilePhoto
  void updateProfilePhoto(int index, ProfilePhoto data) {
    // final int index = photos.indexWhere((ProfilePhoto p) => p.id == data.id);
    photos[index] = data;
    update();
  }

  /// remove ProfilePhoto
  void remove(ProfilePhoto data) {
    final int index = photos.indexWhere((ProfilePhoto p) => p.id == data.id);
    debugPrint(data.id);
    photos.removeAt(index);
    update();
  }

  ///initialize photos
  Future<void> initProfilePhotos(List<ProfilePhoto> data) async {
     photos.value = data;
  }
}
