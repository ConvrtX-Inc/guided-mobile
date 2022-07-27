import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/chat_model.dart';
import 'package:guided/models/message.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/message/widgets/inbox_actions.dart';
import 'package:guided/screens/widgets/reusable_widgets/date_time_ago.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';

import 'message_individual_screen.dart';

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

  List<ChatModel> messages = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getMessages();
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
              // SizedBox(
              //   height: 15.h,
              // ),
              // Center(
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: AppColors.champagne,
              //         border: Border.all(
              //           color: AppColors.sunset,
              //         ),
              //         borderRadius: BorderRadius.all(Radius.circular(10.r))),
              //     child: AnimatedContainer(
              //       curve: Curves.fastOutSlowIn,
              //       duration: const Duration(milliseconds: 1),
              //       child: SizedBox(
              //         width: _width,
              //         height: _height,
              //         child: Stack(
              //           children: <Widget>[
              //             Positioned(
              //               right: 0.w,
              //               top: 0.h,
              //               child: IconButton(
              //                 icon: Image.asset(
              //                     '${AssetsPath.assetsPNGPath}/message_close.png',
              //                     height: 16.h,
              //                     width: 16.w),
              //                 onPressed: () {
              //                   setState(() {
              //                     _width = 0;
              //                     _height = 0;
              //                   });
              //                 },
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(20),
              //               child: Row(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: <Widget>[
              //                   Container(
              //                     width: 30.w,
              //                     height: 30.h,
              //                     decoration: const BoxDecoration(
              //                       shape: BoxShape.circle,
              //                       image: DecorationImage(
              //                         fit: BoxFit.fill,
              //                         image: AssetImage(
              //                             '${AssetsPath.assetsPNGPath}/message_reminder.png'),
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: 10.w,
              //                   ),
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: <Widget>[
              //                       SizedBox(
              //                         width: 215.w,
              //                         child: Text(
              //                           'Reminder to reply Anne Sasha. She sent you message 6 hours ago.',
              //                           style: TextStyle(
              //                             fontSize: 12.sp,
              //                             color: AppColors.rustOrange,
              //                           ),
              //                         ),
              //                       ),
              //                       Text(
              //                         'Reply Anne ',
              //                         style: TextStyle(
              //                           decoration: TextDecoration.underline,
              //                           fontWeight: FontWeight.w700,
              //                           fontSize: 14.sp,
              //                           color: AppColors.rustOrange,
              //                           decorationThickness: 2,
              //                         ),
              //                       ),
              //                     ],
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10.h,
              ),
              if (isLoading)
                Expanded(child: buildLoadingMessages())
              else
                Expanded(
                  child: messages.isNotEmpty
                      ? ListView.separated(
                          itemCount: messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildInboxItem(index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        )
                      : const Center(
                          child: Text("You Don't Have Any Messages Yet")),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInboxItem(int index) => Slidable(
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
                          onPressed: () {
                            InboxActions().showDeleteConversationDialog(context,
                                () {
                              deleteConversation(messages[index]);
                            });
                          },
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
          if (!messages[index].isBlocked!)
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
                            onPressed: () {
                              InboxActions().showBlockDialog(
                                  context, messages[index], () {
                                blockUserMessage(messages[index]);
                              });
                            },
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
            ),
          if (messages[index].isBlocked! && messages[index].userId! == messages[index].userMessageBlockFrom!)
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
                            onPressed: () {
                              unBlockUserMessage(messages[index]);
                            },
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Unblock',
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
      child: InkWell(
          onTap: () async {
            final dynamic result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MessageIndividual(
                          message: messages[index],
                        )));

            if (result == 'getMessages') {
              await getMessages();
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Row(
              children: <Widget>[
                Container(
                  height: 58.h,
                  width: 58.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    shape: BoxShape.circle,
                    image: messages[index].receiver!.avatar != ''
                        ? DecorationImage(
                            image:
                                NetworkImage(messages[index].receiver!.avatar!),
                            fit: BoxFit.cover,
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
                ),
                SizedBox(
                  width: 15.w,
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
                                TextSpan(
                                  text: messages[index].receiver!.fullName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DateTimeAgo(
                            dateString: messages[index]
                                .messages![messages[index].messages!.length - 1]
                                .createdDate!,
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
                              messages[index]
                                          .messages![
                                              messages[index].messages!.length -
                                                  1]
                                          .messageType!
                                          .toLowerCase() ==
                                      'text'
                                  ? messages[index]
                                      .messages![
                                          messages[index].messages!.length - 1]
                                      .message!
                                  : 'Sent a photo',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.dustyGrey,
                              ),
                            ),
                          ),
                          /*if (index == 0)
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
            ),
          )));

  Future<void> getMessages() async {
    final List<ChatModel> res = await APIServices()
        .getChatMessages( 'all');

    debugPrint('Messages: $res');

    if (res.isNotEmpty) {
      setState(() {
        isLoading = false;
        messages = res;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    debugPrint('DATA ${res.length}');
  }

  Widget buildLoadingMessages() => ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return const ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SkeletonText(
            shape: BoxShape.circle,
            height: 120,
            width: 120,
          ),
          title: SkeletonText(
            height: 15,
            width: 80,
          ),
          subtitle: SkeletonText(height: 10, width: 100),
          trailing: SkeletonText(width: 30),
        );
      });

  Future<void> deleteConversation(ChatModel chat) async {
    final response = await APIServices().deleteConversation(chat.roomId!);
    if (response.statusCode == 200) {
      debugPrint('deleted');
      Navigator.of(context).pop();
      setState(() {
        messages.remove(chat);
      });
    }
  }

  Future<void> blockUserMessage(ChatModel chat) async {
    final response = await APIServices().blockUserChat(chat.receiver!.id!);
    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 201) {
      Navigator.of(context).pop();
      chat
        ..isBlocked = true
        ..userMessageBlockedId = jsonData['id'];
      final int index = messages.indexOf(chat);
      setState(() {
        messages[index] = chat;
      });
      _showToast(context, 'You Blocked ${chat.receiver!.fullName!}');
    }
  }

  Future<void> unBlockUserMessage(ChatModel chat) async {
    final response = await APIServices().unBlockUserChat(chat.userMessageBlockedId!);
    debugPrint('status code ${response.statusCode}');
     if (response.statusCode == 200) {
      chat
        ..isBlocked = false
        ..userMessageBlockedId = '';
      final int index = messages.indexOf(chat);
      setState(() {
        messages[index] = chat;
      });
      _showToast(context, 'You Unblocked ${chat.receiver!.fullName!}');
    }
  }


  void _showToast(BuildContext context, String message) {
    final ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
