import 'dart:async';
import 'dart:convert';
import 'package:custom_marker/marker_icon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activity_availability_hours.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/available_date_model.dart';
import 'package:guided/models/chat_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/wishlist_activity_model.dart';
import 'package:guided/screens/activities/widgets/activity_description.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/tabs/popular_guides_traveler_limit_schedules.dart';
import 'package:guided/screens/message/message_screen_traveler.dart';
import 'package:guided/screens/widgets/reusable_widgets/reviews_count.dart';
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
  final List<Marker> markers = <Marker>[];

  bool showMoreDescription = false;

  Completer<GoogleMapController> _controller = Completer();
  late Set<Circle> circle;
  int minDescriptionLength = 200;
  User userGuideDetails = User();

  bool isGettingProfileDetail = true;
  ChatModel chatHistory = ChatModel();
  List<Message> messages = [];
  bool isFavorite = false;
  List<DateTime> availableDates = [];

  void _onMapCreated(GoogleMapController controller) {
    debugPrint('Map created');
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  List<ActivityPackage> otherPackages = <ActivityPackage>[];

  late BitmapDescriptor markerIcon;

  List<ActivityHourAvailability> availableDateSlots = [];

  String wishlistId = '';

  bool isWishlisted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => addMarker());
    debugPrint('Mars Acticity');

    debugPrint('Activity ${widget.package.id}');
    _activityPackage = widget.package;

    // addMarker();
    getPackages();
    getGuideUserDetails();
    getAvailableDates(_activityPackage.id!);
    checkWishlistData(widget.package.id!);
  }

  Future<void> addMarker() async {
    markerIcon = await MarkerIcon.svgAsset(
        assetName: '${AssetsPath.assetsSVGPath}/location_point.svg',
        context: context,
        size: 35);

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(_activityPackage.id!),
      position: LatLng(
          double.parse(_activityPackage
              .activityPackageDestination!.activityPackageDestinationLatitude!),
          double.parse(_activityPackage.activityPackageDestination!
              .activityPackageDestinationLongitude!)),
      icon: markerIcon, //Icon for Marker
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool value) {
            return [
              SliverAppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    /// Share Icon

                    GestureDetector(
                        onTap: () {
                          Share.share('${widget.package.name!} \n  ${widget.package.firebaseCoverImg!} ${widget.package.description!}');
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.harp,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.share_outlined,
                              color: Colors.black,
                              size: 25.h,
                            ),
                          ),
                        )),

                    SizedBox(
                      width: 8.w,
                    ),

                    GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   isFavorite = !isFavorite;
                        // });

                        if(isWishlisted){
                          setState(() {
                            isWishlisted = false;
                          });
                          removeWishlist(wishlistId);
                        }else{
                          setState(() {
                            isWishlisted = true;
                          });
                          addWishlist(widget.package.id!);
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.harp,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Icon(
                            isWishlisted
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: isWishlisted ? Colors.red : Colors.black,
                            size: 25.h,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                flexibleSpace: ExtendedImage.network(
                  _activityPackage.firebaseCoverImg!,
                  gaplessPlayback: true,
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.transparent,
                pinned: true,
                collapsedHeight: 100.h,
                // floating: true,
                expandedHeight: 200.h,
              )
            ];
          },
          body: Column(
            children: <Widget>[
              SizedBox(height: 20.h),
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
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                margin: EdgeInsets.all(4.w),
                child: TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  labelStyle: AppTextStyle.blackStyle,
                  unselectedLabelStyle: AppTextStyle.greyStyle,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: AppTextConstants.description),
                    Tab(text: AppTextConstants.travelerLimitAndSchedule),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: <Widget>[
                  // buildDescriptionTab(),
                  Activity().buildDescription(
                      activityPackage: _activityPackage,
                      userGuideDetails: userGuideDetails,
                      showMoreDescription: showMoreDescription,
                      mapController: _controller,
                      onMapCreated: () => _onMapCreated,
                      context: context,
                      getMessageHistory: getMessageHistory,
                      otherPackages: otherPackages,
                      mapWidget: buildMap(),
                      onReadMoreCallBack: () {
                        setState(() {
                          showMoreDescription = !showMoreDescription;
                        });
                      },
                      availableDates: availableDates,
                      onAvailabilityPressed: checkAvailability),
                  PopularGuidesTravelerLimitSchedules(
                      packageId: _activityPackage.id!,
                      price: _activityPackage.basePrice!)
                ],
              ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(width: 2, color: AppColors.gallery),
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          child: Row(
            children: <Widget>[
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: '\$${_activityPackage.basePrice}',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 30.sp)),
                const TextSpan(
                    text: '/person', style: TextStyle(color: Colors.grey)),
              ])),
              Spacer(),
              GestureDetector(
                onTap: checkAvailability,
                child: Container(
                  height: 45.h,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                      color: AppColors.deepGreen,
                      borderRadius: BorderRadius.all(Radius.circular(6.w))),
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
      ),
    );
  }

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

  Widget buildMap() => Stack(
        children: <Widget>[
          SizedBox(
              height: 200.h,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      double.parse(_activityPackage.activityPackageDestination!
                          .activityPackageDestinationLatitude!),
                      double.parse(_activityPackage.activityPackageDestination!
                          .activityPackageDestinationLongitude!)),
                  zoom: 15,
                ),
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers: Set<Marker>.of(markers),
              )),
          Positioned(
              bottom: 0,
              child: Container(
                color: AppColors.dirtyWhite,
                padding: EdgeInsets.all(8.w),
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(color: Colors.white10),
                child: const Text('Exact Location Provided after booking'),
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

  void checkAvailability() {
    debugPrint('Mars - Check Availability: ${availableDates}');

    Navigator.pushNamed(context, '/checkActivityAvailabityScreen', arguments: {
      'activityPackage': _activityPackage,
      'availableDateSlots': availableDateSlots,
      'availableDates':availableDates
    });
  }

  Future<void> getMessageHistory() async {
    final List<ChatModel> res = await APIServices().getChatMessages('all');

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

  Future<void> getAvailableDates(String packageId) async {
    debugPrint('Mars - Retrieving available dates');

    final DateTime currentDate = DateTime.now();


    // debugPrint('Mars - Parameters from: ${DateTime.now().toString().toString().substring(0,10)}');
    // debugPrint('Mars - Parameters to: ${DateTime(DateTime.now().year, 12, 31).toString().toString().substring(0,10)}');
    // debugPrint('Mars - Parameters for: ${packageId}');
    final List<ActivityHourAvailability> data =
    // await APIServices().getActivityHours(
    //     DateTime(DateTime.now().year, 5, 11).toString().substring(0,10),
    //     DateTime(DateTime.now().year, 5, 12).toString().substring(0,10),
    //     "195b4734-416b-4603-9235-3dd289ae0348");

    await APIServices().getActivityHours(
            DateTime.now().toString().toString().substring(0,10),
            DateTime(DateTime.now().year, 12, 31).toString().toString().substring(0,10),
            // DateTime(currentDate.year, currentDate.month + 1, 0).toString(),
            packageId);

    if (data.isNotEmpty) {
      debugPrint('Mars - Check Availability data: ${data}');

      setState(() {
        availableDateSlots = data;
      });
      data.forEach((element) {
        // element.availabilityDate=element.availabilityDate?.toString().replaceAll("05", "08");
        debugPrint('Mars - Check Availability element: ${element.availabilityDate}');

        setState(() {
          final DateTime _date = DateTime.parse(element.availabilityDate!);
            availableDates.add(_date);
        });
      });
    } else {
      debugPrint('Mars - No dates retrieved');
    }
  }


  Future<void> checkWishlistData(String id) async {
    final WishlistActivityModel res =
    await APIServices().getWishlistActivityByPackageId(id);

    if (res.wishlistActivityDetails.isNotEmpty) {
      wishlistId = res.wishlistActivityDetails[0].id;
      debugPrint('Wishlist id ${wishlistId}');
      setState(() {
        isWishlisted = true;
      });
    } else {
      setState(() {
        isWishlisted = false;
      });
    }
  }


  /// Removed wishlist
  Future<void> removeWishlist(String id) async {
    final dynamic response = await APIServices().request(
        '${AppAPIPath.wishlistUrl}/$id', RequestType.DELETE,
        needAccessToken: true);

    debugPrint('Response: ${response}');
    setState(() {
      isWishlisted = false;
    });
  }

  /// Returns add wishlist
  Future<void> addWishlist(String packageId) async {
    final String? userId = UserSingleton.instance.user.user!.id;

    final Map<String, dynamic> advertisementDetails = {
      'user_id': userId,
      'activity_package_id': packageId
    };

    final dynamic response = await APIServices().request(
        AppAPIPath.wishlistUrl, RequestType.POST,
        needAccessToken: true, data: advertisementDetails);

    setState(() {
      wishlistId = response['id'];
      // isWishlisted = true;
    });
  }
}
