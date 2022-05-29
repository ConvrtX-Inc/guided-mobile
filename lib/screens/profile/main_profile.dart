import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:guided/screens/profile/profile_widgets.dart';
import 'package:guided/screens/profile/reviews_profile.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
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

  @override
  void initState() {
    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'My Custom Title ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            backButton(context),
            /*const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Ethan Hunt's Posts",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),*/
            const SizedBox(height: 20),
            buildCircleAvatar(userGuideDetails.firebaseProfilePicUrl!),
            SizedBox(height: 14.h),
            Center(
              child: Text(
                userGuideDetails.fullName!,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  if (profileImages.imageUrl1 != '')
                    buildImage(context, profileImages.imageUrl1),
                  if (profileImages.imageUrl1 != '')
                    buildImageWithFilter(context, profileImages.imageUrl2)
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Explore Nearby Activities/Packages',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child:  buildNearbyActivities()),
            // const SizedBox(height: 20),
            /*      SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              'assets/images/customer-2.png',
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 80),
                          child: Text(
                            'Hunting',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 45),
                          child: Text('3.5 hour drive'),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/profile-photos-2.png',
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 80),
                          child: Text('Rowing',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 45),
                          child: Text('3.5 hour drive',
                              style: TextStyle(fontSize: 14)),
                        )
                      ],
                    ),
                  ],
                ),
              ),*/

            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Certificates',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            /*   SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    buildImage(context, 'assets/images/customer-2.png'),
                    buildImage(
                      context,
                      'assets/images/image2.png',
                    )
                  ],
                ),
              ),*/
            if (certificates.isNotEmpty)
              SizedBox(
                height: 120.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: buildImage(context,
                          certificates[index].certificatePhotoFirebaseUrl!),
                    );
                  },
                  itemCount: certificates.length,
                ),
              ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                  'Bacon ipsum dolor amet turducken hamburger leberkas, brisket porchetta drumstick rump ham hock chuck chicken. Pig alcatra filet mignon ham hamburger. Prosciutto turkey chislic beef ribs. Andouille meatloaf leberkas ribeye tenderloin. Picanha burgdoggen landjaeger flank beef, tail porchetta.'),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Location',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text('St John, Newfoundland, Canada'),
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

                // child: GoogleMap(
                //   initialCameraPosition:
                //       CameraPosition(target: _initialcameraposition),
                //   onMapCreated: _onMapCreated,
                //   myLocationEnabled: true,
                // ),
              ),
            ),
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
                        '19 Reviews',
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

  Widget buildNearbyActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
                width:  MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
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
                        width:  MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.r),
                          ),
                          border: Border.all(color: AppColors.galleryWhite),
                          image: DecorationImage(
                              image: NetworkImage(
                            packages[index].firebaseCoverImg!,

                          ),fit: BoxFit.cover),
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

  // API CALLS
  Future<void> getGuideUserDetails() async {
    final User result = await APIServices().getUserDetails(widget.userId);

    setState(() {
      userGuideDetails = result;
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
    });
  }

  Future<void> getPackages() async {
    debugPrint('USer id ${widget.userId}');
    final List<ActivityPackage> res =
        await APIServices().getGuidePackages(widget.userId);
    debugPrint('Res: ${res.length}');

    setState(() {
      packages = res;
    });
  }
}
