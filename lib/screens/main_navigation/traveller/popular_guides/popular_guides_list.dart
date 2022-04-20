// ignore_for_file: file_names, unused_element, always_declare_return_types, prefer_const_literals_to_create_immutables, avoid_print, diagnostic_describe_all_properties, curly_braces_in_flow_control_structures, always_specify_types, avoid_dynamic_calls, avoid_redundant_argument_values, avoid_catches_without_on_clauses, unnecessary_lambdas

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/popular_guide_model.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/widget/popular_guide_features.dart';
import 'package:guided/utils/home.dart';

/// Adding Advertisement Screen
class PopularGuidesList extends StatefulWidget {
  /// Constructor
  const PopularGuidesList({Key? key}) : super(key: key);

  @override
  _PopularGuidesListState createState() => _PopularGuidesListState();
}

class _PopularGuidesListState extends State<PopularGuidesList> {
  List<PopularGuideModel> listPopularGuide = [];

  @override
  void initState() {
    super.initState();
    listPopularGuide = HomeUtils.getPopularGuideNearYou();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Transform.scale(
          scale: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 40.w,
              height: 40.h,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: AppColors.harp,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: width,
            height: height,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    AppTextConstants.popularGuidesNearYou,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gilroy',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                    height: 600.h,
                    child: ListView.builder(
                        itemCount: listPopularGuide.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return PopularGuideFeatures(
                              id: listPopularGuide[index].id,
                              name: listPopularGuide[index].name,
                              mainBadgeId:
                                  listPopularGuide[index].mainBadgeId,
                              location: listPopularGuide[index].location,
                              coverImg: listPopularGuide[index].coverImg,
                              profileImg: listPopularGuide[index].profileImg,
                              starRating: listPopularGuide[index].starRating,
                              isFirstAid: listPopularGuide[index].isFirstAid);
                        })),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
