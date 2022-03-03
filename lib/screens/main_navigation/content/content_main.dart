import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/contained_tab_bar_view.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_properties.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_list.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_list.dart';
import 'package:guided/screens/main_navigation/content/packages/packages_list.dart';

/// Main Content Screen
class MainContent extends StatefulWidget {
  /// Constructor
  const MainContent({Key? key, required this.initIndex}) : super(key: key);

  final int initIndex;

  @override
  _MainContentState createState() => _MainContentState(initIndex);
}

class _MainContentState extends State<MainContent> {
  _MainContentState(this.initIndex);

  int initIndex;
  String title = '';

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    setTitle(initIndex);
    super.initState();
  }

  void setTitle(int initIndex) {
    switch (initIndex) {
      case 0:
        return setState(() {
          title = AppTextConstants.myPackage;
        });
      case 1:
        return setState(() {
          title = AppTextConstants.myEvent;
        });
      case 2:
        return setState(() {
          title = AppTextConstants.myOutfitter;
        });
      case 3:
        return setState(() {
          title = AppTextConstants.myAds;
        });
      default:
        return setState(() {
          title = AppTextConstants.myPackage;
        });
    }
  }

  /// Custom tab bar view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
              color: Colors.black,
              fontFamily: AppTextConstants.fontGilroy),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        // width: 370,
        // height: 300,
        child: ContainedTabBarView(
          tabs: <Widget>[
            Text(AppTextConstants.package,
                style: title == AppTextConstants.myPackage
                    ? AppTextStyle.defaultStyle
                    : AppTextStyle.inactive),
            Text(AppTextConstants.event,
                style: title == AppTextConstants.myEvent
                    ? AppTextStyle.defaultStyle
                    : AppTextStyle.inactive),
            Text(AppTextConstants.outfitter,
                style: title == AppTextConstants.myOutfitter
                    ? AppTextStyle.defaultStyle
                    : AppTextStyle.inactive),
            Text(AppTextConstants.myads,
                style: title == AppTextConstants.myAds
                    ? AppTextStyle.defaultStyle
                    : AppTextStyle.inactive),
          ],
          tabBarProperties: TabBarProperties(
            height: 42,
            margin: const EdgeInsets.all(8),
            indicatorColor: Colors.red,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.w),
              insets: EdgeInsets.symmetric(horizontal: 18.w)
            ),
            indicatorWeight: 1,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
          views: <Widget>[
            const PackageList(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                  child: Text('This page is currently under development',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp))),
            ),
            const OutfitterList(),
            const AdvertisementList(),
          ],
          onChange: setTitle,
          initialIndex: initIndex,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('initIndex', initIndex));
    properties.add(StringProperty('title', title));
  }
}
