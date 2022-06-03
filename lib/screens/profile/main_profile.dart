import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:google_maps_webservice/staticmap.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:google_static_maps_controller/google_static_maps_controller.dart';
// import 'package:google_maps_webservice/staticmap.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/certificate.dart';
import 'package:guided/models/profile_image.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/image_viewers/profile_photos_viewer.dart';
import 'package:guided/screens/profile/profile_widgets.dart';
import 'package:guided/screens/profile/reviews_profile.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/geolocation_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:location/location.dart';

// ignore: public_member_api_docs
class MainProfileScreen extends StatefulWidget {
  ///Constructor
  const MainProfileScreen({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  // static const String _API_KEY = 'AIzaSyCPF7ygz63Zj5RWZ_wU4G61JTynfPRjOMg';
  // final Completer<GoogleMapController> _controller = Completer();

  // CameraPosition _currentPosition = CameraPosition(
  //   target: LatLng(13.0827, 80.2707),
  //   zoom: 12,
  // );
  // LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  // late GoogleMapController _controller;
  // Location _location = Location();

  // void _onMapCreated(GoogleMapController _cntlr) {
  //   _controller = _cntlr;
  //   _location.onLocationChanged.listen((loc) {
  //     _controller.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //             target: LatLng(loc.latitude!, loc.longitude!), zoom: 15),
  //       ),
  //     );
  //   });
  // }
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(27.7089427, 85.3086209);

  //location to show in map
  User userGuideDetails = User();
  UserProfileImage profileImages = UserProfileImage();
  List<Certificate> certificates = <Certificate>[];
  List<ActivityPackage> packages = <ActivityPackage>[];

  bool isLoadingProfileDetails = true;
  bool isLoadingCertificates = true;
  bool isLoadingPackages = true;
  bool isLoadingProfileImages = true;

  String currentAddress = '';

  @override
  void initState() {
    debugPrint('guide id  ${widget.userId}');

    //you can add more markers here
    super.initState();

    getGuideUserDetails();
    getPackages();
    getCertificates();
  }

  // final Completer<GoogleMapController> _controller = Completer();
  String googleMapsApi = 'AIzaSyCIag8Y1v3gmGnF55sGh4ocFnZq6qsEnKM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: buildGuideProfile());
  }

  Widget buildGuideProfile() => SafeArea(
          child: SingleChildScrollView(
        child: isLoadingProfileDetails &&
                isLoadingPackages &&
                isLoadingProfileImages
            ? buildLoadingData()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  backButton(context),
                  buildUserDetails(),
                  /*  const SizedBox(height: 20),
            buildCircleAvatar(userGuideDetails.firebaseProfilePicUrl!),
            SizedBox(height: 14.h),
            Center(
              child: Text(
                userGuideDetails.fullName!,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
              ),
            ),*/

                  const SizedBox(height: 20),
                  if (userGuideDetails.about != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            'About Me',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(userGuideDetails.about!),
                        ),
                      ],
                    ),
                  if (profileImages.imageUrl1.isNotEmpty) buildProfileImages(),
                  if (packages.isNotEmpty)
                    Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: buildNearbyActivities()),
                  if (certificates.isNotEmpty) buildCertificates(),
                  const SizedBox(height: 20),
                  if(currentAddress.isNotEmpty)
                    buildLocationSection(),
                  const SizedBox(height: 20),
                  divider(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const ReviewsProfileScreen()));
                            },
                            child: const Text(
                              'Reviews',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xff056028),
                              ),
                            )),
                      ),
                      Row(
                        children: const <Widget>[
                          Icon(
                            Icons.star,
                            color: Color(0xff056028),
                            size: 14,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              '0 Reviews',
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
      ));

  // UI FOR LOADING DATA
  Widget buildLoadingData() => Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    SizedBox(height: 30.h),
                    SkeletonText(
                      shape: BoxShape.circle,
                      height: 110.h,
                      width: 110.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SkeletonText(
                      height: 15.h,
                      width: 100.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SkeletonText(
                      height: 15.h,
                      width: 60.w,
                    ),
                  ])),
              SizedBox(height: 20.h),
              SkeletonText(
                height: 15.h,
                width: 260.w,
              ),
              SizedBox(height: 10.h),
              SkeletonText(
                height: 15.h,
                width: 200.w,
              ),
              SizedBox(height: 20.h),
              buildLoadingDataList(),
              SizedBox(height: 20.h),
              Center(
                child: SkeletonText(
                  height: 200.h,
                  width: 350.w,
                ),
              )
            ]),
      );

  //PROFILE DETAILS SECTION
  Widget buildUserDetails() => Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildCircleAvatar(userGuideDetails.firebaseProfilePicUrl!),
          SizedBox(height: 14.h),
          Center(
            child: Text(
              userGuideDetails.fullName!,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(
                Icons.star,
                color: Color(0xff056028),
                size: 14,
              ),
              Text(
                '0 Reviews',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ],
      ));

  // PROFILE IMAGES SECTION
  Widget buildProfileImages() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                if (profileImages.imageUrl1 != '')
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ProfilePhotosViewer(
                            profileImages: profileImages);
                      }));
                    },
                    child: buildImage(context, profileImages.imageUrl1),
                  ),
                if (profileImages.imageUrl1 != '')
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ProfilePhotosViewer(
                              profileImages: profileImages, initialPage: 1);
                        }));
                      },
                      child: buildImageWithFilter(
                          context: context,
                          image: profileImages.imageUrl2,
                          count: GlobalMixin()
                                      .getTotalProfileImages(profileImages) >
                                  2
                              ? GlobalMixin()
                                      .getTotalProfileImages(profileImages) -
                                  2
                              : 0))
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      );

  //ABOUT SECTION
  Widget buildAbout() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'About Me',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(userGuideDetails.about!),
          ),
        ],
      );

  //NEARBY ACTIVITIES SECTION
  Widget buildNearbyActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Explore Nearby Activities/Packages',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: packages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
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
                            arguments: packages[index]);
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
                                packages[index].firebaseCoverImg!,
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 10,
                              left: 20,
                              child: Image.memory(
                                base64.decode(packages[index]
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
                      packages[index].name!,
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
                              image: AssetImage('assets/images/png/clock.png'),
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
    );
  }

  // CERTIFICATES SECTION
  Widget buildCertificates() => Container(
        padding: const EdgeInsets.only(left: 10, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Certificates',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
            const SizedBox(height: 20),
            SizedBox(
              height: 120.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                        '/view_certificate',
                        arguments: certificates[index]),
                    child: Container(
                      child: buildImage(context,
                          certificates[index].certificatePhotoFirebaseUrl!),
                    ),
                  );
                },
                itemCount: certificates.length,
              ),
            ),
          ],
        ),
      );

  //LOADING WIDGET
  Widget buildLoadingDataList() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        SkeletonText(
          height: 25.h,
          width: 140.w,
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(right: 12.w),
                  child: SkeletonText(
                    height: 120.h,
                    width: 140.w,
                  ),
                );
              },
              itemCount: 5),
        ),
        SizedBox(height: 12.h),
      ]);

  //LOCATION SECTION
  Widget buildLocationSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Location',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 20),
           Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(currentAddress),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: showLocation, //initial position
                  zoom: 10, //initial zoom level
                ),
                markers: markers, //markers to show on map
                onMapCreated: (GoogleMapController controller) {
                  //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
              ),
            ),
          ),
        ],
      );

  // API CALLS
  Future<void> getGuideUserDetails() async {
    final User result = await APIServices().getUserDetails(widget.userId);

    debugPrint('LAT:  ${result.latitude}  ${result.longitude}');

    if (result.longitude != '0.00' && result.longitude != '0.00') {
      final address = await GeoLocationServices().getAddressFromCoordinates(
          double.parse(result.latitude!), double.parse(result.longitude!));

      debugPrint('address $address');
      setState(() {
        showLocation = LatLng(
            double.parse(result.latitude!), double.parse(result.longitude!));
        currentAddress = address;
      });
      markers.add(Marker(
        //add marker on google map
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, //position of marker
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    }
    setState(() {
      userGuideDetails = result;
      isLoadingProfileDetails = false;
    });

    await getImages();
  }

  Future<void> getImages() async {
    final UserProfileImage res =
        await APIServices().getUserProfileImages(widget.userId);
    debugPrint('Data image: ${res.imageUrl1}');

    if (res.id != '') {
      setState(() {
        // _profilePhotoController.setProfileImages(res);
        profileImages = res;
        isLoadingProfileImages = false;
      });
    } else {
      final UserProfileImage addImagesResponse =
          await APIServices().addUserProfileImages(UserProfileImage());
      debugPrint('Response:: $addImagesResponse');
    }
  }

  ///Get Certificates
  Future<void> getCertificates() async {
    final List<Certificate> res =
        await APIServices().getCertificates(widget.userId);

    debugPrint('Certificate ${res[0].certificateName}');
    setState(() {
      certificates = res;
      isLoadingCertificates = false;
    });
  }

  Future<void> getPackages() async {
    debugPrint('USer id ${widget.userId}');
    final List<ActivityPackage> res =
        await APIServices().getGuidePackages(widget.userId);
    debugPrint('Res: ${res.length}');

    setState(() {
      packages = res;
      isLoadingPackages = false;
    });
  }
}
