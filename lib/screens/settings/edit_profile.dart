import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/bordered_text_field.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_input_formatter.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/profile_photos_controller.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/profile_image.dart';
import 'package:guided/models/profile_photo_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/image_picker_bottom_sheet.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';

///Edit Profile
class EditProfileScreen extends StatefulWidget {
  ///Constructor
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _fullNameController = TextEditingController();
  String profilePicPreview = '';
  File? _photo;
  final String _storagePath = 'profilePictures';
  bool isSaving = false;
  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());
  PageController _pageController = PageController(initialPage: 0);

  int currentPage = 0;

  TextEditingController _aboutMeController = TextEditingController();
  List<String> images = List.filled(6, '');

  ProfilePhotoController _photoController = Get.put(ProfilePhotoController());
  List<ProfilePhoto> photos = List.filled(6, ProfilePhoto());
  int selectedPhotoIndex = 0;

  UserProfileImage profileImages = UserProfileImage();

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(
        text: _profileDetailsController.userProfileDetails.fullName);
    _aboutMeController = TextEditingController(
        text: _profileDetailsController.userProfileDetails.about);

    profileImages = UserProfileImage(
        userId: _profileDetailsController.userProfileDetails.id);

    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: Colors.grey.withOpacity(0.2)),
          child: GestureDetector(
            onTap: () {
              debugPrint('current page $currentPage');
              if (currentPage == 0) {
                Navigator.pop(context);
              } else {
                _pageController.animateToPage(currentPage - 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              }
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: buildEditProfileUI(),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
        child: currentPage < 2
            ? CustomRoundedButton(
                title: AppTextConstants.next,
                onpressed: () {
                  _pageController.animateToPage(currentPage + 1,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear);
                },
              )
            : CustomRoundedButton(
                title: AppTextConstants.save,
                isLoading: isSaving,
                onpressed: () {
                  updateProfile();
                },
              ),
      ),
    );
  }

  Widget buildEditProfileUI() {
    return PageView(
      controller: _pageController,
      onPageChanged: (i) {
        setState(() {
          currentPage = i;
        });
      },
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        buildEditPhotoAndName(),
        buildEditAboutMe(),
        buildEditPhotos()
      ],
    );
  }

  Widget buildEditPhotoAndName() {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppTextConstants.editProfile,
              style: TextStyle(fontSize: 24.sp, fontFamily: 'GilroyBold')),
          Center(
            child: buildProfilePicture(),
          ),
          /* TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                    hintText: AppTextConstants.fullName,
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                  ))*/
          BorderedTextField(
              controller: _fullNameController,
              inputFormatters: [AppInputFormatters.name],
              labelText: '',
              hintText: AppTextConstants.fullName)
        ],
      ),
    ));
  }

  Widget buildEditAboutMe() {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppTextConstants.aboutMe,
              style: TextStyle(fontSize: 24.sp, fontFamily: 'GilroyBold')),
          SizedBox(height: 44.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.2.w),
                borderRadius: BorderRadius.circular(12)),
            child: TextFormField(
                controller: _aboutMeController,
                minLines: 8,
                maxLines: null,
                maxLength: 100,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                  hintText: AppTextConstants.aboutMe,
                  hintStyle: TextStyle(
                    color: AppColors.grey,
                  ),
                  border: InputBorder.none,
                )),
          )
        ],
      ),
    ));
  }

  Widget buildEditPhotos() {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppTextConstants.photos,
              style: TextStyle(fontSize: 24.sp, fontFamily: 'GilroyBold')),
          SizedBox(height: 44.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: buildPhotos(),
          )
        ],
      ),
    ));
  }

  Widget buildPhotos() => GridView(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.5),
        ),
        physics: NeverScrollableScrollPhysics(),
        children: [
          buildPhoto(profileImages.imageUrl1, 1),
          buildPhoto(profileImages.imageUrl2, 2),
          buildPhoto(profileImages.imageUrl3, 3),
          buildPhoto(profileImages.imageUrl4, 4),
          buildPhoto(profileImages.imageUrl5, 5),
          buildPhoto(profileImages.imageUrl6, 6)
        ],
      );

  Widget buildPhoto(String image, int order) {
    return Container(
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: image.isNotEmpty ? Colors.black : AppColors.gallery,
          image: image.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(image),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  fit: BoxFit.cover)
              : null),
      child: GestureDetector(
          onTap: () {
            setState(() {
              selectedPhotoIndex = order;
            });
            imagePickerBottomSheet(context, handlePhotoPicked);
          },
          child: Center(
              child: Image.asset(
            AssetsPath.gallery,
            height: 35.h,
            fit: BoxFit.fitHeight,
          ))),
    );
  }
  Widget buildProfilePicture() => Container(
      margin: EdgeInsets.only(top: 55.h, bottom: 65.h),
      child: Stack(
        children: <Widget>[
          Container(
            width: 200.w,
            height: 200.h,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: const <BoxShadow>[
                BoxShadow(blurRadius: 3, color: Colors.grey)
              ],
            ),
            child: profilePicPreview.isEmpty
                ? _profileDetailsController
                        .userProfileDetails.firebaseProfilePicUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        backgroundImage: ExtendedImage.network(
                          _profileDetailsController
                              .userProfileDetails.firebaseProfilePicUrl,
                          gaplessPlayback: true,
                        ).image,
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        backgroundImage:
                            AssetImage(AssetsPath.defaultProfilePic),
                      )
                : CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35,
                    backgroundImage:
                        MemoryImage(base64Decode(profilePicPreview)),
                  ),
          ),
          Positioned(
            top: 18,
            right: 20,
            child: Container(
                width: 33,
                height: 33,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: GestureDetector(
                    onTap: () {
                      imagePickerBottomSheet(context, handleImagePicked);
                    },
                    child: Icon(
                      Icons.edit,
                      size: 15.sp,
                      color: Colors.black,
                    ))),
          )
        ],
      ));

  Future<void> handleImagePicked(image) async {
    final Future<Uint8List> imageBytes = File(image.path).readAsBytes();
    debugPrint('Image Path: $image');

    final String base64String = base64Encode(await imageBytes);
    setState(() {
      _photo = image;
      profilePicPreview = base64String;
    });
  }

  Future<void> updateProfile() async {
    setState(() {
      isSaving = true;
    });

    ///Save image to firebase
    String profileUrl = '';
    if (_photo != null) {
      profileUrl =
          await FirebaseServices().uploadImageToFirebase(_photo!, _storagePath);
    } else {
      profileUrl =
          _profileDetailsController.userProfileDetails.firebaseProfilePicUrl;
    }

    final dynamic editProfileParams = {
      'full_name': _fullNameController.text,
      'about': _aboutMeController.text,
      'profile_photo_firebase_url': profileUrl
    };

    final APIStandardReturnFormat res =
        await APIServices().updateProfile(editProfileParams);

    if (res.status == 'success') {
      final ProfileDetailsModel updatedProfile =
          ProfileDetailsModel.fromJson(json.decode(res.successResponse));
      _profileDetailsController.setUserProfileDetails(updatedProfile);

      await updateProfileImages();
      setState(() {
        isSaving = false;
      });

      Navigator.of(context).pop();
    }
  }

  Future<void> handlePhotoPicked(image) async {
    final Future<Uint8List> imageBytes = File(image.path).readAsBytes();
    debugPrint('Image Path: $image');

    final String base64String = base64Encode(await imageBytes);

    // upload to firebase uncomment when api available ...
    String photoUrl = '';
    if (image != null) {
      photoUrl =
          await FirebaseServices().uploadImageToFirebase(image, _storagePath);
    }

    updatePhoto(photoUrl, selectedPhotoIndex);
  }

  void updatePhoto(String image, int order) {
    switch (order) {
      case 1:
        setState(() {
          profileImages.imageUrl1 = image;
        });
        break;
      case 2:
        setState(() {
          profileImages.imageUrl2 = image;
        });
        break;
      case 3:
        setState(() {
          profileImages.imageUrl3 = image;
        });
        break;
      case 4:
        setState(() {
          profileImages.imageUrl4 = image;
        });
        break;
      case 5:
        setState(() {
          profileImages.imageUrl5 = image;
        });
        break;
      case 6:
        setState(() {
          profileImages.imageUrl6 = image;
        });
        break;
    }
  }

  Future<void> getImages() async {
    final UserProfileImage res = await APIServices()
        .getUserProfileImages(_profileDetailsController.userProfileDetails.id);

    if (res.id != '') {
      setState(() {
        profileImages = res;
      });
    } else {
      final UserProfileImage addImagesResponse =
          await APIServices().addUserProfileImages(profileImages);
    }
  }

  Future<void> updateProfileImages() async {
    final UserProfileImage result =
        await APIServices().updateUserProfileImages(profileImages);

    if (result.id != '') {
      debugPrint('Updated..');
      _photoController.setProfileImages(result);
      setState(() {
        profileImages = result;
      });
    }
  }
}
