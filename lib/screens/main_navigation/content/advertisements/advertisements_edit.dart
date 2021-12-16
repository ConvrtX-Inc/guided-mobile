import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';

/// Edit Advertisement Screen
class AdvertisementEdit extends StatefulWidget {

  /// Constructor
  const AdvertisementEdit({Key? key}) : super(key: key);

  @override
  _AdvertisementEditState createState() => _AdvertisementEditState();
}

class _AdvertisementEditState extends State<AdvertisementEdit> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    /// Image List card widget
    Card _widgetImagesList() => Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      AppTextConstants.images,
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
                  AppTextConstants.sampleImage,
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
                  AppTextConstants.sampleImage,
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

    /// Title card widget
    Card _widgetTitle() => Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      AppTextConstants.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
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
                    AppTextConstants.sportGloves
                ),
              ],
            ),
          ),
        ],
      ),
    );


    /// Price card widget
    Card _widgetPrice() => Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      AppTextConstants.price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
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
                const Text("\$50"),
              ],
            ),
          ),
        ],
      ),
    );

    /// Description card widget
    Card _widgetDescription() => Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      AppTextConstants.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.5
                      ),
                    )
                ),
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
                Text(AppTextConstants.loremIpsum,
                    style: const TextStyle(
                        height: 1.5
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );


    /// Location card widget
    Card _widgetLocation() => Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      AppTextConstants.location,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
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
                Text('${AppTextConstants.country} : ${AppTextConstants.canada}'),
                SizedBox(
                  height: 5.h,
                ),
                Text('${AppTextConstants.state} : ${AppTextConstants.modaca}'),
                SizedBox(
                  height: 5.h,
                ),
                Text('${AppTextConstants.city} : ${AppTextConstants.tonado}'),
              ],
            ),
          ),
        ],
      ),
    );

    /// Province card widget
    Card _widgetProvince() => Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      AppTextConstants.province,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
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
                Text(AppTextConstants.west),
              ],
            ),
          ),
        ],
      ),
    );

    /// Postal Code card widget
    Card _widgetPostalCode() => Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      AppTextConstants.postalCode,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
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
                Text(AppTextConstants.postCode),
              ],
            ),
          ),
        ],
      ),
    );

    /// Date card widget
    Card _widgetDate() => Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      AppTextConstants.date,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
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
                Text(AppTextConstants.constDate),
              ],
            ),
          ),
        ],
      ),
    );

    return
        Scaffold(
          appBar: AppBar(
            elevation: 0,
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
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      HeaderText.headerText(AppTextConstants.editsummaryTitle),
                      SizedBox(
                        height: 30.h,
                      ),
                      _widgetImagesList(),
                      _widgetTitle(),
                      _widgetLocation(),
                      _widgetProvince(),
                      _widgetPostalCode(),
                      _widgetDate(),
                      _widgetDescription(),
                      _widgetPrice(),
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
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
                  AppTextConstants.postEvent,
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
