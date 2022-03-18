// ignore_for_file: public_member_api_docs, use_named_constants, diagnostic_describe_all_properties

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/models/discovery_hub.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/widget/tab_discovery_hub_features.dart';
import 'package:guided/utils/event.dart';


class TabDiscoveryHub extends StatefulWidget {
  const TabDiscoveryHub({Key? key}) : super(key: key);

  @override
  State<TabDiscoveryHub> createState() => _TabDiscoveryHubState();
}

class _TabDiscoveryHubState extends State<TabDiscoveryHub> {
  List<DiscoveryHub> features = EventUtils.getMockDiscoveryHubFeatures();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 0.h),
                      child: Container(
                        height: 60.h,
                        width: 58.w,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.r),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/png/green_house_outlined.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.w, 0.h, 15.w, 0.h),
                        child: TextField(
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(fontSize: 16.sp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(22),
                            fillColor: Colors.white,
                            prefixIcon: IconButton(
                              icon: Image.asset(
                                'assets/images/png/search_icon.png',
                                width: 20.w,
                                height: 20.h,
                              ),
                              onPressed: null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            height: 80.h,
                            width: 80.w,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/png/green_flag.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Events',
                            style: TextStyle(
                              color: AppColors.primaryGreen,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/discovery_hub_outfitter');
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 9.h,
                          ),
                          Container(
                            height: 70.h,
                            width: 70.w,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 70.h,
                                width: 70.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/png/red_shirt.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 9.h,
                          ),
                          Text(
                            'Outfitter',
                            style: TextStyle(
                              color: AppColors.lightRed,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Text(
                    'Discovery Hub',
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: features.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return DiscoveryHubFeatures(
                          id: features[index].id,
                          title: features[index].title,
                          description: features[index].description,
                          date: features[index].date,
                          path: features[index].path,
                          img1: features[index].img1,
                          img2: features[index].img2,
                          img3: features[index].img3,
                        );
                      }),
                ),
              ]),
        ),
      )),
    );
  }
}
