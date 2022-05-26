import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/contained_tab_bar_view.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_properties.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/tabs/popular_guides_description_tab.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:intl/intl.dart';

///Activity Package Info Screen
class ActivityPackageInfo extends StatefulWidget {
  /// Constructor
  const ActivityPackageInfo({Key? key, required this.package})
      : super(key: key);

  final ActivityPackage package;

  @override
  _ActivityPackageInfoState createState() => _ActivityPackageInfoState();
}

class _ActivityPackageInfoState extends State<ActivityPackageInfo> {
  ActivityPackage _activityPackage = ActivityPackage();
  String _selectedTab = 'Description';
  late Marker mark;
  bool showMoreDescription = false;

  Completer<GoogleMapController> _controller = Completer();
  late Set<Circle> circle;
  int minDescriptionLength = 200;
  User userGuideDetails = User();

  bool isGettingProfileDetail = true;

  void _onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => addMarker(context));

    debugPrint('Activity ${widget.package.id}');
    _activityPackage = widget.package;
    getGuideUserDetails();
  }

  Future<void> addMarker(BuildContext context) async {
    /*setState(() {
      circle = {
        Circle(
          circleId: const CircleId('id1'),
          center: LatLng(
              double.parse(_activityPackage.activityPackageDestination!
                  .activityPackageDestinationLatitude!),
              double.parse(_activityPackage.activityPackageDestination!
                  .activityPackageDestinationLongitude!)),
          radius: 500,
        ),
        Circle(
          circleId: const CircleId('id2'),
          center: LatLng(
              double.parse(_activityPackage.activityPackageDestination!
                  .activityPackageDestinationLatitude!),
              double.parse(_activityPackage.activityPackageDestination!
                  .activityPackageDestinationLongitude!)),
          radius: 500,
        )
      };
    });
*/
    Marker set = RippleMarker(
      markerId: const MarkerId('LocationId'),
      icon: await MarkerIcon.pictureAsset(
          assetPath: 'assets/images/png/ellipse.png',
          width: 90.w,
          height: 90.h),
      position: LatLng(
          double.parse(_activityPackage
              .activityPackageDestination!.activityPackageDestinationLatitude!),
          double.parse(_activityPackage.activityPackageDestination!
              .activityPackageDestinationLongitude!)),
    );

    setState(() {
      mark = set;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Transform.scale(
              scale: 0.8,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 50.w,
                  height: 40.h,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AppColors.harp,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                /// Share Icon
                Transform.scale(
                  scale: 0.8,
                  child: Padding(
                    padding: EdgeInsets.zero,
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
                          Icons.share_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () {
                          // _takeScreenshot(screenArguments['name'],
                          //     '\$${screenArguments['fee']}');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            flexibleSpace: ExtendedImage.network(
              _activityPackage.firebaseCoverImg!,
              gaplessPlayback: true,
              fit: BoxFit.cover,
            ),
          )),
      body: buildPackageInfoUI(),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: '\$${_activityPackage.basePrice}',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 30.sp)),
                const TextSpan(
                    text: '/hour', style: TextStyle(color: Colors.grey)),
              ])),
              Spacer(),
              GestureDetector(
                onTap: (){
                  checkAvailability(_activityPackage);
                },
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                      color: AppColors.deepGreen,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Center(
                    child: Text('Check Availability',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget buildPackageInfoUI() => !isGettingProfileDetail
      ? Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _activityPackage.name!,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.sp),
              ),
              SizedBox(height: 10.h),
              buildLocationDetails(),
              SizedBox(height: 16.h),
              Divider(color: AppColors.grey),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: ContainedTabBarView(
                  tabs: <Widget>[
                    Text(AppTextConstants.description,
                        style: _selectedTab == AppTextConstants.description
                            ? AppTextStyle.blackStyle
                            : AppTextStyle.inactive),
                    Text(AppTextConstants.travelerLimitAndSchedule,
                        style: _selectedTab ==
                                AppTextConstants.travelerLimitAndSchedule
                            ? AppTextStyle.blackStyle
                            : AppTextStyle.inactive),
                  ],
                  tabBarProperties: TabBarProperties(
                    height: 42,
                    margin: const EdgeInsets.all(8),
                    indicatorColor: AppColors.rangooGreen,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            width: 2.w, color: AppColors.rangooGreen),
                        insets: EdgeInsets.symmetric(horizontal: 18.w)),
                    indicatorWeight: 1,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                  ),
                  views: <Widget>[buildDescriptionTab(), Text('Schedule')],
                  onChange: setTab,
                  // initialIndex: initIndex,
                ),
              ),
            ],
          ),
        )
      : const Center(child: CircularProgressIndicator());

  Widget buildDescriptionTab() => Container(
          child: SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
              contentPadding: EdgeInsets.all(2.w),
              leading: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(blurRadius: 3, color: Colors.grey)
                    ],
                  ),
                  child: userGuideDetails.firebaseProfilePicUrl != ''
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              userGuideDetails.firebaseProfilePicUrl!),
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage(
                              '${AssetsPath.assetsPNGPath}/default_profile_pic.png'),
                        )),
              title: Text(
                userGuideDetails.fullName!,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
              ),
              subtitle: Row(
                children: <Widget>[
                  SvgPicture.asset('${AssetsPath.assetsSVGPath}/star.svg'),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text('0 review',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ))
                ],
              )),
          SizedBox(height: 12.h),
          Row(
            children: <Widget>[],
          ),
          Text(
            'Description',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 16.h),
          if (_activityPackage.description!.length > minDescriptionLength)
            Text(
              showMoreDescription
                  ? _activityPackage.description!
                  : '${_activityPackage.description!.substring(0, minDescriptionLength)}...',
              textAlign: TextAlign.justify,
            )
          else
            Text(
              _activityPackage.description!,
              textAlign: TextAlign.justify,
            ),
          SizedBox(height: 16.h),
          if (_activityPackage.description!.length > minDescriptionLength)
            GestureDetector(
              onTap: () {
                setState(() {
                  showMoreDescription = !showMoreDescription;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    showMoreDescription ? 'Read Less' : 'Read More',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.sp,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          SizedBox(height: 20.h),
          Divider(color: Colors.grey),
          Text(
            'Location',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 16.h),
          buildLocationDetails(),
          SizedBox(height: 16.h),
          Center(
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
                          target: LatLng(
                              double.parse(_activityPackage
                                  .activityPackageDestination!
                                  .activityPackageDestinationLatitude!),
                              double.parse(_activityPackage
                                  .activityPackageDestination!
                                  .activityPackageDestinationLongitude!)),
                          zoom: 15,
                        ),
                        onMapCreated: _onMapCreated,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                      ),
                    ),
                  ))),
          SizedBox(height: 16.h),
          ListTile(
              contentPadding: EdgeInsets.all(2.w),
              leading: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(blurRadius: 3, color: Colors.grey)
                    ],
                  ),
                  child: userGuideDetails.firebaseProfilePicUrl != ''
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              userGuideDetails.firebaseProfilePicUrl!),
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage(
                              '${AssetsPath.assetsPNGPath}/default_profile_pic.png'),
                        )),
              title: Text(
                userGuideDetails.fullName!,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
              ),
              subtitle: Text(
                  'Joined in ${DateFormat("MMM yyy").format(DateTime.parse(_activityPackage.createdDate!))}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Colors.grey))),
          SizedBox(height: 16.h),
          buildActivityListButtonItem(
              title: AppTextConstants.availability,
              subtitle: 'Add your travel date for exact pricing'),
          buildActivityListButtonItem(
              title: 'Guide Rules & What To Bring',
              subtitle: 'Follow the guide rules for safety'),
          buildActivityListButtonItem(
              title: 'Health & safety',
              subtitle: 'We  care about your health & safety'),
          buildActivityListButtonItem(
              title: 'Traveler release waiver form', subtitle: 'Lorem Ipsum')
        ],
      )));

  void setTab(int initIndex) {
    switch (initIndex) {
      case 0:
        setState(() {
          _selectedTab = AppTextConstants.description;
        });
        break;
      case 1:
        setState(() {
          _selectedTab = AppTextConstants.travelerLimitAndSchedule;
        });
        break;
    }
  }

  Widget buildLocationDetails() => Row(
        children: <Widget>[
          SvgPicture.asset('${AssetsPath.assetsSVGPath}/location.svg'),
          SizedBox(width: 4.w),
          Expanded(
              child: Text(
            _activityPackage.address!,
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 15.sp),
          ))
        ],
      );

  // Skeleton Texts
  Widget buildFakeProfile() => Row(
        children: <Widget>[
          const SkeletonText(
            shape: BoxShape.circle,
            height: 40,
            width: 40,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SkeletonText(
                height: 15.h,
                width: 100.w,
              ),
              SizedBox(height: 8.h),
              SkeletonText(
                height: 15.h,
                width: 50.w,
              ),
            ],
          )
        ],
      );

  Widget buildActivityListButtonItem(
          {String title = '', String subtitle = ''}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
            ),
            subtitle: Text(subtitle,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: Colors.grey)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      );

  Future<void> getGuideUserDetails() async {
    final User result =
        await APIServices().getUserDetails(_activityPackage.userId!);
    debugPrint('user details: ${_activityPackage.userId}');
    setState(() {
      userGuideDetails = result;
      isGettingProfileDetail = false;
    });
  }

  void checkAvailability(
    ActivityPackage package,
  ) {
    final Map<String, dynamic> details = {
      'package': package,
    };

    Navigator.pushNamed(context, '/checkActivityAvailabityScreen',
        arguments: details);
  }
}
