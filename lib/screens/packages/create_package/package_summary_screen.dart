// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/packages/create_package/waiver_screen.dart';

/// Package Summary Screen
class PackageSummaryScreen extends StatefulWidget {

  /// Constructor
  const PackageSummaryScreen({Key? key}) : super(key: key);

  @override
  _PackageSummaryScreenState createState() => _PackageSummaryScreenState();
}

class _PackageSummaryScreenState extends State<PackageSummaryScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

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
                      AppTextConstants.campaign
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                      AppTextConstants.hiking
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                      AppTextConstants.hunt
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
                    AppTextConstants.campaign
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                      AppTextConstants.hunt
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
                  const Text('Sample name goes here'), // Name will come from API
                  SizedBox(
                    height: 5.h,
                  ),
                  const Text(
                      'Sample description goes here to explain about your package details. Sample description goes here to explain about your package details. ' // Description will come from API
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
                children: <Widget> [
                  SizedBox(
                    height: 5.h,
                  ),
                  const Text('5 tourists'), // Will come from API
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
                      AppTextConstants.countryStreet
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    AppTextConstants.stateCity
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    AppTextConstants.zipCode
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
                      AppTextConstants.locationGoesHere, // Will come from API
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
                    AppTextConstants.locationGoesHere
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Text(
                      'Sample description goes here to explain about your package details. Sample description goes here to explain about your package details.' // Will come from API
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
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    AppTextConstants.transport
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    AppTextConstants.breakfast
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    AppTextConstants.water
                  ),
                ],
              ),
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
                    children: const <Widget>[
                      Text(
                        'Base Price 100', // Will come from API
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Base Price 100', // Will come from API
                        style: TextStyle(
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
                  HeaderText.headerText(
                      AppTextConstants.headerSummary
                  ),
                  SizedBox(
                    height: 30.h
                  ),
                  _widgetMainActivity(),
                  SizedBox(
                      height: 15.h
                  ),
                  _widgetSubActivity(),
                  SizedBox(
                      height: 15.h
                  ),
                  _widgetPackageNameDescription(),
                  SizedBox(
                      height: 15.h
                  ),
                  _numberOfTraveler(),
                  SizedBox(
                      height: 15.h
                  ),
                  _currentLocation(),
                  SizedBox(
                      height: 15.h
                  ),
                  _locationOfPackage(),
                  SizedBox(
                      height: 15.h
                  ),
                  _offeredAmenities(),
                  SizedBox(
                      height: 15.h
                  ),
                  _attachedPhotos(),
                  SizedBox(
                      height: 15.h
                  ),
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
            onPressed: () {
              Navigator.of(context).pushNamed('/waiver');
            },
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
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isChecked', isChecked));
  }
}
