// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, use_raw_strings, no_default_cases, sort_constructors_first
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/home.dart';
import 'package:guided/models/package_destination_image_model.dart';
import 'package:guided/models/package_destination_model.dart';
import 'package:guided/screens/main_navigation/content/packages/widget/package_destination_features.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/utils/home.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Advertisement View Screen
class TabDescriptionView extends StatefulWidget {
  final String id;
  final String name;
  final double fee;
  final String description;
  final int numberOfTourist;
  final String services;
  final double starRating;

  /// Constructor
  const TabDescriptionView(
      {Key? key,
      required this.id,
      required this.name,
      required this.fee,
      required this.description,
      required this.numberOfTourist,
      required this.services,
      required this.starRating})
      : super(key: key);

  @override
  _TabDescriptionViewState createState() => _TabDescriptionViewState(
      id, name, fee, description, numberOfTourist, services, starRating);
}

class _TabDescriptionViewState extends State<TabDescriptionView>
    with AutomaticKeepAliveClientMixin<TabDescriptionView> {
  @override
  bool get wantKeepAlive => true;

  _TabDescriptionViewState(
      String id,
      String name,
      double fee,
      String description,
      int numberOfTourist,
      String services,
      double starRating);

  List<HomeModel> features = HomeUtils.getMockFeatures();
  late Map<dynamic, String> value;
  int activeIndex = 0;
  late Future<PackageDestinationModelData> _loadingData;

  @override
  void initState() {
    super.initState();

    final split = widget.services.split(',');
    value = {for (int i = 0; i < split.length; i++) i: split[i]};

    _loadingData = APIServices().getPackageDestinationData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.name, style: AppTextStyle.txtStyle),
                  Text('\$${widget.fee}', style: AppTextStyle.txtStyle)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
              child: Text(
                widget.description,
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.doveGrey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  Text('Team', style: AppTextStyle.semiBoldStyle),
                  SizedBox(width: 55.w),
                  Text(
                    '${widget.numberOfTourist} Tourists',
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.doveGrey),
                  ),
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
              child: SizedBox(
                height: 50.h,
                child: Row(
                  children: <Widget>[
                    Text(AppTextConstants.freeServices,
                        style: AppTextStyle.semiBoldStyle),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.harp,
                                      border: Border.all(color: AppColors.harp),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(value[index].toString(),
                                        style:
                                            TextStyle(color: AppColors.nobel)),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                )
                              ],
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              children: <Widget>[
                FutureBuilder<PackageDestinationModelData>(
                  future: _loadingData,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    Widget _displayWidget;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        _displayWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      default:
                        if (snapshot.hasError) {
                          _displayWidget = Center(
                              child: APIMessageDisplay(
                            message: 'Result: ${snapshot.error}',
                          ));
                        } else {
                          _displayWidget =
                              buildPackageDestinationResult(snapshot.data!);
                        }
                    }
                    return _displayWidget;
                  },
                )
              ],
            ),
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

  Widget buildPackageDestinationResult(
          PackageDestinationModelData packageDestinationData) =>
      SingleChildScrollView(
        child: Column(
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
                buildPackageDestinationInfo(detail)
          ],
        ),
      );

  Widget buildPackageDestinationInfo(PackageDestinationDetailsModel details) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    details.name,
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp),
                  ),
                ),
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
          FutureBuilder<PackageDestinationImageModelData>(
            future: APIServices().getPackageDestinationImageData(details.id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                final PackageDestinationImageModelData packageDestinationImage =
                    snapshot.data;
                final int length = packageDestinationImage
                    .packageDestinationImageDetails.length;
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.26,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: List<Widget>.generate(length, (int i) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 20.h),
                          height: 160.h,
                          width: 300.w,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 160.h,
                                width: 300.w,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.r),
                                  ),
                                  image: DecorationImage(
                                      image: Image.memory(
                                    base64.decode(packageDestinationImage
                                        .packageDestinationImageDetails[i]
                                        .snapshotImg
                                        .split(',')
                                        .last),
                                    fit: BoxFit.cover,
                                    gaplessPlayback: true,
                                  ).image),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                );
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          ),
          Text(
            details.description,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.osloGrey),
          )
        ],
      );

  Widget buildImage(PackageDestinationImageDetailsModel imgData, int index) =>
      Container(
        // margin: EdgeInsets.symmetric(horizontal: 1.w),
        color: Colors.white,
        child: Image.memory(
          base64.decode(imgData.snapshotImg.split(',').last),
          fit: BoxFit.fitWidth,
          gaplessPlayback: true,
        ),
      );
}
