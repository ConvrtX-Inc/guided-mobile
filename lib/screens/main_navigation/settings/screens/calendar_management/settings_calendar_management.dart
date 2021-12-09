import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/main_navigation/settings/screens/calendar_management/settings_calendar_modal.dart';


/// Settings Calendar Management
class SettingsCalendarManagement extends StatefulWidget {

  /// Constructor
  const SettingsCalendarManagement({Key? key}) : super(key: key);

  @override
  _SettingsCalendarManagementState createState() => _SettingsCalendarManagementState();
}

class _SettingsCalendarManagementState extends State<SettingsCalendarManagement> {
  @override
  Widget build(BuildContext context) {

    bool showElevatedButtonBadge = false;

    return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: Transform.scale(
              scale: 0.8,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AppColors.harp,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.black,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  style: AppTextStyle.tbStyle,
                  child: Text(
                      AppTextConstants.cancel
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(22.w, 33.h, 31.w, 60.h),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppTextConstants.findBookingDates,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gilroy'
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                // padding: const EdgeInsets.fromLTRB(22, 0, 22, 27),
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 27.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.january
                        ),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.february
                        ),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.march
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 27.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Badge(
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '2', // Will come from API
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.active,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.april
                        ),
                      ),
                    ),
                    Badge(
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '1',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.active,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.may
                        ),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.june
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 27.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.july
                        ),
                      ),
                    ),
                    Badge(
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '3',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.active,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.august
                        ),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.september
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 27.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.october
                        ),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.november
                        ),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: AppColors.tropicalRainForest,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      child: ElevatedButton(
                        style: AppTextStyle.style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(
                            AppTextConstants.december
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],),
        );
  }

  void _settingModalBottomSheet() {
    showAvatarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => const SettingsCalendarManagementModal(),
    );
  }
}