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
import 'package:guided/utils/services/rest_api_service.dart';

import '../../../message/message_individual_screen.dart';

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15.h,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppTextConstants.inbox,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 0.h),
                child: SizedBox(
                  height: 50.h,
                  child: TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
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
              if (messages.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    itemCount: messages.length,
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
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MessageScreenTraveler(
                                            message: messages[index],
                                          )));
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
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                      image: messages[index].receiver !=null &&  messages[index].receiver!.avatar !=
                                              ''
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  messages[index]
                                                      .receiver!
                                                      .avatar!),
                                              fit: BoxFit.contain,
                                            )
                                          : DecorationImage(
                                              image: AssetImage(
                                                  AssetsPath.defaultProfilePic),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: messages[index]
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
                                        //! added this
                                        InkWell(
                                          onTap: () {
/*
                                      Navigator.push(
                                          context,

                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MessageIndividual(
                                                    message: messages[index],
                                                  ))

                                      );*/
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Text(
                                                  messages[index]
                                                      .messages![messages[index]
                                                              .messages!
                                                              .length -
                                                          1]
                                                      .message!,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: AppColors.dustyGrey,
                                                  ),
                                                ),
                                              ),
                                              if (index == 0)
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
                                                )
                                            ],
                                          ),
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
                  ),
                )
              else
                const Center(
                  child: Text("You don't have any messages yet"),
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

    if(res.isNotEmpty){
      setState(() {
        messages = res;
        isLoading = false;
      });
    }
    debugPrint('DATA ${res.length}');
  }
}
