import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:intl/intl.dart';

///Subscription Details Screen
class SubscriptionDetails extends StatefulWidget {
  ///Constructor
  const SubscriptionDetails({Key? key}) : super(key: key);

  @override
  _SubscriptionDetailsState createState() => _SubscriptionDetailsState();
}

class _SubscriptionDetailsState extends State<SubscriptionDetails> {
  final UserSubscriptionController _userSubscriptionController =
      Get.put(UserSubscriptionController());
  UserSubscription userSubscriptionDetails = UserSubscription();

  @override
  void initState() {
    super.initState();
    userSubscriptionDetails = _userSubscriptionController.userSubscription;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
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
              child: const Text(
                'Premium Subscription',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            Card(
              shadowColor: Colors.grey,
                child: ListTile(
                  leading: Image.asset(AssetsPath.discoveryTree),
              title: Text('You are Subscribed',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              subtitle: Text(
                'Your subscription is valid until ${DateFormat("MMM dd,yyy").format(DateTime.parse(userSubscriptionDetails.endDate))}',
                style: TextStyle(fontSize: 14.sp),
              ),
            ))
            // Expanded(child: buildNotificationList())
          ],
        ),
      )),
    );
  }
}
