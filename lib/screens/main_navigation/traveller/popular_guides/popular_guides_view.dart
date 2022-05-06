// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, always_specify_types, no_logic_in_create_state
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/contained_tab_bar_view.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_properties.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/tabs/popular_guides_description_tab.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/tabs/popular_guides_traveler_limit_schedules.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

/// Advertisement View Screen
class PopularGuidesView extends StatefulWidget {
  /// Constructor
  const PopularGuidesView({Key? key, required this.initIndex})
      : super(key: key);

  final int initIndex;

  @override
  _PopularGuidesViewState createState() => _PopularGuidesViewState(initIndex);
}

class _PopularGuidesViewState extends State<PopularGuidesView>
    with AutomaticKeepAliveClientMixin<PopularGuidesView> {
  @override
  bool get wantKeepAlive => true;
  _PopularGuidesViewState(this.initIndex);

  final screenshotController = ScreenshotController();

  int initIndex;
  String title = '';

  @override
  void initState() {
    super.initState();
    setTitle(initIndex);
  }

  void setTitle(int initIndex) {
    switch (initIndex) {
      case 0:
        return setState(() {
          title = AppTextConstants.description;
        });
      case 1:
        return setState(() {
          title = AppTextConstants.travelerLimitAndSchedule;
        });
      default:
        return setState(() {
          title = AppTextConstants.description;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return DefaultTabController(
      length: 2,
      child: Screenshot(
        controller: screenshotController,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(180),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Transform.scale(
                scale: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: 50.w,
                    height: 40.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AppColors.harp,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
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
                  /// Share Icon
                  Transform.scale(
                    scale: 0.8,
                    child: Padding(
                      padding: EdgeInsets.zero,
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
                            Icons.share_outlined,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {
                            _takeScreenshot(screenArguments['name'],
                                '\$${screenArguments['fee']}');
                          },
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              flexibleSpace: ExtendedImage.network(
                screenArguments['firebase_cover_img'],
                gaplessPlayback: true,
                fit: BoxFit.cover,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15.w, top: 15.h),
                    child: Text(
                      screenArguments['package_name'],
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                          fontSize: 28.sp),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Container(
                          height: 15.h,
                          width: 15.w,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/png/marker.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: SizedBox(
                          child: Text(
                            screenArguments['address'],
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: AppColors.doveGrey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    child: Container(
                      height: 600.h,
                      padding: const EdgeInsets.all(15),
                      color: Colors.white,
                      child: ContainedTabBarView(
                        tabs: <Widget>[
                          Text(AppTextConstants.description,
                              style: title == AppTextConstants.description
                                  ? AppTextStyle.blackStyle
                                  : AppTextStyle.inactive),
                          Text(AppTextConstants.travelerLimitAndSchedule,
                              style: title ==
                                      AppTextConstants.travelerLimitAndSchedule
                                  ? AppTextStyle.blackStyle
                                  : AppTextStyle.inactive),
                        ],
                        tabBarProperties: TabBarProperties(
                          height: 42,
                          margin: const EdgeInsets.all(8),
                          indicatorColor: AppColors.rangooGreen,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 2.w, color: AppColors.rangooGreen),
                              insets: EdgeInsets.symmetric(horizontal: 18.w)),
                          indicatorWeight: 1,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                        ),
                        views: <Widget>[
                          PopularGuidesTabDescription(
                              name: screenArguments['name'],
                              mainBadgeId: screenArguments['main_badge_id'],
                              description: screenArguments['description'],
                              imageUrl: screenArguments['image_url'],
                              numberOfTourist:
                                  screenArguments['number_of_tourist'],
                              starRating: screenArguments['star_rating'],
                              fee: screenArguments['fee'],
                              address: screenArguments['address'],
                              packageId: screenArguments['package_id'],
                              profileImg: screenArguments['profile_img'],
                              packageName: screenArguments['package_name'],
                              isFirstAid: screenArguments['is_first_aid']),
                          PopularGuidesTravelerLimitSchedules(
                              packageId: screenArguments['package_id'],
                              price: screenArguments['fee']),
                        ],
                        onChange: setTitle,
                        initialIndex: initIndex,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> removePackageItem(String id) async {
    final Map<String, dynamic> packageDetails = {
      'is_published': false,
    };

    final dynamic response = await APIServices().request(
        '${AppAPIPath.activityPackagesUrl}/$id', RequestType.PATCH,
        needAccessToken: true, data: packageDetails);
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const MainNavigationScreen(
                  navIndex: 1,
                  contentIndex: 0,
                )));
  }

  /// Navigate to Advertisement Edit
  Future<void> navigateEditPackageDetails(BuildContext context) async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Map<String, dynamic> details = {
      'id': screenArguments['id'],
      'name': screenArguments['name'],
      'main_badge_id': screenArguments['main_badge_id'],
      'sub_badge_id': screenArguments['sub_badge_id'],
      'description': screenArguments['description'],
      'image_url': screenArguments['image_url'],
      'number_of_tourist': screenArguments['number_of_tourist'],
      'star_rating': screenArguments['star_rating'],
      'fee': screenArguments['fee'],
      'date_range': screenArguments['date_range'],
      'services': screenArguments['services'],
      'address': screenArguments['address'],
      'extra_cost': screenArguments['extra_cost'],
      'country': screenArguments['country']
    };

    await Navigator.pushNamed(context, '/package_edit', arguments: details);
  }

  void _takeScreenshot(String title, String price) async {
    final image = await screenshotController.capture();
    if (image == null) return;

    await saveAndShare(image, title, price);
  }

  Future<void> saveAndShare(Uint8List bytes, String title, String price) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    await Share.shareFiles([image.path],
        text: 'Check out this $title! Starting from $price! #GuidED');
  }
}
