// ignore_for_file: file_names, cast_nullable_to_non_nullable, unused_local_variable, avoid_dynamic_calls, always_specify_types
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/activity_destination_model.dart';
import 'package:guided/models/address.dart';
import 'package:guided/models/image_bulk_package.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/models/services.dart';

/// Package Summary Screen
class PackageSummaryScreen extends StatefulWidget {
  /// Constructor
  const PackageSummaryScreen({Key? key}) : super(key: key);

  @override
  _PackageSummaryScreenState createState() => _PackageSummaryScreenState();
}

class _PackageSummaryScreenState extends State<PackageSummaryScreen> {
  bool isChecked = false;
  bool _isSubmit = false;
  final TextStyle txtStyle = TextStyle(fontSize: 14.sp, fontFamily: 'Poppins');
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      List<String> list = screenArguments['services'];

      // final service = Services(
      //   services: list.join(','),
      // );

      // serviceData = Services(services: list.join(','));

      // final json = serviceData.toJson();
      // print('JSON 1: ${json}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Card _widgetMainActivity() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.activities,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    AppTextConstants.edit,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    screenArguments['main_activity'],
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _widgetSubActivity() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.subActivities,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    AppTextConstants.edit,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    screenArguments['sub_activity_1'],
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    screenArguments['sub_activity_2'],
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    screenArguments['sub_activity_3'],
                    style: txtStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _widgetPackageNameDescription() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.packageNameandDescr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    AppTextConstants.edit,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    screenArguments['package_name'],
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    screenArguments['description'],
                    style: txtStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _numberOfTraveler() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.numberOfTraveler,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    AppTextConstants.edit,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '${screenArguments['maximum']} tourists',
                    style: txtStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _currentLocation() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.currentLocation,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    AppTextConstants.edit,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '${screenArguments['country']},${screenArguments['street']}',
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '${screenArguments['state']}, ${screenArguments['city']}',
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '${screenArguments['zip_code']}',
                    style: txtStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _locationOfPackage() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.locationOfPackage,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    AppTextConstants.edit,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    screenArguments['place_name'],
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    screenArguments['place_description'],
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _offeredAmenities() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.offeredAmenities,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    AppTextConstants.edit,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: int.parse(screenArguments['services_length']),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          screenArguments['services'][index],
                          style: txtStyle,
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      );
    }

    Card _attachedPhotos() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.attachedPhotos,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    AppTextConstants.edit,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Sample', // Will come from API
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Sample', // Will come from API
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Sample', // Will come from API
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _basePrice() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${AppTextConstants.basePrice}: \$${screenArguments['base_price']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${AppTextConstants.extraCost}: \$${screenArguments['extra_cost']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                  Text(
                    AppTextConstants.edit,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.headerSummary),
                  SizedBox(height: 30.h),
                  _widgetMainActivity(),
                  SizedBox(height: 15.h),
                  _widgetSubActivity(),
                  SizedBox(height: 15.h),
                  _widgetPackageNameDescription(),
                  SizedBox(height: 15.h),
                  _numberOfTraveler(),
                  SizedBox(height: 15.h),
                  _currentLocation(),
                  SizedBox(height: 15.h),
                  _locationOfPackage(),
                  SizedBox(height: 15.h),
                  _offeredAmenities(),
                  SizedBox(height: 15.h),
                  _attachedPhotos(),
                  SizedBox(height: 15.h),
                  _basePrice(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: 60,
          child: ElevatedButton(
            onPressed: () async => _isSubmit ? null : packageDetail(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.silver,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              primary: AppColors.primaryGreen,
              onPrimary: Colors.white,
            ),
            child: _isSubmit
                ? const Center(child: CircularProgressIndicator())
                : Text(
                    AppTextConstants.submit,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> packageDetail() async {
    setState(() {
      _isSubmit = true;
    });

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String? userId = UserSingleton.instance.user.user!.id;

    List<String> list = screenArguments['services'];

    Map<String, dynamic> packageDetails = {
      'user_id': userId,
      'package_note': screenArguments['note'].toString(),
      'name': screenArguments['package_name'].toString(),
      'description': screenArguments['description'].toString(),
      'cover_img': screenArguments['cover_img'].toString(),
      'max_traveller': int.parse(screenArguments['maximum'].toString()),
      'min_traveller': int.parse(screenArguments['minimum'].toString()),
      'country': screenArguments['country'].toString(),
      'address':
          '${screenArguments['street']}, ${screenArguments['city']}, ${screenArguments['state']}, ${screenArguments['zip_code']}',
      'services': list.join(','),
      'base_price': screenArguments['base_price'].toString(),
      'extra_cost_per_person': screenArguments['extra_cost'].toString(),
      'max_extra_person': int.parse(screenArguments['max_person'].toString()),
      'currency_id': screenArguments['currency_id'].toString(),
      'price_note': screenArguments['additional_notes'].toString(),
      'is_published': true
    };

    /// Activity Package Details API
    final dynamic response = await APIServices().request(
        AppAPIPath.activityPackagesUrl, RequestType.POST,
        needAccessToken: true, data: packageDetails);

    /// Get the activity package id
    final String activityPackageId = response['id'];

    List<ActivityDestinationModel> item = screenArguments['destination_list'];

    /// Loop through the destination list
    for (var i = 0; i < item.length; i++) {
      /// Destination Details
      final Map<String, dynamic> destinationDetails = {
        'activity_package_id': activityPackageId,
        'place_name': item[i].placeName,
        'place_description': item[i].placeDescription,
        'latitude': item[i].latitude,
        'longitude': item[i].longitude,
      };

      final dynamic response1 = await APIServices().request(
          AppAPIPath.activityDestinationDetails, RequestType.POST,
          needAccessToken: true, data: destinationDetails);

      /// Get the activity package destination id
      final String activityPackageDestinationId = response1['id'];

      /// Destination Image API
      if (screenArguments['upload_count'] == 1) {
        final Map<String, dynamic> image = {
          'activity_package_destination_id': activityPackageDestinationId,
          'snapshot_img': item[i].img1Holder,
        };

        /// Activity Package Destination Image API
        await APIServices().request(
            AppAPIPath.activityDestinationImage, RequestType.POST,
            needAccessToken: true, data: image);
      } else if (screenArguments['upload_count'] == 2) {
        final ImageListPackage objImg1 = ImageListPackage(
            id: activityPackageDestinationId, img: item[i].img1Holder);
        final ImageListPackage objImg2 = ImageListPackage(
            id: activityPackageDestinationId, img: item[i].img2Holder);

        final List<ImageListPackage> list = [objImg1, objImg2];

        final Map<String, List<dynamic>> finalJson = {
          'bulk': encodeToJson(list)
        };

        /// Activity Package Destination Image Bulk API
        await APIServices().request(
            AppAPIPath.activityDestinationImageBulk, RequestType.POST,
            needAccessToken: true, data: finalJson);
      } else if (screenArguments['upload_count'] == 3) {
        final ImageListPackage objImg1 = ImageListPackage(
            id: activityPackageDestinationId, img: item[i].img1Holder);
        final ImageListPackage objImg2 = ImageListPackage(
            id: activityPackageDestinationId, img: item[i].img2Holder);
        final ImageListPackage objImg3 = ImageListPackage(
            id: activityPackageDestinationId, img: item[i].img3Holder);

        final List<ImageListPackage> list = [objImg1, objImg2, objImg3];

        final Map<String, List<dynamic>> finalJson = {
          'bulk': encodeToJson(list)
        };

        /// Activity Package Destination Image Bulk API
        await APIServices().request(
            AppAPIPath.activityDestinationImageBulk, RequestType.POST,
            needAccessToken: true, data: finalJson);
      }
    }

    final Map<String, dynamic> guideRuleDetails = {
      'user_id': userId,
      'description': screenArguments['guide_rule']
    };

    /// Guide Rules and What to Bring Details API
    final dynamic response2 = await APIServices().request(
        AppAPIPath.guideRules, RequestType.POST,
        needAccessToken: true, data: guideRuleDetails);

    final Map<String, dynamic> localLawDetails = {
      'user_id': userId,
      'description': screenArguments['local_law_and_taxes']
    };

    /// Local Laws and Taxes Details API
    final dynamic response3 = await APIServices().request(
        AppAPIPath.localLawandTaxes, RequestType.POST,
        needAccessToken: true, data: localLawDetails);

    final Map<String, dynamic> waiverDetails = {
      'user_id': userId,
      'description': screenArguments['waiver']
    };

    /// Waiver Details API
    final dynamic response4 = await APIServices().request(
        AppAPIPath.waiverUrl, RequestType.POST,
        needAccessToken: true, data: waiverDetails);

    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const MainNavigationScreen(
                  navIndex: 1,
                  contentIndex: 0,
                )));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isChecked', isChecked));
  }
}
