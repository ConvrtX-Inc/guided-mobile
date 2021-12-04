import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/contained_tab_bar_view.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_properties.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/main_navigation/content/outfitters/outfitters_list.dart';
import 'package:guided/main_navigation/content/advertisements/advertisements_list.dart';

class MainContent extends StatefulWidget {

  final int initIndex;
  /// Constructor
  const MainContent({Key? key, required this.initIndex}) : super(key: key);

  @override
  _MainContentState createState() => _MainContentState(initIndex);
}

class _MainContentState extends State<MainContent> {

  int initIndex;
  String title = '';

  _MainContentState(this.initIndex);

  final TextStyle defaultStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: ConstantHelpers.fontGilroy
  );

  final TextStyle inactive = TextStyle(
      color: ConstantHelpers.osloGrey,
      fontWeight: FontWeight.w600,
      fontFamily: ConstantHelpers.fontGilroy
  );

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    setTitle(initIndex);
    super.initState();
  }

  void setTitle(int initIndex){
    switch(initIndex){
      case 0:
        return setState(() {
          title = ConstantHelpers.myPackage;
        });
      case 1:
        return setState(() {
          title = ConstantHelpers.myEvent;
        });
      case 2:
        return setState(() {
          title = ConstantHelpers.myOutfitter;
        });
      case 3:
        return setState(() {
          title = ConstantHelpers.myAds;
        });
      default:
        return setState(() {
          title = ConstantHelpers.myPackage;
        });
    }
  }

  /// Custom tab bar view
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () =>
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.black,
                fontFamily: ConstantHelpers.fontGilroy
              ),
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
              tabs: [
                Text(ConstantHelpers.package, style: title == ConstantHelpers.myPackage ? defaultStyle : inactive),
                Text(ConstantHelpers.event, style: title == ConstantHelpers.myEvent ? defaultStyle : inactive),
                Text(ConstantHelpers.outfitter, style: title == ConstantHelpers.myOutfitter ? defaultStyle : inactive),
                Text(ConstantHelpers.myads, style: title == ConstantHelpers.myAds ? defaultStyle : inactive),
              ],
              tabBarProperties: const TabBarProperties(
                height: 42,
                margin: EdgeInsets.all(8),
                indicatorColor: Colors.black,
                indicatorWeight: 2,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,

              ),
              views: const [
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
        ),
      designSize: const Size(375, 812),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextStyle>('defaultStyle', defaultStyle));
  }
}
