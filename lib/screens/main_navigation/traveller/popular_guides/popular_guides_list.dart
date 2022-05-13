// ignore_for_file: file_names, unused_element, always_declare_return_types, prefer_const_literals_to_create_immutables, avoid_print, diagnostic_describe_all_properties, curly_braces_in_flow_control_structures, always_specify_types, avoid_dynamic_calls, avoid_redundant_argument_values, avoid_catches_without_on_clauses, unnecessary_lambdas, public_member_api_docs, always_put_required_named_parameters_first, sort_constructors_first, no_default_cases

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/package_destination_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/user_list_model.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/widget/popular_guide_features.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Adding Advertisement Screen
class PopularGuidesList extends StatefulWidget {
  /// Constructor
  const PopularGuidesList({Key? key}) : super(key: key);

  @override
  _PopularGuidesListState createState() => _PopularGuidesListState();
}

class _PopularGuidesListState extends State<PopularGuidesList> {
  late Future<UserListModel> _loadingData;
  double latitude = 0;
  double longitude = 0;
  String address = '';
  @override
  void initState() {
    super.initState();
    _loadingData = APIServices().getUserListData();
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
                FutureBuilder<UserListModel>(
                  future: _loadingData,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
            )),
          ),
        ),
      ),
    );
  }

  Widget buildResult(UserListModel userListData) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (userListData.userDetails.isEmpty)
              Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 3) - 40),
                child: APIMessageDisplay(
                  message: AppTextConstants.noResultFound,
                ),
              )
            else
              for (UserDetailsModel detail in userListData.userDetails)
                if (!detail.isTraveller) getPackage(detail)
          ],
        ),
      );

  Widget getPackage(UserDetailsModel details) =>
      FutureBuilder<PackageModelData>(
        future: APIServices().getPackageDataByUserId(details.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget _displayWidget;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              _displayWidget = const MainContentSkeleton();
              break;
            // ignore: no_default_cases
            default:
              if (snapshot.hasError) {
                _displayWidget = Container();
              } else {
                final PackageModelData packageData = snapshot.data;
                if (packageData.packageDetails.isEmpty) {
                  return Container();
                } else {
                  return buildPackageDestination(
                      packageData.packageDetails[0].id, details);
                }
              }
          }
          return Container();
        },
      );

  Widget buildPackageDestination(String id, UserDetailsModel details) =>
      FutureBuilder<PackageDestinationModelData>(
        future: APIServices().getPackageDestinationData(id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget _displayWidget;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              _displayWidget = const MainContentSkeleton();
              break;
            // ignore: no_default_cases
            default:
              if (snapshot.hasError) {
                _displayWidget = Container();
              } else {
                PackageDestinationModelData packageDestinationData =
                    snapshot.data!;

                latitude = double.parse(packageDestinationData
                    .packageDestinationDetails[0].latitude);
                longitude = double.parse(packageDestinationData
                    .packageDestinationDetails[0].longitude);
                address =
                    packageDestinationData.packageDestinationDetails[0].name;

                _displayWidget =
                    buildInfo(details, address, latitude, longitude);
              }
          }
          return _displayWidget;
        },
      );

  Widget buildInfo(UserDetailsModel details, String address, double latitude,
          double longitude) =>
      PopularGuideFeatures(
          id: details.id,
          name: details.fullName,
          profileImg: details.firebaseImg,
          starRating: '0',
          isFirstAid: details.isFirstAid,
          isTraveller: details.isTraveller,
          createdDate: details.createdDate,
          address: address,
          latitude: latitude,
          longitude: longitude);
}
