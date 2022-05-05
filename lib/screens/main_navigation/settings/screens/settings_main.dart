// ignore_for_file: no_default_cases
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/profile_photos_controller.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/settings.dart';
import 'package:guided/screens/main_navigation/settings/widgets/settings_items.dart';
import 'package:guided/screens/auths/logins/screens/login_screen.dart';
import 'package:guided/screens/settings/profile_screen.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/settings.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Screen for user settings
class SettingsMain extends StatefulWidget {
  /// Constructor
  SettingsMain({Key? key}) : super(key: key);

  @override
  State<SettingsMain> createState() => _SettingsMainState();
}

class _SettingsMainState extends State<SettingsMain>
    with AutomaticKeepAliveClientMixin<SettingsMain> {
  @override
  bool get wantKeepAlive => true;
  final storage = new FlutterSecureStorage();


  /// Get settings items mocked data
  final List<SettingsModel> settingsItems =
      SettingsUtils.getMockedDataSettings();

  late Future<ProfileDetailsModel> _loadingData;

  final UserProfileDetailsController _profileDetailsController =
  Get.put(UserProfileDetailsController());

  bool isLoading = false;

  @override
  void initState() {
    // _loadingData = APIServices().getProfileData();
    super.initState();

    getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    child: SvgPicture.asset(AssetsPath.iconBell,
                        fit: BoxFit.scaleDown),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                /* child: Row(
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
                            blurRadius: 5, color: Colors.grey, spreadRadius: 2)
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.r,
                      backgroundImage: const AssetImage(
                          '${AssetsPath.assetsPNGPath}/default_profile_pic.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: FutureBuilder<ProfileDetailsModel>(
                        future: _loadingData,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          Widget _displayWidget;
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              _displayWidget = Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              );
                              break;
                            default:
                              if (snapshot.hasError) {
                                _displayWidget = Center(
                                    child: APIMessageDisplay(
                                  message: 'Result: ${snapshot.error}',
                                ));
                              } else {
                                _displayWidget =
                                    buildProfileData(snapshot.data!);
                              }
                          }
                          return _displayWidget;
                        }),
                  ),
                  IconButton(
                    icon: const Icon(Icons.navigate_next),
                    iconSize: 36,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                ],
              ),*/
                child: GetBuilder<UserProfileDetailsController>(
                    builder: (UserProfileDetailsController _controller) {
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
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.grey,
                                spreadRadius: 2)
                          ],
                        ),
                        child: _controller.userProfileDetails.firebaseProfilePicUrl.isEmpty ?  CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35.r,
                          backgroundImage: const AssetImage(
                              '${AssetsPath.assetsPNGPath}/default_profile_pic.png'),
                        ) :CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35.r,
                          backgroundImage: NetworkImage(_controller.userProfileDetails.firebaseProfilePicUrl),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                          child:
                              buildProfileData(_controller.userProfileDetails)),
                      IconButton(
                        icon: const Icon(Icons.navigate_next),
                        iconSize: 36,
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                    ],
                  );
                })),
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
                          onPressed: () async {

                            await SecureStorage.clearAll();
                            await Navigator.of(context)
                                .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
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

  Widget buildProfileData(ProfileDetailsModel profileData) => Column(
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
          ]);

  Future<void> getProfileDetails() async {
    final ProfileDetailsModel res = await APIServices().getProfileData();
    debugPrint('Profile:: ${res.id}');
    setState(() {
      isLoading = false;
    });
    _profileDetailsController.setUserProfileDetails(res);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IterableProperty<SettingsModel>('settingsItems', settingsItems));
  }
}
