import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/activity_outfitter/activity_outfitter_model.dart';
import 'package:guided/models/outfitter_image_model.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_view.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;

/// Widget for home features
class OutfitterFeature extends StatelessWidget {
  /// Constructor
  const OutfitterFeature({
    String id = '',
    String title = '',
    String imageUrl1 = '',
    String imageUrl2 = '',
    String imageUrl3 = '',
    String price = '',
    String date = '',
    String description = '',
    String productLink = '',
    String country = '',
    String address = '',
    Key? key,
  })  : _id = id,
        _title = title,
        _imageUrl1 = imageUrl1,
        _imageUrl2 = imageUrl2,
        _imageUrl3 = imageUrl3,
        _price = price,
        _date = date,
        _description = description,
        _productLink = productLink,
        _country = country,
        _address = address,
        super(key: key);

  final String _id;
  final String _title;
  final String _imageUrl1;
  final String _imageUrl2;
  final String _imageUrl3;
  final String _price;
  final String _date;
  final String _description;
  final String _productLink;
  final String _country;
  final String _address;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateOutfitterDetails(context),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.r))),
                child: buildImageSlideShow(context)),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _title,
                  style: AppTextStyle.txtStyle,
                ),
                Text(
                  _price,
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
                  _date,
                  style: AppTextStyle.dateStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              _description,
              style: AppTextStyle.descrStyle,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.lightRed),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: const BorderSide(color: Colors.red)))),
                child: Text(
                  AppTextConstants.visitShop,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  // Widget buildImageSlideShow(BuildContext context) => ImageSlideshow(
  //       height: 200.h,
  //       indicatorColor: Colors.white,
  //       onPageChanged: (int value) {},
  //       autoPlayInterval: 3000,
  //       isLoop: true,
  //       children: <Widget>[
  //         Image.memory(
  //           base64.decode(_imageUrl1.split(',').last),
  //           fit: BoxFit.fitHeight,
  //         ),
  //         Image.asset(
  //           _imageUrl2,
  //           fit: BoxFit.fitHeight,
  //         ),
  //         Image.asset(
  //           _imageUrl3,
  //           fit: BoxFit.fitHeight,
  //         ),
  //       ],
  //     );

  Widget buildImageSlideShow(BuildContext context) => ImageSlideshow(
        height: 200.h,
        indicatorColor: Colors.white,
        onPageChanged: (int value) {},
        autoPlayInterval: 3000,
        isLoop: false,
        children: <Widget>[
          // Image.memory(
          //   base64.decode(_imageUrl1.split(',').last),
          //   fit: BoxFit.fitHeight,
          // ),
          // Image.asset(
          //   _imageUrl2,
          //   fit: BoxFit.fitHeight,
          // ),
          // Image.asset(
          //   _imageUrl3,
          //   fit: BoxFit.fitHeight,
          // ),
          FutureBuilder<OutfitterImageModelData>(
            future: APIServices().getOutfitterImageData(_id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget _displayWidget;
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  _displayWidget = const Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                // ignore: no_default_cases
                default:
                  if (snapshot.hasError) {
                    _displayWidget = Center(
                        child: APIMessageDisplay(
                      message: 'Result: ${snapshot.error}',
                    ));
                  } else {
                    _displayWidget =
                        buildOutfitterImageResult(snapshot.data!, context);
                  }
              }
              return _displayWidget;
            },
          )
        ],
      );
  // FutureBuilder<OutfitterImageModelData>(
  //   future: APIServices().getOutfitterImageData(),
  //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //     Widget _displayWidget;
  //     switch (snapshot.connectionState) {
  //       case ConnectionState.waiting:
  //         _displayWidget = const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //         break;
  //       // ignore: no_default_cases
  //       default:
  //         if (snapshot.hasError) {
  //           _displayWidget = Center(
  //               child: APIMessageDisplay(
  //             message: 'Result: ${snapshot.error}',
  //           ));
  //         } else {
  //           _displayWidget =
  //               buildOutfitterImageResult(snapshot.data!, context);
  //         }
  //     }
  //     return _displayWidget;
  //   },
  // );

  Widget buildOutfitterImageResult(
          OutfitterImageModelData outfitterImageData, BuildContext context) =>
      Row(
        children: <Widget>[
          if (outfitterImageData.outfitterImageDetails.isEmpty)
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 3) - 40),
              child: APIMessageDisplay(
                message: AppTextConstants.noResultFound,
              ),
            )
          else
            for (OutfitterImageDetailsModel imageDetail
                in outfitterImageData.outfitterImageDetails)
              if (_id == imageDetail.activityOutfitterId)
                buildOutfitterImageInfo(imageDetail)
        ],
      );

  Widget buildOutfitterImageInfo(OutfitterImageDetailsModel details) =>
      Image.memory(
        base64.decode(details.snapshotImg.split(',').last),
        fit: BoxFit.fitHeight,
      );

  /// Navigate to Outfitter View
  Future<void> navigateOutfitterDetails(BuildContext context) async {
    final Map<String, dynamic> details = {
      'id': _id,
      'title': _title,
      'price': _price,
      'product_link': _productLink,
      'country': _country,
      'description': _description,
      'date': _date,
      'address': _address
    };

    await Navigator.pushNamed(context, '/outfitter_view', arguments: details);
  }
}
