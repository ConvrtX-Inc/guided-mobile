import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
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
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_view_properties.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_input_formatter.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/error_dialog.dart';
import 'package:guided/screens/widgets/reusable_widgets/image_picker_bottom_sheet.dart';
import 'package:guided/utils/mixins/validator_mixin.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

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
  final String _storagePath = 'profilePictures';
  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());

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

  DateTime? _selectedDate;

  String phoneNumber = '';
  final GlobalKey<FormState> _updateAccountFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _updateAboutMeFormKey = GlobalKey<FormState>();

  final List<String> tabs = <String>['Account', 'About Me'];

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
    if (_profileDetailsController.userProfileDetails.birthDate.isNotEmpty) {
      _selectedDate = DateTime.parse(
          _profileDetailsController.userProfileDetails.birthDate);
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
      resizeToAvoidBottomInset: true,
      body: buildEditProfileUI(),
      backgroundColor: Colors.white,
    );
  }

  Widget buildEditProfileUI() => ListView(
        children: <Widget>[
          Center(
            child: buildProfilePicture(),
          ),
          buildTabs(),
          if (selectedTabIndex == 0)
            GestureDetector(
                onPanUpdate: (details) {
                  // Swiping in left direction.
                  if (details.delta.dx < 0) {
                    setState(() {
                      selectedTabIndex = 1;
                    });
                  }
                },
                child: buildEditAccount())
          else
            GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx > 0) {
                    setState(() {
                      selectedTabIndex = 0;
                    });
                  }
                },
                child: buildAboutMe())
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
        child: Form(
          key: _updateAccountFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.h),
              BorderedTextField(
                  isEnabled: false,
                  controller: _emailController,
                  onValidate: (String val) {
                    if (!GlobalValidator().validEmail(val.trim())) {
                      return ErrorMessageConstants.emailInvalidorEmpty;
                    }
                    return null;
                  },
                  labelText: AppTextConstants.email,
                  hintText: AppTextConstants.email),
              SizedBox(height: 16.h),
              BorderedTextField(
                  isPassword: true,
                  maxLines: 1,
                  controller: _passwordController,
                  onValidate: (String val) {
                    if (val.trim().length < 6 && val.trim().isNotEmpty) {
                      return 'Password must be at least 6 characters';
                    }
                    if (val.trim().isNotEmpty &&
                        _retypePasswordController.text.trim() != val.trim()) {
                      return ErrorMessageConstants.passwordDoesNotMatch;
                    }

                    return null;
                  },
                  labelText: AppTextConstants.password,
                  hintText: AppTextConstants.password),
              SizedBox(height: 16.h),
              BorderedTextField(
                  isPassword: true,
                  maxLines: 1,
                  controller: _retypePasswordController,
                  labelText: 'Re-Type Password',
                  hintText: 'Re-Type Password'),
              SizedBox(height: 26.h),
              CustomRoundedButton(
                title: AppTextConstants.save,
                isLoading: isSaving,
                onpressed: () {
                  final FormState? form = _updateAccountFormKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    updateEmailOrPassword();
                  }
                },
              ),
            ],
          ),
        ),
      );

  Widget buildAboutMe() => Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Form(
          key: _updateAboutMeFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 16.h),
              BorderedTextField(
                controller: _fullNameController,
                labelText: AppTextConstants.fullName,
                hintText: AppTextConstants.fullName,
                inputFormatters: [
                  AppInputFormatters.name
                ],
                onValidate: (String val) {
                  if (val.trim().isEmpty) {
                    return '${AppTextConstants.fullName} is required';
                  }

                  return null;
                },
              ),
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
                borderWidth: 0.2.w,
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
                        border: Border.all(width: 0.2.w, color: Colors.grey)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: <Widget>[
                          if (_selectedDate != null)
                            Text(
                                DateFormat('MM-dd-yyy').format(_selectedDate!)),
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
              const Text('Phone Number'),
              SizedBox(height: 10.h),
              IntlPhoneField(
                initialValue:
                    '+$_dialCode${_profileDetailsController.userProfileDetails.phoneNumber}',
                controller: phoneController,
                dropdownIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Phone number',
                  hintStyle: TextStyle(
                    color: AppColors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(color: Colors.grey, width: 0.2.w),
                  ),
                ),
                // initialCountryCode: '+$_dialCode',
                onChanged: (PhoneNumber phone) {
                  setState(() {
                    phoneNumber = phone.number;
                    debugPrint('country code ${phone.countryCode}');
                    _dialCode = phone.countryCode;
                  });
                },
              ),
              SizedBox(
                height: 26.h,
              ),
              CustomRoundedButton(
                title: AppTextConstants.save,
                isLoading: isSaving,
                onpressed: () {
                  final FormState? form = _updateAboutMeFormKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    updateProfile();
                  }
                },
              ),
              SizedBox(
                height: 26.h,
              ),
            ],
          ),
        ),
      );

  Widget buildTabs() {
    return Row(
      children: <Widget>[
        for (int i = 0; i < tabs.length; i++)
          Expanded(
              child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedTabIndex = i;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: selectedTabIndex == i
                          ? BorderSide(width: 4, color: AppColors.deepGreen)
                          : BorderSide(color: AppColors.gallery),
                    )),
                    child: Text(tabs[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: selectedTabIndex == i
                                ? AppColors.deepGreen
                                : Colors.grey.withOpacity(0.5),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700)),
                  )))
      ],
    );
  }

  Future<void> handleImagePicked(image) async {
    final Future<Uint8List> imageBytes = File(image.path).readAsBytes();

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
      'birth_date': _selectedDate.toString(),
      'country_code': _dialCode
    };

    if (_dialCode != _profileDetailsController.userProfileDetails.countryCode &&
        phoneNumber !=
            _profileDetailsController.userProfileDetails.phoneNumber) {
      editProfileParams['phone_no'] = phoneController.text;
    }

    final APIStandardReturnFormat res =
        await APIServices().updateProfile(editProfileParams);

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
          ? listCountry.firstWhere((CountryModel element) =>
              element.name ==
              _profileDetailsController.userProfileDetails.country)
          : listCountry[0];
    });
  }

  void setCountry(dynamic value) {
    setState(() {
      _country = value;
    });
  }

  Future<void> _showDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
      firstDate: DateTime(1930),
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

  Future<void> updateEmailOrPassword() async {
    /// Update email
    if (_profileDetailsController.userProfileDetails.email !=
        _emailController.text) {
      setState(() {
        isSaving = true;
      });
      final dynamic editProfileParams = {
        'email': _emailController.text,
      };

      final APIStandardReturnFormat res =
          await APIServices().updateProfile(editProfileParams);

      if (res.status == 'success') {
        final ProfileDetailsModel updatedProfile =
            ProfileDetailsModel.fromJson(json.decode(res.successResponse));
        _profileDetailsController.setUserProfileDetails(updatedProfile);
        setState(() {
          isSaving = false;
        });
      } else {
        dynamic error = jsonDecode(res.errorResponse);
        debugPrint('error ${error['errors']['email']}');
        final String message = error['errors']['email'] == 'emailAlreadyExists'
            ? ErrorMessageConstants.emailAlreadyInUse
            : 'An Error Occurred';
        ErrorDialog().showErrorDialog(
            context: context,
            title: 'Unable to Update Email',
            message: message);
      }
    }

    if (_passwordController.text != '') {
      final dynamic updatePasswordParams = {
        'password': _passwordController.text,
      };

      final APIStandardReturnFormat res =
          await APIServices().updatePassword(updatePasswordParams);
      debugPrint(
          'Response:: update password ${res.statusCode} ${res.status} ${res.errorResponse}${_passwordController.text}');

      if (res.status == 'success') {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isSaving', isSaving))
      ..add(StringProperty('profilePicPreview', profilePicPreview))
      ..add(IntProperty('selectedTabIndex', selectedTabIndex))
      ..add(IterableProperty<CountryModel>('listCountry', listCountry))
      ..add(DiagnosticsProperty<bool>('isPhoneValid', isPhoneValid))
      ..add(DiagnosticsProperty<TextEditingController>(
          'phoneController', phoneController));
  }
}
