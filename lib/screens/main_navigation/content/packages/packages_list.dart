// ignore_for_file: prefer_const_literals_to_create_immutables, no_default_cases

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/activity_availability_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/screens/main_navigation/content/packages/widget/package_features.dart';
import 'package:guided/screens/packages/create_package/create_package_screen.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Package List Screen
class PackageList extends StatefulWidget {
  /// Constructor
  const PackageList({Key? key}) : super(key: key);

  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList>
    with AutomaticKeepAliveClientMixin<PackageList> {
  @override
  bool get wantKeepAlive => true;

  late Future<PackageModelData> _loadingData;

  @override
  void initState() {
    _loadingData = APIServices().getPackageData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<PackageModelData>(
              future: _loadingData,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget _displayWidget;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    _displayWidget = const MainContentSkeleton();
                    break;
                  default:
                    if (snapshot.hasError) {
                      _displayWidget = Center(
                          child: APIMessageDisplay(
                        message: 'Result: ${snapshot.error}',
                      ));
                    } else {
                      _displayWidget = buildPackageResult(snapshot.data!);
                    }
                }
                return _displayWidget;
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn0',
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

  Widget buildPackageResult(PackageModelData packageData) =>
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (packageData.packageDetails.isEmpty)
              Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 3) - 40),
                child: APIMessageDisplay(
                  message: AppTextConstants.noResultFound,
                ),
              )
            else
              for (PackageDetailsModel detail in packageData.packageDetails)
                buildPackageInfo(detail)
          ],
        ),
      );

  Widget buildPackageInfo(PackageDetailsModel details) => PackageFeatures(
        id: details.id,
        name: details.name,
        mainBadgeId: details.mainBadgeId,
        subBadgeId: details.subBadgeId,
        description: details.description,
        imageUrl: details.coverImg,
        numberOfTouristMin: details.minTraveller,
        numberOfTourist: details.maxTraveller,
        starRating: 0,
        fee: double.parse(details.basePrice),
        dateRange: '1-9',
        services: details.services,
        country: details.country,
        address: details.address,
        extraCost: details.extraCostPerPerson,
        isPublished: details.isPublished,
      );
}
