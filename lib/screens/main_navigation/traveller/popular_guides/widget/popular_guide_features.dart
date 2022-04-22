// ignore_for_file: unused_local_variable, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/activity_availability_model.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/popular_guide_model.dart';
import 'package:guided/utils/home.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widget for home features
class PopularGuideFeatures extends StatefulWidget {
  /// Constructor
  const PopularGuideFeatures({
    String id = '',
    String name = '',
    String mainBadgeId = '',
    String location = '',
    String coverImg = '',
    String starRating = '',
    String profileImg = '',
    bool isFirstAid = false,
    Key? key,
  })  : _id = id,
        _name = name,
        _mainBadgeId = mainBadgeId,
        _location = location,
        _coverImg = coverImg,
        _profileImg = profileImg,
        _starRating = starRating,
        _isFirstAid = isFirstAid,
        super(key: key);

  final String _id;
  final String _name;
  final String _mainBadgeId;
  final String _location;
  final String _coverImg;
  final String _profileImg;
  final String _starRating;
  final bool _isFirstAid;

  @override
  State<PopularGuideFeatures> createState() => _PopularGuideFeaturesState();
}

class _PopularGuideFeaturesState extends State<PopularGuideFeatures> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            navigatePackageDetails(context);
          },
          child: Stack(children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
              child: SizedBox(
                height: 280.h,
                width: width,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      widget._coverImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
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
                  navigatePackageDetails(context);
                },
                child: Container(
                  height: 100.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage(widget._profileImg),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.r)),
                      border: Border.all(color: Colors.white, width: 4.w)),
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
                        widget._location,
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
              onTap: (){
                navigatePackageDetails(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Text(
                            widget._name,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20.sp),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 7.h),
                            child: Image.asset(
                              widget._mainBadgeId,
                              width: 40.w,
                              height: 40.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget._isFirstAid)
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.mintGreen,
                            border: Border.all(color: AppColors.mintGreen),
                            borderRadius: BorderRadius.all(Radius.circular(8.r))),
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
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }

  /// Navigate to Advertisement View
  Future<void> navigatePackageDetails(BuildContext context) async {
    List<String> splitSubBadge = [];
    final Map<String, dynamic> details = {
      // 'id': widget._id,
      // 'name': widget._name,
      // 'main_badge_id': widget._mainBadgeId,
      // 'cover_img': widget._coverImg,
      // 'is_first_aid': widget._isFirstAid,
      // 'profile_img': widget._profileImg,
      // 'location': widget._location
      'id': widget._id,
      'name': widget._name,
      'main_badge_id': widget._mainBadgeId,
      'sub_badge_id': splitSubBadge,
      'description': 'asdqwe',
      'image_url': widget._coverImg,
      'number_of_tourist': 6,
      'star_rating':55.0,
      'fee': 55.0,
      'date_range': '1-9',
      'services': 'qwe',
      'address': 'qwer',
      'country': 'qwe',
      'extra_cost': '5',
    };

    await Navigator.pushNamed(context, '/popular_guides_view',
        arguments: details);
  }
}
