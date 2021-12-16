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
        backgroundColor: Colors.transparent,
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
          tabBarProperties: const TabBarProperties(
            height: 42,
            margin: EdgeInsets.all(8),
            indicatorColor: Colors.black,
            indicatorWeight: 2,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
          views: const <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Package Content'),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Event Content'),
            ),
            OutfitterList(),
            AdvertisementList(),
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