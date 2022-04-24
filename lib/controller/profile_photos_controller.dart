import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/models/profile_image.dart';
import 'package:guided/models/profile_photo_model.dart';

///ProfilePhotos controller
class ProfilePhotoController extends GetxController {
  /// ProfilePhotos
  // RxList<ProfilePhoto> photos = RxList<ProfilePhoto>([]);

  // final Rx<UserProfileImage> profilePhotos = UserProfileImage().obs;

  UserProfileImage profilePhotos = UserProfileImage();
  /// set user profile images
  void setProfileImages(UserProfileImage data) {
    debugPrint('Profile Image:: $data');
    profilePhotos = data;
    update();
  }

  /// set user profile images
 /* void setProfileImages(UserProfileImage data) {
    debugPrint('Profile Image:: $data');
    profilePhotos.value = data;
  }*/

}
