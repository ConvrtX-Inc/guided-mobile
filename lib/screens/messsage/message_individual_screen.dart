import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';

/// Notification Screen
class MessageIndividual extends StatefulWidget {
  /// Constructor
  const MessageIndividual({Key? key}) : super(key: key);

  @override
  _MessageIndividualState createState() => _MessageIndividualState();
}

class _MessageIndividualState extends State<MessageIndividual> {
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
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                        '${AssetsPath.assetsPNGPath}/phone_green.png',
                        height: 20.h,
                        width: 20.w),
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
              child: const Text(
                'Ann Sasah',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
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
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5 + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index == 0 || index == 3
                      ? _senderMessage()
                      : index == 5
                          ? _offerMessage()
                          : _repliedMessage();
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
                      onPressed: null,
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

  Widget _repliedMessage() {
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
            child: const Text(
              'Sample tourist guide text message goes here ',
              style: TextStyle(
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

  Widget _senderMessage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 49.h,
            width: 49.w,
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
            child: const Text(
              'Sample tourist text message goes here to receive tourist guide Sample tourist text message goes here to receive tourist guide',
              style: TextStyle(
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
}
