import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/main_navigation/settings/screens//settings_contact_us.dart';
import 'package:guided/main_navigation/settings/screens/calendar_management/settings_calendar_management.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart';

/// Widgets for displaying list of user settings
class SettingsItems extends StatelessWidget {
  /// Constructor
  const SettingsItems(
      {String keyName = '', String imgUrl = '', String name = '', Key? key})
      : _keyName = keyName,
        _imgUrl = imgUrl,
        _name = name,
        super(key: key);

  final String _keyName;
  final String _imgUrl;
  final String _name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        switch (_keyName) {
          case 'contact_us':
            Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const SettingsContactUs()),
            );
            break;
          case 'schedule':
            showAvatarModalBottomSheet(
              expand: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => SettingsCalendarManagement(),
            );
            break;
        }
      },
      leading: SvgPicture.asset(_imgUrl),
      title: Text(
        _name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      trailing: const Icon(
        Icons.navigate_next,
        size: 36,
        color: Colors.black,
      ),
    );
  }
}
