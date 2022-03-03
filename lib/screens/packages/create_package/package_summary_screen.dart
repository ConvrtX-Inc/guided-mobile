// ignore_for_file: file_names, cast_nullable_to_non_nullable, unused_local_variable, avoid_dynamic_calls, always_specify_types
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/image_bulk_package.dart';
import 'package:guided/screens/main_navigation/content/content_main.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Package Summary Screen
class PackageSummaryScreen extends StatefulWidget {
  /// Constructor
  const PackageSummaryScreen({Key? key}) : super(key: key);

  @override
  _PackageSummaryScreenState createState() => _PackageSummaryScreenState();
}

class _PackageSummaryScreenState extends State<PackageSummaryScreen> {
  bool isChecked = false;

  final TextStyle txtStyle = TextStyle(fontSize: 14.sp, fontFamily: 'Poppins');

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
            onPressed: () async => packageDetail(),
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
            child: Text(
              AppTextConstants.submit,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> packageDetail() async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String userId =
        await SecureStorage.readValue(key: SecureStorage.userIdKey);

    final Map<String, dynamic> packageDetails = {
      'user_id': userId,
      'package_note': screenArguments['note'],
      'name': screenArguments['package_name'],
      'description': screenArguments['description'],
      'cover_img': screenArguments['cover_img'],
      'max_traveller': int.parse(screenArguments['maximum']),
      'min_traveller': int.parse(screenArguments['minimum']),
      'country': screenArguments['country'],
      'address':
          '${screenArguments['street']}, ${screenArguments['city']}, ${screenArguments['state']}, ${screenArguments['zip_code']}',
      'services': screenArguments['services'],
      'base_price': screenArguments['base_price'],
      'extra_cost_per_person': screenArguments['extra_cost'],
      'max_extra_person': int.parse(screenArguments['max_person']),
      'currency_id': screenArguments['currency_id'],
      'price_note': screenArguments['additional_notes'],
      'is_published': false
    };

    final dynamic response = await APIServices().request(
        AppAPIPath.activityPackagesUrl, RequestType.POST,
        needAccessToken: true, data: packageDetails);

    /// Get the activity package id
    final String activityPackageId = response['id'];

    /// Destination Details
    final Map<String, dynamic> destinationDetails = {
      'activity_package_id': activityPackageId,
      'place_name': screenArguments['place_name'],
      'place_description': screenArguments['place_description'],
      'latitude': '9.300221', //static for now
      'longitude': '19.670221', //static for now
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
        'snapshot_img': screenArguments['snapshot_img_1'],
      };

      await APIServices().request(
          AppAPIPath.activityDestinationImage, RequestType.POST,
          needAccessToken: true, data: image);
    } else if (screenArguments['upload_count'] == 2) {
      final ImageListPackage objImg1 = ImageListPackage(
          id: activityPackageDestinationId,
          img: screenArguments['snapshot_img_1']);
      final ImageListPackage objImg2 = ImageListPackage(
          id: activityPackageDestinationId,
          img: screenArguments['snapshot_img_2']);

      final List<ImageListPackage> list = [objImg1, objImg2];

      final Map<String, List<dynamic>> finalJson = {'bulk': encodeToJson(list)};

      await APIServices().request(
          AppAPIPath.activityDestinationImageBulk, RequestType.POST,
          needAccessToken: true, data: finalJson);
    } else if (screenArguments['upload_count'] == 3) {
      final ImageListPackage objImg1 = ImageListPackage(
          id: activityPackageDestinationId,
          img: screenArguments['snapshot_img_1']);
      final ImageListPackage objImg2 = ImageListPackage(
          id: activityPackageDestinationId,
          img: screenArguments['snapshot_img_2']);
      final ImageListPackage objImg3 = ImageListPackage(
          id: activityPackageDestinationId,
          img: screenArguments['snapshot_img_3']);

      final List<ImageListPackage> list = [objImg1, objImg2, objImg3];

      final Map<String, List<dynamic>> finalJson = {'bulk': encodeToJson(list)};

      await APIServices().request(
          AppAPIPath.activityDestinationImageBulk, RequestType.POST,
          needAccessToken: true, data: finalJson);
    }

    await Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const MainContent(initIndex: 0)),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isChecked', isChecked));
  }
}
