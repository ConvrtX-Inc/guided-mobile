// ignore_for_file: no_default_cases
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/settings.dart';
import 'package:guided/screens/auths/logins/screens/login_screen.dart';
import 'package:guided/screens/main_navigation/settings/widgets/settings_items.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/app_home_button.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/auth_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/settings.dart';

/// Screen for user settings
class TabSettingsMain extends StatefulWidget {
  /// Constructor
  const TabSettingsMain({Key? key}) : super(key: key);

  @override
  State<TabSettingsMain> createState() => _TabSettingsMainState();
}

class _TabSettingsMainState extends State<TabSettingsMain> {
  /// Get settings items mocked data
  final List<SettingsModel> travellersettingsItems =
      SettingsUtils.getMockedTravellerDataSettings();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppHomeButton(),
        title: Text(
          AppTextConstants.settings,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 24, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.r),
                        bottomLeft: Radius.circular(50.r)),
                    color: AppColors.aquaHaze),
                margin: EdgeInsets.only(left: 20.w, bottom: 20.h, top: 14.h),
                padding: EdgeInsets.all(6.w),
                child: buildProfileData()),
            Expanded(
              child: ListView.builder(
                  itemCount: travellersettingsItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    /*if (travellersettingsItems.length == index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60.h,
                          child: ElevatedButton(
                            onPressed: ()  =>
                              AuthServices().logout(context)
                             ,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: AppColors.silver),
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              primary: AppColors.lightRed,
                              onPrimary: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  AppTextConstants.logout,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }*/

                    return SettingsItems(
                        keyName: travellersettingsItems[index].keyName,
                        imgUrl: travellersettingsItems[index].imgUrl,
                        name: travellersettingsItems[index].name);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () => AuthServices().logout(context),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.silver),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    primary: AppColors.aquaHaze,
                    onPrimary: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.power_settings_new_rounded),
                      SizedBox(width: 10.w),
                      Text(
                        AppTextConstants.logout,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget buildProfileData() =>
      GetBuilder<UserProfileDetailsController>(builder: (_controller) {
        final ProfileDetailsModel profileData = _controller.userProfileDetails;

        return Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 3.w,
                ),
                color: Colors.white,
                shape: BoxShape.circle,
                // boxShadow: const <BoxShadow>[
                //   BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 2)
                // ],
              ),
              child: profileData.firebaseProfilePicUrl.isEmpty
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.r,
                      backgroundImage: const AssetImage(
                          '${AssetsPath.assetsPNGPath}/default_profile_pic.png'),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.r,
                      backgroundImage:
                          NetworkImage(profileData.firebaseProfilePicUrl),
                    ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                  if (profileData.fullName.isEmpty)
                    const Text('Unknown User')
                  else
                    Column(
                      children: <Widget>[
                        Text(
                          profileData.fullName,
                          style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(profileData.email,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey))
                      ],
                    )
                ])),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              iconSize: 36,
              color: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, '/edit_profile_traveler');
              },
            ),
          ],
        );
      });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<SettingsModel>(
        'travellersettingsItems', travellersettingsItems));
  }
}
