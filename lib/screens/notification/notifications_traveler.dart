import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_properties.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/helpers/hexColor.dart';

import '../../common/widgets/custom_tab_bar_view/contained_tab_bar_view.dart';

///Notification Screen for Traveler
class NotificationTraveler extends StatefulWidget {
  ///Constructor
  const NotificationTraveler({Key? key}) : super(key: key);

  @override
  _NotificationTravelerState createState() => _NotificationTravelerState();
}

class _NotificationTravelerState extends State<NotificationTraveler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:   Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: SvgPicture.asset(
                    'assets/images/svg/arrow_back_with_tail.svg',
                    height: 40.h,
                    width: 40.w),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  AppTextConstants.notification,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            Expanded(child:   ContainedTabBarView(
              tabs: const <Widget>[
                Text(
                  'All',
                ),
                Text(
                  'Accepted',
                ),
                Text(
                  'Rejected',
                ),
              ],
              tabBarProperties: TabBarProperties(
                height: 42,
                margin: const EdgeInsets.all(8),
                indicatorColor: Colors.red,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.w,color: HexColor('#ECEFF0')),
                    insets: EdgeInsets.symmetric(horizontal: 18.w)),
                indicatorWeight: 1,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
              ),
              views: <Widget>[
                Container(
                  child: Text('All'),
                ),
                Container(
                  child: Text('Accepted'),
                ),
                Container(
                  child: Text('Rejected'),
                ),
              ],

            ))
              // Expanded(child: buildNotificationList())
            ],
          ),
        ),

    );
  }

  void setTitle(int initIndex) {
    debugPrint('Index $initIndex');
  }
}
