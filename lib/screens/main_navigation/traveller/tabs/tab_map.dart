// ignore_for_file: public_member_api_docs, use_named_constants

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/card_controller.dart';
import 'package:guided/controller/traveller_controller.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'dart:async';

import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/guide.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:guided/screens/payments/confirm_payment.dart';
import 'package:guided/screens/payments/payment_failed.dart';
import 'package:guided/screens/payments/payment_method.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_bottom_sheet.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_payment_details.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';
import 'package:guided/screens/widgets/reusable_widgets/sfDateRangePicker.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../models/activity_package.dart';
import 'package:collection/collection.dart';

/// PopularGuides
class TabMapScreen extends StatefulWidget {
  const TabMapScreen({Key? key}) : super(key: key);

  @override
  State<TabMapScreen> createState() => _TabMapScreenState();
}

class _TabMapScreenState extends State<TabMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  final List<Marker> _markers = <Marker>[];
  final ScrollToIndexController _scrollController = ScrollToIndexController();
  final travellerMonthController = Get.put(TravellerMonthController());
  final SwiperController _cardController = SwiperController();
  final List<Guide> guides = StaticDataService.getGuideList();
  final List<Activity> activities =
      StaticDataService.getActivityForNearybyGuides();
  final List<Activity> tourList = StaticDataService.getTourList();
  bool hideActivities = false;
  bool showBottomScroll = true;
  double activitiesContainer = 70;
  bool _isloading = true;
  List<int> _selectedActivity = [];
  LatLng currentMapLatLong = LatLng(53.59, -113.60);
  List<ActivityPackage> _loadingData = [];
  List<ActivityPackage> _filteredActivity = [];
  final CardController _creditCardController = Get.put(CardController());
  final UserSubscriptionController _userSubscriptionController =
      Get.put(UserSubscriptionController());

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    APIServices().getActivityPackages().then((List<ActivityPackage> value) {
      addMarker(value);
    });

    // WidgetsBinding.instance?.addPostFrameCallback((_) => addMarker(context));
    super.initState();

