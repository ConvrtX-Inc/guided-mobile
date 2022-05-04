// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, always_specify_types
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
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/activity_availability_hours_model.dart';
import 'package:guided/models/activity_availability_model.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/screens/main_navigation/content/packages/tab/tab_description.dart';
import 'package:guided/screens/main_navigation/content/packages/tab/tab_slots_and_schedule.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
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
  List<String> splitId = [];
  List<DateTime> splitAvailabilityDate = [];
  int initIndex;
  String title = '';
  int slots = 0;
  @override
  void initState() {
    super.initState();
    setTitle(initIndex);
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      await getActivityAvailability(screenArguments['id']);
    });
  }

  Future<void> getActivityAvailability(String activityPackageId) async {
    final List<ActivityAvailability> resForm =
        await APIServices().getActivityAvailability(activityPackageId);
    if (resForm.isNotEmpty) {
      final List<ActivityAvailabilityHour> resForm1 =
          await APIServices().getActivityAvailabilityHour(resForm[0].id);
      slots = resForm1[0].slots;
    }
    for (int index = 0; index < resForm.length; index++) {
      splitId.add(resForm[index].id);
      splitAvailabilityDate
          .add(DateTime.parse(resForm[index].availability_date));
    }
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
              flexibleSpace: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ExtendedImage.network(
                      screenArguments['image_url'],
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    ),
                  ),
                  FutureBuilder<BadgeModelData>(
                    future: APIServices()
                        .getBadgesModelById(screenArguments['main_badge_id']),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        final BadgeModelData badgeData = snapshot.data;
                        final int length = badgeData.badgeDetails.length;
                        return Positioned(
                          left: 10,
                          bottom: 10,
                          child: Column(
                            children: <Widget>[
                              Image.memory(
                                base64.decode(badgeData.badgeDetails[0].imgIcon
                                    .split(',')
                                    .last),
                                gaplessPlayback: true,
                              ),
                            ],
                          ),
                        );
                      }
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Positioned(
                          left: 10,
                          bottom: 10,
                          child: Column(
                            children: const <Widget>[
                              SkeletonText(
                                height: 30,
                                width: 30,
                                shape: BoxShape.circle,
                              ),
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
                  numberOfTouristMin: screenArguments['number_of_tourist_min'],
                  numberOfTourist: screenArguments['number_of_tourist'],
                  services: screenArguments['services'],
                  starRating: screenArguments['star_rating'],
                ),
                TabSlotsAndScheduleView(
                    id: screenArguments['id'],
                    availabilityId: splitId,
                    availabilityDate: splitAvailabilityDate,
                    numberOfTourist: screenArguments['number_of_tourist'],
                    slots: slots)
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
