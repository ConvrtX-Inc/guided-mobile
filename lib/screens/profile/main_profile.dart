import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/staticmap.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:google_static_maps_controller/google_static_maps_controller.dart';
// import 'package:google_maps_webservice/staticmap.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/screens/profile/profile_widgets.dart';
import 'package:guided/screens/profile/reviews_profile.dart';
import 'package:location/location.dart';

// ignore: public_member_api_docs
class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({Key? key}) : super(key: key);

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

    //you can add more markers here
    super.initState();
  }

  // final Completer<GoogleMapController> _controller = Completer();
  String googleMapsApi = 'AIzaSyCIag8Y1v3gmGnF55sGh4ocFnZq6qsEnKM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              backButton(context),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Ethan Hunt's Posts",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 20),
              buildCircleAvatar(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.star,
                    color: Color(0xff056028),
                    size: 14,
                  ),
                  Text(
                    '19 Reviews',
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
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                    'Bacon ipsum dolor amet frankfurter meatloaf short loin boudin cow capicola pork belly picanha bresaola andouille ground round porchetta kielbasa filet mignon tail.'),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    buildImage(context, 'assets/images/customer-2.png'),
                    buildImageWithFilter(context)
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
              const SizedBox(height: 20),
              SingleChildScrollView(
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
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Certificates',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
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
        )));
  }
}
