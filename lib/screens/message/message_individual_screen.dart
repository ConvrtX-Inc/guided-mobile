// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/chat_model.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/image_viewers/image_viewer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


/// Notification Screen
class MessageIndividual extends StatefulWidget {
  /// Constructor
  const MessageIndividual({Key? key, this.message}) : super(key: key);

  final ChatModel? message;

  @override
  _MessageIndividualState createState() => _MessageIndividualState();
}

class _MessageIndividualState extends State<MessageIndividual> {
  late IO.Socket socket;
  String message = 'test';
  final TextEditingController _textMessageController = TextEditingController();

  ChatModel chat = ChatModel();

  List<Message> chatMessages = [];

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
                    icon: SvgPicture.asset(
                        'assets/images/svg/arrow_back_with_tail.svg',
                        height: 40.h,
                        width: 40.w),
                    onPressed: () {
                      Navigator.pop(context, 'getMessages');
                    },
                  ),
                  /*   IconButton(
                    icon: Image.asset(
                        '${AssetsPath.assetsPNGPath}/phone_green.png',
                        height: 20.h,
                        width: 20.w),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),*/
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
            /* Container(
              height: 57.h,
              color: AppColors.tealGreen.withOpacity(0.15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Create a custom offer?',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.deepGreen),
                  ),
                  Container(
                    width: 122.w,
                    height: 37.h,
                    decoration: BoxDecoration(
                      color: AppColors.deepGreen,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed('/message_custom_offer'),
                        child: const Text(
                          'Create offer',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),*/
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
            if(!chat.isBlocked!)
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

  Widget _offerMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: AppColors.tealGreen.withOpacity(0.15),
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Text(
                  'Sent offer details',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.deepGreen),
                ),
              ),
              Divider(
                height: 2.h,
                color: AppColors.tealGreen.withOpacity(0.8),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Selected package',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: AppColors.deepGreen),
                        ),
                        Text(
                          'Premium',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: AppColors.deepGreen),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Number of People',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: AppColors.deepGreen),
                        ),
                        Text(
                          '5 People',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: AppColors.deepGreen),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Set date',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: AppColors.deepGreen),
                        ),
                        Text(
                          '23. 07. 2021',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: AppColors.deepGreen),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Price',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: AppColors.deepGreen),
                        ),
                        Text(
                          'CAD 200',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: AppColors.deepGreen),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
          child: Text(
            'Withdraw offer?',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppColors.coralPink),
          ),
        ),
      ],
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
          if(message.messageType!.toLowerCase() == 'text')  
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
          )
          else
            buildChatAttachment(message.message!)
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

  Widget buildChatAttachment(String image) => GestureDetector(
      onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ImageViewerScreen(imageUrl: image);
        }));
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            image,
            height: 150.h,
            fit: BoxFit.contain,
          )));
}
