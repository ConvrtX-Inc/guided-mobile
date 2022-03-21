import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';

/// Widget for home features
class DiscoveryHubFeatures extends StatelessWidget {
  /// Constructor
  const DiscoveryHubFeatures({
    int id = 0,
    String title = '',
    String type = '',
    String description = '',
    String date = '',
    String path = '',
    String img1 = '',
    String img2 = '',
    String img3 = '',
    Key? key,
  })  : _id = id,
        _title = title,
        _type = type,
        _description = description,
        _date = date,
        _path = path,
        _img1 = img1,
        _img2 = img2,
        _img3 = img3,
        super(key: key);

  final int _id;
  final String _title;
  final String _type;
  final String _description;
  final String _date;
  final String _path;
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
        Navigator.pushNamed(context, '/discovery_hub_view', arguments: details);
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: DecorationImage(
                      image: AssetImage(_img1), fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(_path),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heartOutlined),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: DecorationImage(
                      image: AssetImage(_img2), fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(_path),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heartOutlined),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                  image: DecorationImage(
                      image: AssetImage(_img3), fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: AssetImage(_path),
                        )),
                    Positioned(
                        top: 9,
                        right: 14,
                        child: Image(
                          image: AssetImage(AssetsPath.heartOutlined),
                          width: 30,
                          height: 30,
                        ))
                  ],
                ),
              ),
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
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy'),
                    )
                  ],
                ),
              )
            ],
          ),
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
            height: 40.h,
          ),
        ],
      ),
    );
  }
}
