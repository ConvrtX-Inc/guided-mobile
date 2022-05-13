// ignore_for_file: avoid_dynamic_calls, avoid_bool_literals_in_conditional_expressions, no_default_cases

import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/package_destination_image_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/screens/widgets/reusable_widgets/white_border.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Widget for home features
class ActivityPackageWishlistFeature extends StatefulWidget {
  /// Constructor
  const ActivityPackageWishlistFeature({
    String id = '',
    String coverImg = '',
    String packageName = '',
    String price = '',
    String mainBadgeId = '',
    String description = '',
    int numberOfTourist = 0,
    String starRating = '',
    String fee = '',
    String address = '',
    String packageId = '',
    String latitude = '',
    String longitude = '',
    Key? key,
  })  : _id = id,
        _coverImg = coverImg,
        _packageName = packageName,
        _price = price,
        _mainBadgeId = mainBadgeId,
        _description = description,
        _numberOfTourist = numberOfTourist,
        _starRating = starRating,
        _fee = fee,
        _address = address,
        _packageId = packageId,
        _latitude = latitude,
        _longitude = longitude,
        super(key: key);

  final String _id;
  final String _coverImg;
  final String _packageName;
  final String _price;
  final String _mainBadgeId;
  final String _description;
  final int _numberOfTourist;
  final String _starRating;
  final String _fee;
  final String _address;
  final String _packageId;
  final String _latitude;
  final String _longitude;

  @override
  State<ActivityPackageWishlistFeature> createState() =>
      _ActivityPackageWishlistFeatureState();
}

class _ActivityPackageWishlistFeatureState
    extends State<ActivityPackageWishlistFeature> {
  late List<String> imageList;
  late List<String> imageIdList;
  int activeIndex = 0;
  int imageCount = 0;
  String name = '';
  String profileImg = '';
  bool? isFirstAid = false;
  DateTime? createdDate;
  @override
  void initState() {
    super.initState();
    imageList = [];
    imageIdList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(child: buildSlider(context)),
        ),
        SizedBox(height: 10.h),
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
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget._packageName,
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
              '\$${widget._price}/Person',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        FutureBuilder<PackageModelData>(
          future: APIServices().getPackageDataById(widget._packageId),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            Widget _displayWidget;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                _displayWidget = Container();
                break;
              default:
                if (snapshot.hasError) {
                  _displayWidget = Container();
                } else {
                  _displayWidget = buildPackageResult(snapshot.data!);
                }
            }
            return _displayWidget;
          },
        ),
      ],
    );
  }

  Widget buildPackageResult(PackageModelData packageData) => Column(
        children: <Widget>[
          if (packageData.packageDetails.isEmpty)
            Container()
          else
            for (PackageDetailsModel detail in packageData.packageDetails)
              buildGuideProfile(detail),
        ],
      );

  Widget buildGuideProfile(PackageDetailsModel details) =>
      FutureBuilder<ProfileDetailsModel>(
        future: APIServices().getProfileDataById(details.userId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget _displayWidget;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              _displayWidget = Container();
              break;
            default:
              if (snapshot.hasError) {
                _displayWidget = Container();
              } else {
                _displayWidget = Container();
                ProfileDetailsModel details = snapshot.data!;

                name = details.fullName;
                profileImg = details.firebaseProfilePicUrl;
                isFirstAid = details.isFirstAidTrained;
                createdDate = details.createdDate;
              }
          }
          return _displayWidget;
        },
      );

  Widget buildSlider(BuildContext context) =>
      FutureBuilder<PackageDestinationImageModelData>(
        future: APIServices().getPackageDestinationImageData(widget._id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final PackageDestinationImageModelData packageDestinationImage =
                snapshot.data;
            final int length =
                packageDestinationImage.packageDestinationImageDetails.length;
            imageCount = length;

            for (int i = 0; i < imageCount; i++) {
              imageList.add(packageDestinationImage
                  .packageDestinationImageDetails[i].firebaseSnapshotImg);
              imageIdList.add(
                  packageDestinationImage.packageDestinationImageDetails[i].id);
            }

            return ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  CarouselSlider.builder(
                      itemCount: length,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        onPageChanged:
                            (int index, CarouselPageChangedReason reason) =>
                                setState(() => activeIndex = index),
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        final PackageDestinationImageDetailsModel imgData =
                            packageDestinationImage
                                .packageDestinationImageDetails[index];

                        return buildImage(imgData, index, length);
                      }),
                  if (length == 1) Container(),
                  if (length == 0)
                    GestureDetector(
                        onTap: () {
                          // navigateOutfitterDetails(context, '');
                        },
                        child: SizedBox(
                          width: 300.w,
                          height: 300.h,
                          child: const Text(''),
                        ))
                  else
                    Positioned(
                      bottom: 10,
                      child: buildIndicator(length),
                    ),
                  Positioned(
                      top: 9,
                      right: 14,
                      child: Image(
                        image: AssetImage(AssetsPath.heart),
                        width: 30,
                        height: 30,
                      )),
                  FutureBuilder<BadgeModelData>(
                    future:
                        APIServices().getBadgesModelById(widget._mainBadgeId),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        final BadgeModelData badgeData = snapshot.data;
                        final int length = badgeData.badgeDetails.length;
                        return Positioned(
                          left: 10,
                          bottom: 10,
                          child: Row(
                            children: <Widget>[
                              WhiteBorderBadge(
                                base64Image: badgeData.badgeDetails[0].imgIcon,
                              ),
                            ],
                          ),
                        );
                      }
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Positioned(
                          left: 10,
                          bottom: 10,
                          child: SkeletonText(
                            height: 30,
                            width: 30,
                            radius: 10,
                            shape: BoxShape.circle,
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            );
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const SkeletonText(
              height: 200,
              width: 900,
              radius: 10,
            );
          }
          return Container();
        },
      );

  Widget buildImage(
          PackageDestinationImageDetailsModel imgData, int index, int length) =>
      GestureDetector(
        onTap: () {
          navigatePackageDetails(imgData.firebaseSnapshotImg);
        },
        child: ExtendedImage.network(
          imgData.firebaseSnapshotImg,
          fit: BoxFit.cover,
          gaplessPlayback: true,
          width: 500,
          height: 200,
        ),
      );

  Widget buildIndicator(int count) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: count,
        effect: SlideEffect(
            activeDotColor: Colors.white,
            dotColor: Colors.grey.shade800,
            dotHeight: 10.h,
            dotWidth: 10.w),
      );

  /// Navigate to Popular Guides Near You! View
  Future<void> navigatePackageDetails(String firebaseCoverImg) async {
    final Map<String, dynamic> details = {
      'id': widget._id,
      'name': name,
      'main_badge_id': widget._mainBadgeId,
      'description': widget._description,
      'image_url': widget._coverImg,
      'number_of_tourist': widget._numberOfTourist,
      'star_rating': widget._starRating,
      'fee': widget._price,
      'address': widget._address,
      'package_id': widget._packageId,
      'profile_img': profileImg,
      'package_name': widget._packageName,
      'is_first_aid': isFirstAid,
      'firebase_cover_img': firebaseCoverImg,
      'latitude': widget._latitude,
      'longitude': widget._longitude,
      'created_date': createdDate
    };

    await Navigator.pushNamed(context, '/popular_guides_view',
        arguments: details);
  }
}
