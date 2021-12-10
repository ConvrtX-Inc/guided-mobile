import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/settings.dart';
import 'package:guided/screens/main_navigation/settings/widgets/settings_items.dart';
import 'package:guided/screens/auths/logins/screens/login_screen.dart';
import 'package:guided/screens/settings/profile_screen.dart';
import 'package:guided/utils/settings.dart';

/// Screen for user settings
class SettingsMain extends StatelessWidget {
  /// Constructor
  SettingsMain({Key? key}) : super(key: key);

  /// Get settings items mocked data
  final List<SettingsModel> settingsItems =
      SettingsUtils.getMockedDataSettings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.settings,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/notification');
                    },
                    child: SvgPicture.asset(
                        AssetsPath.iconBell,
                        fit: BoxFit.scaleDown),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 3.w,
                      ),
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey,
                            spreadRadius: 2
                        )
                      ],
                    ),
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35.r,
                        backgroundImage: const NetworkImage(
                            'https://www.vhv.rs/dpng/d/164-1645859_selfie-clipart-groucho-glass-good-profile-hd-png.png')),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Ethan Hunt', // Will change based on the API
                          style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        Text('ethan@gmail.com', // Will change based on the API
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.navigate_next),
                    iconSize: 36,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const ProfileScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: AppColors.platinum,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: settingsItems.length + 1,
                  itemBuilder: (BuildContext ctx, int index) {
                    if (settingsItems.length == index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.lightRed),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      side: const BorderSide(
                                          color: Colors.red)))),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      const LoginScreen(),
                                ));
                          },
                        ),
                      );
                    }

                    return SettingsItems(
                        keyName: settingsItems[index].keyName,
                        imgUrl: settingsItems[index].imgUrl,
                        name: settingsItems[index].name);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IterableProperty<SettingsModel>('settingsItems', settingsItems));
  }
}
