import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/discovery_hub.dart';
import 'package:guided/models/hub_outfitter.dart';
import 'package:guided/utils/event.dart';

class HubOutfitterView extends StatefulWidget {
  const HubOutfitterView({Key? key}) : super(key: key);

  @override
  State<HubOutfitterView> createState() => _HubOutfitterViewState();
}

class _HubOutfitterViewState extends State<HubOutfitterView> {
  List<HubOutfitter> features = EventUtils.getMockHubOutfitterFeatures();

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
              Image.asset(features[screenArguments['id']].img1,
                  fit: BoxFit.fitHeight),
              Image.asset(features[screenArguments['id']].img2,
                  fit: BoxFit.fitHeight),
              Image.asset(features[screenArguments['id']].img3,
                  fit: BoxFit.fitHeight),
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
                  '\$${features[screenArguments['id']].price}',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 10.h),
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
                  features[screenArguments['id']].date,
                  style: TextStyle(
                      color: AppColors.doveGrey,
                      fontFamily: 'Gilroy',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
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
