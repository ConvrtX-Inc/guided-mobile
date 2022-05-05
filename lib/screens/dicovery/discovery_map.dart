import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:pay/pay.dart';

///Discovery Screen
class DiscoveryMapScreen extends StatefulWidget {
  ///constructor
  const DiscoveryMapScreen({Key? key}) : super(key: key);

  @override
  State<DiscoveryMapScreen> createState() => _DiscoveryMapScreenState();
}

class _DiscoveryMapScreenState extends State<DiscoveryMapScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    const _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '5.99',
        status: PaymentItemStatus.final_price,
      )
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: Transform.scale(
      //     scale: 0.8,
      //     child: Padding(
      //       padding: const EdgeInsets.all(8),
      //       child: Container(
      //         width: 40.w,
      //         height: 40.h,
      //         padding: EdgeInsets.zero,
      //         decoration: BoxDecoration(
      //           color: AppColors.harp,
      //           borderRadius: BorderRadius.circular(10.r),
      //         ),
      //         child: IconButton(
      //           icon: const Icon(
      //             Icons.arrow_back_sharp,
      //             color: Colors.black,
      //             size: 25,
      //           ),
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.7,
              width: width,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r),
                      ),
                      image: DecorationImage(
                        image: AssetImage(AssetsPath.discoveryMapImage),
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
                          backgroundImage: AssetImage(AssetsPath.discoveryTree),
                        ),
                        Text(
                          AppTextConstants.discovery,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Colors.white),
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
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'You can discover ongoing \n events/happenings initiative by \n Discovery',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                              color: Colors.white),
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
                                color: Colors.white),
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
                          width: width * 0.4,
                          child: ElevatedButton(
                            onPressed: () async {
                              Pay _payClient = Pay.withAssets(
                                  ['default_payment_profile_apple_pay.json']);
                              final result =
                                  await _payClient.showPaymentSelector(
                                provider: PayProvider.apple_pay,
                                paymentItems: _paymentItems,
                              );
                              print(result);
                              // ApplePayButton(
                              //   paymentConfigurationAsset:
                              //       'default_payment_profile_apple_pay.json',
                              //   paymentItems: _paymentItems,
                              //   style: ApplePayButtonStyle.black,
                              //   type: ApplePayButtonType.buy,
                              //   margin: const EdgeInsets.only(top: 15.0),
                              //   onPaymentResult: onApplePayResult,
                              //   loadingIndicator: const Center(
                              //     child: CircularProgressIndicator(),
                              //   ),
                              // );
                            },
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
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: height * 0.05,
                    left: width * 0.45,
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed('/activities');
                      },
                      child: Text(
                        'Skip',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 30,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
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
                      onTap: () {},
                      child: const Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       Text(
          //         AppTextConstants.discovery,
          //         style: const TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 25,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      )),
    );
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }
}
