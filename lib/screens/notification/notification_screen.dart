import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/notification_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/date_time_ago.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Notification Screen
class NotificationScreen extends StatefulWidget {
  /// Constructor
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();

    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              Expanded(child: buildNotificationList())
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotificationList() => ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext ctx, int index) {
        final NotificationModel _notification = notifications[index];

        return Padding(
          padding: EdgeInsets.fromLTRB(4.w, 15.h, 0, 15.h),
          child: _notification.bookingRequestId != null
              ? bookingRequestNotif(_notification)
              : buildNotificationItem(_notification),
        );
      });

  Widget bookingRequestNotif(NotificationModel notification) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildProfilePic(notification.fromUser!.profilePhotoFirebaseUrl!),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      notification.title!,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                    DateTimeAgo(
                      dateString: notification.createdDate!,
                      size: 14.sp,
                      color: AppColors.cloud,
                    )
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  notification.notificationMsg!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.dustyGrey,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                if(notification.bookingRequestStatus!.isNotEmpty && notification.bookingRequestStatus =='Pending')
                  Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.lightningYellow,
                      border: Border.all(
                        color: AppColors.lightningYellow,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  child: Text(
                    notification.bookingRequestStatus!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );

  Widget _requestPending() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 58.h,
          width: 58.w,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            shape: BoxShape.circle,
            image: const DecorationImage(
              image:
                  AssetImage('${AssetsPath.assetsPNGPath}/profile_photo.png'),
              fit: BoxFit.contain,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                // offset: const Offset(
                //     0, 0), // changes position of shadow
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppTextConstants.requestPending,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    AppTextConstants.messageTime,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.cloud,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                'Your booking request in pending status',
                // dont add this on the app text constant since this will be coming from the api
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.dustyGrey,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.lightningYellow,
                    border: Border.all(
                      color: AppColors.lightningYellow,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Text(
                  AppTextConstants.pending,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _requestAccepted() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 58.h,
          width: 58.w,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            shape: BoxShape.circle,
            image: const DecorationImage(
              image:
                  AssetImage('${AssetsPath.assetsPNGPath}/student_profile.png'),
              fit: BoxFit.contain,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                // offset: const Offset(
                //     0, 0), // changes position of shadow
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppTextConstants.requestAccepted,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    AppTextConstants.messageTime,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.cloud,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                AppTextConstants.congratulations,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: AppColors.mediumGreen,
                  decorationThickness: 2,
                ),
              ),
              Text(
                'James Brown accepted your custom offer. Please contact with him for mre info',
                // dont add this on the app text constant since this will be coming from the api
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.dustyGrey,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildNotificationItem(NotificationModel notification) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProfilePic(notification.fromUser!.profilePhotoFirebaseUrl!),
        SizedBox(
          width: 10.w,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: [
                        /* TextSpan(
                          text: AppTextConstants.newMessage,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: AppColors.mediumGreen,
                          ),
                        ),*/
                        TextSpan(
                          text: notification.title,
                          // dont add this on the app text constant since this will be coming from the api
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*Text(
                    AppTextConstants.messageTime,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.cloud,
                    ),
                  ),*/
                  DateTimeAgo(
                    dateString: notification.createdDate!,
                    size: 14.sp,
                    color: AppColors.cloud,
                  )
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      notification.notificationMsg!,
                      // dont add this on the app text constant since this will be coming from the api
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.dustyGrey,
                      ),
                    ),
                  ),
                 /* Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.mediumGreen,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )*/
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildProfilePic(String image) => Container(
        height: 58.h,
        width: 58.w,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          shape: BoxShape.circle,
          image: image.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.contain,
                )
              : DecorationImage(
                  image: AssetImage(AssetsPath.defaultProfilePic),
                  fit: BoxFit.contain,
                ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              // offset: const Offset(
              //     0, 0), // changes position of shadow
            ),
          ],
        ),
      );

  Future<void> getNotifications() async {
    final List<NotificationModel> res = await APIServices().getNotifications();
    setState(() {
      notifications = res;
    });

    debugPrint('Notifications ${res.length}');
  }
}
