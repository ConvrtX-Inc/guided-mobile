import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/contained_tab_bar_view.dart';
import 'package:guided/common/widgets/custom_tab_bar_view/tab_bar_properties.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/notification_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:intl/intl.dart';

///Notification Screen for Traveler
class NotificationTraveler extends StatefulWidget {
  ///Constructor
  const NotificationTraveler({Key? key}) : super(key: key);

  @override
  _NotificationTravelerState createState() => _NotificationTravelerState();
}

class _NotificationTravelerState extends State<NotificationTraveler> {
  int selectedIndex = 0;
  Color tabColor = Colors.black;
  String selectedFilter = 'All';

  List<NotificationModel> notifications = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getNotifications();
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
            Expanded(
                child: ContainedTabBarView(
                    tabs: <Widget>[
                      Text(AppTextConstants.all,
                          style: selectedIndex == 0
                              ? const TextStyle(fontWeight: FontWeight.w700)
                              : null),
                      Text(
                        AppTextConstants.accepted,
                        style: selectedIndex == 1
                            ? TextStyle(
                                color: AppColors.mediumGreen,
                                fontWeight: FontWeight.w700)
                            : null,
                      ),
                      Text(AppTextConstants.rejected,
                          style: selectedIndex == 2
                              ? TextStyle(
                                  color: AppColors.lightRed,
                                  fontWeight: FontWeight.w700)
                              : null),
                    ],
                    tabBarProperties: TabBarProperties(
                      height: 42,
                      margin: const EdgeInsets.all(8),
                      indicatorColor: tabColor,
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 2.w, color: tabColor),
                          insets: EdgeInsets.symmetric(horizontal: 18.w)),
                      indicatorWeight: 1,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                    ),
                    views: <Widget>[
                      for (int i = 0; i < 3; i++) buildNotificationsUI(),
                    ],
                    onChange: setTab))
            // Expanded(child: buildNotificationList())
          ],
        ),
      )),
    );
  }

  Widget buildNotificationsUI() =>
      isLoading ? buildLoadingNotificationUI() : buildNotificationList();

  Widget buildNotificationList() => notifications.isNotEmpty
      ? Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return buildNotificationItem(notifications[index]);
              },
              itemCount: notifications.length))
      : Center(
          child: Text("You don't have any notifications yet",
              style: TextStyle(color: AppColors.grey)),
        );

  Widget buildNotificationItem(NotificationModel notification) => Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            border: Border.all(color: AppColors.tabBorder)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              notification.title!,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: notification.bookingRequestStatus!.toLowerCase() ==
                          AppTextConstants.rejected.toLowerCase()
                      ? AppColors.lightRed
                      : AppColors.mediumGreen),
            ),
            SizedBox(height: 16.h),
            Text(notification.notificationMsg!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(height: 16.h),
            Text(
                'Booking Date ${DateFormat('dd. MMM. yyyy').format(DateTime.parse(notification.bookingRequestDate!))}',
                style: TextStyle(fontSize: 14.sp, color: AppColors.grey)),
            SizedBox(
              height: 14.h,
            ),
            Row(
              children: <Widget>[
                Text(
                  'View Request Details',
                  style: TextStyle(
                      color: AppColors.mediumGreen,
                      decoration: TextDecoration.underline,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                Spacer(),
                Text(
                  'No: ${notification.transactionNo!}',
                  style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp),
                )
              ],
            )
          ],
        ),
      );

  Widget buildLoadingNotificationUI() => Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return buildFakeNotificationItem();
          },
          itemCount: 5));

  Widget buildFakeNotificationItem() => Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            border: Border.all(color: AppColors.tabBorder)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SkeletonText(height: 15.h, width: 80.w),
            SizedBox(height: 16.h),
            SkeletonText(height: 15.h, width: 180.w),
            SizedBox(
              height: 14.h,
            ),
            Row(
              children: <Widget>[
                SkeletonText(height: 15.h, width: 80.w),
                Spacer(),
                SkeletonText(height: 15.h, width: 80.w),
              ],
            )
          ],
        ),
      );

  void setTab(int index) {
    Color _tabColor = Colors.black;
    String _selectedTab = '';
    switch (index) {
      case 1:
        _tabColor = AppColors.mediumGreen;
        _selectedTab = 'Accepted';
        break;
      case 2:
        _tabColor = AppColors.lightRed;
        _selectedTab = 'Rejected';
        break;
      default:
        _tabColor = Colors.black;
        _selectedTab = 'All';
    }

    setState(() {
      selectedIndex = index;
      tabColor = _tabColor;
      selectedFilter = _selectedTab;
    });

    getNotifications();
  }

  Future<void> getNotifications() async {
    setState(() {
      isLoading = true;
    });
    final List<NotificationModel> res =
        await APIServices().getTravelerNotifications(selectedFilter);

    setState(() {
      notifications = res;
      isLoading = false;
    });
  }
}
