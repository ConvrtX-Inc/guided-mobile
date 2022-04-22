import 'package:flutter/material.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/asset_path.dart';

/// GoToPaymentMethod screen
class GoToPaymentMethod extends StatefulWidget {
  ///Constructor
  const GoToPaymentMethod({Key? key}) : super(key: key);

  @override
  State<GoToPaymentMethod> createState() => _GoToPaymentMethodState();
}

class _GoToPaymentMethodState extends State<GoToPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#979B9B'),
      body: Center(
        child: Container(
          height: 175.h,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          child: Stack(children: <Widget>[
            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 22.h,
                  width: 22.w,
                  decoration: BoxDecoration(
                      color: HexColor('#F3F3F3'), shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      AssetsPath.close1,
                      height: 9.h,
                      width: 9.w,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Image.asset(
                  AssetsPath.warning,
                  height: 38.h,
                  width: 38.w,
                ),
              ),
            ),
            Align(
              child: Text(
                'Do the payment before purchase \n your package',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HexColor('#FF4848'),
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: HexColor('#007749'),
                    side: BorderSide(color: HexColor('#007749'), width: 1),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  onPressed: () {
                    Navigator.pop(context, 'openPaymentMethod');

                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Text(
                      'Go to payment Method',
                      style: TextStyle(
                          color: HexColor('#007749'),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
