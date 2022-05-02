// ignore_for_file: use_named_constants



import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/become_a_guide_activites_model.dart';
import 'package:guided/models/become_a_guide_request_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../models/badge.dart';
import '../../../../models/badge_model.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/services/rest_api_service.dart';

/// Screen for settings contact us
class SettingsBecomeAGuide extends StatefulWidget {
  /// Constructor
  const SettingsBecomeAGuide({Key? key}) : super(key: key);

  @override
  _SettingsBecomeAGuide createState() => _SettingsBecomeAGuide();
}

class _SettingsBecomeAGuide extends State<SettingsBecomeAGuide> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String dropdownValue = 'Indeed';
  bool _isActive = false;
  bool _firstAid = false;
  final String? firstName = UserSingleton.instance.user.user?.firstName;
  final String? lastName = UserSingleton.instance.user.user?.lastName;
  final String? email = UserSingleton.instance.user.user?.email;
  final String? phoneNo = UserSingleton.instance.user.user?.phoneNo;
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneNoFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _whyDoYouThinkFocus = FocusNode();
  final FocusNode _describeAdventureYouWantFocus = FocusNode();
  final FocusNode _runningLocationsFocus = FocusNode();
  final FocusNode _adventuresStandOutFocus = FocusNode();
  final FocusNode _whyDoYouWantToWorkFocus = FocusNode();
  final FocusNode _certificateNameFocus = FocusNode();
  final FocusNode _certDescFocus = FocusNode();
  final FocusNode _otherFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _whyDoYouThinkController = TextEditingController();
  final TextEditingController _describeAdventureYouWantController = TextEditingController();
  final TextEditingController _runningLocationsController = TextEditingController();
  final TextEditingController _adventuresStandOutController = TextEditingController();
  final TextEditingController _whyDoYouWantToWorkController = TextEditingController();
  final TextEditingController _certificateNameController = TextEditingController();
  final TextEditingController _certDescController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  late List<ActivityModel> activities;
  bool _isLoading = true;
  bool hasBecomeGuideRequestDat = false;
  bool _isApproved = false;
  File? image1;
  File? image2;
  File? image3;
  int count = 0;
  int _uploadCount = 0;

  @override
  void initState() {
    _firstNameController.text = firstName!;
    _lastNameController.text = lastName!;
    _emailController.text = email!;
    _phoneNoController.text = phoneNo!;
    getBecomeAGuideRequest();
    super.initState();
    setState(() {
      _isLoading = true;
    });
  }

  Future<void> getAllBadges() async {
    setState(() => _isLoading = true);
    final List<ActivityModel> badgeData = await APIServices().getAllBadgesInBecomeAguide();
    setState((){
      activities = badgeData;
      _isLoading = false;
    });
  }

  Future<void> getBecomeAGuideRequest() async {
    setState(() => _isLoading = true);
    final BecomeAGudeModel res = await APIServices().getBecomeAGuideRequest();
    print('become a guide response $res');

    if (res.userId != '' || res.userId != null) {
      setState(() {
        hasBecomeGuideRequestDat = true;
        _isApproved = res.isApproved! as bool;
      });
    } else {
      setState(() {
        hasBecomeGuideRequestDat = false;
      });
    }

    if(hasBecomeGuideRequestDat == false || _isApproved == false) {
      await getAllBadges();
    }

    setState(() => _isLoading = false);
  }

  // Format File Size
  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const List<String> suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    int i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  static List<ActivityModel> data = [
    ActivityModel(
      name: 'Camping',
      imageUrl: 'assets/images/badge-Camping.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Hiking',
      imageUrl: 'assets/images/badge-Hiking.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Hunt',
      imageUrl: 'assets/images/badge-Hunt.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Fishing',
      imageUrl: 'assets/images/badge-Fishing.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Eco Tour',
      imageUrl: 'assets/images/badge-Eco.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Paddle Spot',
      imageUrl: 'assets/images/badge-PaddleSpot.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Discovery',
      imageUrl: 'assets/images/badge-Discovery.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Retreat',
      imageUrl: 'assets/images/badge-Retreat.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Motor',
      imageUrl: 'assets/images/badge-Motor.png',
      isChecked: false
    ),
  ];

  // List of items in our dropdown menu
  List<String> items = [
    'Facebook',
    'LinkedIn',
    'Google',
    'Ads',
    'Youtube',
    'Indeed',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/svg/arrow_back_with_tail.svg',
                height: 29, width: 34.w),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              child: Column(
                children: (hasBecomeGuideRequestDat == false && _isLoading == false) ? <Widget> [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppTextConstants.becomeAGuide,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  subTitleWidget(AppTextConstants.basicInfo),
                  textInputWidget('fname', 'First name', _firstNameController, false, _firstNameFocus),
                  textInputWidget('lname', 'Last name', _lastNameController, false, _lastNameFocus),
                  textInputWidget('email', 'Email', _emailController, false, _emailFocus),
                  textInputWidget('number', 'Number', _phoneNoController, false, _phoneNoFocus),
                  textInputWidget('province', 'Province', _provinceController, true, _provinceFocus),
                  textInputWidget('city', 'City', _cityController, true, _cityFocus),
                  subTitleWidget('Activities'),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: _isLoading == false ? ListView.builder(
                        itemCount: activities.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext ctx, int index) {
                          if (index == 7) {
                            return Column(
                              children: <Widget> [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 7.h, 0, 7.h),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: const Color(0xffCCFFD5),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(15.h),
                                          child: const Text(
                                            'Discovery Badge will let you host unique activities, tours, or adventures. The possibilities are endless!',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Color(0xff066028),
                                              height: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
                                    child: OutlinedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.fromLTRB(13.h, 16.h, 16.h, 16.h)),
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                              AppColors.white),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          )),
                                          side: MaterialStateProperty.all(BorderSide(color: activities[index].isChecked == true ? AppColors.deepGreen : AppColors.grey, width: activities[index].isChecked == true ? 1.0 : 0.4.w, style: BorderStyle.solid))
                                      ),
                                      child: Row(
                                        children: <Widget> [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Visibility(
                                              visible: true,
                                              // child: Image.asset(activities[index].imageUrl,
                                              //         height: 55.h,
                                              //         width: 55.w,
                                              //     ),
                                              child: Image.memory(
                                                base64.decode(activities[index].imageUrl.split(',').last),
                                                gaplessPlayback: true,
                                                width: 60,
                                                height: 60,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 25.w),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(activities[index].name,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black
                                                ),
                                                textAlign: TextAlign.left
                                            ),
                                          ),
                                          const Spacer(),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              child: Visibility(
                                                visible: activities[index].isChecked == true ? true : false,
                                                child: SvgPicture.asset('assets/images/svg/check_green_circle.svg',
                                                    height: 60.h, width: 60.w),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          activities[index].isChecked = !activities[index].isChecked;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
                            child: OutlinedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.fromLTRB(13.h, 16.h, 16.h, 16.h)),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      AppColors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                                  side: MaterialStateProperty.all(BorderSide(color: activities[index].isChecked == true ? AppColors.deepGreen : AppColors.grey, width: activities[index].isChecked == true ? 1.0 : 0.4.w, style: BorderStyle.solid))
                              ),
                              child: Row(
                                children: <Widget> [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Visibility(
                                      visible: true,
                                      // child: Image.asset(activities[index].imageUrl,
                                      //         height: 55.h,
                                      //         width: 55.w,
                                      //     ),
                                      child: activities[index].name == 'Discovery' ? Image.asset('assets/images/badge-Discovery.png',
                                        height: 55.h,
                                        width: 55.w,
                                      ) : Image.memory(
                                        base64.decode(activities[index].imageUrl.split(',').last),
                                        gaplessPlayback: true,
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 25.w),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(activities[index].name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black
                                        ),
                                        textAlign: TextAlign.left
                                    ),
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Visibility(
                                        visible: activities[index].isChecked == true ? true : false,
                                        child: SvgPicture.asset('assets/images/svg/check_green_circle.svg',
                                            height: 60.h, width: 60.w),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: (){
                                setState(() {
                                  activities[index].isChecked = !activities[index].isChecked;
                                });
                              },
                            ),
                          );
                        }) : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: CircularProgressIndicator(),
                        )
                      ],
                    ),
                  ),
                  subTitleWidget('Tell us a bit about yourself'),
                  descriptionWidget('Why do you think you will be a good Guide ?'),
                  textInputWidget('normal', '', _whyDoYouThinkController, true, _whyDoYouThinkFocus),
                  descriptionWidget('Briefly describe the Adventures you want to host.'),
                  textInputWidget('message', '', _describeAdventureYouWantController, true, _describeAdventureYouWantFocus),
                  descriptionWidget('What locations will you be running your Adventures?'),
                  textInputWidget('normal', '', _runningLocationsController, true, _runningLocationsFocus),
                  descriptionWidget('What will make your Adventures stand-out?'),
                  textInputWidget('normal', '', _adventuresStandOutController, true, _adventuresStandOutFocus),
                  descriptionWidget('Why do you want to work with Guided?'),
                  textInputWidget('message', '', _whyDoYouWantToWorkController, true, _whyDoYouWantToWorkFocus),
                  descriptionWidget('How did you hear about us?'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 7.h, 0, 7.h),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.4.w,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(25.h, 10.h, 10.h, 10.h),
                            child: DropdownButton(
                              underline: SizedBox(),
                              isExpanded: true,
                              value: dropdownValue,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  descriptionWidget("If you selected 'Individual' or 'Other' please let us know who referred you:"),
                  textInputWidget('normal', '', _otherController, true, _otherFocus),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
                        child: Row(
                          children: <Widget> [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                  value: _firstAid,
                                  activeColor: const Color(0xff4CD964),
                                  onChanged: (bool value) {
                                    setState(() {
                                      _firstAid = value;
                                    });
                                  }
                              ),
                            ),
                            SizedBox(width: 25.w),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('First Aid',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff979B9B)
                                  ),
                                  textAlign: TextAlign.left
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  textInputWidget('normal', 'Certificate Name', _certificateNameController, true, _certificateNameFocus),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget> [
                            InkWell(
                              onTap: () {
                                showMaterialModalBottomSheet(
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
                                                      final XFile? image1 = await ImagePicker()
                                                          .pickImage(
                                                          source: ImageSource.camera,
                                                          imageQuality: 25);

                                                      if (image1 == null) {
                                                        return;
                                                      }
                                                      final File imageTemporary = File(image1.path);
                                                      String file;
                                                      int fileSize;
                                                      file = getFileSizeString(
                                                          bytes: imageTemporary.lengthSync());
                                                      fileSize = int.parse(
                                                          file.substring(0, file.indexOf('K')));
                                                      if (fileSize >= 100) {
                                                        AdvanceSnackBar(
                                                            message: ErrorMessageConstants
                                                                .imageFileToSize)
                                                            .show(context);
                                                        Navigator.pop(context);
                                                        return;
                                                      }
                                                      setState(() {
                                                        this.image1 = imageTemporary;
                                                        _uploadCount += 1;
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
                                                      final XFile? image1 = await ImagePicker()
                                                          .pickImage(
                                                          source: ImageSource.gallery,
                                                          imageQuality: 10);

                                                      if (image1 == null) {
                                                        return;
                                                      }

                                                      final File imageTemporary = File(image1.path);
                                                      String file;
                                                      int fileSize;
                                                      file = getFileSizeString(
                                                          bytes: imageTemporary.lengthSync());
                                                      fileSize = int.parse(
                                                          file.substring(0, file.indexOf('K')));
                                                      if (fileSize >= 100) {
                                                        AdvanceSnackBar(
                                                            message: ErrorMessageConstants
                                                                .imageFileToSize)
                                                            .show(context);
                                                        Navigator.pop(context);
                                                        return;
                                                      }
                                                      setState(() {
                                                        this.image1 = imageTemporary;
                                                        _uploadCount += 1;
                                                      });
                                                    } on PlatformException catch (e) {
                                                      print('Failed to pick image: $e');
                                                    }
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          ),
                                        )));
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: image1 != null ? Image.file(
                                    image1!,
                                    width: 100.w,
                                    height: 100.h
                                ) : Image.asset('assets/images/uploadPhoto.png',
                                  height: 100.h,
                                  width: 100.w,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showMaterialModalBottomSheet(
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
                                                      final XFile? image2 = await ImagePicker()
                                                          .pickImage(
                                                          source: ImageSource.camera,
                                                          imageQuality: 25);

                                                      if (image2 == null) {
                                                        return;
                                                      }
                                                      final File imageTemporary = File(image2.path);
                                                      String file;
                                                      int fileSize;
                                                      file = getFileSizeString(
                                                          bytes: imageTemporary.lengthSync());
                                                      fileSize = int.parse(
                                                          file.substring(0, file.indexOf('K')));
                                                      if (fileSize >= 100) {
                                                        AdvanceSnackBar(
                                                            message: ErrorMessageConstants
                                                                .imageFileToSize)
                                                            .show(context);
                                                        Navigator.pop(context);
                                                        return;
                                                      }
                                                      setState(() {
                                                        this.image2 = imageTemporary;
                                                        _uploadCount += 1;
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
                                                      final XFile? image2 = await ImagePicker()
                                                          .pickImage(
                                                          source: ImageSource.gallery,
                                                          imageQuality: 10);

                                                      if (image2 == null) {
                                                        return;
                                                      }

                                                      final File imageTemporary = File(image2.path);
                                                      String file;
                                                      int fileSize;
                                                      file = getFileSizeString(
                                                          bytes: imageTemporary.lengthSync());
                                                      fileSize = int.parse(
                                                          file.substring(0, file.indexOf('K')));
                                                      if (fileSize >= 100) {
                                                        AdvanceSnackBar(
                                                            message: ErrorMessageConstants
                                                                .imageFileToSize)
                                                            .show(context);
                                                        Navigator.pop(context);
                                                        return;
                                                      }
                                                      setState(() {
                                                        this.image2 = imageTemporary;
                                                        _uploadCount += 1;
                                                      });
                                                    } on PlatformException catch (e) {
                                                      print('Failed to pick image: $e');
                                                    }
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          ),
                                        )));
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: image2 != null ? Image.file(
                                    image2!,
                                    width: 100.w,
                                    height: 100.h
                                ) : Image.asset('assets/images/uploadPhoto.png',
                                  height: 100.h,
                                  width: 100.w,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showMaterialModalBottomSheet(
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
                                                      final XFile? image3 = await ImagePicker()
                                                          .pickImage(
                                                          source: ImageSource.camera,
                                                          imageQuality: 25);

                                                      if (image3 == null) {
                                                        return;
                                                      }
                                                      final File imageTemporary = File(image3.path);
                                                      String file;
                                                      int fileSize;
                                                      file = getFileSizeString(
                                                          bytes: imageTemporary.lengthSync());
                                                      fileSize = int.parse(
                                                          file.substring(0, file.indexOf('K')));
                                                      if (fileSize >= 100) {
                                                        AdvanceSnackBar(
                                                            message: ErrorMessageConstants
                                                                .imageFileToSize)
                                                            .show(context);
                                                        Navigator.pop(context);
                                                        return;
                                                      }
                                                      setState(() {
                                                        this.image3 = imageTemporary;
                                                        _uploadCount += 1;
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
                                                      final XFile? image3 = await ImagePicker()
                                                          .pickImage(
                                                          source: ImageSource.gallery,
                                                          imageQuality: 10);

                                                      if (image3 == null) {
                                                        return;
                                                      }

                                                      final File imageTemporary = File(image3.path);
                                                      String file;
                                                      int fileSize;
                                                      file = getFileSizeString(
                                                          bytes: imageTemporary.lengthSync());
                                                      fileSize = int.parse(
                                                          file.substring(0, file.indexOf('K')));
                                                      if (fileSize >= 100) {
                                                        AdvanceSnackBar(
                                                            message: ErrorMessageConstants
                                                                .imageFileToSize)
                                                            .show(context);
                                                        Navigator.pop(context);
                                                        return;
                                                      }
                                                      setState(() {
                                                        this.image3 = imageTemporary;
                                                        _uploadCount += 1;
                                                      });
                                                    } on PlatformException catch (e) {
                                                      print('Failed to pick image: $e');
                                                    }
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          ),
                                        )));
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: image3 != null ? Image.file(
                                    image3!,
                                    width: 100.w,
                                    height: 100.h
                                ) : Image.asset('assets/images/uploadPhoto.png',
                                  height: 100.h,
                                  width: 100.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 15.h, 0, 0),
                        child: const Text(
                          'Minimum 3 images should be uploaded',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffADB1B1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  descriptionWidget('Description'),
                  textInputWidget('message', '', _certDescController, true, _certDescFocus),
                  SizedBox(
                    width: double.maxFinite, // set width to maxFinite
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 60.h, 0, 25.h),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.spruce),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ))),
                        child: const Text('Apply',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () async {
                          print('_firstNameController $_firstNameController');
                          print('_lastNameController $_lastNameController');
                          print('_emailController $_emailController');
                          print('_phoneNoController $_phoneNoController');
                          print('_provinceController $_provinceController');
                          print('_cityController $_cityController');
                          print('_whyDoYouThinkController $_whyDoYouThinkController');
                          print('_describeAdventureYouWantController $_describeAdventureYouWantController');
                          print('_runningLocationsController $_runningLocationsController');
                          print('_adventuresStandOutController $_adventuresStandOutController');
                          print('_whyDoYouWantToWorkController $_whyDoYouWantToWorkController');
                          print('_certificateNameController $_certificateNameController');
                          print('_certDescController $_certDescController');
                          print('_otherController $_otherController');
                          print('is first aid $_firstAid');
                          print('image1: $image1--- image2 $image2 ----- image3: $image3}');
                          print('BASE64 image 1 ${saveImage(image1!)}');
                          saveImage(image1!).then((String value) => print('base64image $value'));
                          if (_firstNameController.text.isNotEmpty &&
                              _lastNameController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _phoneNoController.text.isNotEmpty &&
                              _provinceController.text.isNotEmpty &&
                              _cityController.text.isNotEmpty &&
                              _whyDoYouThinkController.text.isNotEmpty &&
                              _describeAdventureYouWantController.text.isNotEmpty &&
                              _runningLocationsController.text.isNotEmpty &&
                              _adventuresStandOutController.text.isNotEmpty &&
                              _whyDoYouWantToWorkController.text.isNotEmpty &&
                              _certificateNameController.text.isNotEmpty &&
                              _certDescController.text.isNotEmpty &&
                              (_otherController.text.isNotEmpty || dropdownValue.isNotEmpty) &&
                              image1 != null && image2 != null && image3 != null
                          ) {
                            print('PWEDE NA CREATE SA BECOME A GUIDE');
                            final String? userId = UserSingleton.instance.user.user?.id;
                            final Map<String, dynamic> data = {
                              'user_id': userId,
                              'first_name': _firstNameController.text,
                              'last_name': _lastNameController.text,
                              'email': _emailController.text,
                              'phone_no': _phoneNoController.text,
                              'activities': 'badge1, badge,2 ,badge3',
                              'province': _provinceController.text,
                              'city': _cityController.text,
                              'good_guide_reason': _whyDoYouThinkController.text,
                              'adventures_to_host': _describeAdventureYouWantController.text,
                              'adventure_location': _runningLocationsController.text,
                              'standout_reason': _adventuresStandOutController.text,
                              'guided_reason': _whyDoYouWantToWorkController.text,
                              'where_did_you_hear_us': dropdownValue == 'other' ? _otherController.text : dropdownValue.toString(),
                              'where_did_you_hear_us_reason': dropdownValue == 'other' ? _otherController.text : dropdownValue.toString(),
                              'is_first_aid': _firstAid,
                              'certificate_name': _certificateNameController.text,
                              // 'image_firebase_url': '${saveImage(image1!).then((String value) => value).toString()}, ${saveImage(image2!).then((String value) => value).toString()}, ${saveImage(image3!).then((String value) => value).toString()}',
                              'image_firebase_url': 'image_firebase_url'
                            };
                            final dynamic response  = await APIServices().request('api/v1/user-guide-request/', RequestType.POST,
                                needAccessToken: true, data: data);
                            print('tata response $response');
                          } else {
                            print('NAAY KUWANG NGA FIELD');
                          }
                        },
                      ),
                    ),
                  )
                ] : <Widget> [
                  if (_isApproved == false) Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppTextConstants.becomeAGuide,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Text('Pending request')
                      )
                    ],
                  )
                  else
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppTextConstants.becomeAGuide,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const Text('Request approved')
                      ],
                    )
                ],
              ),
            ),
          ),
        ));
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FlutterSecureStorage>('storage', storage));
    properties.add(StringProperty('dropdownValue', dropdownValue));
    properties.add(IterableProperty<String>('items', items));
    properties.add(IterableProperty<ActivityModel>('activities', activities));
    properties.add(DiagnosticsProperty<File?>('image1', image1));
    properties.add(IntProperty('count', count));
    properties.add(DiagnosticsProperty<File?>('image2', image2));
    properties.add(DiagnosticsProperty<File?>('image3', image3));
    properties.add(DiagnosticsProperty<bool>('hasBecomeGuideRequestDat', hasBecomeGuideRequestDat));
  }

  Future<String> saveImage(File image) async {
    final Future<Uint8List> image1Bytes = File(image.path).readAsBytes();
    final String base64Image = base64Encode(await image1Bytes);
    return base64Image;
  }
}

Widget descriptionWidget(desc) {
  return Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 30.h, 0, 20.h),
            child: Text(desc,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xffADB1B1),
                ),
            ),
        ),
    ),
  );
}


Widget subTitleWidget(subTitle) {
  return Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 25.h, 0, 0),
            child: Text(subTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                ),
            ),
        ),
    ),
  );
}

Widget textInputWidget(type, placeholder, controller, enabled, focusNode) {
  if (type == 'message') {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: TextField(
              controller: controller,
              focusNode: focusNode,
              minLines:
                  6, // any number you need (It works as the rows for the textarea)
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.4.w),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.4.w),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  hintText: placeholder),
            )
          ),
      ),
    );
  }
  return Align(
    alignment: Alignment.centerLeft,
      child: SizedBox(
      // width: double.maxFinite, // set width to maxFinite
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
        child: TextField(
          enabled: enabled,
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide:
                    BorderSide(color: Colors.grey, width: 0.4.w),
            ),
          ),
        ),
      ),
    ),
  );
}