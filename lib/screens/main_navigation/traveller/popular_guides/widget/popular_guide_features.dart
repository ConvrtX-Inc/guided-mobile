// ignore_for_file: unused_local_variable, unrelated_type_equality_checks, no_default_cases, always_specify_types, type_annotate_public_apis

import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widget for home features
class PopularGuideFeatures extends StatefulWidget {
  /// Constructor
  const PopularGuideFeatures({
    String? id = '',
    String? name = '',
    String? starRating = '',
    String? profileImg = '',
    bool? isFirstAid = false,
    Key? key,
  })  : _id = id,
        _name = name,
        _profileImg = profileImg,
        _starRating = starRating,
        _isFirstAid = isFirstAid,
        super(key: key);

  final String? _id;
  final String? _name;
  final String? _profileImg;
  final String? _starRating;
  final bool? _isFirstAid;

  @override
  State<PopularGuideFeatures> createState() => _PopularGuideFeaturesState();
}

class _PopularGuideFeaturesState extends State<PopularGuideFeatures> {
  late Future<PackageModelData> _loadingData;

  @override
  void initState() {
    super.initState();

    _loadingData = APIServices().getPopularGuidePackage(widget._id);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        FutureBuilder<PackageModelData>(
          future: _loadingData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            Widget _displayWidget;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                _displayWidget = const SkeletonText(
                  height: 200,
                  width: 900,
                  radius: 10,
                );
                break;
              default:
                if (snapshot.hasError) {
                  _displayWidget = Center(
                      child: APIMessageDisplay(
                    message: 'Result: ${snapshot.error}',
                  ));
                } else {
                  _displayWidget = buildPackageResult(snapshot.data!);
                }
            }
            return _displayWidget;
          },
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }

  Widget buildPackageResult(PackageModelData packageData) =>
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (packageData.packageDetails.isEmpty)
              // Padding(
              //   padding: EdgeInsets.only(
              //       top: (MediaQuery.of(context).size.height / 3) - 40),
              //   child: APIMessageDisplay(
              //     message: '${widget._name} has no Activity Package',
              //   ),
              // )
              Container()
            else
              // for (PackageDetailsModel detail in packageData.packageDetails)
              buildPackageInfo(packageData.packageDetails[0])
          ],
        ),
      );

  Widget buildPackageInfo(PackageDetailsModel details) => details.isPublished
      ? Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                navigatePackageDetails(
                    context,
                    details.coverImg,
                    details.description,
                    details.id,
                    details.maxTraveller,
                    details.basePrice,
                    details.mainBadgeId,
                    details.address,
                    details.name,
                    details.firebaseCoverImg);
              },
              child: Stack(children: <Widget>[
                if (details.firebaseCoverImg.isNotEmpty)
                  SizedBox(
                    height: 280.h,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Positioned.fill(
                          child: ExtendedImage.network(
                            details.firebaseCoverImg,
                            fit: BoxFit.cover,
                            gaplessPlayback: true,
                          ),
                        )),
                  )
                else
                  SizedBox(
                    height: 280.h,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Positioned.fill(
                          child: Image.asset('assets/images/png/activity3.png'),
                        )),
                  ),
                Positioned(
                    top: 40,
                    right: 40,
                    child: Image.asset(
                      AssetsPath.heartOutlined,
                      width: 30.w,
                      height: 30.h,
                    )),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      navigatePackageDetails(
                          context,
                          details.coverImg,
                          details.description,
                          details.id,
                          details.maxTraveller,
                          details.basePrice,
                          details.mainBadgeId,
                          details.address,
                          details.name,
                          details.firebaseCoverImg);
                    },
                    child: widget._profileImg == ''
                        ? Container(
                            height: 100.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://img.icons8.com/office/344/person-male.png'),
                                  fit: BoxFit.fill,
                                ),
                                border: Border.all(
                                    color: Colors.white, width: 4.w)),
                          )
                        : Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                    image: ExtendedImage.network(
                                  widget._profileImg.toString(),
                                  fit: BoxFit.cover,
                                  gaplessPlayback: true,
                                ).image),
                                border: Border.all(
                                    color: Colors.white, width: 4.w)),
                          ),
                  ),
                )
              ]),
            ),
            Column(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                      // color: Colors.white,
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Container(
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
                        SizedBox(
                          width: 2.w,
                        ),
                        Expanded(
                          child: Text(
                            details.address,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                                color: AppColors.doveGrey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w, top: 4.h),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star_rate,
                                size: 18,
                                color: Colors.green.shade900,
                              ),
                              Text('${widget._starRating} review'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigatePackageDetails(
                        context,
                        details.coverImg,
                        details.description,
                        details.id,
                        details.maxTraveller,
                        details.basePrice,
                        details.mainBadgeId,
                        details.address,
                        details.name,
                        details.firebaseCoverImg);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Text(
                                widget._name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 7.h),
                                child: FutureBuilder<BadgeModelData>(
                                  future: APIServices()
                                      .getBadgesModelById(details.mainBadgeId),
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
                                          ],
                                        ),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget._isFirstAid!)
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.mintGreen,
                                border: Border.all(color: AppColors.mintGreen),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r))),
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
                        else
                          Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      : Container();

  /// Navigate to Advertisement View
  Future<void> navigatePackageDetails(
      BuildContext context,
      String _coverImg,
      String description,
      String packageId,
      int maxTraveller,
      String price,
      String mainBadgeId,
      String address,
      String packageName,
      String firebaseCoverImg) async {
    List<String> splitSubBadge = [];
    final Map<String, dynamic> details = {
      'id': widget._id,
      'name': widget._name,
      'main_badge_id': mainBadgeId,
      'description': description,
      'image_url': _coverImg,
      'number_of_tourist': maxTraveller,
      'star_rating': '0',
      'fee': price,
      'address': address,
      'package_id': packageId,
      'profile_img': AssetsPath.pmessage3,
      'package_name': packageName,
      'is_first_aid': widget._isFirstAid,
      'firebase_cover_img': firebaseCoverImg
    };

    await Navigator.pushNamed(context, '/popular_guides_view',
        arguments: details);
  }
}