/*    if (_creditCardController.cards.isEmpty) {
      getUserCards();
    }*/
  }

  Future<void> addMarker(List<ActivityPackage> activityPackages) async {
    final List<Marker> marks = <Marker>[];
    for (ActivityPackage element in activityPackages) {
      final Activity? activity = activities
          .firstWhereOrNull((Activity a) => a.id == element.mainBadge!.id);

      double lat = double.parse(element
          .activityPackageDestination!.activitypackagedestinationLatitude!);
      double long = double.parse(element
          .activityPackageDestination!.activitypackagedestinationLongitude!);
      if (activity != null) {
        marks.add(
          Marker(
            markerId: MarkerId(element.id!),
            icon: await MarkerIcon.pictureAsset(
                assetPath: activity.path, width: 80, height: 80),
            position: LatLng(lat, long),
          ),
        );
      }
    }
    double lat = double.parse(activityPackages
        .first.activityPackageDestination!.activitypackagedestinationLatitude!);
    double long = double.parse(activityPackages.first
        .activityPackageDestination!.activitypackagedestinationLongitude!);
    // mapController?.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(target: LatLng(lat, long), zoom: 17)
    //     //17 is new zoom level
    //     ));
    setState(() {
      currentMapLatLong = LatLng(lat, long);
      _loadingData = activityPackages;
      _isloading = false;
      _markers.addAll(marks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentMapLatLong,
                zoom: 12,
              ),
              markers: Set<Marker>.of(_markers),
              onMapCreated: _onMapCreated,
              zoomControlsEnabled: false,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: HexColor('#F8F7F6'),
              ),
              height: hideActivities
                  ? MediaQuery.of(context).size.height * 0.23
                  : MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 10.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/traveller_tab');
                          },
                          child: Container(
                            transform: Matrix4.translationValues(0, -5.h, 0),
                            height: 60.h,
                            width: 58.w,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 20.h,
                                width: 20.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/png/green_house_outlined.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 0.h, 15.w, 0.h),
                          child: TextField(
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(fontSize: 16.sp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.all(22),
                              fillColor: Colors.white,
                              prefixIcon: IconButton(
                                icon: Image.asset(
                                  'assets/images/png/search_icon.png',
                                  width: 20.w,
                                  height: 20.h,
                                ),
                                onPressed: null,
                              ),
                              suffixIcon: IconButton(
                                icon: Image.asset(
                                  'assets/images/png/calendar_icon.png',
                                  width: 20.w,
                                  height: 20.h,
                                ),
                                // onPressed: null,
                                onPressed: () async {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: 20.w,
                      ),
                      Flexible(
                        flex: 6,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          height: 44.h,
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10.w, right: 8.w),
                                height: 15.h,
                                width: 15.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/png/marker.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const Text(
                                "St. John's, Newfo...",
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          height: 44.h,
                          child: const Center(child: Text('Radius : 05')),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: hideActivities ? 20 : 40.h,
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: activitiesContainer,
                    child:
                        hideActivities ? Container() : overlapped(activities),
                  ),
                  // const Spacer(),
                  Align(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (hideActivities) {
                            hideActivities = false;
                            activitiesContainer = 70;
                          } else {
                            hideActivities = true;
                            activitiesContainer = 0;
                          }
                        });
                      },
                      child: Icon(
                        hideActivities ? Icons.expand_more : Icons.expand_less,
                        // color: HexColor('#979B9B'),
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: showBottomScroll
                      ? MediaQuery.of(context).size.height * 0.24
                      : 40,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (showBottomScroll) {
                              showBottomScroll = false;
                            } else {
                              showBottomScroll = true;
                            }
                          });
                        },
                        child: Icon(
                          showBottomScroll
                              ? Icons.expand_more
                              : Icons.expand_less,
                          color: HexColor('#979B9B'),
                          size: 30,
                        ),
                      ),
                      if (showBottomScroll)
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: List<Widget>.generate(_loadingData.length,
                                (int i) {
                              final Activity? icon = activities
                                  .firstWhereOrNull((Activity element) =>
                                      element.id ==
                                      _loadingData[i].mainBadgeId);
                              final ActivityPackage? enable = _filteredActivity
                                  .firstWhereOrNull((ActivityPackage element) =>
                                      element.id == _loadingData[i].id);
                              return InkWell(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .pushNamed('/discovery_map');
                                    if (_userSubscriptionController
                                        .userSubscription.id.isEmpty) {
                                      _showDiscoveryBottomSheet(
                                          tourList[i].featureImage);
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 20.h),
                                    height: 180.h,
                                    width: 135.w,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _loadingData[i].name!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          height: 90.h,
                                          width: 135.w,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15.r),
                                            ),
                                            image: DecorationImage(
                                                image: Image.memory(
                                              base64.decode(_loadingData[i]
                                                  .coverImg!
                                                  .split(',')
                                                  .last),
                                              fit: BoxFit.cover,
                                              gaplessPlayback: true,
                                            ).image),
                                            // image: DecorationImage(
                                            //   image: AssetImage(
                                            //       tourList[0].featureImage),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned(
                                                left: 5,
                                                bottom: 5,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  radius: 12,
                                                  backgroundImage:
                                                      AssetImage(icon!.path),
                                                ),
                                              ),
                                              if (enable == null)
                                                Container(
                                                  height: 90.h,
                                                  width: 135.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.8),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15.r),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                          ),
                        )
                      else
                        Container()
                    ],
                  )),
            ),
            Align(
                child: _isloading
                    ? const CircularProgressIndicator()
                    : Container()),
          ],
        ),
      ),
    );
  }

  Widget overlapped(List<Activity> activities) {
    final overlap = 30.0;
    final r = 15;
    final items = <Widget>[];
    double minus = 0;
    for (var i = 0; i < activities.length; i++) {
      if (i < 5) {
        items.add(
          GestureDetector(
            onTap: () {
              final List<ActivityPackage> filteredActivity = _loadingData
                  .where((ActivityPackage a) =>
                      a.mainBadge!.id == activities[i].id)
                  .toList();

              if (filteredActivity.isNotEmpty) {
                setState(() {
                  if (_selectedActivity.contains(i)) {
                    _selectedActivity.remove(i);
                    _filteredActivity.removeWhere(
                        (element) => element.mainBadgeId == activities[i].id);
                  } else {
                    _filteredActivity.addAll(filteredActivity);
                    _selectedActivity.add(i);
                  }
                });
              } else {
                setState(() {
                  if (_selectedActivity.contains(i)) {
                    _selectedActivity.remove(i);
                  } else {
                    _selectedActivity.add(i);
                  }
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedActivity.contains(i)
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: r.toDouble() + i.toDouble() + 5,
                      backgroundImage: ExactAssetImage(activities[i].path),
                    ),
                  ),
                  Positioned(
                      top: 2,
                      right: 8,
                      child: _selectedActivity.contains(i)
                          ? Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                size: 10.h,
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox()),
                ],
              ),
            ),
          ),
        );
        minus = r.toDouble() + i.toDouble() + 5;
      } else {
        items.add(
          GestureDetector(
            onTap: () {
              final List<ActivityPackage> filteredActivity = _loadingData
                  .where((ActivityPackage a) =>
                      a.mainBadge!.id == activities[i].id)
                  .toList();

              if (filteredActivity.isNotEmpty) {
                setState(() {
                  if (_selectedActivity.contains(i)) {
                    _selectedActivity.remove(i);
                    _filteredActivity.removeWhere(
                        (element) => element.mainBadgeId == activities[i].id);
                  } else {
                    _filteredActivity.addAll(filteredActivity);
                    _selectedActivity.add(i);
                  }
                });
              } else {
                setState(() {
                  if (_selectedActivity.contains(i)) {
                    _selectedActivity.remove(i);
                  } else {
                    _selectedActivity.add(i);
                  }
                });
              }
              // final ActivityPackage? activity = _loadingData.firstWhereOrNull(
              //     (ActivityPackage a) => a.mainBadge!.id == activities[i].id);

              // if (activity != null) {
              //   double lat = double.parse(activity.activityPackageDestination!
              //       .activitypackagedestinationLatitude!);
              //   double long = double.parse(activity.activityPackageDestination!
              //       .activitypackagedestinationLongitude!);
              //   mapController?.animateCamera(CameraUpdate.newCameraPosition(
              //       CameraPosition(target: LatLng(lat, long), zoom: 17)
              //       //17 is new zoom level
              //       ));
              //   setState(() {
              //     currentMapLatLong = LatLng(lat, long);
              //     if (_selectedActivity.contains(i)) {
              //       _selectedActivity.remove(i);
              //     } else {
              //       _selectedActivity.add(i);
              //     }
              //   });
              // } else {
              //   setState(() {
              //     if (_selectedActivity.contains(i)) {
              //       _selectedActivity.remove(i);
              //     } else {
              //       _selectedActivity.add(i);
              //     }
              //   });
              // }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedActivity.contains(i)
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      // backgroundColor:
                      //     Colors.primaries[Random().nextInt(Colors.primaries.length)],
                      radius: minus - i.toDouble() + 4,
                      backgroundImage: ExactAssetImage(activities[i].path),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 8,
                    child: _selectedActivity.contains(i)
                        ? Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 10.h,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    List<Widget> stackLayersLeft =
        List<Widget>.generate(items.getRange(0, 4).length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: items[index],
      );
    });
    List<Widget> stackLayersRight =
        List<Widget>.generate(items.getRange(5, 9).length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: items[5 + index],
      );
    });
    List<Widget> stackLayersCenter =
        List<Widget>.generate(items.getRange(5, 5).length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: items[5],
      );
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          transform: Matrix4.translationValues(15, 0, 0),
          child: Stack(
            children: stackLayersLeft,
          ),
        ),
        Align(
          child: items[4],
        ),
        Container(
          transform: Matrix4.translationValues(-15, 0, 0),
          child: Stack(
            children: stackLayersRight,
          ),
        ),

        // Positioned(child: items[4]),
      ],
    );
  }

  void _showDiscoveryBottomSheet(String backgroundImage) {
    showCupertinoModalBottomSheet(
        context: context,
        isDismissible: true,
        barrierColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext ctx) => DiscoveryBottomSheet(
              backgroundImage: backgroundImage,
              onSubscribeBtnPressed: () {
                const double price = 5.99;
                Navigator.of(ctx).pop();

                paymentMethod(
                    context: context,
                    onCreditCardSelected: (CardModel card) {
                      debugPrint('Payment Method:: ${card.cardNo}');
                    },
                    onContinueBtnPressed: (dynamic data) {
                      String mode = '';
                      if (data is CardModel) {
                        mode = 'Credit Card';
                      } else {
                        mode = Platform.isAndroid ? 'Google Pay' : 'Apple Pay';
                      }
                      final String transactionNumber =
                          GlobalMixin().generateTransactionNumber();
                      confirmPaymentModal(
                          context: context,
                          serviceName: 'Premium Subscription',
                          paymentMethod: data,
                          paymentMode: mode,
                          price: price,
                          onPaymentSuccessful: () {
                            Navigator.of(context).pop();
                            saveSubscription(transactionNumber,
                                'Premium Subscription', price.toString());
                            //Save Subscription
                            paymentSuccessful(
                                context: context,
                                paymentDetails: DiscoveryPaymentDetails(
                                    transactionNumber: transactionNumber),
                                paymentMethod: mode);
                          },
                          onPaymentFailed: () {
                            paymentFailed(
                                context: context,
                                paymentDetails: DiscoveryPaymentDetails(
                                    transactionNumber: transactionNumber),
                                paymentMethod: mode);
                          },
                          paymentDetails: DiscoveryPaymentDetails(
                              transactionNumber: transactionNumber));
                    },
                    price: price);
              },
              onSkipBtnPressed: () {
                Navigator.of(context).pop();
              },
              onCloseBtnPressed: () {
                Navigator.of(context).pop();
              },
              onBackBtnPressed: () {
                Navigator.of(context).pop();
              },
            ));
  }

  Future<void> saveSubscription(
      String transactionNumber, String subscriptionName, String price) async {
    final DateTime startDate = DateTime.now();

    final DateTime endDate = GlobalMixin().getEndDate(startDate);

    final UserSubscription subscriptionParams = UserSubscription(
        paymentReferenceNo: transactionNumber,
        name: subscriptionName,
        startDate: startDate.toString(),
        endDate: endDate.toString(),
        price: price);

    final APIStandardReturnFormat result =
        await APIServices().addUserSubscription(subscriptionParams);

    debugPrint('subscription result ${result.successResponse}');
  }
}
