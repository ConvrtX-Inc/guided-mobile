import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/message.dart';

/// Notification Screen
class MessageInbox extends StatefulWidget {
  /// Constructor
  const MessageInbox({Key? key}) : super(key: key);

  @override
  _MessageInboxState createState() => _MessageInboxState();
}

class _MessageInboxState extends State<MessageInbox> {
  double _height = 94.h;
  double _width = 309.w;
  final List<Message> messages = AppListConstants.getMessages();
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
              SizedBox(
                height: 15.h,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppTextConstants.messages,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      IconButton(
                        icon: Image.asset(
                            '${AssetsPath.assetsPNGPath}/sort.png',
                            height: 22.h,
                            width: 24.w),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/message_filter');
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.champagne,
                      border: Border.all(
                        color: AppColors.sunset,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 1),
                    child: SizedBox(
                      width: _width,
                      height: _height,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            right: 0.w,
                            top: 0.h,
                            child: IconButton(
                              icon: Image.asset(
                                  '${AssetsPath.assetsPNGPath}/message_close.png',
                                  height: 16.h,
                                  width: 16.w),
                              onPressed: () {
                                setState(() {
                                  _width = 0;
                                  _height = 0;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          '${AssetsPath.assetsPNGPath}/message_reminder.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 215.w,
                                      child: Text(
                                        'Reminder to reply Anne Sasha. She sent you message 6 hours ago.',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.rustOrange,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Reply Anne ',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp,
                                        color: AppColors.rustOrange,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 20.h),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 58.h,
                            width: 58.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(messages[index].imgUrl),
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
                            width: 15.w,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: messages[index].name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
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
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(
                                        'Sample tourist text message goes here to receive tourist guide ',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.dustyGrey,
                                        ),
                                      ),
                                    ),
                                    if (index == 0)
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
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
                                      )
                                  ],
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
