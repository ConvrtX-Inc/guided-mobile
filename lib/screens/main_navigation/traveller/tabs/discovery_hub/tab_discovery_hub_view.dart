import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/discovery_hub.dart';
import 'package:guided/models/hub_outfitter.dart';
import 'package:guided/utils/event.dart';

class TabDiscoveryHubView extends StatefulWidget {
  const TabDiscoveryHubView({Key? key}) : super(key: key);

  @override
  State<TabDiscoveryHubView> createState() => _TabDiscoveryHubViewState();
}

class _TabDiscoveryHubViewState extends State<TabDiscoveryHubView> {
  List<DiscoveryHub> features = EventUtils.getMockDiscoveryHubFeatures();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
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
                      image: AssetImage(features[screenArguments['id']].img1),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage:
                              AssetImage(features[screenArguments['id']].path),
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
                      image: AssetImage(features[screenArguments['id']].img2),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage:
                              AssetImage(features[screenArguments['id']].path),
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
                      image: AssetImage(features[screenArguments['id']].img3),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage:
                              AssetImage(features[screenArguments['id']].path),
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
                  features[screenArguments['id']].title,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, top: 10.h),
                child: Text(
                  features[screenArguments['id']].date,
                  style: TextStyle(
                      color: AppColors.doveGrey,
                      fontFamily: 'Gilroy',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.w, top: 15.h),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Expanded(
                      child: Row(children: <Widget>[
                    Image.asset(
                      '${AssetsPath.assetsPNGPath}/mark_chen.png',
                      width: 50.w,
                      height: 50.h,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Matt Parker',
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.green[900],
                            ),
                            Text(
                              '16 reviews',
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: AppColors.doveGrey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    ),
                  ])),
                ),
              ),
              Image.asset(
                '${AssetsPath.assetsPNGPath}/phone_circle.png',
                width: 70.w,
                height: 70.h,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Text(
              features[screenArguments['id']].description,
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
