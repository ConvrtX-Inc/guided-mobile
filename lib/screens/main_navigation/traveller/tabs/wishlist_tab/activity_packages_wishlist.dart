// ignore_for_file: prefer_const_literals_to_create_immutables, no_default_cases, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/package_destination_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/wishlist_activity_model.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/wishlist_tab/widget/activity_package_wishlist_features.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Package List Screen
class ActivityPackagesWishlist extends StatefulWidget {
  /// Constructor
  const ActivityPackagesWishlist({Key? key}) : super(key: key);

  @override
  _ActivityPackagesWishlistState createState() =>
      _ActivityPackagesWishlistState();
}

class _ActivityPackagesWishlistState extends State<ActivityPackagesWishlist>
    with AutomaticKeepAliveClientMixin<ActivityPackagesWishlist> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<WishlistActivityModel>(
              future: APIServices().getWishlistActivityData(),
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
                      _displayWidget = buildResult(snapshot.data!);
                    }
                }
                return _displayWidget;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildResult(WishlistActivityModel wishlistData) => Column(
        children: <Widget>[
          if (wishlistData.wishlistActivityDetails.isEmpty)
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 3) - 40),
              child: APIMessageDisplay(
                message: AppTextConstants.noResultFound,
              ),
            )
          else
            for (WishlistActivityDetailsModel detail
                in wishlistData.wishlistActivityDetails)
              buildInfo(detail)
        ],
      );

  Widget buildInfo(WishlistActivityDetailsModel details) =>
      FutureBuilder<PackageDestinationModelData>(
        future:
            APIServices().getPackageDestinationData(details.activityPackageId),
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
                _displayWidget = buildPackageDestinationResult(
                    snapshot.data!, details.activityPackageId);
              }
          }
          return _displayWidget;
        },
      );

  Widget buildPackageDestinationResult(
          PackageDestinationModelData packageDestinationData,
          String activityPackageId) =>
      Column(
        children: <Widget>[
          if (packageDestinationData.packageDestinationDetails.isEmpty)
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 3) - 40),
              child: APIMessageDisplay(
                message: AppTextConstants.noResultFound,
              ),
            )
          else
            for (PackageDestinationDetailsModel detail
                in packageDestinationData.packageDestinationDetails)
              buildPackageDestinationInfo(detail, activityPackageId)
        ],
      );

  Widget buildPackageDestinationInfo(
          PackageDestinationDetailsModel details, String activityPackageId) =>
      FutureBuilder<PackageModelData>(
        future: APIServices().getPackageDataById(activityPackageId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget _displayWidget;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              _displayWidget = Container();
              break;
            default:
              if (snapshot.hasError) {
                _displayWidget = Center(
                    child: APIMessageDisplay(
                  message: 'Result: ${snapshot.error}',
                ));
              } else {
                PackageModelData data = snapshot.data!;
                _displayWidget = ActivityPackageWishlistFeature(
                    id: details.id,
                    coverImg: data.packageDetails[0].firebaseCoverImg,
                    packageName: data.packageDetails[0].name,
                    price: data.packageDetails[0].basePrice,
                    mainBadgeId: data.packageDetails[0].mainBadgeId,
                    description: data.packageDetails[0].description,
                    numberOfTourist:
                        data.packageDetails[0].maxTraveller,
                    starRating: '0',
                    fee: data.packageDetails[0].basePrice,
                    address: details.name,
                    packageId: data.packageDetails[0].id,
                    latitude: details.latitude,
                    longitude: details.longitude);
              }
          }
          return _displayWidget;
        },
      );
}
