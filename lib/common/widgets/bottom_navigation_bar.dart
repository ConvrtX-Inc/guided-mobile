import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/constants/asset_path.dart';

/// Common widgets for bottom navigation bar
class GuidedBottomNavigationBar extends StatelessWidget {
  /// Constructor
  const GuidedBottomNavigationBar(
      {required int selectedIndex, this.setBottomNavigationIndex, Key? key})
      : _selectedIndex = selectedIndex,
        super(key: key);

  /// function to set index in bottom navigator
  final dynamic setBottomNavigationIndex;
  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: setBottomNavigationIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? SvgPicture.asset(
                    AssetsPath.bottomNavigationIconHomeSelected)
                : SvgPicture.asset(AssetsPath.bottomNavigationIconHome),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? SvgPicture.asset(
                AssetsPath.bottomNavigationIconUnionSelected)
                : SvgPicture.asset(AssetsPath.bottomNavigationIconUnion),
            label: 'Union'),
        BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? SvgPicture.asset(
                AssetsPath.bottomNavigationIconAddPersonSelected)
                : SvgPicture.asset(
                AssetsPath.bottomNavigationIconAddPerson),
            label: 'Add Person'),
        BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? SvgPicture.asset(
                AssetsPath.bottomNavigationIconChatSelected)
                : SvgPicture.asset(AssetsPath.bottomNavigationIconChat),
            label: 'Add Person'),
        BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? SvgPicture.asset(
                AssetsPath.bottomNavigationIconSettingsSelected)
                : SvgPicture.asset(
                AssetsPath.bottomNavigationIconSettings),
            label: 'Add Person'),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DiagnosticPropertiesBuilder>(
        'setBottomNavigationIndex', setBottomNavigationIndex));
  }
}
