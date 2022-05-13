// ignore_for_file: use_raw_strings, always_put_required_named_parameters_first, diagnostic_describe_all_properties, public_member_api_docs, avoid_dynamic_calls, always_specify_types

import 'dart:convert';

import 'package:custom_marker/marker_icon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'dart:async';

import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';

/// Popular Guides Tab Description
class PopularGuidesTabDescription extends StatefulWidget {
  /// Constructor
  const PopularGuidesTabDescription(
      {Key? key,
      required this.name,
      required this.mainBadgeId,
      required this.description,
      required this.imageUrl,
      required this.numberOfTourist,
      required this.starRating,
      required this.fee,
      required this.address,
      required this.packageId,
      required this.profileImg,
      required this.packageName,
      required this.isFirstAid,
      required this.latitude,
      required this.longitude,
      required this.createdDate})
      : super(key: key);

  final String name,
      mainBadgeId,
      description,
      imageUrl,
      fee,
      address,
      packageId,
      profileImg,
      packageName,
      starRating,
      latitude,
      longitude;

  final int numberOfTourist;

  final bool isFirstAid;

  final DateTime? createdDate;

  @override
  State<PopularGuidesTabDescription> createState() =>
      _PopularGuidesTabDescriptionState();
}

class _PopularGuidesTabDescriptionState
    extends State<PopularGuidesTabDescription>
    with AutomaticKeepAliveClientMixin<PopularGuidesTabDescription> {
  @override
  bool get wantKeepAlive => true;
  Completer<GoogleMapController> _controller = Completer();
  final List<Activity> activities = StaticDataService.getActivityList();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  double latitude = 41;
  double longitude = -18;
  List<Marker> _markers = <Marker>[];
  late Marker mark;
  late Set<Circle> circle;
  String month = '';
  @override
  void initState() {
    super.initState();

    setState(() {
      latitude = double.parse(widget.latitude);
      longitude = double.parse(widget.longitude);
      month = AppListConstants.calendarMonths[widget.createdDate!.month - 1];
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) => addMarker(context));
  }

  Future<void> addMarker(BuildContext context) async {
    setState(() {
      circle = {
        Circle(
          circleId: const CircleId('id1'),
          center: LatLng(
              double.parse(widget.latitude), double.parse(widget.longitude)),
          radius: 500,
        ),
        Circle(
          circleId: const CircleId('id2'),
          center: LatLng(
              double.parse(widget.latitude), double.parse(widget.longitude)),
          radius: 500,
        )
      };
    });

    Marker set = RippleMarker(
      markerId: const MarkerId('LocationId'),
      icon: await MarkerIcon.pictureAsset(
          assetPath: 'assets/images/png/ellipse.png',
          width: 90.w,
          height: 90.h),
      position: LatLng(latitude, longitude),
    );

    setState(() {
      mark = set;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              guideProfile1(widget.name, widget.profileImg),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.w,
                        ),
                        FutureBuilder<BadgeModelData>(
                          future: APIServices()
                              .getBadgesModelById(widget.mainBadgeId),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              final BadgeModelData badgeData = snapshot.data;
                              final int length = badgeData.badgeDetails.length;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Image.memory(
                                    base64.decode(badgeData
                                        .badgeDetails[0].imgIcon
                                        .split(',')
                                        .last),
                                    gaplessPlayback: true,
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: SizedBox(
                                      height: 35.h,
                                      child: Text(
                                        badgeData.badgeDetails[0].name,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Gilroy'),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: SizedBox(
                                      height: 70.h,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, bottom: 20.h),
                                        child: Image(
                                          image: AssetImage(
                                              AssetsPath.forThePlanet),
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    const SkeletonText(
                                      width: 30,
                                      height: 30,
                                      shape: BoxShape.circle,
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                    if (widget.isFirstAid)
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.h, bottom: 17.h, right: 15.w),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.mintGreen,
                              border: Border.all(color: AppColors.mintGreen),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r))),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(AppTextConstants.firstaid,
                                style: TextStyle(
                                    color: AppColors.deepGreen,
                                    fontFamily: 'Gilroy',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      )
                    else
                      Container()
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w, bottom: 10.h),
                child: Text(
                  AppTextConstants.description,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w, bottom: 10.h),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w, bottom: 10.h),
                child: Text(
                  AppTextConstants.location,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Container(
                      height: 15.h,
                      width: 15.w,
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
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        widget.address,
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: AppColors.doveGrey),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                child: Center(
                  child: SizedBox(
                    height: 200.h,
                    width: double.infinity,
                    child: AbsorbPointer(
                      child: Animarker(
                        curve: Curves.bounceInOut,
                        duration: const Duration(milliseconds: 2000),
                        rippleRadius: 0.1,
                        rippleColor: const Color.fromARGB(255, 6, 134, 49),
                        markers: <Marker>{mark},
                        mapId: _controller.future.then<int>(
                            (GoogleMapController value) => value.mapId),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(latitude, longitude),
                            zoom: 15,
                          ),
                          onMapCreated: _onMapCreated,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //     padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              //     child: Text(
              //       'Exact location provided after booking',
              //       style: TextStyle(
              //           fontFamily: 'Gilroy',
              //           fontWeight: FontWeight.w600,
              //           fontSize: 12.sp),
              //     )),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.h, left: 10.w, bottom: 10.h),
                    child: Text(
                      AppTextConstants.reviews,
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: AppColors.deepGreen,
                          size: 15,
                        ),
                        Text(
                          '0 reviews',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Gilroy',
                              color: AppColors.osloGrey,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: EdgeInsets.fromLTRB(10.w, 10.h, 0.w, 0.h),
                  //       child: Container(
                  //         width: 55.w,
                  //         height: 55.h,
                  //         decoration: BoxDecoration(
                  //             boxShadow: <BoxShadow>[
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.8),
                  //                 spreadRadius: 2,
                  //                 blurRadius: 5,
                  //               ),
                  //             ],
                  //             color: Colors.white,
                  //             shape: BoxShape.circle,
                  //             image: const DecorationImage(
                  //                 fit: BoxFit.fitHeight,
                  //                 image: AssetImage(
                  //                     'assets/images/profile-photos-2.png'))),
                  //       ),
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[
                  //         Padding(
                  //             padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                  //             child: Text(
                  //               'Ann Sasha',
                  //               style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontFamily: 'Gilroy',
                  //                   fontSize: 14.sp,
                  //                   fontWeight: FontWeight.w600),
                  //             )),
                  //         Padding(
                  //             padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                  //             child: SizedBox(
                  //               width: 180.w,
                  //               child: Text(
                  //                 'May 6, 2021',
                  //                 style: TextStyle(
                  //                     color: Colors.grey,
                  //                     fontFamily: 'Gilroy',
                  //                     fontSize: 12.sp,
                  //                     fontWeight: FontWeight.w400),
                  //               ),
                  //             )),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // Padding(
                  //   padding:
                  //       EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                  //   child: Text(AppTextConstants.loremIpsum,
                  //       style: TextStyle(
                  //           fontFamily: 'Poppins',
                  //           fontSize: 14.sp,
                  //           color: AppColors.osloGrey,
                  //           fontWeight: FontWeight.w400)),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(0.w, 20.h, 0.w, 0.h),
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width * 0.9,
                  //     child: TextButton(
                  //       style: TextButton.styleFrom(
                  //         side: BorderSide(color: AppColors.tealGreen),
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(10.r))),
                  //       ),
                  //       onPressed: () {
                  //         print('Pressed');
                  //       },
                  //       child: Padding(
                  //         padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                  //         child: Text('Show all 16 reviews',
                  //             style: TextStyle(
                  //                 color: AppColors.tealGreen,
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w700)),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1.w,
                          ),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 40.r,
                          backgroundImage: widget.profileImg != ''
                              ? Image.network(
                                  'https://img.icons8.com/external-coco-line-kalash/344/external-person-human-body-anatomy-coco-line-kalash-4.png',
                                ).image
                              : ExtendedImage.network(
                                  widget.profileImg,
                                  fit: BoxFit.cover,
                                  gaplessPlayback: true,
                                  width: 100,
                                  height: 100,
                                ).image,
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 20.w),
                                child: Text(
                                  widget.name,
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.w),
                                child: Text(
                                  'Joined in $month ${widget.createdDate?.year}',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: 'Gilroy',
                                      color: AppColors.osloGrey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          AssetsPath.iconVerified,
                          width: 20.w,
                          height: 20.h,
                        ),
                        Text(
                          'Identity verified',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                    child: Text(
                      'During Your Activity',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                    child: Text(
                      "I'm available over phone 24/7 for Traveller",
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                    child: Text(
                      'Response rate: 80%',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 10.h),
                    child: Text(
                      'Response rate: A few minutes or hours or more',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0.h),
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width * 0.9,
                  //     child: TextButton(
                  //       style: TextButton.styleFrom(
                  //         side: BorderSide(color: AppColors.tealGreen),
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(10.r))),
                  //       ),
                  //       onPressed: () {
                  //         print('Pressed');
                  //       },
                  //       child: Padding(
                  //         padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                  //         child: Text('Contact Guide',
                  //             style: TextStyle(
                  //                 color: AppColors.tealGreen,
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w700)),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'To protect your payment, never transfer money or communicate outside off the guided website or app',
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Image.asset(
                            AssetsPath.logoSmall,
                            width: 25.w,
                            height: 25.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: Text(
                          AppTextConstants.availability,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 10.w),
                      //   child: const Icon(Icons.arrow_forward_ios),
                      // )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 10.h),
                    child: Text(
                      'Add your travel date for axact pricing',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: Text(
                          AppTextConstants.headerGuideRules,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 10.w),
                      //   child: const Icon(Icons.arrow_forward_ios),
                      // )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 10.h),
                    child: Text(
                      'Follow the guide rules for safety',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: Text(
                          AppTextConstants.healthSafety,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 10.w),
                      //   child: const Icon(Icons.arrow_forward_ios),
                      // )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 10.h),
                    child: Text(
                      'We care about your health & safety',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: Text(
                          AppTextConstants.travelerReleaseAndWaiverForm,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 10.w),
                      //   child: const Icon(Icons.arrow_forward_ios),
                      // )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 10.h),
                    child: Text(
                      AppTextConstants.loremIpsum,
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 10.h),
                  //   child: Row(
                  //     children: <Widget>[
                  //       const Icon(Icons.flag),
                  //       SizedBox(width: 5.w),
                  //       Text(
                  //         'Report this listing',
                  //         style: TextStyle(
                  //           fontFamily: 'Gilroy',
                  //           fontSize: 12.sp,
                  //           fontWeight: FontWeight.w400,
                  //           decoration: TextDecoration.underline,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                    child: Text(
                      'Other Offering',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 15.w, 0.h),
                    child: nearbyActivities(context, activities),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 15.w, 0.h),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '\$${widget.fee}',
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '/hour',
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(20),
                          //   child: SizedBox(
                          //     width: 140.w,
                          //     height: 60.h,
                          //     child: ElevatedButton(
                          //       onPressed: () {},
                          //       style: ElevatedButton.styleFrom(
                          //         shape: RoundedRectangleBorder(
                          //           side: BorderSide(
                          //             color: AppColors.silver,
                          //           ),
                          //           borderRadius: BorderRadius.circular(18.r),
                          //         ),
                          //         primary: AppColors.primaryGreen,
                          //         onPrimary: Colors.white,
                          //       ),
                          //       child: Text(
                          //         AppTextConstants.checkAvailability,
                          //         style: const TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ]),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nearbyActivities(BuildContext context, List<Activity> activities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.26,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(activities.length, (int i) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                height: 180.h,
                width: 168.w,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 112.h,
                      width: 168.w,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.r),
                        ),
                        image: DecorationImage(
                          image: AssetImage(activities[i].featureImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              backgroundImage: AssetImage(activities[i].path),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      activities[i].name,
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
                              image: AssetImage('assets/images/png/clock.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          activities[i].distance,
                          style: TextStyle(
                              color: HexColor('#696D6D'),
                              fontSize: 11.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget guideProfile1(String name, String profileImg) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20.w,
          ),
          Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1.w,
                ),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40.r,
                backgroundImage: profileImg != ''
                    ? Image.network(
                        'https://img.icons8.com/external-coco-line-kalash/344/external-person-human-body-anatomy-coco-line-kalash-4.png',
                      ).image
                    : ExtendedImage.network(
                        profileImg,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        width: 100,
                        height: 100,
                      ).image,
              ),
            ),
            Positioned(
              bottom: 8,
              right: -10,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade400,
                ),
                height: 20.h,
                width: 40.w,
              ),
            )
          ]),
          Expanded(
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: AppColors.deepGreen,
                              size: 15,
                            ),
                            Text(
                              '0 reviews',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy',
                                  color: AppColors.osloGrey,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
}
