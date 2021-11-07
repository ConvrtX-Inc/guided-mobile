import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/helpers/constant.dart';

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
                    ConstantHelpers.bottomNavigationIconHomeSelected)
                : SvgPicture.asset(ConstantHelpers.bottomNavigationIconHome),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? SvgPicture.asset(
                    ConstantHelpers.bottomNavigationIconUnionSelected)
                : SvgPicture.asset(ConstantHelpers.bottomNavigationIconUnion),
            label: 'Union'),
        BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? SvgPicture.asset(
                    ConstantHelpers.bottomNavigationIconAddPersonSelected)
                : SvgPicture.asset(
                    ConstantHelpers.bottomNavigationIconAddPerson),
            label: 'Add Person'),
        BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? SvgPicture.asset(
                    ConstantHelpers.bottomNavigationIconChatSelected)
                : SvgPicture.asset(ConstantHelpers.bottomNavigationIconChat),
            label: 'Add Person'),
        BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? SvgPicture.asset(
                    ConstantHelpers.bottomNavigationIconSettingsSelected)
                : SvgPicture.asset(
                    ConstantHelpers.bottomNavigationIconSettings),
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
