// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, avoid_void_async, cascade_invocations, always_specify_types
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

/// Advertisement View Screen
class EventView extends StatefulWidget {
  /// Constructor
  const EventView({Key? key}) : super(key: key);

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  final screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
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
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AppColors.harp,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_sharp,
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
                      width: 50.w,
                      height: 50.h,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: AppColors.harp, shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(
                          Icons.share,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () {
                          _takeScreenshot(screenArguments['title'],
                              '\$${screenArguments['price'].toString()}');
                        },
                      ),
                    ),
                  ),
                ),

                /// Edit Icon
                Transform.scale(
                  scale: 0.8,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: AppColors.harp, shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () {
                          navigateEditEventDetails(context, screenArguments);
                        },
                      ),
                    ),
                  ),
                ),

                /// Delete icon
                Transform.scale(
                  scale: 0.8,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: AppColors.harp, shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                        onPressed: () {
                          removeEventItem(screenArguments['id']);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            flexibleSpace: Center(
              child: Stack(
                children: <Widget>[
                  if (screenArguments['snapshot_img'] != '')
                    Image.memory(
                      base64.decode(
                          screenArguments['snapshot_img'].split(',').last),
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    )
                  else
                    Container(),
                  FutureBuilder<BadgeModelData>(
                    future: APIServices()
                        .getBadgesModelById(screenArguments['badge_id']),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        final BadgeModelData badgeData = snapshot.data;
                        final int length = badgeData.badgeDetails.length;
                        return Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 110.h,
                              ),
                              Image.memory(
                                base64.decode(badgeData.badgeDetails[0].imgIcon
                                    .split(',')
                                    .last),
                                gaplessPlayback: true,
                              ),
                            ],
                          ),
                        );
                      }
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 110.h,
                            ),
                            const CircularProgressIndicator(),
                          ],
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(screenArguments['title'],
                              style: AppTextStyle.txtStyle),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.w, top: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('\$${screenArguments['price'].toString()}',
                            style: AppTextStyle.txtStyle),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w, top: 15.h, right: 25.w),
                child: Text(
                  screenArguments['description'],
                  style: AppTextStyle.descrStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 25.w),
                child: SizedBox(
                  height: 50.h,
                  child: Row(
                    children: <Widget>[
                      Text(AppTextConstants.activities,
                          style: AppTextStyle.semiBoldStyle),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: screenArguments['sub_activity'].length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return FutureBuilder<BadgeModelData>(
                                future: APIServices().getBadgesModelById(
                                    screenArguments['sub_activity'][index]),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData) {
                                    final BadgeModelData badgeData =
                                        snapshot.data;
                                    final int length =
                                        badgeData.badgeDetails.length;
                                    return Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.harp,
                                              border: Border.all(
                                                  color: AppColors.harp),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.r))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                                badgeData.badgeDetails[0].name
                                                    .toString(),
                                                style: TextStyle(
                                                    color: AppColors.nobel)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        )
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
                                          const CircularProgressIndicator(),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.h, left: 25.w),
                child: SizedBox(
                  height: 50.h,
                  child: Row(
                    children: <Widget>[
                      Text(AppTextConstants.freeServices,
                          style: AppTextStyle.semiBoldStyle),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: screenArguments['services'].length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.harp,
                                        border:
                                            Border.all(color: AppColors.harp),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.r))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          screenArguments['services'][index]
                                              .toString(),
                                          style: TextStyle(
                                              color: AppColors.nobel)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  )
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 25.w),
                child: Row(
                  children: <Widget>[
                    Text(AppTextConstants.location,
                        style: AppTextStyle.semiBoldStyle),
                    SizedBox(width: 35.w),
                    Text(
                      '${AppTextConstants.country} : ${screenArguments['country']}',
                      style: AppTextStyle.greyStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 25.w),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 66.w),
                    Text(
                      '${AppTextConstants.street} : ${screenArguments['street']}',
                      style: AppTextStyle.greyStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 25.w),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 66.w),
                    Text(
                      '${AppTextConstants.city} : ${screenArguments['city']}',
                      style: AppTextStyle.greyStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 25.w),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppTextConstants.province,
                      style: AppTextStyle.semiBoldStyle,
                    ),
                    SizedBox(width: 35.w),
                    Text(
                      screenArguments['province'],
                      style: AppTextStyle.greyStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 25.w),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppTextConstants.date,
                      style: AppTextStyle.semiBoldStyle,
                    ),
                    SizedBox(width: 48.w),
                    Text(
                      screenArguments['event_date'],
                      style: AppTextStyle.greyStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 25.w),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppTextConstants.price,
                      style: AppTextStyle.semiBoldStyle,
                    ),
                    SizedBox(width: 48.w),
                    Text(
                      'USD ${screenArguments['price'].toString()}',
                      style: AppTextStyle.greyStyle,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 25.w),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      screenArguments['star_rating'].toString(),
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '(1 Reviews)',
                      style: AppTextStyle.greyStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(width: 1.w, color: AppColors.porcelain),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 10.h, 0.w, 0.h),
                          child: Container(
                            width: 55.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage(
                                        'assets/images/profile-photos-2.png'))),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                                child: Text(
                                  'Ann Sasha',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Gilroy',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                                child: SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    'Architect',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Gilroy',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 5.w, 0.h),
                              child: Text(
                                '5',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                              child: const Icon(
                                Icons.star,
                                color: Colors.black,
                                size: 10,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                              child: const Icon(
                                Icons.star,
                                color: Colors.black,
                                size: 10,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                              child: const Icon(
                                Icons.star,
                                color: Colors.black,
                                size: 10,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                              child: const Icon(
                                Icons.star,
                                color: Colors.black,
                                size: 10,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 0.w, 0.h),
                              child: const Icon(
                                Icons.star,
                                color: Colors.black,
                                size: 10,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                      child: Text(AppTextConstants.loremIpsum,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.sp,
                              color: AppColors.osloGrey,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 20.h, bottom: 20.h, right: 25.w, left: 25.w),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
                  child: ElevatedButton(
                    // onPressed: () async => advertisementDetail(),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.primaryGreen,
                        ),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      primary: Colors.white,
                      onPrimary: AppColors.primaryGreen,
                    ),
                    child: Text(
                      AppTextConstants.viewMore,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigate to Event Edit
  Future<void> navigateEditEventDetails(
      BuildContext context, Map<String, dynamic> screenArguments) async {
    final List<String> subactivity = screenArguments['sub_activity'];
    final List<String> service = screenArguments['services'];

    final Map<String, dynamic> details = {
      'id': screenArguments['id'],
      'title': screenArguments['title'],
      'price': screenArguments['price'].toString(),
      'country': screenArguments['country'],
      'description': screenArguments['description'],
      'event_date': screenArguments['event_date'],
      'address':
          '${screenArguments['street']},${screenArguments['city']},${screenArguments['province']},${screenArguments['zip_code']}',
      'street': screenArguments['street'],
      'city': screenArguments['city'],
      'province': screenArguments['province'],
      'zip_code': screenArguments['zip_code'],
      'main_activity': screenArguments['main_activity'],
      'badge_id': screenArguments['badge_id'],
      'services': service.join(','),
      'sub_activity': subactivity,
      'date_format': screenArguments['date_format'],
      'snapshot_img': screenArguments['snapshot_img'],
      'image_id': screenArguments['image_id'],
      'is_published': true
    };

    await Navigator.pushNamed(context, '/event_edit', arguments: details);
  }

  /// Removed item from event
  Future<void> removeEventItem(String id) async {
    final Map<String, dynamic> eventDetails = {
      'is_published': false,
    };

    final dynamic response = await APIServices().request(
        '${AppAPIPath.activityEventUrl}/$id', RequestType.PATCH,
        needAccessToken: true, data: eventDetails);

    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const MainNavigationScreen(
                  navIndex: 1,
                  contentIndex: 1,
                )));
  }

  void _takeScreenshot(String title, String price) async {
    final image = await screenshotController.capture();
    if (image == null) return;

    await saveAndShare(image, title, price);
  }

  Future<void> saveAndShare(Uint8List bytes, String title, String price) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    await Share.shareFiles([image.path],
        text: 'Check out this $title! Starting from $price! #GuidED');
  }
}
