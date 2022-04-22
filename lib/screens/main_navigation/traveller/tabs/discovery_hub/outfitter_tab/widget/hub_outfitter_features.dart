import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';

/// Widget for home features
class DiscoveryHubOutfitterFeatures extends StatelessWidget {
  /// Constructor
  const DiscoveryHubOutfitterFeatures({
    int id = 0,
    String title = '',
    String description = '',
    String date = '',
    String price = '',
    String img1 = '',
    String img2 = '',
    String img3 = '',
    Key? key,
  })  : _id = id,
        _title = title,
        _description = description,
        _date = date,
        _price = price,
        _img1 = img1,
        _img2 = img2,
        _img3 = img3,
        super(key: key);

  final int _id;
  final String _title;
  final String _description;
  final String _date;
  final String _price;
  final String _img1;
  final String _img2;
  final String _img3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final Map<String, dynamic> details = {
          'id': _id,
        };
        Navigator.pushNamed(context, '/discovery_hub_outfitter_view',
            arguments: details);
      },
      child: Column(
        children: <Widget>[
          ImageSlideshow(
            width: 375,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.white,
            indicatorBackgroundColor: Colors.grey[100],
            autoPlayInterval: 3000,
            isLoop: true,
            children: <Widget>[
              Image.asset(_img1, fit: BoxFit.fitHeight),
              Image.asset(_img2, fit: BoxFit.fitHeight),
              Image.asset(_img3, fit: BoxFit.fitHeight),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 10.h),
                child: Text(
                  _title,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, top: 10.h),
                child: Text(
                  '\$$_price',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(
                top: 10.h,
                left: 20.w,
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.calendar_month,
                    size: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    _date,
                    style: TextStyle(
                        color: AppColors.doveGrey,
                        fontFamily: 'Gilroy',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Text(
              _description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  height: 2),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Row(
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
                    AppTextConstants.visitSite,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    final Map<String, dynamic> details = {
                      'id': _id,
                    };
                    Navigator.pushNamed(
                        context, '/discovery_hub_outfitter_view',
                        arguments: details);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
        ],
      ),
    );
  }
}
