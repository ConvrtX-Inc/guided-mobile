// ignore_for_file: avoid_dynamic_calls, avoid_bool_literals_in_conditional_expressions
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/outfitter_image_model.dart';
import 'package:guided/models/package_destination_image_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget for home features
class ActivityPackageWishlistFeature extends StatefulWidget {
  /// Constructor
  const ActivityPackageWishlistFeature({
    String id = '',
    String coverImg = '',
    String packageName = '',
    String price = '',
    String mainBadgeId = '',
    Key? key,
  })  : _id = id,
        _coverImg = coverImg,
        _packageName = packageName,
        _price = price,
        _mainBadgeId = mainBadgeId,
        super(key: key);

  final String _id;
  final String _coverImg;
  final String _packageName;
  final String _price;
  final String _mainBadgeId;

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
        )
      ],
    );
  }

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
                        height: 350,
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
                              Image.memory(
                                base64.decode(badgeData.badgeDetails[0].imgIcon
                                    .split(',')
                                    .last),
                                gaplessPlayback: true,
                              )
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
        onTap: () {},
        child: ExtendedImage.network(
          imgData.firebaseSnapshotImg,
          fit: BoxFit.fill,
          gaplessPlayback: true,
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

  Future<void> openBrowserURL({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: inApp, // iOS
          forceWebView: inApp, // Android
          enableJavaScript: true // Android
          );
    }
  }

  // /// Navigate to Outfitter View
  // Future<void> navigateOutfitterDetails(
  //     BuildContext context, String snapshotImg) async {
  //   final Map<String, dynamic> details = {
  //     'id': widget._id,
  //     'title': widget._title,
  //     'price': widget._price,
  //     'product_link': widget._productLink,
  //     'country': widget._country,
  //     'description': widget._description,
  //     'date': widget._date,
  //     'availability_date': widget._availabilityDate,
  //     'address': widget._address,
  //     'street': widget._street,
  //     'city': widget._city,
  //     'province': widget._province,
  //     'zip_code': widget._zipCode,
  //     'snapshot_img': snapshotImg,
  //     'image_count': imageCount,
  //     'image_list': imageList,
  //     'image_id_list': imageIdList
  //   };

  //   await Navigator.pushNamed(context, '/outfitter_view', arguments: details);
  // }
}
