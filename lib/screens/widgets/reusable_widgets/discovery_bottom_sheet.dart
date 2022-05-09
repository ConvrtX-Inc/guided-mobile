import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';

///Discovery Bottom Sheet
class DiscoveryBottomSheet extends StatelessWidget {
  ///Constructor
  const DiscoveryBottomSheet(
      {required this.backgroundImage,
      required this.onBackBtnPressed,
      required this.onSubscribeBtnPressed,
      required this.onSkipBtnPressed,
      required this.onCloseBtnPressed,
      Key? key})
      : super(key: key);

  ///Background of bottom sheet
  final String backgroundImage;

  ///Callback for Subscribe button pressed
  final VoidCallback onSubscribeBtnPressed;

  ///Callback for Skip button pressed
  final VoidCallback onSkipBtnPressed;

  ///Callback for Close button pressed
  final VoidCallback onCloseBtnPressed;

  ///Callback for back button pressed
  final VoidCallback onBackBtnPressed;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Material(
        child: SizedBox(
            height: height * 0.7,
            width: width,
            child: Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(backgroundImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: height * 0.3,
                      width: width,
                    ),
                    Container(
                      height: height * 0.7,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r),
                        ),
                        // color: HexColor('#066028'),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            HexColor('#066028'),
                            HexColor('#066028').withOpacity(0.2),
                          ],
                          stops: [0.6, 1],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 50,
                            backgroundImage:
                                AssetImage(AssetsPath.discoveryTree),
                          ),
                          Text(
                            AppTextConstants.discovery,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Know more about \n this event ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            AppTextConstants.upgradeToPremiumAndDiscoverMore,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          RichText(
                            text: TextSpan(
                              text: '\$5.99',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' / year',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            // width: width * 0.4,
                            child: ElevatedButton(
                              onPressed: onSubscribeBtnPressed,
                              style: AppTextStyle.active,
                              child: const Text(
                                'Subscribe',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: onSkipBtnPressed,
                            child: Text(
                              'Skip',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 30,
                      right: 30,
                      child: GestureDetector(
                          onTap: onCloseBtnPressed,
                          child: Image.asset(
                            AssetsPath.discoveryClose,
                            height: 30.h,
                            width: 30.w,
                          )),
                    ),
                    Positioned(
                      top: 30,
                      left: 30,
                      child: GestureDetector(
                        onTap: onBackBtnPressed,
                        child: const Icon(
                          Icons.chevron_left,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}
