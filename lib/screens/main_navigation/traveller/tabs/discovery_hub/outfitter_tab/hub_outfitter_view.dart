// ignore_for_file: always_specify_types, cast_nullable_to_non_nullable,avoid_bool_literals_in_conditional_expressions, avoid_dynamic_calls, cascade_invocations, avoid_void_async
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Outfitter View Screen
class HubOutfitterView extends StatefulWidget {
  /// Constructor
  const HubOutfitterView({Key? key}) : super(key: key);

  @override
  _HubOutfitterViewState createState() => _HubOutfitterViewState();
}

class _HubOutfitterViewState extends State<HubOutfitterView> {
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
              ],
            ),
            flexibleSpace: screenArguments['snapshot_img'] != ''
                ? Image.memory(
                    base64.decode(
                        screenArguments['snapshot_img'].split(',').last),
                    fit: BoxFit.fitHeight,
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
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(screenArguments['title'],
                        style: AppTextStyle.txtStyle),
                    Text(
                      screenArguments['price'],
                      style: AppTextStyle.txtStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppTextConstants.companyName,
                      style: AppTextStyle.semiBoldStyle,
                    ),
                    SizedBox(width: 15.w),
                    GestureDetector(
                      onTap: () async {
                        await openBrowserURL(
                            url: 'https://${screenArguments['product_link']}',
                            inApp: true);
                      },
                      child: Text(AppTextConstants.visitOurStore,
                          style: AppTextStyle.underlinedLinkStyle),
                    ),
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
                child: Row(
                  children: <Widget>[
                    Text(AppTextConstants.productLink,
                        style: AppTextStyle.semiBoldStyle),
                    SizedBox(width: 35.w),
                    Text(
                      screenArguments['product_link'],
                      style: AppTextStyle.greyStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 25.w),
                child: Row(
                  children: <Widget>[
                    Text(AppTextConstants.location,
                        style: AppTextStyle.semiBoldStyle),
                    SizedBox(width: 49.w),
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
                    SizedBox(width: 80.w),
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
                    SizedBox(width: 80.w),
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
                    SizedBox(width: 49.w),
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
                    SizedBox(width: 60.w),
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
                    SizedBox(width: 60.w),
                    Text(
                      'USD ${screenArguments['price'].toString().substring(1, 6)}',
                      style: AppTextStyle.greyStyle,
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.w),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      await openBrowserURL(
                          url: 'https://${screenArguments['product_link']}',
                          inApp: true);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.silver,
                        ),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      primary: AppColors.primaryGreen,
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      AppTextConstants.visitShop,
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

  Future<void> openBrowserURL({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: inApp, // iOS
          forceWebView: inApp, // Android
          enableJavaScript: true // Android
          );
    }
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
