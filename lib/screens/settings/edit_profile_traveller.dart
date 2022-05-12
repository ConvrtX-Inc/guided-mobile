import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/bordered_text_field.dart';
import 'package:guided/common/widgets/country_dropdown.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/contained_tab_bar_view.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_properties.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/image_picker_bottom_sheet.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:intl/intl.dart';

///Edit Profile Traveler Screen
class EditProfileTraveler extends StatefulWidget {
  ///Constructor
  const EditProfileTraveler({Key? key}) : super(key: key);

  @override
  _EditProfileTravelerState createState() => _EditProfileTravelerState();
}

class _EditProfileTravelerState extends State<EditProfileTraveler> {
  bool isSaving = false;
  String profilePicPreview = '';
  File? _photo;
  final String _storagePath = 'profilePictures';
  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());
  PageController _pageController = PageController(initialPage: 0);

  int currentPage = 0;

  List<String> images = List.filled(6, '');
  int selectedTabIndex = 0;

  late List<CountryModel> listCountry = [];
  late CountryModel _country = CountryModel(name: 'Canada', code: 'CA');
  bool isPhoneValid = false;
  TextEditingController phoneController = TextEditingController();

  String _dialCode = '+1';

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePasswordController = TextEditingController();
  TextEditingController _aboutMeController = TextEditingController();
  TextEditingController _addressLine1Controller = TextEditingController();
  TextEditingController _addressLine2Controller = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  String profilePicture = '';

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    getCountries();

    _aboutMeController = TextEditingController(
        text: _profileDetailsController.userProfileDetails.about);
    _fullNameController = TextEditingController(
        text: _profileDetailsController.userProfileDetails.fullName);

    _emailController = TextEditingController(
        text: _profileDetailsController.userProfileDetails.email);
    profilePicture =
        _profileDetailsController.userProfileDetails.firebaseProfilePicUrl;

    _dialCode = _profileDetailsController.userProfileDetails.countryCode;

    phoneController = TextEditingController(
        text: _profileDetailsController.userProfileDetails.phoneNumber);

    _addressLine1Controller = TextEditingController(
        text: _profileDetailsController.userProfileDetails.addressLine1);
    _addressLine2Controller = TextEditingController(
        text: _profileDetailsController.userProfileDetails.addressLine2);
    if(_profileDetailsController.userProfileDetails.birthDate.isNotEmpty){
      _selectedDate = DateTime.parse(_profileDetailsController.userProfileDetails.birthDate);
    }
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
        title: Text(AppTextConstants.editProfile,
            style: TextStyle(
                fontSize: 24.sp,
                fontFamily: 'GilroyBold',
                color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: buildEditProfileUI(),
      backgroundColor: Colors.white,
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
      //   child: CustomRoundedButton(
      //     title: AppTextConstants.save,
      //     isLoading: isSaving,
      //     onpressed: () {},
      //   ),
      // ),
    );
  }

  Widget buildEditProfileUI() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: buildProfilePicture(),
          ),
          Expanded(
              child: ContainedTabBarView(
            showBorder: false /**/,
            tabs: <Widget>[
              Text('Account',
                  style: selectedTabIndex == 0
                      ? const TextStyle(fontWeight: FontWeight.w700)
                      : null),
              Text(
                AppTextConstants.aboutMe,
                style: selectedTabIndex == 1
                    ? TextStyle(
                        color: AppColors.mediumGreen,
                        fontWeight: FontWeight.w700)
                    : null,
              ),
            ],
            tabBarProperties: TabBarProperties(
              height: 42,
              indicatorColor: AppColors.deepGreen,
              indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(width: 2.w, color: AppColors.deepGreen),
                  insets: EdgeInsets.symmetric(horizontal: 18.w)),
              indicatorWeight: 1,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            ),
            views: <Widget>[buildEditAccount(), buildAboutMe()],
          ))
        ],
      );

  Widget buildProfilePicture() => Container(
      margin: EdgeInsets.only(top: 45.h, bottom: 35.h),
      child: Stack(
        children: <Widget>[
          Container(
            width: 130.w,
            height: 130.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 3, color: Colors.grey)
              ],
            ),
            child: profilePicPreview.isEmpty
                ? profilePicture.isNotEmpty
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        backgroundImage: ExtendedImage.network(
                          profilePicture,
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
              bottom: 4,
              right: 6,
              child: Container(
                  width: 40,
                  height: 40,
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
                      child: SvgPicture.asset(
                          '${AssetsPath.assetsSVGPath}/upload_camera.svg')))),
        ],
      ));

  Widget buildEditAccount() => Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.h),
              BorderedTextField(
                  controller: _emailController,
                  labelText: AppTextConstants.email,
                  hintText: AppTextConstants.email),
              SizedBox(height: 16.h),
              BorderedTextField(
                  labelText: AppTextConstants.password,
                  hintText: AppTextConstants.password),
              SizedBox(height: 16.h),
              BorderedTextField(
                  labelText: 'Re-Type Password', hintText: 'Re-Type Password'),
              SizedBox(height: 26.h),
              CustomRoundedButton(
                title: AppTextConstants.save,
                isLoading: isSaving,
                onpressed: () {},
              ),
            ],
          ),
        ),
      );

  Widget buildAboutMe() => Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.h),
              BorderedTextField(
                  controller: _fullNameController,
                  labelText: AppTextConstants.fullName,
                  hintText: AppTextConstants.fullName),
              SizedBox(height: 16.h),
              BorderedTextField(
                  controller: _aboutMeController,
                  labelText: AppTextConstants.aboutMe,
                  minLines: 6,
                  hintText: AppTextConstants.aboutMe),
              SizedBox(height: 16.h),
              BorderedTextField(
                  controller: _addressLine1Controller,
                  labelText: AppTextConstants.addressLine1,
                  hintText: AppTextConstants.addressLine1),
              SizedBox(height: 16.h),
              BorderedTextField(
                  controller: _addressLine2Controller,
                  labelText: AppTextConstants.addressLine2,
                  hintText: AppTextConstants.addressLine2),
              SizedBox(height: 16.h),
              DropDownCountry(
                fontSize: 16.sp,
                value: _country,
                setCountry: setCountry,
                list: listCountry,
              ),
              SizedBox(height: 16.h),
              Text(AppTextConstants.birthDate),
              SizedBox(height: 16.h),
              GestureDetector(
                  onTap: () => _showDate(context),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            width: 1.w, color: Colors.grey.withOpacity(0.7))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: <Widget>[
                          Text(DateFormat("MM-dd-yyy").format(_selectedDate)),
                          const Spacer(),
                          const Icon(
                            Icons.date_range,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  )),
              SizedBox(height: 16.h),
              Text('Phone Number'),
              SizedBox(height: 10.h),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: AppTextConstants.phoneNumberHint,
                  prefixIcon: SizedBox(
                    child: CountryCodePicker(
                      onChanged: _onCountryChange,
                      initialSelection: AppTextConstants.defaultCountry,
                      favorite: ['+1', 'US'],
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: AppColors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(color: Colors.grey, width: 0.2.w),
                  ),
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              CustomRoundedButton(
                title: AppTextConstants.save,
                isLoading: isSaving,
                onpressed: updateProfile,
              ),
            ],
          ),
        ),
      );

  Future<void> handleImagePicked(image) async {
    final Future<Uint8List> imageBytes = File(image.path).readAsBytes();
    debugPrint('Image Path: $image');

    final String base64String = base64Encode(await imageBytes);
    // setState(() {
    //   _photo = image;
    //   profilePicPreview = base64String;
    // });

    String profileUrl = '';
    if (image != null) {
      profileUrl =
          await FirebaseServices().uploadImageToFirebase(image, _storagePath);
    }

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
        profilePicture = profileUrl;
      });
    }
  }

  Future<void> updateProfile() async {
    setState(() {
      isSaving = !isSaving;
    });
    final dynamic editProfileParams = {
      'about': _aboutMeController.text,
      'address_line1': _addressLine1Controller.text,
      'address_line2': _addressLine2Controller.text,
      'country': _country.name,
      'full_name': _fullNameController.text,
      'phone_no': phoneController.text,
      'birth_date': _selectedDate.toString()
    };

    final APIStandardReturnFormat res =
        await APIServices().updateProfile(editProfileParams);
    debugPrint('Response:: update about me ${_aboutMeController.text}');

    if (res.status == 'success') {
      final ProfileDetailsModel updatedProfile =
          ProfileDetailsModel.fromJson(json.decode(res.successResponse));
      _profileDetailsController.setUserProfileDetails(updatedProfile);
      setState(() {
        isSaving = false;
      });
    }
  }

  Future<void> getCountries() async {
    final String response =
        await rootBundle.loadString('assets/currencies.json');
    final data = await json.decode(response);

    for (dynamic res in data) {
      listCountry.add(
          CountryModel(code: res['countryCode'], name: res['countryName']));
    }

    setState(() {
      _country = _profileDetailsController.userProfileDetails.country != ''
          ? listCountry.firstWhere((element) =>
              element.name ==
              _profileDetailsController.userProfileDetails.country)
          : listCountry[0];
    });
  }

  void setCountry(dynamic value) {
    debugPrint('Value $value');
    setState(() {
      _country = value;
    });
  }

  Future<void> _showDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.green,
            splashColor: AppColors.primaryGreen,
          ),
          child: child ?? const Text(''),
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      final String formattedDate =
          '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      setState(() {
        _selectedDate = picked;
        // _date.value = TextEditingValue(text: formattedDate.toString());
      });
    }
  }

  /// Country code
  void _onCountryChange(CountryCode countryCode) =>
      _dialCode = countryCode.dialCode.toString();
}
