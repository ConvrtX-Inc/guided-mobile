import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';
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
class SettingsSwitchUserType extends StatefulWidget {
  /// Constructor
  const SettingsSwitchUserType({Key? key}) : super(key: key);

  @override
  _SettingsSwitchUserType createState() => _SettingsSwitchUserType();
}

class _SettingsSwitchUserType extends State<SettingsSwitchUserType> {
  bool _isTraveler = false;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkUserType();
  }

  Future<void> checkUserType() async {
     await SecureStorage.readValue(
              key: AppTextConstants.userType)
          .then((String value) async {
        if (value == 'traveller') {
          setState(() => _isTraveler = true);
        } else {
          setState(() => _isTraveler = false);
        }
      });
  }

  Future<void> _toggleUserType(userType) async {
    if (userType == 'traveller') {
      setState(() => _isTraveler = true);
      final Map<String, dynamic> details = {
        'user_type': 'traveller'
      };
      await storage.delete(key: AppTextConstants.userType);
      await SecureStorage.saveValue(
              value: 'traveller',
              key: AppTextConstants.userType)
          .then((_) {
        Navigator.of(context)
            .pushNamed('/traveller_tab', arguments: details);
      });
    } else if (userType == 'guide') {
      // setState(() => _isTraveler = false);
        final Map<String, dynamic> details = {
        'user_type': 'guide'
      };
      // await storage.delete(key: AppTextConstants.userType);
      // await SecureStorage.saveValue(
      //         key: AppTextConstants.userType, value: 'guide')
      //     .then((_) {
        await Navigator.of(context)
            .pushNamed('/become_a_guide', arguments: details);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const BackButtonWidget(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppTextConstants.switchUserType,
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
                                borderRadius: BorderRadius.circular(18),
                              ))),
                          child: Row(
                            children: <Widget> [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(AppTextConstants.switchToGuide,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: _isTraveler ? Colors.grey : Colors.black
                                  ),
                                  textAlign: TextAlign.left
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Visibility(
                                  visible: _isTraveler ? false : true,
                                  child: Icon(
                                    Icons.done,
                                    color: _isTraveler ? Colors.white : Colors.black,
                                    size: 24.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => _toggleUserType('guide'),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: SizedBox(
                      // width: double.maxFinite, // set width to maxFinite
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: OutlinedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.dirtyWhite),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ))),
                          child: Row(
                            children: <Widget> [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(AppTextConstants.switchToTraveler,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: _isTraveler ? Colors.black : Colors.grey,
                                  ),
                                  textAlign: TextAlign.left
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Visibility(
                                  visible: _isTraveler ? true : false,
                                  child: Icon(
                                    Icons.done,
                                    color: _isTraveler ? Colors.black : Colors.white,
                                    size: 24.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => _toggleUserType('traveller'),
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
