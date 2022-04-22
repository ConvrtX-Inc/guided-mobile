// ignore_for_file: public_member_api_docs, use_named_constants, diagnostic_describe_all_properties

import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/discovery_hub.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/models/home.dart';
import 'package:guided/models/hub_outfitter.dart';
import 'package:guided/screens/main_navigation/content/event/widget/event_features.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/outfitter_tab/widget/hub_outfitter_features.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/widget/tab_discovery_hub_features.dart';
import 'package:guided/screens/main_navigation/traveller/traveller_tabbar.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/utils/event.dart';
import 'package:guided/utils/services/static_data_services.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TabDiscoveryHubOutfitter extends StatefulWidget {
  const TabDiscoveryHubOutfitter({Key? key}) : super(key: key);

  @override
  State<TabDiscoveryHubOutfitter> createState() =>
      _TabDiscoveryHubOutfitterState();
}

class _TabDiscoveryHubOutfitterState extends State<TabDiscoveryHubOutfitter> {
  List<HubOutfitter> features = EventUtils.getMockHubOutfitterFeatures();

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
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 20.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const TravellerTabScreen()));
                        },
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
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.arrow_back,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'Back To Category',
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 30.h),
                  child: Text(
                    'My Outfitter',
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
                        return DiscoveryHubOutfitterFeatures(
                          id: features[index].id,
                          title: features[index].title,
                          description: features[index].description,
                          date: features[index].date,
                          price: features[index].price,
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
