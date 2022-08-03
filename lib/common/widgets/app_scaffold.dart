import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App Scaffold
class AppScaffold extends StatelessWidget {
  ///Constructor
  const AppScaffold(
      {required this.body,
      this.appBarTitle = '',
      this.appBarLeadingCallback,
      this.appbarLeadingIcon = Icons.chevron_left,
      this.appBarLeadingIconColor = Colors.black,
      this.appBarActions = const <Widget>[],
      this.appBarElevation = 0,
      this.appBarColor = Colors.white,
      this.scaffoldBgColor = Colors.white,
      this.centerAppBarTitle = false,
      this.appBarTitleColor = Colors.black,
      this.bodyPaddingHorizontal = 26,
      this.bodyPaddingVertical = 16,
      Key? key})
      : super(key: key);

  /// Body of Scaffold
  final Widget body;

  /// Title of Appbar
  final String appBarTitle;

  /// Callback when app bar button is pressed
  final VoidCallback? appBarLeadingCallback;

  /// Icon for appbar
  final IconData appbarLeadingIcon;

  /// Sets title to center if the value is true
  final bool centerAppBarTitle;

  /// Appbar Icon color
  final Color appBarLeadingIconColor;

  /// Appbar Actions
  final List<Widget> appBarActions;

  /// Appbar Elevation
  final double appBarElevation;

  /// App bar background color
  final Color appBarColor;

  /// Scaffold Background Color
  final Color scaffoldBgColor;

  /// Color of appbar title
  final Color appBarTitleColor;

  ///   vertical padding of body
  final double bodyPaddingVertical;

  ///  horizontal padding of body
  final double bodyPaddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        centerTitle: centerAppBarTitle,
        automaticallyImplyLeading: false,

        leading: IconButton(

          icon: Icon(
            appbarLeadingIcon,
            color: appBarLeadingIconColor,
          ),
          onPressed: () {
            appBarLeadingCallback!();
          },
        ),
        backgroundColor: appBarColor,
        elevation: 0,
        actions: appBarActions,
        title: Text(
          appBarTitle,
          style: TextStyle(
              color: appBarTitleColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: bodyPaddingHorizontal, vertical: bodyPaddingVertical),
        child: body,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Widget>('body', body))
      ..add(StringProperty('appBarTitle', appBarTitle))
      ..add(ObjectFlagProperty<VoidCallback?>.has(
          'appBarLeadingCallback', appBarLeadingCallback))
      ..add(
          DiagnosticsProperty<IconData>('appbarLeadingIcon', appbarLeadingIcon))
      ..add(DiagnosticsProperty<bool>('centerAppBarTitle', centerAppBarTitle))
      ..add(ColorProperty('appBarLeadingIconColor', appBarLeadingIconColor))
      ..add(IterableProperty<Widget>('appBarActions', appBarActions))
      ..add(DoubleProperty('appBarElevation', appBarElevation))
      ..add(ColorProperty('appBarColor', appBarColor))
      ..add(ColorProperty('scaffoldBgColor', scaffoldBgColor))
      ..add(ColorProperty('appBarTitleColor', appBarTitleColor))
      ..add(DoubleProperty('bodyPaddingVertical', bodyPaddingVertical))
      ..add(DoubleProperty('bodyPaddingHorizontal', bodyPaddingHorizontal));
  }
}
