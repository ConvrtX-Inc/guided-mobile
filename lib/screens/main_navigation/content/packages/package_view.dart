// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, always_specify_types
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/contained_tab_bar_view.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_properties.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/screens/main_navigation/content/packages/tab/tab_description.dart';
import 'package:guided/screens/main_navigation/content/packages/tab/tab_slots_and_schedule.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

/// Advertisement View Screen
class PackageView extends StatefulWidget {
  /// Constructor
  const PackageView({Key? key, required this.initIndex}) : super(key: key);

  final int initIndex;

  @override
  _PackageViewState createState() => _PackageViewState(initIndex);
}

class _PackageViewState extends State<PackageView>
    with AutomaticKeepAliveClientMixin<PackageView> {
  @override
  bool get wantKeepAlive => true;
  _PackageViewState(this.initIndex);

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
          title = AppTextConstants.slotsAndSchedule;
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
                    width: 40.w,
                    height: 40.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AppColors.harp,
                      borderRadius: BorderRadius.circular(10.r),
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
                children: <Widget>[
                  /// Share Icon
                  Transform.scale(
                    scale: 0.8,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: AppColors.harp, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(
                            Icons.share,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {
                            _takeScreenshot(screenArguments['name'],
                                '\$${screenArguments['fee'].toString().substring(0, screenArguments['fee'].toString().indexOf('.'))}');
                          },
                        ),
                      ),
                    ),
                  ),

                  /// Edit Icon
                  Transform.scale(
                    scale: 0.8,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: AppColors.harp, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {
                            navigateEditPackageDetails(context);
                          },
                        ),
                      ),
                    ),
                  ),

                  /// Delete icon
                  Transform.scale(
                    scale: 0.8,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: AppColors.harp, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 25,
                          ),
                          onPressed: () {
                            removePackageItem(screenArguments['id']);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              flexibleSpace: Center(
                child: Stack(
                  children: <Widget>[
                    Image.memory(
                      base64
                          .decode(screenArguments['image_url'].split(',').last),
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    ),
                    FutureBuilder<BadgeModelData>(
                      future: APIServices()
                          .getBadgesModelById(screenArguments['main_badge_id']),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          final BadgeModelData badgeData = snapshot.data;
                          final int length = badgeData.badgeDetails.length;
                          return Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 110.h,
                                ),
                                Image.memory(
                                  base64.decode(badgeData
                                      .badgeDetails[0].imgIcon
                                      .split(',')
                                      .last),
                                  gaplessPlayback: true,
                                ),
                              ],
                            ),
                          );
                        }
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 110.h,
                                ),
                                const CircularProgressIndicator(),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: ContainedTabBarView(
              tabs: <Widget>[
                Text(AppTextConstants.description,
                    style: title == AppTextConstants.description
                        ? AppTextStyle.blackStyle
                        : AppTextStyle.inactive),
                Text(AppTextConstants.slotsAndSchedule,
                    style: title == AppTextConstants.slotsAndSchedule
                        ? AppTextStyle.blackStyle
                        : AppTextStyle.inactive),
              ],
              tabBarProperties: TabBarProperties(
                height: 42,
                margin: const EdgeInsets.all(8),
                indicatorColor: AppColors.rangooGreen,
                indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 2.w, color: AppColors.rangooGreen),
                    insets: EdgeInsets.symmetric(horizontal: 18.w)),
                indicatorWeight: 1,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
              ),
              views: <Widget>[
                TabDescriptionView(
                  id: screenArguments['id'],
                  name: screenArguments['name'],
                  subActivityId: screenArguments['sub_badge_id'],
                  description: screenArguments['description'],
                  fee: screenArguments['fee'],
                  numberOfTourist: screenArguments['number_of_tourist'],
                  services: screenArguments['services'],
                  starRating: screenArguments['star_rating'],
                ),
                TabSlotsAndScheduleView(
                  id: screenArguments['id'],
                )
              ],
              onChange: setTitle,
              initialIndex: initIndex,
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
