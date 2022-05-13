// ignore_for_file: no_default_cases, public_member_api_docs
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/profile_photos_controller.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/profile_image.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/image_picker_bottom_sheet.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:skeleton_text/skeleton_text.dart';

/// Profile Screen
class ProfileScreen extends StatefulWidget {
  /// Constructor
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());
  bool isLoading = false;

  String profilePicPreview = '';
  File? _photo;

  final ProfilePhotoController _profilePhotoController =
      Get.put(ProfilePhotoController());

  final String _storagePath = 'profilePictures';
  bool isUploading = false;

  @override
  void initState() {
    super.initState();

    /* if (_profileDetailsController.userProfileDetails.id.isEmpty) {
      isLoading = true;
    }*/

    isLoading = true;
    getProfileDetails();
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
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        elevation: 0.2,
        backgroundColor: Colors.white,
      ),
      body: isLoading ? buildFakeProfile() : getBody(context),
      backgroundColor: Colors.white,
    );
  }

  /// Body of profile screen
  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
        child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Profile',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 14.h,
            ),
            GetBuilder<UserProfileDetailsController>(
                builder: (UserProfileDetailsController _controller) {
              return buildProfileData(context, _controller.userProfileDetails);
            }),
            getAboutMe(context),
            getProfileSetting(context)
          ],
        ),
      ),
    ));
  }

  Widget buildProfileData(
          BuildContext context, ProfileDetailsModel profileData) =>
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getProfile(context, profileData.fullName),
                SizedBox(
                  height: 9.h,
                ),
                Text(
                  'About Me',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 9.h,
                ),
                Text(
                  profileData.about,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                ),
              ],
            )
          ]);

  /// profile image
  Widget getProfile(BuildContext context, String name) {
    return Center(
      child: Column(
        children: <Widget>[
          buildProfilePicture(),
          SizedBox(
            height: 13.h,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/edit_profile');
              },
              child: Text(
                'Edit',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              )),
          SizedBox(
            height: 6.h,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  /// widget for about me
  Widget getAboutMe(BuildContext context) {
    return GetBuilder<ProfilePhotoController>(
        builder: (ProfilePhotoController _controller) {
          debugPrint('image controller ${_controller.profilePhotos.id}');
      return _controller.profilePhotos.id.isNotEmpty
          ? GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              shrinkWrap: true,
              children: <Widget>[
                if (_controller.profilePhotos.imageUrl1 != '')
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 23, 0, 23),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                                _controller.profilePhotos.imageUrl1),
                            fit: BoxFit.cover)),
                  ),
                if (_controller.profilePhotos.imageUrl2 != '')
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 23, 0, 23),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                        image: DecorationImage(
                            image: NetworkImage(
                                _controller.profilePhotos.imageUrl2),
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.6),
                                BlendMode.dstATop),
                            fit: BoxFit.cover)),
                    child: Center(
                      child: Text(
                        '4+',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp),
                      ),
                    ),
                  )
              ],
            )
          : Container(height: 22.h);
    });
  }



  /// widget for profile settings
  Widget getProfileSetting(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
          onTap: (){
            Navigator.of(context).pushNamed('/change_password');
          },
          leading: Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.lock_outline)),
          title: Text(
            'Change Password',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 17.sp)),
      ListTile(
          leading: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.tablet_android_outlined)),
          title: Text(
            'Change Mobile Number',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 17.sp)),
      ListTile(
          onTap: (){
            Navigator.of(context).pushNamed('/profile-certificate');
          },
          leading: Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset(AssetsPath.certificateIcon)),
          title: Text(
            'Certificates',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 17.sp)),
     
    ]);
  }

  Widget buildFakeProfile() => Container(
        padding: EdgeInsets.all(22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SkeletonText(
              width: 80,
              height: 30,
            ),
            SizedBox(height: 35.h),
            const Center(
              child: SkeletonText(
                width: 120,
                height: 120,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 18.h),
            const Center(
              child: SkeletonText(
                width: 130,
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            SkeletonText(
              width: 90.w,
            ),
            SizedBox(
              height: 22.h,
            ),
            SkeletonText(
              width: 300.w,
            ),
            SizedBox(
              height: 12.h,
            ),
            SkeletonText(
              width: 240.w,
            ),
            SizedBox(
              height: 35.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SkeletonText(
                  width: 150.w,
                  height: 150.h,
                ),
                SkeletonText(
                  width: 150.w,
                  height: 150.h,
                ),
              ],
            )
          ],
        ),
      );

  Widget buildProfilePicture() => Container(
          child: Stack(
        children: <Widget>[
          Container(
            width: 121.w,
            height: 121.h,
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
            child: isUploading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.deepGreen,
                    ),
                  )
                : _profileDetailsController
                        .userProfileDetails.firebaseProfilePicUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        backgroundImage: NetworkImage(_profileDetailsController
                            .userProfileDetails.firebaseProfilePicUrl))
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        backgroundImage:
                            AssetImage(AssetsPath.defaultProfilePic),
                      ),
          ),
          Positioned(
            top: 8,
            right: 6,
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
    setState(() {
      isUploading = true;
    });

    ///Save image to firebase
    String profileUrl = '';
    if (image != null) {
      profileUrl =
          await FirebaseServices().uploadImageToFirebase(image, _storagePath);
    }

    debugPrint('firebse url: $profileUrl');
    final dynamic editProfileParams = {
      'profile_photo_firebase_url': profileUrl
    };

    final APIStandardReturnFormat res =
        await APIServices().updateProfile(editProfileParams);
    debugPrint('Response:: ${res.status}');

    if (res.status == 'success') {
      final ProfileDetailsModel updatedProfile =
          ProfileDetailsModel.fromJson(json.decode(res.successResponse));
      _profileDetailsController.setUserProfileDetails(updatedProfile);

      setState(() {
        isUploading = false;
      });
    }
  }

  Future<void> getProfileDetails() async {
    final ProfileDetailsModel res = await APIServices().getProfileData();
    debugPrint('Profile:: ${res.id}');
    setState(() {
      isLoading = false;
    });
    _profileDetailsController.setUserProfileDetails(res);
  }

  Future<void> getImages() async {
    final UserProfileImage res = await APIServices().getUserProfileImages();
    debugPrint('Data ${res.imageUrl1}');

    if (res.id != '') {
      setState(() {
        _profilePhotoController.setProfileImages(res);
      });
    } else {
      final UserProfileImage addImagesResponse =
          await APIServices().addUserProfileImages(UserProfileImage());
      debugPrint('Response:: $addImagesResponse');
    }
  }
}
