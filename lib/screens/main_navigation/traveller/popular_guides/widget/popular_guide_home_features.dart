import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart' as show_avatar;
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/package_destination_model.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/popular_guides_list.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widget for home features
class PopularGuideHomeFeatures extends StatefulWidget {
  /// Constructor
  const PopularGuideHomeFeatures({
    String id = '',
    String fullName = '',
    String firebaseProfImg = '',
    Key? key,
  })  : _id = id,
        _fullName = fullName,
        _firebaseProfImg = firebaseProfImg,
        super(key: key);
  final String _id;
  final String _fullName;
  final String _firebaseProfImg;

  @override
  State<PopularGuideHomeFeatures> createState() =>
      _PopularGuideHomeFeaturesState();
}

class _PopularGuideHomeFeaturesState extends State<PopularGuideHomeFeatures>
    with AutomaticKeepAliveClientMixin<PopularGuideHomeFeatures> {
  @override
  bool get wantKeepAlive => true;
  double latitude = 0;
  double longitude = 0;
  double totalDistance = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: _settingModalBottomSheet,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
        height: 180.h,
        width: 220.w,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 112.h,
              width: 220.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
                image: DecorationImage(
                  image: widget._firebaseProfImg == ''
                      ? Image.network(
                          'https://img.icons8.com/external-coco-line-kalash/344/external-person-human-body-anatomy-coco-line-kalash-4.png',
                          width: 50,
                          height: 50,
                        ).image
                      : ExtendedImage.network(
                          widget._firebaseProfImg,
                        ).image,
                  fit: widget._firebaseProfImg == ''
                      ? BoxFit.fitHeight
                      : BoxFit.cover,
                ),
              ),
              // child: Stack(
              //   children: <Widget>[
              //     Positioned(
              //       bottom: 0,
              //       child: CircleAvatar(
              //         backgroundColor: Colors.transparent,
              //         radius: 30,
              //         backgroundImage:
              //             AssetImage(guides[1].path),
              //       ),
              //     ),
              //   ],
              // ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              widget._fullName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.r),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/png/marker.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                FutureBuilder<PackageModelData>(
                  future: APIServices().getPackageDataByUserId(widget._id),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      final PackageModelData packageData = snapshot.data;
                      if (packageData.packageDetails.isEmpty) {
                        return Container();
                      } else {
                        return buildPackageDestination(
                            packageData.packageDetails[0].id);
                      }
                    }
                    return Container();
                  },
                ),
                // Text(
                //   totalDistance.toString(),
                //   style: TextStyle(
                //       color: HexColor('#696D6D'),
                //       fontSize: 11.sp,
                //       fontFamily: 'Gilroy',
                //       fontWeight: FontWeight.normal),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPackageDestination(String id) =>
      FutureBuilder<PackageDestinationModelData>(
        future: APIServices().getPackageDestinationData(id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget _displayWidget;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              _displayWidget = Container();
              break;
            // ignore: no_default_cases
            default:
              if (snapshot.hasError) {
                _displayWidget = Container();
              } else {
                // _displayWidget = Container();

                PackageDestinationModelData packageDestinationData =
                    snapshot.data!;

                latitude = double.parse(packageDestinationData
                    .packageDestinationDetails[0].latitude);
                longitude = double.parse(packageDestinationData
                    .packageDestinationDetails[0].longitude);

                double calculateDistance(lat1, lon1, lat2, lon2) {
                  var p = 0.017453292519943295;
                  var c = cos;
                  var a = 0.5 -
                      c((lat2 - lat1) * p) / 2 +
                      c(lat1 * p) *
                          c(lat2 * p) *
                          (1 - c((lon2 - lon1) * p)) /
                          2;
                  return 12742 * asin(sqrt(a));
                }

                totalDistance =
                    calculateDistance(41.46, -81.51, latitude, longitude);

                _displayWidget = Text(
                  '${totalDistance.toString().substring(0, totalDistance.toString().indexOf('.'))} KM',
                  style: TextStyle(
                      color: HexColor('#696D6D'),
                      fontSize: 11.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.normal),
                );
              }
          }
          return _displayWidget;
        },
      );

  void _settingModalBottomSheet() {
    show_avatar.showAvatarModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      expand: false,
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) => const PopularGuidesList(),
    );
  }
}
