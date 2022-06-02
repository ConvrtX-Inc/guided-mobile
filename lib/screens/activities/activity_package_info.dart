import 'dart:async';
import 'dart:convert';

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
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/chat_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/tabs/popular_guides_description_tab.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/tabs/popular_guides_traveler_limit_schedules.dart';
import 'package:guided/screens/message/message_screen_traveler.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

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
  ChatModel chatHistory = ChatModel();
  List<Message> messages = [];

  void _onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  List<ActivityPackage> otherPackages = <ActivityPackage>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => addMarker(context));

    debugPrint('Activity ${widget.package.id}');
    _activityPackage = widget.package;

    getPackages();
    getGuideUserDetails();
  }

  Future<void> addMarker(BuildContext context) async {
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
                          Share.share('${widget.package.name!} \n  ${widget.package.firebaseCoverImg!} ${widget.package.description!}');

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
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        child: Row(
          children: <Widget>[
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: '\$${_activityPackage.basePrice}',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp)),
              const TextSpan(
                  text: '/hour', style: TextStyle(color: Colors.grey)),
            ])),
            Spacer(),
            GestureDetector(
              onTap: () {
                checkAvailability(_activityPackage);
              },
              child: Container(
                height: 40.h,
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
        ),
      ),
    );
  }

  Widget buildPackageInfoUI() => !isGettingProfileDetail
      ? Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _activityPackage.name!,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 28.sp),
                    ),
                    SizedBox(height: 10.h),
                    buildLocationDetails(),
                  ],
                ),
              ),
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
                  views: <Widget>[
                    buildDescriptionTab(),
                    PopularGuidesTravelerLimitSchedules(
                        packageId: _activityPackage.id!,
                        price: _activityPackage.basePrice!)
                  ],
                  onChange: setTab,
                  // initialIndex: initIndex,
                ),
              ),
            ],
          ),
        )
      : const Center(child: CircularProgressIndicator());

  //DESCRIPTION TAB
  Widget buildDescriptionTab() => SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.sp),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                              '${AssetsPath.assetsSVGPath}/star.svg'),
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
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 16.h),
                  if (_activityPackage.description!.length >
                      minDescriptionLength)
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
                  if (_activityPackage.description!.length >
                      minDescriptionLength)
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
                  const Divider(color: Colors.grey),
                  Text(
                    'Location',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
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
                              rippleColor:
                                  const Color.fromARGB(255, 6, 134, 49),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.sp),
                      ),
                      subtitle: Text(
                          'Joined in ${DateFormat("MMM yyy").format(DateTime.parse(_activityPackage.createdDate!))}',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: Colors.grey))),
                  Row(
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
                  SizedBox(height: 12.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                    child: Text(
                      'During Your Activity',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                    child: Text(
                      'Response rate: 80%',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                    child: Text(
                      'Response rate: A few minutes or hours or more',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0.h),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          side: BorderSide(color: AppColors.tealGreen),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r))),
                        ),
                        onPressed: getMessageHistory,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                          child: Text('Contact Guide',
                              style: TextStyle(
                                  color: AppColors.tealGreen,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
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
                      title: 'Traveler Release Waiver form',
                      subtitle: 'Lorem Ipsum',
                      showDivider: false),
                ],
              )),
          Divider(
            color: AppColors.gallery,
            thickness: 14.w,
          ),
          if (otherPackages.isNotEmpty) buildOtherOffering()
        ],
      ));

  Widget buildOtherOffering() => Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.h),
          const Text(
            'Other Offering',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: otherPackages.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(right: 5.w),
                  height: 110,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // checkAvailability(
                          //     context, snapshot.data![index]);
                          Navigator.of(context).pushNamed(
                              '/activity_package_info',
                              arguments: otherPackages[index]);
                        },
                        child: Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            border: Border.all(color: AppColors.galleryWhite),
                            image: DecorationImage(
                                image: NetworkImage(
                                  otherPackages[index].firebaseCoverImg!,
                                ),
                                fit: BoxFit.cover),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                bottom: 10,
                                left: 20,
                                child: Image.memory(
                                  base64.decode(otherPackages[index]
                                      .mainBadge!
                                      .imgIcon!
                                      .split(',')
                                      .last),
                                  width: 30,
                                  height: 30,
                                  gaplessPlayback: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        otherPackages[index].name!,
                        overflow: TextOverflow.ellipsis,
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
                                image:
                                    AssetImage('assets/images/png/clock.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            // snapshot.data![index].timeToTravel!,
                            '0.0 hour drive',
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
              },
            ),
          ),
        ],
      ));

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
          {String title = '', String subtitle = '', showDivider: true}) =>
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
          if (showDivider)
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

  Future<void> getPackages() async {
    final List<ActivityPackage> res =
        await APIServices().getGuidePackages(_activityPackage.userId!);
    debugPrint('Res: ${res.length} ${_activityPackage.id}');

    setState(() {
      otherPackages = res
          .where((ActivityPackage element) => element.id != _activityPackage.id)
          .toList();
    });

    debugPrint('Packages ${otherPackages.length}');
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

  Future<void> getMessageHistory() async {
    final List<ChatModel> res = await APIServices()
        .getChatMessages(UserSingleton.instance.user.user!.id!, 'all');

    final ChatModel chat = res.firstWhere(
        (ChatModel element) => element.receiver!.id! == userGuideDetails.id,
        orElse: () => ChatModel());

    setState(() {
      if (chat.messages != null) {
        messages = chat.messages!;
      } else {
        messages = [];
      }
    });

    ChatModel _chatHistory = ChatModel(
        receiver: Receiver(
            fullName: userGuideDetails.fullName,
            id: userGuideDetails.id,
            avatar: userGuideDetails.firebaseProfilePicUrl),
        messages: messages,
        isBlocked: chat.isBlocked);

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MessageScreenTraveler(
                  message: _chatHistory,
                )));
  }
}
