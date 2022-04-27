import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/chat_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/date_time_ago.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

///Message Screen Traveler
class MessageScreenTraveler extends StatefulWidget {
  ///Constructor
  const MessageScreenTraveler({Key? key, this.message}) : super(key: key);

  final ChatModel? message;

  @override
  _MessageScreenTravelerState createState() => _MessageScreenTravelerState();
}

class _MessageScreenTravelerState extends State<MessageScreenTraveler> {
  List<Message> chatMessages = [];

  late IO.Socket socket;
  String message = 'test';
  final TextEditingController _textMessageController = TextEditingController();

  ChatModel chat = ChatModel();

  final UserProfileDetailsController _profileDetailsController =
      Get.put(UserProfileDetailsController());

  ProfileDetailsModel senderDetails = ProfileDetailsModel();

  final GroupedItemScrollController _scrollController =
      GroupedItemScrollController();

  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();

    final KeyboardVisibilityController keyboardVisibilityController =
        KeyboardVisibilityController();

    chat = widget.message!;

    chatMessages = List.from(widget.message!.messages!);

    senderDetails = _profileDetailsController.userProfileDetails;

    connectToServer();

    scrollToBottom();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      keyboardSubscription =
          keyboardVisibilityController.onChange.listen((bool visible) {
        if (visible) {
          if (chatMessages.isNotEmpty) {
            scrollToBottom();
          }
        }
      });
    });
  }

  void connectToServer() {

    socket = IO.io(AppAPIPath.webSocketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    // Connect to websocket
    socket.connect();
    // Handle socket events
    // ignore: cascade_invocations
    socket.onConnect((_) {
      debugPrint('connected');
      socket.emit('msg', 'test');
    });

    // ignore: cascade_invocations
    socket.onError((data) {
      debugPrint('error $data');
    });

    // ignore: cascade_invocations
    socket.emit('connect_users', {
      'receiver_id': chat.receiver!.id!,
      'sender_id': UserSingleton.instance.user.user?.id,
    });

    socket.on('msgToClient', handleMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop('getMessages'),
        ),
        title: Text(chat.receiver!.fullName!,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15.h,
            ),
            /*      Expanded(
              child: ListView.builder(
                itemCount: chatMessages.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  final Message message = chatMessages[index];
                  debugPrint(
                      'Sender id : ${message.senderId} Text ${message.message} sender detais ${senderDetails.id}');
                  return message.senderId == senderDetails.id
                      ? _myMessage(message)
                      : _guideMessage(message);
                },
              ),
            ),*/
            Expanded(child: buildMessages()),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // height: 87.h,
                  width: double.infinity,
                  color: Colors.white,
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 3,
                            controller: _textMessageController,
                            onChanged: (val) {
                              setState(() {
                                message = val.trim();
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(4.w),
                      /*        prefixIcon: IconButton(
                                icon: SvgPicture.asset(
                                    '${AssetsPath.assetsSVGPath}/emoji.svg',
                                    height: 16.h,
                                    width: 16.w,
                                    fit: BoxFit.scaleDown),
                                onPressed: () {},
                              ),
                              suffixIcon: IconButton(
                                  icon: SvgPicture.asset(
                                      '${AssetsPath.assetsSVGPath}/attachment.svg',
                                      height: 16.h,
                                      width: 16.w,
                                      fit: BoxFit.scaleDown),
                                  onPressed: () {}),*/
                              filled: true,
                              fillColor: AppColors.porcelain,
                              hintText: 'Type your message...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                  borderSide: BorderSide.none),
                              hintStyle: TextStyle(
                                color: AppColors.novel,
                              ),
                            ),
                            style: TextStyle(
                                color: AppColors.novel, fontSize: 16.sp),
                          ),
                        ),
                        if (_textMessageController.text.isNotEmpty)
                          GestureDetector(
                              onTap: sendMessageToServer,
                              child: Container(
                                height: 48.h,
                                width: 40.w,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: AppColors.deepGreen,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: const Icon(Icons.arrow_forward,
                                    color: Colors.white),
                              ))
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _myMessage(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(
              width: 205.w,
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              decoration: BoxDecoration(
                color: HexColor('#F7F9FA'),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
              ),
              child: Text(
                message.message!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 2,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            DateTimeAgo(
                dateString: message.createdDate!,
                textAlign: TextAlign.right,
                color: HexColor('#C4C4C4'),
                size: 12.sp),
          ])),
          SizedBox(
            width: 15.w,
          ),
          buildProfilePicture(senderDetails.firebaseProfilePicUrl),
        ],
      ),
    );
  }

  Widget _guideMessage(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildProfilePicture(chat.receiver!.avatar!),
          SizedBox(
            width: 15.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 205.w,
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                decoration: BoxDecoration(
                    color: HexColor('#F7F9FA'),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Text(
                  message.message!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 2,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              DateTimeAgo(
                  dateString: message.createdDate!,
                  color: HexColor('#C4C4C4'),
                  size: 12.sp),
            ],
          )
        ],
      ),
    );
  }

  Widget buildProfilePicture(String image) => Container(
        height: 39.h,
        width: 39.w,
        margin: EdgeInsets.only(bottom: 35.h),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.white, width: 3),
          shape: BoxShape.circle,
          image: image.isEmpty
              ? DecorationImage(
                  image: AssetImage(AssetsPath.defaultProfilePic),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
        ),
      );

  handleMessage(payload) {
    // final dynamic dataFromServer = jsonDecode(payload);
    final Message message = Message(
        createdDate: payload['dateCreate'],
        message: payload['text'],
        senderId: payload['sender_id'],
        receiverId: payload['receiver_id']);
//
    setState(() {
      chatMessages.add(message);
    });
    scrollToBottom(timer: 200);
  }

  void sendMessageToServer() {
    socket.emit('msgToServer', {
      'receiver_id': chat.receiver!.id!,
      'sender_id': UserSingleton.instance.user.user?.id,
      'text': _textMessageController.text
    });
    print('success');
    _textMessageController.clear();
  }

  void scrollToBottom({int timer = 100}) {
    Timer(Duration(milliseconds: timer),
        () => _scrollController.jumpTo(index: chatMessages.length - 1));

    /*scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: timer),
        curve: Curves.fastOutSlowIn,
      ),*/
  }

  Widget buildMessages() => StickyGroupedListView<Message, DateTime>(
        padding: const EdgeInsets.only(top: 10),
        // shrinkWrap: true,
        itemScrollController: _scrollController,
        elements: chatMessages,
        order: StickyGroupedListOrder.DESC,
        groupBy: (Message element) {
          DateTime date = DateTime.parse(element.createdDate!);
          return DateTime(date.year, date.month, date.day);
        },
        groupComparator: (DateTime value1, DateTime value2) =>
            value2.compareTo(value1),
        itemComparator: (Message element1, Message element2) =>
            DateTime.parse(element2.createdDate!)
                .compareTo(DateTime.parse(element1.createdDate!)),
        floatingHeader: true,
        stickyHeaderBackgroundColor: Colors.transparent,
        groupSeparatorBuilder: (Message element) => Container(
          height: 50,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 38.w),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(child: Divider()),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${DateFormat('EEEE hh:mm a').format(DateTime.parse(element.createdDate!).toLocal())}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Expanded(child: Divider()),
                ]),
              ),
            ),
          ),
        ),
        itemBuilder: (_, Message message) {
          return  message.senderId == senderDetails.id
                  ? _myMessage(message)
                  : _guideMessage(message);
        },
      );
}
