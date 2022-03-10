// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, use_raw_strings
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/home.dart';
import 'package:guided/screens/main_navigation/content/packages/widget/package_destination_features.dart';
import 'package:guided/utils/home.dart';

/// Advertisement View Screen
class TabDescriptionView extends StatefulWidget {
  /// Constructor
  const TabDescriptionView({Key? key}) : super(key: key);

  @override
  _TabDescriptionViewState createState() => _TabDescriptionViewState();
}

class _TabDescriptionViewState extends State<TabDescriptionView> {
  List<HomeModel> features = HomeUtils.getMockFeatures();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Ohaio Tour', style: AppTextStyle.txtStyle),
                  Text('\$200', style: AppTextStyle.txtStyle)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w, top: 15.h, right: 25.w),
              child: const Text(
                  'Sample description goes here to explain about your package details.'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  Text('Team', style: AppTextStyle.semiBoldStyle),
                  SizedBox(width: 55.w),
                  const Text('5 Tourists'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 40.w),
                    child: Text(AppTextConstants.activities,
                        style: AppTextStyle.semiBoldStyle),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.harp,
                        border: Border.all(color: AppColors.harp),
                        borderRadius: BorderRadius.all(Radius.circular(5.r))),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(AppTextConstants.camping,
                          style: TextStyle(color: AppColors.nobel)),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.harp,
                        border: Border.all(color: AppColors.harp),
                        borderRadius: BorderRadius.all(Radius.circular(5.r))),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(AppTextConstants.hiking,
                          style: TextStyle(color: AppColors.nobel)),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.harp,
                        border: Border.all(color: AppColors.harp),
                        borderRadius: BorderRadius.all(Radius.circular(5.r))),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(AppTextConstants.hunt,
                          style: TextStyle(color: AppColors.nobel)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  Text(AppTextConstants.freeServices,
                      style: AppTextStyle.semiBoldStyle),
                  SizedBox(width: 5.w),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.harp,
                        border: Border.all(color: AppColors.harp),
                        borderRadius: BorderRadius.all(Radius.circular(5.r))),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(AppTextConstants.transport,
                          style: TextStyle(color: AppColors.nobel)),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.harp,
                        border: Border.all(color: AppColors.harp),
                        borderRadius: BorderRadius.all(Radius.circular(5.r))),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(AppTextConstants.breakfast,
                          style: TextStyle(color: AppColors.nobel)),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.harp,
                        border: Border.all(color: AppColors.harp),
                        borderRadius: BorderRadius.all(Radius.circular(5.r))),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(AppTextConstants.water,
                          style: TextStyle(color: AppColors.nobel)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Name of Place No. 1', style: AppTextStyle.txtStyle),
                  Transform.scale(
                    scale: 0.8,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: AppColors.tealGreen, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 15,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: SizedBox(
                height: 190.h,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: features.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return PackageDestinationFeatures(
                                name: features[index].featureName,
                                imageUrl: features[index].featureImageUrl,
                                numberOfTourist:
                                    features[index].featureNumberOfTourists,
                                starRating: features[index].featureStarRating,
                                fee: features[index].featureFee,
                                dateRange: features[index].dateRange,
                              );
                            }))
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                child: Text(
                  AppTextConstants.loremIpsum,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: AppColors.osloGrey,
                      fontWeight: FontWeight.w400),
                )),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Name of Place No. 2', style: AppTextStyle.txtStyle),
                  Transform.scale(
                    scale: 0.8,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: AppColors.tealGreen, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 15,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: SizedBox(
                height: 190.h,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: features.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return PackageDestinationFeatures(
                                name: features[index].featureName,
                                imageUrl: features[index].featureImageUrl,
                                numberOfTourist:
                                    features[index].featureNumberOfTourists,
                                starRating: features[index].featureStarRating,
                                fee: features[index].featureFee,
                                dateRange: features[index].dateRange,
                              );
                            }))
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                child: Text(
                  AppTextConstants.loremIpsum,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: AppColors.osloGrey,
                      fontWeight: FontWeight.w400),
                )),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: AppColors.tealGreen,
                    size: 10,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text('4.9',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.tealGreen)),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(
                    '(67 Reviews)',
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.osloGrey),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(width: 1.w, color: AppColors.porcelain),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.w, 10.h, 0.w, 0.h),
                        child: Container(
                          width: 55.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(
                                      'assets/images/profile-photos-2.png'))),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                              child: Text(
                                'Ann Sasha',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Gilroy',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                              child: SizedBox(
                                width: 180.w,
                                child: Text(
                                  'Architect',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Gilroy',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 5.w, 0.h),
                            child: Text(
                              '5',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                            child: const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                            child: const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                            child: const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                            child: const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                            child: const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 10,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                    child: Text(AppTextConstants.loremIpsum,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            color: AppColors.osloGrey,
                            fontWeight: FontWeight.w400)),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(width: 1.w, color: AppColors.porcelain),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.w, 10.h, 0.w, 0.h),
                        child: Container(
                          width: 55.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(
                                      'assets/images/profile-photos-2.png'))),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                              child: Text(
                                'Ann Sasha',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Gilroy',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                              child: SizedBox(
                                width: 180.w,
                                child: Text(
                                  'Architect',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Gilroy',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 5.w, 0.h),
                            child: Text(
                              '5',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                            child: const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                            child: const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                            child: const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                            child: const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                            child: const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 10,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                    child: Text(AppTextConstants.loremIpsum,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            color: AppColors.osloGrey,
                            fontWeight: FontWeight.w400)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
