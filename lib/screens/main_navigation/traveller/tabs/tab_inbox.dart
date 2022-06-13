import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/chat_model.dart';
import 'package:guided/models/message.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/message/message_screen_traveler.dart';
import 'package:guided/screens/widgets/reusable_widgets/app_home_button.dart';
import 'package:guided/screens/widgets/reusable_widgets/date_time_ago.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/screens/message/widgets/inbox_actions.dart';

/// TabInboxScreen Screen
class TabInboxScreen extends StatefulWidget {
  /// Constructor
  const TabInboxScreen({Key? key}) : super(key: key);

  @override
  _TabInboxScreenState createState() => _TabInboxScreenState();
}

class _TabInboxScreenState extends State<TabInboxScreen> {
  // final List<Message> messages = AppListConstants.getMessages();
  List<ChatModel> messages = [];
  bool isLoading = false;
  List<ChatModel> filteredMessages = [];

  String query = '';
  final TextEditingController _searchBoxTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFFFFF'),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leadingWidth: 60,
        leading: AppHomeButton(),
        title: Text(
          AppTextConstants.inbox,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.black
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,

      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 0.h),
                child: SizedBox(
                  height: 50.h,
                  child: TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    controller: _searchBoxTextController,
                    onChanged: (val) {
                      setState(() {
                        query = val.trim();

                        filteredMessages = messages
                            .where((element) => element.receiver!.fullName!
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Image.asset(
                          'assets/images/png/search_icon.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                        onPressed: null,
                      ),
                      hintText: 'Search here',
                      suffixIcon: query.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.close, color: AppColors.novel),
                              onPressed: () {
                                _searchBoxTextController.clear();
                                query = '';
                                setState(() {
                                  filteredMessages = messages;
                                });
                              })
                          : null,
                      hintStyle: TextStyle(fontSize: 16.sp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        // ignore: use_named_constants
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                          // color: HexColor('#F8F7F6'),
                        ),
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      //Ch
                      fillColor: HexColor('#F8F7F6'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (isLoading)
                Expanded(child: buildLoadingMessages())
              else
                Expanded(
                  child: filteredMessages.isNotEmpty
                      ? ListView.separated(
                          itemCount: filteredMessages.length,
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
                                                  onPressed: () {
                                                    InboxActions()
                                                        .showDeleteConversationDialog(
                                                            context, () {
                                                      deleteConversation(
                                                          messages[index]);
                                                    });

                                                    /* _showRemoveDialog(
                                                        messages[index]);*/
                                                  },
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  'Delete',
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                            shape:
                                                const RoundedRectangleBorder(),
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
                                                      InboxActions()
                                                          .showBlockDialog(
                                                              context,
                                                              messages[index],
                                                              () {
                                                        blockUserMessage(
                                                            messages[index]);
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'Block',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                  if (messages[index].isBlocked! &&
                                      messages[index].userId! ==
                                          messages[index].userMessageBlockFrom!)
                                    Expanded(
                                      child: SizedBox.expand(
                                        child: OutlinedButton(
                                          onPressed: null,
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: AppColors.lightRed,
                                            shape:
                                                const RoundedRectangleBorder(),
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
                                                      unBlockUserMessage(
                                                          messages[index]);
                                                    },
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'Unblock',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                            builder: (BuildContext context) =>
                                                MessageScreenTraveler(
                                                  message:
                                                      filteredMessages[index],
                                                )));

                                    if (result == 'getMessages') {
                                      await getMessages();
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 20.h),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 58.h,
                                          width: 58.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: filteredMessages[index]
                                                            .receiver !=
                                                        null &&
                                                    filteredMessages[index]
                                                            .receiver!
                                                            .avatar !=
                                                        ''
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                        filteredMessages[index]
                                                            .receiver!
                                                            .avatar!),
                                                    fit: BoxFit.cover,
                                                  )
                                                : DecorationImage(
                                                    image: AssetImage(AssetsPath
                                                        .defaultProfilePic),
                                                    fit: BoxFit.contain,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              filteredMessages[
                                                                      index]
                                                                  .receiver!
                                                                  .fullName,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 14.sp,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  DateTimeAgo(
                                                    dateString: filteredMessages[
                                                            index]
                                                        .messages![
                                                            filteredMessages[
                                                                        index]
                                                                    .messages!
                                                                    .length -
                                                                1]
                                                        .createdDate!,
                                                    size: 14.sp,
                                                    color: AppColors.cloud,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              //! added this
                                              Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: Text(
                                                      filteredMessages[index]
                                                                  .messages![filteredMessages[
                                                                              index]
                                                                          .messages!
                                                                          .length -
                                                                      1]
                                                                  .messageType!
                                                                  .toLowerCase() ==
                                                              'text'
                                                          ? filteredMessages[
                                                                  index]
                                                              .messages![filteredMessages[
                                                                          index]
                                                                      .messages!
                                                                      .length -
                                                                  1]
                                                              .message!
                                                          : 'You Sent a photo',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color:
                                                            AppColors.dustyGrey,
                                                      ),
                                                    ),
                                                  ),
                                                  /*if (index == 0)
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.mediumGreen,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '3',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                  )),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        )
                      : Center(
                          child: query.isEmpty
                              ? Text("You Don't Have Any Messages Yet")
                              : Text('No Messages Found')),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getMessages() async {
    final List<ChatModel> res = await APIServices()
        .getChatMessages(UserSingleton.instance.user.user!.id!, 'all');

    if (res.isNotEmpty) {
      setState(() {
        messages = res;
        filteredMessages = res;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
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

  Future<void> unBlockUserMessage(ChatModel chat) async {
    final response =
        await APIServices().unBlockUserChat(chat.userMessageBlockedId!);
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
}
