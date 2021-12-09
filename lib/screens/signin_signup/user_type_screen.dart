// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/signin_signup/user_on_boarding_screen.dart';

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
                    onTap: () {
                      Navigator.of(context).pushNamed('/user_on_boarding');
                    },
                    child: Image.asset(
                      AssetsPath.touristImage,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/user_on_boarding');
                    },
                    child: Image.asset(
                      AssetsPath.guideImage,
                      width: 345.w,
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
