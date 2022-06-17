import 'dart:convert';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/error_dialog.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

///Update Phone Number Screen
class UpdatePhoneNumber extends StatefulWidget {
  ///Constructor
  const UpdatePhoneNumber({Key? key}) : super(key: key);

  @override
  _UpdatePhoneNumberState createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());
  String _dialCode = '+1';
  String phoneNumber = '';
  bool isSaving = false;

  TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _updatePhoneFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _dialCode = _profileDetailsController.userProfileDetails.countryCode;

    _phoneController = TextEditingController(
        text: _profileDetailsController.userProfileDetails.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Form(
          key: _updatePhoneFormKey,
          child: SafeArea(
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Change Phone Number',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        IntlPhoneField(
                          initialValue:
                              '+$_dialCode${_profileDetailsController.userProfileDetails.phoneNumber}',

                          controller: _phoneController,
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
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.2.w),
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
                      ],
                    )),
                    CustomRoundedButton(
                        isLoading: isSaving,
                        title: 'Update',
                        onpressed: _phoneController.text !=
                            _profileDetailsController.userProfileDetails.phoneNumber ? () {
                          final FormState? form =
                              _updatePhoneFormKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            updatePhoneNumber();
                          }
                        } : null),
                    SizedBox(height: 20.h)
                  ],
                ),
              ),
            ),
          )),
      // bottomNavigationBar:,
    );
  }

  Future<void> updatePhoneNumber() async {
    final dynamic editProfileParams = {'country_code': _dialCode};

    setState(() {
      isSaving = true;
    });

    if (_dialCode != _profileDetailsController.userProfileDetails.countryCode &&
        phoneNumber !=
            _profileDetailsController.userProfileDetails.phoneNumber) {
      editProfileParams['phone_no'] = _phoneController.text;
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

      const AdvanceSnackBar(
              bgColor: Colors.green,
              message: 'Mobile Number Updated Successfully!')
          .show(context);
    } else {
      final errors = jsonDecode(res.errorResponse);
      debugPrint('Error Response ${res.errorResponse}');
      if (errors['errors']['phone_no'] != '') {
        ErrorDialog().showErrorDialog(
            context: context,
            title: 'Unable to update phone number',
            message: errors['errors']['phone_no']);
      }
      setState(() {
        isSaving = false;
      });
    }
  }
}
