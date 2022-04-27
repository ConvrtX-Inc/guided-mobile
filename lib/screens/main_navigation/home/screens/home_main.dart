// ignore_for_file: no_default_cases, always_specify_types, avoid_dynamic_calls, use_string_buffers

import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/name_with_bullet.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/booking_request.dart';
import 'package:guided/models/home.dart';
import 'package:guided/models/package_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/content/packages/widget/package_features.dart';
import 'package:guided/screens/main_navigation/home/widgets/concat_strings.dart';
import 'package:guided/screens/main_navigation/home/widgets/home_earnings.dart';
import 'package:guided/screens/main_navigation/home/widgets/home_features.dart';
import 'package:guided/screens/main_navigation/home/widgets/overlapping_avatars.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/utils/home.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Screen for home
class HomeScreen extends StatefulWidget {
  /// Constructor
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;
  int _selectedMenuIndex = 0;
  final double _bulletHeight = 50;
  final double _bulletWidth = 50;
  final Color _bulletColor = AppColors.tropicalRainForest;
  int total = 0;

  /// Get features items mocked data
  List<HomeModel> features = HomeUtils.getMockFeatures();

  /// Get customer requests mocked data
  List<HomeModel> customerRequests = HomeUtils.getMockCustomerRequests();

  /// Get customer requests mocked data
  List<HomeModel> earnings = HomeUtils.getMockEarnings();

  void setMenuIndexHandler(int value) {
    setState(() {
      _selectedMenuIndex = value;
    });
  }

