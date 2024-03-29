import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/requests.dart';
import 'package:guided/utils/requests.dart';

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

  final List<RequestsScreenModel> requestsItems =
      RequestsScreenUtils.getMockedDataRequestsScreen();
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
              // IconButton(
              //   icon: SvgPicture.asset(
              //       'assets/images/svg/arrow_back_with_tail.svg',
              //       height: 40.h,
              //       width: 40.w),
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              // ),
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
                height: 10.h,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: AppListConstants.filterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      key: ValueKey<int>(index),
                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: <Widget>[
                          Expanded(
                            child: SizedBox.expand(
                              child: OutlinedButton(
                                onPressed: null,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppColors.lightRed,
                                  shape: const RoundedRectangleBorder(),
                                  side: BorderSide.none,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Flexible(
                                        child: IconButton(
                                          iconSize: 40.h,
                                          icon: Image.asset(
                                              '${AssetsPath.assetsPNGPath}/delete_message.png'),
                                          onPressed: () {},
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Delete',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox.expand(
                              child: OutlinedButton(
                                onPressed: null,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppColors.lightRed,
                                  shape: const RoundedRectangleBorder(),
                                  side: BorderSide.none,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Flexible(
                                        child: IconButton(
                                          iconSize: 40.h,
                                          icon: Image.asset(
                                              '${AssetsPath.assetsPNGPath}/block_message.png'),
                                          onPressed: () {},
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Block',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 58.h,
                              width: 58.w,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(requestsItems[0].imgUrl),
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
                                              text: requestsItems[index].name,
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
