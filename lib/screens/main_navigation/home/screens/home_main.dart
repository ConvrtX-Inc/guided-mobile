// ignore_for_file: no_default_cases, always_specify_types, avoid_dynamic_calls, use_string_buffers, type_annotate_public_apis, always_declare_return_types, cascade_invocations

import 'dart:convert';

import 'package:extended_image/extended_image.dart';
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
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/home/widgets/home_earnings.dart';
import 'package:guided/screens/main_navigation/home/widgets/home_features.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
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

  void setMenuIndexHandler(int value) {
    setState(() {
      _selectedMenuIndex = value;
    });
  }

  late Future<PackageModelData> _loadingData;
  late Future<List<BookingRequest>> _loadingBooking;
  String image1 = '';
  String image2 = '';
  String image3 = '';
  String name1 = '';
  String name2 = '';
  String name3 = '';
  bool _hasData = false;
  int totalData = 0;
  @override
  void initState() {
    super.initState();
    _loadingData = APIServices().getPackageData();

    getData();
  }

  getData() async {
    final List<BookingRequest> resData =
        await APIServices().getBookingRequest();

    if (resData.isNotEmpty) {
      setState(() {
        _hasData = true;
        totalData = resData.length;
      });
    }

    for (int index = 0; index < resData.length; index++) {
      if (resData[index].isApproved! == false) {
        if (resData.length == 1) {
          if (index == 0) {
            if (image1 == '') {
              setData1(resData[index].fromUserFirebaseProfilePic!,
                  resData[index].fromUserId!);
            }
          }
        } else if (resData.length == 2) {
          if (index == 0) {
            if (image1 == '') {
              setData1(resData[index].fromUserFirebaseProfilePic!,
                  resData[index].fromUserId!);
            }
          } else if (index == 1) {
            if (image2 == '') {
              setData2(resData[index].fromUserFirebaseProfilePic!,
                  resData[index].fromUserId!);
            }
          }
        } else if (resData.length >= 3) {
          if (index == 0) {
            if (image1 == '') {
              setData1(resData[index].fromUserFirebaseProfilePic!,
                  resData[index].fromUserId!);
            }
          } else if (index == 1) {
            if (image2 == '') {
              setData2(resData[index].fromUserFirebaseProfilePic!,
                  resData[index].fromUserId!);
            }
          } else if (index == 2) {
            if (image3 == '') {
              setData3(resData[index].fromUserFirebaseProfilePic!,
                  resData[index].fromUserId!);
            }
          }
        }

        setState(() {
          total = resData.length;
        });
      }
    }
  }

  setData1(String img, String id) async {
    final ProfileDetailsModel resUsername0 =
        await APIServices().getProfileDataById(id);

    setState(() {
      image1 = img;
      name1 = resUsername0.firstName;
    });
  }

  setData2(String img, String id) async {
    final ProfileDetailsModel resUsername0 =
        await APIServices().getProfileDataById(id);
    setState(() {
      image2 = img;
      name2 = ', ${resUsername0.firstName}';
    });
  }

  setData3(String img, String id) async {
    final ProfileDetailsModel resUsername0 =
        await APIServices().getProfileDataById(id);
    setState(() {
      image3 = img;
      name3 = ', ${resUsername0.firstName}';
    });
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
                                    name:
                                        packageData.packageDetails[index].name,
                                    mainBadgeId: packageData
                                        .packageDetails[index].mainBadgeId,
                                    subBadgeId: packageData
                                        .packageDetails[index].subBadgeId,
                                    description: packageData
                                        .packageDetails[index].description,
                                    imageUrl: packageData
                                        .packageDetails[index].coverImg,
                                    numberOfTouristMin: packageData
                                        .packageDetails[index].minTraveller,
                                    numberOfTourist: packageData
                                        .packageDetails[index].maxTraveller,
                                    starRating: 0,
                                    fee: double.parse(packageData
                                        .packageDetails[index].basePrice),
                                    dateRange: '1-9',
                                    services: packageData
                                        .packageDetails[index].services,
                                    country: packageData
                                        .packageDetails[index].country,
                                    address: packageData
                                        .packageDetails[index].address,
                                    extraCost: packageData.packageDetails[index]
                                        .extraCostPerPerson,
                                    isPublished: packageData
                                        .packageDetails[index].isPublished,
                                    firebaseCoverImg: packageData
                                        .packageDetails[index].firebaseCoverImg,
                                    notIncluded: packageData
                                        .packageDetails[index]
                                        .notIncludedServices);
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
          if (_hasData)
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            const MainNavigationScreen(
                              navIndex: 2,
                              contentIndex: 0,
                            )));
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 12.h),
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.platinum),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            if (totalData >= 3)
                              manyCustomerRequest()
                            else if (totalData == 2)
                              twoCustomerRequest()
                            else
                              oneCustomerRequest(),
                            SizedBox(height: 10.h),
                            Text(
                              AppTextConstants.homeMainHeader,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 9.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: AppColors.lightningYellow),
                      child: Text('$total Pending request',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  )
                ],
              ),
            )
          else
            const Center(
              child: Text('Nothing to show here'),
            ),
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

  Widget oneCustomerRequest() => Row(
        children: <Widget>[
          if (image1 == '')
            Align(
              alignment: Alignment.centerLeft,
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
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.green,
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/office/344/person-male.png'),
                  ),
                ),
              ),
            )
          else
            Align(
              alignment: Alignment.centerRight,
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
                  child: ExtendedImage.network(
                    image1,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),
              ),
            ),
          SizedBox(width: 15.w),
          Text(
            name1,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      );

  Widget twoCustomerRequest() => Row(
        children: <Widget>[
          if (image1 == '')
            Align(
              alignment: Alignment.centerLeft,
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
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.green,
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/office/344/person-male.png'),
                  ),
                ),
              ),
            )
          else
            Align(
              alignment: Alignment.centerRight,
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
                  child: ExtendedImage.network(
                    image1,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),
              ),
            ),
          if (image2 == '')
            Align(
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
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.green,
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/office/344/person-male.png'),
                  ),
                ),
              ),
            )
          else
            Align(
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
                  child: ExtendedImage.network(
                    image2,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),
              ),
            ),
          SizedBox(width: 15.w),
          Text(
            name1,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Text(
            name2,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      );

  Widget manyCustomerRequest() => Row(
        children: <Widget>[
          if (image1 == '')
            Align(
              alignment: Alignment.centerLeft,
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
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.green,
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/office/344/person-male.png'),
                  ),
                ),
              ),
            )
          else
            Align(
              alignment: Alignment.centerRight,
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
                  child: ExtendedImage.network(
                    image1,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),
              ),
            ),
          if (image2 == '')
            Align(
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
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.green,
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/office/344/person-male.png'),
                  ),
                ),
              ),
            )
          else
            Align(
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
                  child: ExtendedImage.network(
                    image2,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),
              ),
            ),
          if (image3 == '')
            Align(
              alignment: Alignment.centerLeft,
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
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.green,
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/office/344/person-male.png'),
                  ),
                ),
              ),
            )
          else
            Align(
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
                  child: ExtendedImage.network(
                    image3,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),
              ),
            ),
          SizedBox(width: 15.w),
          Text(
            name1,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Text(
            name2,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Text(
            name3,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      );
}
