import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/main_navigation/settings/screens/settings_main.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Screen for settings contact us
class SettingsContactUs extends StatefulWidget {
  /// Constructor
  const SettingsContactUs({Key? key}) : super(key: key);

  @override
  _SettingsContactUsState createState() => _SettingsContactUsState();
}

class _SettingsContactUsState extends State<SettingsContactUs> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _message = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/svg/arrow_back_with_tail.svg',
                height: 29.h, width: 34.w),
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
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppTextConstants.contactUS,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.h, 0, 15.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(AppTextConstants.contactUsMessage,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.grey)),
                    ),
                  ),
                  TextField(
                    controller: _name,
                    focusNode: _nameFocus,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.nobel,
                            fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        filled: true,
                        hintText: 'Name',
                        contentPadding: const EdgeInsets.all(25),
                        fillColor: Colors.white70),
                  ),
                  SizedBox(height: 25.h),
                  TextField(
                    controller: _email,
                    focusNode: _emailFocus,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.nobel,
                            fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        filled: true,
                        hintText: 'Email',
                        contentPadding: const EdgeInsets.all(25),
                        fillColor: Colors.white70),
                  ),
                  SizedBox(height: 25.h),
                  TextField(
                    controller: _message,
                    focusNode: _messageFocus,
                    minLines:
                        6, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        hintText: AppTextConstants.messages),
                  ),
                  SizedBox(
                    width: double.maxFinite, // set width to maxFinite
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 25.h, 0, 25.h),
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
                        child: Text(
                          AppTextConstants.send,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () async => contactUsDetail(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> contactUsDetail() async {
    final Map<String, dynamic> contactUsDetail = {
      'name': _name.text,
      'email': _email.text,
      'message': _message.text,
    };

    if (_name.text.isEmpty || _message.text.isEmpty || _email.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.fieldMustBeFilled)
          .show(context);
    } else {
      final dynamic response = await APIServices().request(
          AppAPIPath.contactUsUrl, RequestType.POST,
          needAccessToken: true, data: contactUsDetail);

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => SettingsMain()));
    }
  }
}
