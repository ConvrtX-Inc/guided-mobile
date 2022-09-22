// ignore_for_file: public_member_api_docs, use_named_constants, diagnostic_describe_all_properties, no_default_cases, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/wishlist_activity_model.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/wishlist_tab/widget/guide_profile_feature.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Guide Profile
class GuideProfile extends StatefulWidget {
  const GuideProfile({Key? key}) : super(key: key);

  @override
  State<GuideProfile> createState() => _GuideProfileState();
}

class _GuideProfileState extends State<GuideProfile>
    with AutomaticKeepAliveClientMixin<GuideProfile> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: <Widget>[
              FutureBuilder<WishlistActivityModel>(
                future: APIServices().getWishlistActivityData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
      FutureBuilder<PackageModelData>(
        future: APIServices().getPackageDataById(details.activityPackageId),
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
                _displayWidget = buildPackageResult(
                    snapshot.data!, details.activityPackageId);
              }
          }
          return _displayWidget;
        },
      );

  Widget buildPackageResult(
          PackageModelData packageData, String activityPackageId) =>
      Column(
        children: <Widget>[
          if (packageData.packageDetails.isEmpty)
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 3) - 40),
              child: APIMessageDisplay(
                message: AppTextConstants.noResultFound,
              ),
            )
          else
            for (PackageDetailsModel detail in packageData.packageDetails)
              buildGuideProfile(detail, activityPackageId),
        ],
      );

  Widget buildGuideProfile(
          PackageDetailsModel details, String activityPackageId) =>
      FutureBuilder<ProfileDetailsModel>(
        future: APIServices().getProfileDataById(details.userId),
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
                _displayWidget = buildGuideResult(snapshot.data!,
                    activityPackageId, details.mainBadgeId, details.userId);
              }
          }
          return _displayWidget;
        },
      );

  Widget buildGuideResult(ProfileDetailsModel details, String activityPackageId,
          String mainBadgeId, String userId) =>
      Center(
        child: GuideProfileFeature(
            id: details.id,
            activityPackageId: activityPackageId,
            firebaseProfImg: details.firebaseProfilePicUrl,
            name: details.fullName,
            isFirstAid: details.isFirstAidTrained,
            mainBadgeId: mainBadgeId,
            userId: userId,
            createdDate: details.createdDate),
      );

  Widget nearbyActivities(BuildContext context, List<Activity> activities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Posts',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.26,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(activities.length, (int i) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                height: 180.h,
                width: 168.w,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 112.h,
                      width: 168.w,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.r),
                        ),
                        image: DecorationImage(
                          image: AssetImage(activities[i].featureImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              backgroundImage: AssetImage(activities[i].path),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      activities[i].name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 10.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/png/clock.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          activities[i].distance,
                          style: TextStyle(
                              color: HexColor('#696D6D'),
                              fontSize: 11.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
