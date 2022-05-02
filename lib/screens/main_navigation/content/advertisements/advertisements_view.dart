// ignore_for_file: cast_nullable_to_non_nullable, avoid_dynamic_calls, always_specify_types, unnecessary_lambdas, avoid_print, unnecessary_statements, cascade_invocations, always_put_control_body_on_new_line, avoid_void_async
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_edit.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

/// Advertisement View Screen
class AdvertisementView extends StatefulWidget {
  /// Constructor
  const AdvertisementView({Key? key}) : super(key: key);

  @override
  _AdvertisementViewState createState() => _AdvertisementViewState();
}

class _AdvertisementViewState extends State<AdvertisementView> {
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
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: AppColors.harp,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.share,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () {
                          _takeScreenshot(screenArguments['title'],
                              screenArguments['price']);
                        },
                      ),
                    ),
                  ),
                ),

                /// Edit Icon
                Transform.scale(
                  scale: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: AppColors.harp,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () {
                          navigateEditAdvertisementDetails(
                              context, screenArguments);
                        },
                      ),
                    ),
                  ),
                ),

                /// Delete icon
                Transform.scale(
                  scale: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: AppColors.harp,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                        onPressed: () {
                          removeAdvertisementItem(screenArguments['id']);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            flexibleSpace: screenArguments['snapshot_img'] != ''
                ? ExtendedImage.network(
                    screenArguments['snapshot_img'],
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  )
                : Container(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(screenArguments['title'],
                        style: AppTextStyle.txtStyle),
                  ],
                ),
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
                      SizedBox(width: 20.w),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: screenArguments['activities'].length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return FutureBuilder<BadgeModelData>(
                                future: APIServices().getBadgesModelById(
                                    screenArguments['activities'][index]),
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
                                          const SkeletonText(
                                            width: 100,
                                            height: 30,
                                            radius: 10,
                                          ),
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
                padding: EdgeInsets.only(top: 20.h, left: 25.w),
                child: Row(
                  children: <Widget>[
                    Text(AppTextConstants.location,
                        style: AppTextStyle.semiBoldStyle),
                    SizedBox(width: 25.w),
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
                    SizedBox(width: 55.w),
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
                    SizedBox(width: 55.w),
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
                    SizedBox(width: 25.w),
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
                    SizedBox(width: 38.w),
                    Text(
                      screenArguments['date'],
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
                    SizedBox(width: 38.w),
                    Text(
                      'USD ${screenArguments['price'].toString().substring(1, 6)}',
                      style: AppTextStyle.greyStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigate to Outfitter Edit
  Future<void> navigateEditAdvertisementDetails(
      BuildContext context, Map<String, dynamic> screenArguments) async {
    final Map<String, dynamic> details = {
      'id': screenArguments['id'],
      'title': screenArguments['title'],
      'price': screenArguments['price'].toString().substring(1),
      'product_link': screenArguments['product_link'],
      'country': screenArguments['country'],
      'description': screenArguments['description'],
      'date': screenArguments['date'],
      'availability_date': screenArguments['availability_date'],
      'address': screenArguments['address'],
      'street': screenArguments['street'],
      'city': screenArguments['city'],
      'province': screenArguments['province'],
      'zip_code': screenArguments['zip_code'],
      'snapshot_img': screenArguments['snapshot_img'],
      'image_id': screenArguments['image_id'],
      'activities': screenArguments['activities']
    };

    await Navigator.pushNamed(context, '/advertisement_edit',
        arguments: details);
  }

  /// Removed item from advertisement
  Future<void> removeAdvertisementItem(String id) async {
    final Map<String, dynamic> advertisementDetails = {
      'is_published': false,
    };

    final dynamic response = await APIServices().request(
        '${AppAPIPath.createAdvertisementUrl}/$id', RequestType.PATCH,
        needAccessToken: true, data: advertisementDetails);

    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const MainNavigationScreen(
                  navIndex: 1,
                  contentIndex: 3,
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
