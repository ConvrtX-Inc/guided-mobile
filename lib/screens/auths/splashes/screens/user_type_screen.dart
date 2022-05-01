// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/utils/secure_storage.dart';

/// User type screen
class UserTypeScreen extends StatefulWidget {
  ///Constructor
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              AssetsPath.logo,
              width: 90.w,
              height: 90.h,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      final Map<String, dynamic> details = {
                        'user_type': 'traveller'
                      };
                      await SecureStorage.saveValue(
                              key: AppTextConstants.userType,
                              value: 'traveller')
                          .then((_) {
                        Navigator.of(context)
                            .pushNamed('/user_on_boarding', arguments: details);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: AppColors.galleryWhite)),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "I'm a Traveler",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Gilroy',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  height: 100.h,
                                  width: 100.w,
                                  child: Image.asset(
                                    AssetsPath.rafikiImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () async {
                      final Map<String, dynamic> details = {
                        'user_type': 'guide'
                      };
                      await SecureStorage.saveValue(
                              key: AppTextConstants.userType, value: 'guide')
                          .then((_) {
                        Navigator.of(context)
                            .pushNamed('/user_on_boarding', arguments: details);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: AppColors.galleryWhite)),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "I'm a Guide/Outfitter",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Gilroy',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  height: 100.h,
                                  width: 100.w,
                                  child: Image.asset(
                                    AssetsPath.amico,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              AssetsPath.forThePlanet,
              height: 45.h,
            ),
          ],
        ),
      ),
    );
  }
}
