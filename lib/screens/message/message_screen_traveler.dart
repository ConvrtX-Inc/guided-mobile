import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/chat_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


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

  String receiverId = '1be3bb15-8931-4135-aaa2-f5f242b190bb';

  ChatModel chat = ChatModel();

  final UserProfileDetailsController _profileDetailsController =
  Get.put(UserProfileDetailsController());

  ProfileDetailsModel senderDetails = ProfileDetailsModel();

  final ScrollController _scrollController = ScrollController();

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
              if (_scrollController.hasClients) {
                scrollToBottom();
              }
            }
          });
    });
  }

  void connectToServer() {
    debugPrint(
        'Socekt url : ${AppAPIPath.webSocketUrl} ${receiverId} ${UserSingleton.instance.user.user?.id}');
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
    return   Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                chat.receiver!.fullName!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: chatMessages.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  final Message message = chatMessages[index];

                  return message.senderId == senderDetails.id
                      ? _repliedMessage(message)
                      : _senderMessage(message);

                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 108.h,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.platinum),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 25.w, top: 25.h, bottom: 20.h, right: 20.w),
                        child: TextField(
                          maxLines: null,
                          controller: _textMessageController,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(
                                fontSize: 12.sp, color: AppColors.novel),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15.h,
                    right: 15.w,
                    child: TextButton(
                      //! send message to socket iox
                      onPressed: sendMessageToServer,
                      child: Container(
                        width: 79.w,
                        height: 41.h,
                        decoration: BoxDecoration(
                          color: AppColors.deepGreen,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Send',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _repliedMessage(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 205.w,
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: AppColors.novel,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
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
          _messageSeenIndentified(),
        ],
      ),
    );
  }

  Widget _senderMessage(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildProfilePicture(chat.receiver!.avatar!),
          SizedBox(
            width: 15.w,
          ),
          Container(
            width: 205.w,
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: AppColors.porcelain,
              border: Border.all(
                color: Colors.transparent,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
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
        ],
      ),
    );
  }

  Widget _messageSeenIndentified() {
    final overlap = 5.w;
    final List<Widget> items = <Widget>[
      Icon(
        Icons.check,
        color: AppColors.deepGreen,
        size: 15.h,
      ),
      Icon(
        Icons.check,
        color: AppColors.deepGreen,
        size: 15.h,
      ),
    ];

    final List<Widget> stackLayers =
    List<Widget>.generate(items.length, (int index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: items[index],
      );
    });

    return Stack(children: stackLayers);
  }

  Widget buildProfilePicture(String image) => Container(
    height: 49.h,
    width: 49.w,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 3),
      shape: BoxShape.circle,
      image: image.isEmpty
          ? DecorationImage(
        image: AssetImage(AssetsPath.defaultProfilePic),
        fit: BoxFit.contain,
      )
          : DecorationImage(
        image: NetworkImage(image),
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
    Timer(
      Duration(milliseconds: timer),
          () => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: timer),
        curve: Curves.fastOutSlowIn,
      ),
    );
  }
}
