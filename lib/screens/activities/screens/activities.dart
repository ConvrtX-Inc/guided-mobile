import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/utils/secure_storage.dart';
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
  List<Activity> selectedActivities = <Activity>[];
  final List<Activity> activities = StaticDataService.getActivityList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  'Select Your Preferred Activities.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        crossAxisCount: 3,
                        mainAxisExtent: 140,
                      ),
                      itemBuilder: (_, int index) {
                        return buildPreferredActivity(activities[index]);
                      },
                      itemCount: activities.length,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.only(top: 16.h),
                      padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: HexColor('#CCFFD5'),
                          borderRadius: BorderRadius.all(Radius.circular(10.r))),
                      child: Text(
                        'Discovery Badge will let you discover unique activities hosted by different   local guides and organizations',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.sp,
                            color: AppColors.deepGreen),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 26.h),
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: selectedActivities.isNotEmpty
                        ? handleContinuePress
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.silver,
                        ),
                        borderRadius: BorderRadius.circular(18.r), // <-- Radius
                      ),
                      primary: AppColors.primaryGreen,
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      AppTextConstants.continueText,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  // Preferred Activity Widget
  Widget buildPreferredActivity(Activity activity) {
    final bool isSelected = isActivitySelected(activity);
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (isSelected) {
              setState(() {
                selectedActivities.remove(activity);
              });
            } else {
              setState(() {
                selectedActivities.add(activity);
              });
            }
          },
          child: Card(
            color: isSelected
                ? AppColors.brightSun
                : Colors.white, //AppColors.brightSun,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.circular(10),
            ),
            // margin: const EdgeInsets.all(20),
            child: Container(
              transform: Matrix4.translationValues(-6, 10, 0),
              height: 140.h,
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
        ),
        if (isSelected)
          Positioned(
            top: -5,
            right: -5,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 15,
              backgroundImage: AssetImage(AssetsPath.selectedActivity),
            ),
          ),
      ],
    );
  }

  // Checks if activity is selected
  bool isActivitySelected(Activity activity) {
    bool isSelected = false;
    final Activity selectedActivity = selectedActivities.firstWhere(
        (Activity element) => element.id == activity.id,
        orElse: () => Activity());
    if (selectedActivity.id.isNotEmpty) {
      isSelected = true;
    }
    return isSelected;
  }

  // handle continue button when pressed
  Future<void> handleContinuePress() async {
    await SecureStorage.saveValue(
        key: SecureStorage.preferredActivitiesKey, value: activities.join(','));
    await Navigator.of(context).pushNamed('/login');
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          IterableProperty<Activity>('selectedActivities', selectedActivities))
      ..add(IterableProperty<Activity>('activities', activities));
  }
}
