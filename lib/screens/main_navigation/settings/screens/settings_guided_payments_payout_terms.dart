import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';

/// Guided Payment Payout Terms Screen
class GuidedPaymentPayoutTerms extends StatefulWidget {
  /// Constructor
  const GuidedPaymentPayoutTerms({Key? key}) : super(key: key);

  @override
  _GuidedPaymentPayoutTermsState createState() =>
      _GuidedPaymentPayoutTermsState();
}

class _GuidedPaymentPayoutTermsState extends State<GuidedPaymentPayoutTerms> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset(
                        '${AssetsPath.assetsPNGPath}/chevron_back_button.png',
                      ),
                      iconSize: 44.h,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: Text(
                        AppTextConstants.guidedPaymentPayoutTerms,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: Text(
                  AppTextConstants.longLoremIpsum,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    height: 2,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Center(
                child: SizedBox(
                  width: 315.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(20)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.r),
                                    side:
                                        BorderSide(color: AppColors.silver)))),
                    child: Text(
                      AppTextConstants.edit,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.spruce),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: SizedBox(
                  width: 315.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(20)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(AppColors.spruce),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r),
                        ))),
                    child: Text(
                      AppTextConstants.save,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
