// ignore_for_file: file_names, unused_element, always_declare_return_types, prefer_const_literals_to_create_immutables, avoid_print, diagnostic_describe_all_properties, curly_braces_in_flow_control_structures, always_specify_types, avoid_dynamic_calls, avoid_redundant_argument_values, avoid_catches_without_on_clauses, unnecessary_lambdas, public_member_api_docs, always_put_required_named_parameters_first, sort_constructors_first, no_default_cases

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/popular_guide_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/widget/popular_guide_features.dart';
import 'package:guided/utils/home.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Adding Advertisement Screen
class PopularGuidesList extends StatefulWidget {
  /// Constructor
  const PopularGuidesList({Key? key}) : super(key: key);

  @override
  _PopularGuidesListState createState() => _PopularGuidesListState();
}

class _PopularGuidesListState extends State<PopularGuidesList> {
  List<PopularGuideModel> listPopularGuide = [];
  late Future<List<User>> _loadingData;
  @override
  void initState() {
    super.initState();
    listPopularGuide = HomeUtils.getPopularGuideNearYou();
    _loadingData = APIServices().getPopularGuides();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                Align(
                  child: Image.asset(
                    AssetsPath.horizontalLine,
                    width: 60.w,
                    height: 5.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 0.h, 20.w, 0.h),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back))),
                ),
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
                FutureBuilder<List<User>>(
                    future: _loadingData, // async work
                    builder: (BuildContext context,
                        AsyncSnapshot<List<User>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            return GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                height: 600.h,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: List<Widget>.generate(
                                      snapshot.data!.length, (int i) {
                                    return PopularGuideFeatures(
                                        id: snapshot.data![i].id,
                                        name: snapshot.data![i].fullName,
                                        profileImg: '',
                                        starRating: '0',
                                        isFirstAid: snapshot
                                            .data![i].isFirstAidTrained);
                                  }),
                                ),
                              ),
                            );
                          }
                      }
                    }),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
