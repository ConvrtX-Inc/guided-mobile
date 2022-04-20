import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

///Refund Screen
class RefundScreen extends StatefulWidget {
  ///Constructor
  const RefundScreen({Key? key}) : super(key: key);

  @override
  _RefundScreenState createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {},
          child: IconButton(
            icon: Image.asset(
              '${AssetsPath.assetsPNGPath}/chevron_back_button.png',
            ),
            iconSize: 44.h,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: buildRefundUI()),
    );
  }

  Widget buildRefundUI() => Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppTextConstants.notif,
            style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey),
          buildRefundDetails(),
          SizedBox(height: 34.h),
          CustomRoundedButton(
              title: AppTextConstants.approve, onpressed: _showRefundDialog)
        ],
      ));

  Widget buildRefundDetails() {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: AppColors.mercury)),
        child: Container(
            margin: EdgeInsets.all(8.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: ClipOval(
                          child: Image.asset(
                              '${AssetsPath.assetsPNGPath}/student_profile.png')),
                    ),
                    title: Text('Ethan Hunt',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.sp)),
                    trailing: Text('16 sc',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.grey)),
                  ),
                  SizedBox(height: 25.h),
                  Container(
                    margin: EdgeInsets.only(left: 25.w),
                    child: Text('Transaction Number: 122900083HN',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp)),
                  ),
                  Container(
                      // color: AppColors.islandSpice,
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          color: AppColors.islandSpice,
                          border: Border(
                            top: BorderSide(color: AppColors.grey),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Package Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp)),
                          SizedBox(height: 20.h),
                          buildPackageDetail(
                              AppTextConstants.headerNumberOfPeople,
                              '5 people'),
                          buildPackageDetail(
                              AppTextConstants.bookingDate, '23. 07. 2021'),
                          buildPackageDetail(AppTextConstants.price, 'CAD 100'),
                          SizedBox(height: 14.h),
                          Divider(
                            color: AppColors.grey,
                          ),
                          SizedBox(height: 14.h),
                          buildPackageDetail(AppTextConstants.location,
                              'Country, Street \n State, City \n Zip code'),
                          buildPackageDetail(AppTextConstants.dateOfTransaction,
                              '23. 07. 2021'),
                          buildPackageDetail(
                              AppTextConstants.travelerLimitAndSchedule, 5),
                          buildPackageDetail(
                              AppTextConstants.paymentMethod, 'Bank Card'),
                          buildPackageDetail(AppTextConstants.creditCardNumber,
                              'XXXX XXXX XXX 1289')
                        ],
                      ))
                ])));
  }

  Widget buildPackageDetail(String label, dynamic data) => Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: <Widget>[
          Text(label,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey)),
          const Spacer(),
          Text('$data',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
        ],
      ));

  _showRefundDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.r))),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Image.asset(
                              '${AssetsPath.assetsPNGPath}/close_btn.png'),
                        )),
                    SizedBox(height: 16.h),
                    Text(
                      AppTextConstants.refundAndCancellationOfPayment,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 25.h),
                    Center(
                      child: Image.asset(
                          '${AssetsPath.assetsPNGPath}/refund_icon.png'),
                    ),
                    SizedBox(height: 25.h),
                    Center(
                        child: Text(
                      AppTextConstants.refundBookingQuestion,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700),
                    )),
                    SizedBox(height: 25.h),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.r))),
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(AppTextConstants.refundableAmount,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(height: 10.h),
                          Text('50.00 CAD',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 20.h),
                          Text(AppTextConstants.transactionNumber,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(height: 10.h),
                          Text('122900083HN',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                CustomRoundedButton(
                    title: AppTextConstants.continueText,
                    onpressed: _showConfirmRefundBottomSheet),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          });
        });
  }

  _showConfirmRefundBottomSheet() {
    showCupertinoModalBottomSheet(
        context: context,
        isDismissible: true,
        expand: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext ctx) => Material(
                child: SingleChildScrollView (child: Container(
                  padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {},
                      child: IconButton(
                        icon: Image.asset(
                          '${AssetsPath.assetsPNGPath}/chevron_back_button.png',
                        ),
                        iconSize: 44.h,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                      child:
                          Text(AppTextConstants.refundAndCancelTravelerPayment,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ))),
                  SizedBox(height: 10.h),
                  Center(
                      child: Text(AppTextConstants.refundInstruction,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey))),
                  SizedBox(height: 34.h),
                   Container(
                    margin: EdgeInsets.all(20.w),
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      border:Border.all(color: Colors.grey)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 24.h),
                        Text(
                          '${AppTextConstants.packagePrice} : \$100',
                        ),
                        SizedBox(height: 20.h),
                        Text(AppTextConstants.refundableAmount,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600)),
                        SizedBox(height: 24.h),
                        RichText(
                            text: TextSpan(
                          text: '50',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60.sp,
                            color: Colors.black
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '.00 CAD',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.sp,
                                color:Colors.black,fontFamily: 'Gilroy'
                                  ),
                            ),
                          ],
                        )),
                        SizedBox(height: 10.h),
                        Text('(10 % service charge)',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22.sp,
                            color:Colors.black,fontFamily: 'Gilroy'
                        )),
                        SizedBox(height: 30.h),
                        Divider(color:Colors.grey),
                        SizedBox(height: 30.h),

                        Text(AppTextConstants.company,style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        )),
                        SizedBox(height: 10.h),
                        Text('Company XYZ',style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        )),

                        SizedBox(height: 20.h),

                        Text(AppTextConstants.transactionNumber,style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),),
                        SizedBox(height: 10.h),
                        Text('122900083HN',style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        )),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                 Container(
                     padding: EdgeInsets.all(10.w),
                     child:  CustomRoundedButton(title: AppTextConstants.confirm, onpressed: (){}))
                ],
              ),
            ))));
  }
}
