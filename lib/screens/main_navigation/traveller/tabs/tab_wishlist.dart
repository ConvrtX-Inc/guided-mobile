import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/contained_tab_bar_view.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_properties.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/wishlist_tab/activity_packages_wishlist.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/wishlist_tab/guide_profile.dart';

/// Tab Wishlist Screen
class TabWishlistScreen extends StatefulWidget {
  /// Constructor
  const TabWishlistScreen({Key? key, required this.initIndex})
      : super(key: key);

  final int initIndex;

  @override
  _TabWishlistScreenState createState() => _TabWishlistScreenState(initIndex);
}

class _TabWishlistScreenState extends State<TabWishlistScreen> {
  _TabWishlistScreenState(this.initIndex);

  int initIndex;
  String title = '';

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    setTitle(initIndex);
    super.initState();
  }

  void setTitle(int initIndex) {
    switch (initIndex) {
      case 0:
        return setState(() {
          title = AppTextConstants.activityPackages;
        });
      case 1:
        return setState(() {
          title = AppTextConstants.guideProfile;
        });
      default:
        return setState(() {
          title = AppTextConstants.activityPackages;
        });
    }
  }

  /// Custom tab bar view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: title == AppTextConstants.guideProfile
              ? Column(
                  children: <Widget>[
                    Text(
                      'Wish List',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                          color: Colors.black,
                          fontFamily: AppTextConstants.fontGilroy),
                    ),
                    Text(
                      'Adventure, Discover, Explore',
                      style: TextStyle(
                          color: AppColors.lightningYellow,
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Text(
                      'Wish List',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                          color: Colors.black,
                          fontFamily: AppTextConstants.fontGilroy),
                    ),
                  ],
                ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: ContainedTabBarView(
        tabs: <Widget>[
          Text(AppTextConstants.activityPackages,
              style: title == AppTextConstants.activityPackages
                  ? AppTextStyle.activeStyle
                  : AppTextStyle.inactive),
          Text(AppTextConstants.guideProfile,
              style: title == AppTextConstants.guideProfile
                  ? AppTextStyle.activeStyle
                  : AppTextStyle.inactive),
        ],
        tabBarProperties: TabBarProperties(
          height: 42,
          margin: const EdgeInsets.all(8),
          indicatorColor: AppColors.deepGreen,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.w, color: AppColors.deepGreen),
              insets: EdgeInsets.symmetric(horizontal: 18.w)),
          indicatorWeight: 1,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
        views: const <Widget>[
          ActivityPackagesWishlist(),
          GuideProfile(),
        ],
        onChange: setTitle,
        initialIndex: initIndex,
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
