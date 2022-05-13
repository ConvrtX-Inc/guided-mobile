// ignore_for_file: avoid_dynamic_calls, avoid_bool_literals_in_conditional_expressions, use_if_null_to_convert_nulls_to_bools
import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/wishlist_tab/widget/post_features.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widget for home features
class GuideProfileFeature extends StatefulWidget {
  /// Constructor
  const GuideProfileFeature({
    String id = '',
    String activityPackageId = '',
    String firebaseProfImg = '',
    String name = '',
    bool? isFirstAid = false,
    String mainBadgeId = '',
    String userId = '',
    DateTime? createdDate,
    Key? key,
  })  : _id = id,
        _activityPackageId = activityPackageId,
        _firebaseProfImg = firebaseProfImg,
        _name = name,
        _isFirstAid = isFirstAid,
        _mainBadgeId = mainBadgeId,
        _userId = userId,
        _createdDate = createdDate,
        super(key: key);

  final String _id;
  final String _activityPackageId;
  final String _firebaseProfImg;
  final String _name;
  final bool? _isFirstAid;
  final String _mainBadgeId;
  final String _userId;
  final DateTime? _createdDate;

  @override
  State<GuideProfileFeature> createState() => _GuideProfileFeatureState();
}

class _GuideProfileFeatureState extends State<GuideProfileFeature> {
  late List<String> imageList;
  late List<String> imageIdList;
  int activeIndex = 0;
  int imageCount = 0;

  @override
  void initState() {
    super.initState();
    imageList = [];
    imageIdList = [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (widget._firebaseProfImg == '')
                  Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.white),
                        borderRadius: BorderRadius.circular(60.r),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                              blurRadius: 1,
                              color: Colors.grey,
                              spreadRadius: 1)
                        ],
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://img.icons8.com/external-coco-line-kalash/344/external-person-human-body-anatomy-coco-line-kalash-4.png'),
                          fit: BoxFit.cover,
                        )),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.white),
                      borderRadius: BorderRadius.circular(60.r),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            blurRadius: 1, color: Colors.grey, spreadRadius: 1)
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.r),
                      child: ExtendedImage.network(
                        widget._firebaseProfImg,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                Expanded(
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            widget._name,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: <Widget>[
                            FutureBuilder<BadgeModelData>(
                              future: APIServices()
                                  .getBadgesModelById(widget._mainBadgeId),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  final BadgeModelData badgeData =
                                      snapshot.data;
                                  final int length =
                                      badgeData.badgeDetails.length;
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Image.memory(
                                          base64.decode(badgeData
                                              .badgeDetails[0].imgIcon
                                              .split(',')
                                              .last),
                                          gaplessPlayback: true,
                                          width: 30,
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          badgeData.badgeDetails[0].name,
                                          style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        const SkeletonText(
                                          width: 30,
                                          height: 30,
                                          shape: BoxShape.circle,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        const SkeletonText(
                                          width: 60,
                                          height: 30,
                                          radius: 10,
                                        )
                                      ],
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 17),
                              child: widget._isFirstAid == true
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.mintGreen,
                                          border: Border.all(
                                              color: AppColors.mintGreen),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.r))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(AppTextConstants.firstaid,
                                            style: TextStyle(
                                                color: AppColors.deepGreen,
                                                fontFamily: 'Gilroy',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Image(
                                image: AssetImage(AssetsPath.forThePlanet),
                                width: 60,
                                height: 60,
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: AppColors.deepGreen,
                                    size: 10,
                                  ),
                                  Text(
                                    '0 reviews',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'Gilroy',
                                        color: AppColors.osloGrey,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 200.h,
              child: Row(
                children: <Widget>[
                  Expanded(child: buildPost(widget._userId)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPost(String userId) => FutureBuilder<PackageModelData>(
        future: APIServices().getPackageDataByUserId(userId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final PackageModelData packageData = snapshot.data;
            final int length = packageData.packageDetails.length;
            if (packageData.packageDetails.isEmpty) {
              return const Center(
                child: Text('Nothing to show here'),
              );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return PostFeatures(
                        id: packageData.packageDetails[index].id,
                        name: packageData.packageDetails[index].name,
                        mainBadgeId:
                            packageData.packageDetails[index].mainBadgeId,
                        subBadgeId:
                            packageData.packageDetails[index].subBadgeId,
                        description:
                            packageData.packageDetails[index].description,
                        imageUrl: packageData.packageDetails[index].coverImg,
                        numberOfTouristMin:
                            packageData.packageDetails[index].minTraveller,
                        numberOfTourist:
                            packageData.packageDetails[index].maxTraveller,
                        starRating: '0',
                        fee: double.parse(
                            packageData.packageDetails[index].basePrice),
                        dateRange: '1-9',
                        services: packageData.packageDetails[index].services,
                        country: packageData.packageDetails[index].country,
                        address: packageData.packageDetails[index].address,
                        extraCost: packageData
                            .packageDetails[index].extraCostPerPerson,
                        isPublished:
                            packageData.packageDetails[index].isPublished,
                        firebaseCoverImg:
                            packageData.packageDetails[index].firebaseCoverImg,
                        notIncluded: packageData
                            .packageDetails[index].notIncludedServices,
                        fullName: widget._name,
                        firebaseProfImg: widget._firebaseProfImg,
                        isFirstAid: widget._isFirstAid,
                        createdDate: widget._createdDate);
                  });
            }
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const MainContentSkeletonHorizontal();
          }
          return Container();
        },
      );
}
