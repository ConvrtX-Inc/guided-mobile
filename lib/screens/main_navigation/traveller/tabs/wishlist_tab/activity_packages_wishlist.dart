// ignore_for_file: prefer_const_literals_to_create_immutables, no_default_cases

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/package_destination_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/wishlist_activity_model.dart';
import 'package:guided/models/wishlist_model.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/wishlist_tab/widget/activity_package_wishlist_features.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';

/// Package List Screen
class ActivityPackagesWishlist extends StatefulWidget {
  /// Constructor
  const ActivityPackagesWishlist({Key? key}) : super(key: key);

  @override
  _ActivityPackagesWishlistState createState() =>
      _ActivityPackagesWishlistState();
}

class _ActivityPackagesWishlistState extends State<ActivityPackagesWishlist>
    with AutomaticKeepAliveClientMixin<ActivityPackagesWishlist> {
  @override
  bool get wantKeepAlive => true;

  /// Get features items mocked data
  List<Wishlist> features = StaticDataService.getWishListData();
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<WishlistActivityModel>(
              future: APIServices().getWishlistActivityData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget _displayWidget;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    _displayWidget = const MainContentSkeleton();
                    break;
                  default:
                    if (snapshot.hasError) {
                      _displayWidget = Center(
                          child: APIMessageDisplay(
                        message: 'Result: ${snapshot.error}',
                      ));
                    } else {
                      _displayWidget = buildResult(snapshot.data!);
                    }
                }
                return _displayWidget;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildResult(WishlistActivityModel wishlistData) => Column(
        children: <Widget>[
          if (wishlistData.wishlistActivityDetails.isEmpty)
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 3) - 40),
              child: APIMessageDisplay(
                message: AppTextConstants.noResultFound,
              ),
            )
          else
            for (WishlistActivityDetailsModel detail
                in wishlistData.wishlistActivityDetails)
              buildInfo(detail)
        ],
      );

  Widget buildInfo(WishlistActivityDetailsModel details) =>
      FutureBuilder<PackageDestinationModelData>(
        future:
            APIServices().getPackageDestinationData(details.activityPackageId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget _displayWidget;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              _displayWidget = SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: SkeletonText(
                        width: 300,
                        height: 30,
                        radius: 10,
                      ),
                    ),
                  ],
                ),
              );
              break;
            default:
              if (snapshot.hasError) {
                _displayWidget = Center(
                    child: APIMessageDisplay(
                  message: 'Result: ${snapshot.error}',
                ));
              } else {
                _displayWidget = buildPackageDestinationResult(
                    snapshot.data!, details.activityPackageId);
              }
          }
          return _displayWidget;
        },
      );

  Widget buildPackageDestinationResult(
          PackageDestinationModelData packageDestinationData,
          String activityPackageId) =>
      Column(
        children: <Widget>[
          if (packageDestinationData.packageDestinationDetails.isEmpty)
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 3) - 40),
              child: APIMessageDisplay(
                message: AppTextConstants.noResultFound,
              ),
            )
          else
            for (PackageDestinationDetailsModel detail
                in packageDestinationData.packageDestinationDetails)
              buildPackageDestinationInfo(detail, activityPackageId)
        ],
      );

  Widget buildPackageDestinationInfo(
          PackageDestinationDetailsModel details, String activityPackageId) =>
      FutureBuilder<PackageModelData>(
        future: APIServices().getPackageDataById(activityPackageId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget _displayWidget;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              _displayWidget = Container();
              break;
            default:
              if (snapshot.hasError) {
                _displayWidget = Center(
                    child: APIMessageDisplay(
                  message: 'Result: ${snapshot.error}',
                ));
              } else {
                PackageModelData data = snapshot.data!;
                _displayWidget = ActivityPackageWishlistFeature(
                    id: details.id,
                    coverImg: data.packageDetails[0].firebaseCoverImg,
                    packageName: data.packageDetails[0].name,
                    price: data.packageDetails[0].basePrice,
                    mainBadgeId: data.packageDetails[0].mainBadgeId);
              }
          }
          return _displayWidget;
        },
      );

  // ActivityPackageWishlistFeature(
  //   id: details.id,
  //   activityPackageId: activityPackageId,
  // );

  Widget _slideshow1() => Column(
        children: <Widget>[
          ImageSlideshow(
            width: 375,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.white,
            indicatorBackgroundColor: Colors.grey[100],
            autoPlayInterval: 3000,
            isLoop: true,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity1.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.hunt),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity2.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.paddle),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity3.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.hiking),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.star_rounded,
                  color: Colors.green[900],
                  size: 15,
                ),
                Text(
                  '0 review',
                  style: TextStyle(color: AppColors.osloGrey),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Wilderness Adventure Co.',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '\$50/Person',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      );

  Widget _slideshow2() => Column(
        children: <Widget>[
          ImageSlideshow(
            width: 375,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.white,
            indicatorBackgroundColor: Colors.grey[100],
            autoPlayInterval: 3000,
            isLoop: true,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity2.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.paddle),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity1.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.hunt),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/png/activity3.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(AssetsPath.hiking),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heart),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.star_rounded,
                  color: Colors.green[900],
                  size: 15,
                ),
                Text(
                  '13 review',
                  style: TextStyle(color: AppColors.osloGrey),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Blue Lake Paddle Co.',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '\$25/Person',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      );
}
