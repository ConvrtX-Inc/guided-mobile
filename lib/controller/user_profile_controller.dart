import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/models/profile_data_model.dart';

///User Profile Details controller
class UserProfileDetailsController extends GetxController {

/// Profile Details
  ProfileDetailsModel  userProfileDetails =   ProfileDetailsModel();

  /// Set User Profile Details function
  void setUserProfileDetails(ProfileDetailsModel data) {
    debugPrint('Data $data');
    userProfileDetails = data;
    update();
  }
}
