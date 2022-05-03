// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, use_raw_strings, no_default_cases, sort_constructors_first, always_put_required_named_parameters_first, public_member_api_docs, diagnostic_describe_all_properties
import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/home.dart';
import 'package:guided/models/package_destination_image_model.dart';
import 'package:guided/models/package_destination_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/home.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Advertisement View Screen
class TabDescriptionView extends StatefulWidget {
  final String id;
  final String name;
  final List<String> subActivityId;
  final double fee;
  final String description;
  final int numberOfTouristMin;
  final int numberOfTourist;
  final String services;
  final double starRating;

  /// Constructor
  const TabDescriptionView({
    Key? key,
    required this.id,
    required this.name,
    required this.subActivityId,
    required this.fee,
    required this.description,
    required this.numberOfTourist,
    required this.services,
    required this.starRating,
    required this.numberOfTouristMin,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _TabDescriptionViewState createState() => _TabDescriptionViewState();
}

class _TabDescriptionViewState extends State<TabDescriptionView>
    with AutomaticKeepAliveClientMixin<TabDescriptionView> {
  @override
  bool get wantKeepAlive => true;

  _TabDescriptionViewState();

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
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: RegExp(r"\w+(\'\w+)?")
                                    .allMatches(widget.name)
                                    .length >
                                5
                            ? 12.sp
                            : 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                      '\$${widget.fee.toString().substring(0, widget.fee.toString().indexOf('.'))}',
                      style: AppTextStyle.txtStyle)
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
                  color: AppColors.doveGrey,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  Text('Team', style: AppTextStyle.semiBoldStyle),
                  SizedBox(width: 35.w),
                  Text(
                    '${widget.numberOfTouristMin} - ${widget.numberOfTourist} Traveller',
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
              padding: EdgeInsets.only(top: 5.h, left: 25.w),
              child: SizedBox(
                height: 50.h,
                child: Row(
                  children: <Widget>[
                    Text(AppTextConstants.activities,
                        style: AppTextStyle.semiBoldStyle),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.subActivityId.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return FutureBuilder<BadgeModelData>(
                              future: APIServices().getBadgesModelById(
                                  widget.subActivityId[index]),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  final BadgeModelData badgeData =
                                      snapshot.data;
                                  final int length =
                                      badgeData.badgeDetails.length;
                                  return Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.harp,
                                            border: Border.all(
                                                color: AppColors.harp),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.r))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                              badgeData.badgeDetails[0].name
                                                  .toString(),
                                              style: TextStyle(
                                                  color: AppColors.nobel)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      )
                                    ],
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
                                          width: 60,
                                          height: 30,
                                          radius: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Container();
                              },
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 25.w),
              child: SizedBox(
                height: 50.h,
                child: Row(
                  children: <Widget>[
                    Text(AppTextConstants.freeServices,
                        style: AppTextStyle.semiBoldStyle),
                    SizedBox(width: 10.w),
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
                              SizedBox(
                                height: 10.h,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: SkeletonText(
                                  width: 400,
                                  height: 200,
                                  radius: 10,
                                ),
                              )
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
                  Text('0.0',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.tealGreen)),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(
                    '(0 Reviews)',
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.osloGrey),
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
                          height: 170.h,
                          width: 200.w,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 170.h,
                                width: 200.w,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.r),
                                  ),
                                  image: DecorationImage(
                                      image: ExtendedImage.network(
                                    packageDestinationImage
                                        .packageDestinationImageDetails[i]
                                        .firebaseSnapshotImg,
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
                return const MainContentSkeletonHorizontal();
              }
              return Container();
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h, left: 25.w),
            child: Text(
              details.description,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.osloGrey),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      );
}
