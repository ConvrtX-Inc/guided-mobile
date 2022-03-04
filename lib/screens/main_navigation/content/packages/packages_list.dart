// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/models/home.dart';
import 'package:guided/screens/main_navigation/content/packages/widget/package_features.dart';
import 'package:guided/screens/packages/create_package/create_package_screen.dart';
import 'package:guided/utils/home.dart';

/// Package List Screen
class PackageList extends StatefulWidget {
  /// Constructor
  const PackageList({Key? key}) : super(key: key);

  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  List<HomeModel> features = HomeUtils.getMockFeatures();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          height: 625.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: features.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return PackageFeatures(
                        name: features[index].featureName,
                        imageUrl: features[index].featureImageUrl,
                        numberOfTourist:
                            features[index].featureNumberOfTourists,
                        starRating: features[index].featureStarRating,
                        fee: features[index].featureFee,
                        dateRange: features[index].dateRange,
                      );
                    }),
              ),
              SizedBox(height: 50.h),
              Center(
                  child: Text(
                'This page is currently under development',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp),
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.chateauGreen,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      const CreatePackageScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
