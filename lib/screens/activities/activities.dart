import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/services/static_data_services.dart';

///Activities Screen
class ActivitiesScreen extends StatefulWidget {
  ///constructor
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Activity> activities = StaticDataService.getActivityList();
    return Scaffold(
      // backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
              Padding(
                padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Select Your Prefered Activities.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.sp,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        mainAxisExtent: 150,
                      ),
                      itemBuilder: (_, int index) {
                        return Stack(
                          children: <Widget>[
                            actitivitiesCard(activities[index], index),
                            if (index == _selectedIndex)
                              Positioned(
                                top: -5,
                                right: -5,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 15,
                                  backgroundImage:
                                      AssetImage(AssetsPath.selectedActivity),
                                ),
                              ),
                          ],
                        );
                      },
                      itemCount: activities.length,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.w, 0.h, 30.w, 10.h),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                      color: HexColor('#CCFFD5'),
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  child: Text(
                    'Discovery Badge will let you discover unique activities hosted by different   local guides and organizations',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        width: MediaQuery.of(context).size.width,
        height: 60.h,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/login');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.silver,
              ),
              borderRadius: BorderRadius.circular(18.r), // <-- Radius
            ),
            primary: AppColors.primaryGreen,
            onPrimary: Colors.white, // <-- Splash color
          ),
          child: Text(
            AppTextConstants.continueText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget actitivitiesCard(Activity activity, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Card(
        color: index == _selectedIndex
            ? AppColors.brightSun
            : Colors.white, //AppColors.brightSun,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        // margin: const EdgeInsets.all(20),
        child: Container(
          transform: Matrix4.translationValues(-6, 10, 0),
          height: 150.h,
          width: 97.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: AssetImage(activity.path),
              ),
              Container(
                transform: Matrix4.translationValues(6, -20, 0),
                child: Text(
                  activity.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13.sp,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}