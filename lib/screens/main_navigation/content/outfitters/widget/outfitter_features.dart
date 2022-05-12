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
import 'package:guided/models/outfitter_image_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget for home features
class OutfitterFeature extends StatefulWidget {
  /// Constructor
  const OutfitterFeature({
    String id = '',
    String title = '',
    String imageUrl1 = '',
    String imageUrl2 = '',
    String imageUrl3 = '',
    String price = '',
    String date = '',
    // required DateTime? availabilityDate,
    String availabilityDate = '',
    String description = '',
    String productLink = '',
    String country = '',
    String address = '',
    String street = '',
    String city = '',
    String province = '',
    String zipCode = '',
    bool isPublished = false,
    Key? key,
  })  : _id = id,
        _title = title,
        _imageUrl1 = imageUrl1,
        _imageUrl2 = imageUrl2,
        _imageUrl3 = imageUrl3,
        _price = price,
        _date = date,
        _availabilityDate = availabilityDate,
        _description = description,
        _productLink = productLink,
        _country = country,
        _address = address,
        _street = street,
        _city = city,
        _province = province,
        _zipCode = zipCode,
        _isPublished = isPublished,
        super(key: key);

  final String _id;
  final String _title;
  final String _imageUrl1;
  final String _imageUrl2;
  final String _imageUrl3;
  final String _price;
  final String _date;
  // final DateTime? _availabilityDate;
  final String _availabilityDate;
  final String _description;
  final String _productLink;
  final String _country;
  final String _address;
  final String _street;
  final String _city;
  final String _province;
  final String _zipCode;
  final bool _isPublished;

  @override
  State<OutfitterFeature> createState() => _OutfitterFeatureState();
}

class _OutfitterFeatureState extends State<OutfitterFeature> {
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
    return widget._isPublished
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: buildSlider(context)),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget._title,
                        style: TextStyle(
                            fontSize: RegExp(r"\w+(\'\w+)?")
                                        .allMatches(widget._title)
                                        .length >
                                    5
                                ? 10.sp
                                : 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      widget._price,
                      style: AppTextStyle.txtStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 15,
                      color: AppColors.osloGrey,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      widget._date,
                      style: AppTextStyle.dateStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget._description,
                  style: AppTextStyle.descrStyle,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.lightRed),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                    side:
                                        const BorderSide(color: Colors.red)))),
                    child: Text(
                      AppTextConstants.visitShop,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      await openBrowserURL(
                          url: 'https://${widget._productLink}', inApp: true);
                    },
                  ),
                ],
              ),
            ],
          )
        : Container();
  }

  Widget buildSlider(BuildContext context) =>
      FutureBuilder<OutfitterImageModelData>(
        future: APIServices().getOutfitterImageData(widget._id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final OutfitterImageModelData outfitterImage = snapshot.data;
            final int length = outfitterImage.outfitterImageDetails.length;
            imageCount = length;

            for (int i = 0; i < imageCount; i++) {
              imageList.add(
                  outfitterImage.outfitterImageDetails[i].firebaseSnapshotImg);
              imageIdList.add(outfitterImage.outfitterImageDetails[i].id);
            }

            return Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  CarouselSlider.builder(
                      itemCount: length,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: 300.h,
                        viewportFraction: 1,
                        onPageChanged:
                            (int index, CarouselPageChangedReason reason) =>
                                setState(() => activeIndex = index),
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        final OutfitterImageDetailsModel imgData =
                            outfitterImage.outfitterImageDetails[index];

                        return buildImage(imgData, index);
                      }),
                  if (length == 1) Container(),
                  if (length == 0)
                    GestureDetector(
                        onTap: () {
                          navigateOutfitterDetails(context, '');
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

  Widget buildImage(OutfitterImageDetailsModel imgData, int index) =>
      GestureDetector(
        onTap: () {
          navigateOutfitterDetails(context, imgData.firebaseSnapshotImg);
        },
        child: ExtendedImage.network(
          imgData.firebaseSnapshotImg,
          fit: BoxFit.cover,
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

  /// Navigate to Outfitter View
  Future<void> navigateOutfitterDetails(
      BuildContext context, String snapshotImg) async {
    final Map<String, dynamic> details = {
      'id': widget._id,
      'title': widget._title,
      'price': widget._price,
      'product_link': widget._productLink,
      'country': widget._country,
      'description': widget._description,
      'date': widget._date,
      'availability_date': widget._availabilityDate,
      'address': widget._address,
      'street': widget._street,
      'city': widget._city,
      'province': widget._province,
      'zip_code': widget._zipCode,
      'snapshot_img': snapshotImg,
      'image_count': imageCount,
      'image_list': imageList,
      'image_id_list': imageIdList
    };

    await Navigator.pushNamed(context, '/outfitter_view', arguments: details);
  }
}