  late Future<PackageModelData> _loadingData;
  late Future<List<BookingRequest>> _loadingBooking;
  @override
  void initState() {
    super.initState();
    _loadingData = APIServices().getPackageData();
    _loadingBooking = APIServices().getBookingRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppTextConstants.home,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.black,
              fontFamily: 'Gilroy'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
              child: Container(
                height: 45.h,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2.w)),
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          const MainNavigationScreen(
                                            navIndex: 1,
                                            contentIndex: 0,
                                          )));
                            },
                            child: Text(
                              AppTextConstants.packages,
                              style: AppTextStyle.defaultStyle,
                            ))),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      const MainNavigationScreen(
                                        navIndex: 1,
                                        contentIndex: 1,
                                      )));
                        },
                        child: Text(
                          AppTextConstants.event,
                          style: AppTextStyle.inactive,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      const MainNavigationScreen(
                                        navIndex: 1,
                                        contentIndex: 2,
                                      )));
                        },
                        child: Text(
                          AppTextConstants.outfitter,
                          style: AppTextStyle.inactive,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      const MainNavigationScreen(
                                        navIndex: 1,
                                        contentIndex: 3,
                                      )));
                        },
                        child: Text(
                          AppTextConstants.myads,
                          style: AppTextStyle.inactive,
                        )),
                  ],
                ),
              ),
            ),
            _homeScreenContent(context),
          ],
        ),
      ),
    );
  }

  /// Home Screen Content Screen
  Widget _homeScreenContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.harp,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            height: 270.h,
            child: Row(
              children: [
                Expanded(
                  child: FutureBuilder<PackageModelData>(
                    future: _loadingData,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        final PackageModelData packageData = snapshot.data;
                        final int length = packageData.packageDetails.length;
                        if (packageData.packageDetails.isEmpty) {
                          return const Center(
                            child: Text('Nothing to show here'),
                          );
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: length,
                              itemBuilder: (BuildContext ctx, int index) {
                                return HomeFeatures(
                                  id: packageData.packageDetails[index].id,
                                  name: packageData.packageDetails[index].name,
                                  mainBadgeId: packageData
                                      .packageDetails[index].mainBadgeId,
                                  subBadgeId: packageData
                                      .packageDetails[index].subBadgeId,
                                  description: packageData
                                      .packageDetails[index].description,
                                  imageUrl: packageData
                                      .packageDetails[index].coverImg,
                                  numberOfTourist: packageData
                                      .packageDetails[index].maxTraveller,
                                  starRating: 0,
                                  fee: double.parse(packageData
                                      .packageDetails[index].basePrice),
                                  dateRange: '1-9',
                                  services: packageData
                                      .packageDetails[index].services,
                                  country:
                                      packageData.packageDetails[index].country,
                                  address:
                                      packageData.packageDetails[index].address,
                                  extraCost: packageData
                                      .packageDetails[index].extraCostPerPerson,
                                  isPublished: packageData
                                      .packageDetails[index].isPublished,
                                );
                              });
                        }
                      }
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const MainContentSkeletonHorizontal();
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
          MyListWithBullet(
            text: 'Customers Requests',
            width: _bulletWidth,
            height: _bulletHeight,
            color: _bulletColor,
          ),
          // SizedBox(
          //   height: 150.h,
          //   child: Column(
          //     children: <Widget>[
          //       Container(
          //         color: Colors.yellow,
          //         child: Stack(children: <Widget>[
          //           FutureBuilder<List<BookingRequest>>(
          //             future: _loadingBooking,
          //             builder: (BuildContext context,
          //                 AsyncSnapshot<dynamic> snapshot) {
          //               if (snapshot.hasData) {
          //                 final List<BookingRequest> bookingData =
          //                     snapshot.data;
          //                 final int length = bookingData.length;
          //                 if (bookingData.isEmpty) {
          //                   return const Center(
          //                     child: Text('Nothing to show here'),
          //                   );
          //                 } else {
          //                   return Row(
          //                     children: <Widget>[
          //                       SizedBox(
          //                         width: 80.w,
          //                         height: 30.h,
          //                         child: Stack(children: <Widget>[
          //                           ListView.builder(
          //                               scrollDirection: Axis.horizontal,
          //                               itemCount: length,
          //                               itemBuilder:
          //                                   (BuildContext ctx, int index) {
          //                                 return customerRequestImage(
          //                                     context,
          //                                     index,
          //                                     snapshot.data![index],
          //                                     length);
          //                               }),
          //                         ]),
          //                       ),
          //                       SizedBox(
          //                         height: 30.h,
          //                         width:
          //                             MediaQuery.of(context).size.width * 0.6,
          //                         child: Expanded(
          //                           child: ListView.builder(
          //                               scrollDirection: Axis.horizontal,
          //                               itemCount: length,
          //                               itemBuilder:
          //                                   (BuildContext ctx, int index) {
          //                                 return customerRequestName(
          //                                     context,
          //                                     index,
          //                                     snapshot.data![index],
          //                                     length);
          //                               }),
          //                         ),
          //                       ),
          //                     ],
          //                   );
          //                 }
          //               }
          //               if (snapshot.connectionState != ConnectionState.done) {
          //                 return const MainContentSkeletonHorizontal();
          //               }
          //               return Container();
          //             },
          //           ),
          //         ]),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 15,
          ),
          MyListWithBullet(
            text: AppTextConstants.earning,
            width: _bulletWidth,
            height: _bulletHeight,
            color: _bulletColor,
          ),
          HomeEarnings()
        ],
      ),
    );
  }

  Widget customerRequestImage(
      BuildContext context, int index, BookingRequest request, int total) {
    return FutureBuilder<User>(
      future: APIServices().getUserDetails(request.fromUserId!),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        String concatStrings = '';
        if (snapshot.hasData) {
          for (int i = 0; i < 3; i++) {
            concatStrings = '$concatStrings${snapshot.data!.firstName}, ';
          }
          concatStrings = concatStrings.substring(0, concatStrings.length - 2);

          if (request.profilePhoto != null) {
            if (index < 3) {
              return Align(
                alignment: index == 0
                    ? Alignment.centerRight
                    : (index == 1 ? Alignment.center : Alignment.centerRight),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 3)
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: Image.memory(
                            base64
                                .decode(request.profilePhoto!.split(',').last),
                            fit: BoxFit.cover,
                            gaplessPlayback: true,
                          ).image),
                          borderRadius: BorderRadius.all(Radius.circular(50.r)),
                          border: Border.all(color: Colors.red, width: 4.w)),
                    ),
                  ),
                ),
              );
            }
          } else {
            return Container();
          }
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const Align(
              alignment: Alignment.topLeft, child: CircularProgressIndicator());
        }
        return Container();
      },
    );
  }

  Widget customerRequestName(
      BuildContext context, int index, BookingRequest request, int total) {
    return FutureBuilder<User>(
      future: APIServices().getUserDetails(request.fromUserId!),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        String? concatStrings = '';
        if (snapshot.hasData) {
          // for (int i = 0; i < 3; i++) {
          //   concatStrings = '$concatStrings${snapshot.data!.firstName}, ';
          // }
          // concatStrings = concatStrings.substring(0, concatStrings.length - 2);

          concatStrings = '${snapshot.data!.firstName}';
          if (index < 3) {
            if (index == 2) {
              return Text(
                concatStrings,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              );
            } else {
              return Text(
                '$concatStrings, ',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              );
            }
          }
        }
        // if (snapshot.hasData) {
        //   for (int i = 0; i < 3; i++) {
        //     concatStrings = '$concatStrings${snapshot.data!.firstName}, ';
        //   }
        //   concatStrings = concatStrings.substring(0, concatStrings.length - 2);

        //   return Align(
        //     alignment: index == 0
        //         ? Alignment.centerRight
        //         : (index == 1 ? Alignment.center : Alignment.centerRight),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         shape: BoxShape.circle,
        //         boxShadow: <BoxShadow>[
        //           BoxShadow(
        //               blurRadius: 5,
        //               color: Colors.black.withOpacity(0.3),
        //               spreadRadius: 3)
        //         ],
        //       ),
        //       child: CircleAvatar(
        //         backgroundColor: Colors.white,
        //         child: Container(
        //           height: 10.h,
        //           width: 10.w,
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               image: DecorationImage(
        //                   image: Image.memory(
        //                 base64.decode(request.profilePhoto!.split(',').last),
        //                 fit: BoxFit.cover,
        //                 gaplessPlayback: true,
        //               ).image),
        //               borderRadius: BorderRadius.all(Radius.circular(50.r)),
        //               border: Border.all(color: Colors.red, width: 4.w)),
        //         ),
        //       ),
        //     ),
        //   );
        // }
        if (snapshot.connectionState != ConnectionState.done) {
          return const Align(
              alignment: Alignment.topLeft, child: CircularProgressIndicator());
        }
        return Container();
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<HomeModel>('features', features));
    properties
        .add(IterableProperty<HomeModel>('customerRequests', customerRequests));
    properties.add(IterableProperty<HomeModel>('earnings', earnings));
  }
}
