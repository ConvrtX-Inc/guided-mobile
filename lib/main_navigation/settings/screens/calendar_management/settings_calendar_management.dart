import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart';
import 'package:guided/helpers/constant.dart';
import 'settings_calendar_modal.dart';

class SettingsCalendarManagement extends StatefulWidget {
  const SettingsCalendarManagement({Key? key}) : super(key: key);

  @override
  _SettingsCalendarManagementState createState() => _SettingsCalendarManagementState();
}

class _SettingsCalendarManagementState extends State<SettingsCalendarManagement> {
  @override
  Widget build(BuildContext context) {

    /// Default button style
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        onPrimary: ConstantHelpers.lightgrey,
        side: BorderSide(width: 1.5, color: ConstantHelpers.lightgrey),
        textStyle: TextStyle( fontSize: 13, fontWeight: FontWeight.w800, fontFamily: ConstantHelpers.fontPoppins),
        fixedSize: const Size(108, 38),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    );

    /// Active button style
    final ButtonStyle active = ElevatedButton.styleFrom(
        primary: ConstantHelpers.activeDate,
        elevation: 0,
        shadowColor: Colors.transparent,
        onPrimary: Colors.black,
        side: BorderSide(width: 1.5, color: ConstantHelpers.activeDate),
        textStyle: TextStyle( fontSize: 13, fontWeight: FontWeight.w800, fontFamily: ConstantHelpers.fontPoppins),
        fixedSize: const Size(108, 38),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    );

    final ButtonStyle tbStyle = TextButton.styleFrom(
      primary: Colors.black,
      textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600, fontFamily: ConstantHelpers.fontGilroy),
    );

    bool showElevatedButtonBadge = false;

    return ScreenUtilInit(
        builder: () => Scaffold(
          appBar: AppBar(
            elevation: 0,
              leading: Transform.scale(
                scale: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: ConstantHelpers.backarrowgrey,
                      borderRadius: BorderRadius.circular(10),
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
              children: [
                TextButton(
                  style: tbStyle,
                  child: Text(ConstantHelpers.cancel),
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
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 33, 31, 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      ConstantHelpers.findBookingDates,
                      style: TextStyle( fontSize: 24, fontWeight: FontWeight.w600, fontFamily: ConstantHelpers.fontGilroy),
                    ),
                  ],
                ),
              ),
              Padding(
                // padding: const EdgeInsets.fromLTRB(22, 0, 22, 27),
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 27),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.january),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.february),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.march),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Badge(
                      showBadge: true,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '2',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: active,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.april),
                      ),
                    ),
                    Badge(
                      showBadge: true,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '1',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: active,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.may),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.june),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.july),
                      ),
                    ),
                    Badge(
                      showBadge: true,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: active,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.august),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.september),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.october),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.november),
                      ),
                    ),
                    Badge(
                      showBadge: showElevatedButtonBadge,
                      padding: const EdgeInsets.all(8),
                      badgeColor: ConstantHelpers.badgeColor,
                      badgeContent: const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: ElevatedButton(
                        style: style,
                        onPressed: _settingModalBottomSheet,
                        child: Text(ConstantHelpers.december),
                      ),
                    ),
                  ],
                ),
              ),
            ],),
        ),
    designSize: const Size(375, 812)
    );
  }

  void _settingModalBottomSheet() {
    showAvatarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SettingsCalendarManagementModal(),
    );
  }
}