// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

import '../../../constants/app_routes.dart';

/// Create Package Screen
class TravellerPricingScreen extends StatefulWidget {
  /// Constructor
  const TravellerPricingScreen({Key? key}) : super(key: key);

  @override
  _TravellerPricingScreenState createState() => _TravellerPricingScreenState();
}

class _TravellerPricingScreenState extends State<TravellerPricingScreen> {
  bool showMainActivityChoices = false;
  bool showSubActivityChoices = false;
  dynamic mainActivity;

  late Future<BadgeModelData> _loadingData;

  @override
  void initState() {
    super.initState();

    _loadingData = APIServices().getBadgesModel();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  BackButtonWidget(),
                  Spacer(),
                  Text('17/21'),
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      //TODO
                    },
                  )
                ],
              ),
              InkWell(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    showMainActivityChoices = false;
                    showSubActivityChoices = false;
                  });
                },
                child: SizedBox(
                  width: width,
                  height: height,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          HeaderText.headerText("Traveller Pricing"),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          width: width,
          height: 60.h,
          child: ElevatedButton(
            onPressed: () {
              // Temp set to different screen
              Navigator.pushNamed(context, AppRoutes.BOOKING_SETTINGS);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.silver),
                borderRadius: BorderRadius.circular(18.r),
              ),
              primary: AppColors.primaryGreen,
              onPrimary: Colors.white,
            ),
            child: Text(
              AppTextConstants.continueText,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>(
        'showMainActivityChoices', showMainActivityChoices));
    properties.add(DiagnosticsProperty<bool>(
        'showSubActivityChoices', showSubActivityChoices));
    properties.add(DiagnosticsProperty('mainActivity', mainActivity));
  }
}
