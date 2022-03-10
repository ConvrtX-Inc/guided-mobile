// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/contained_tab_bar_view.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_properties.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/main_navigation/content/packages/tab/tab_description.dart';
import 'package:guided/screens/main_navigation/content/packages/tab/tab_slots_and_schedule.dart';

/// Advertisement View Screen
class PackageView extends StatefulWidget {
  /// Constructor
  const PackageView({Key? key, required this.initIndex}) : super(key: key);

  final int initIndex;

  @override
  _PackageViewState createState() => _PackageViewState(initIndex);
}

class _PackageViewState extends State<PackageView> {
  _PackageViewState(this.initIndex);

  int initIndex;
  String title = '';

  @override
  void initState() {
    setTitle(initIndex);
    super.initState();
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
   
    return Scaffold(
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
                        Navigator.pop(context);
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
                        //  navigateEditAdvertisementDetails(context, screenArguments);
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
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          flexibleSpace: Stack(
            children: <Widget>[
              const Image(
                image: AssetImage('assets/images/png/package1.png'),
              ),
              Positioned(
                left: 15,
                bottom: 20,
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(3),
                    child: Image.asset(AssetsPath.homeFeatureHikingIcon),
                  ),
                ),
              ),
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
          views: const <Widget>[ TabDescriptionView(), TabSlotsAndScheduleView()],
          onChange: setTitle,
          initialIndex: initIndex,
        ),
      ),
    );
  }
}
