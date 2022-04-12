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
import 'package:guided/utils/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Screen for settings contact us
class SettingsAvailability extends StatefulWidget {
  /// Constructor
  const SettingsAvailability({Key? key}) : super(key: key);

  @override
  _SettingsAvailability createState() => _SettingsAvailability();
}

class _SettingsAvailability extends State<SettingsAvailability> {
  bool _isActive = true;

  final TextEditingController _message = TextEditingController();
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
                      AppTextConstants.availability,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: SizedBox(
                      // width: double.maxFinite, // set width to maxFinite
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 25.h, 0, 25.h),
                        child: OutlinedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.dirtyWhite),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          child: Row(
                            children: <Widget> [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(_isActive ? 'Set yourself as unavailable' : 'Set yourself as available',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black
                                  ),
                                  textAlign: TextAlign.left
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Switch(
                                  value: _isActive,
                                  activeColor: Color(0xFF00C853),
                                  onChanged: (bool value) {
                                    setState(() {
                                      _isActive = value;
                                    });
                                  }
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    ),
                  ),
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
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        hintText: AppTextConstants.why),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: SizedBox(
                      // width: double.maxFinite, // set width to maxFinite
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 25.h, 0, 25.h),
                        child: OutlinedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.dirtyWhite),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          child: Row(
                            children: <Widget> [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(AppTextConstants.returnDate,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Visibility(
                                  visible: true,
                                  child: Text('20 June 2021',
                                  style: TextStyle(
                                    fontSize: 16,
                                    // fontWeight: FontWeight.w700,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.right
                                ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
} 