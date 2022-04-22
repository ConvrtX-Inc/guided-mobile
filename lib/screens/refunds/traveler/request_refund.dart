import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_transaction_model.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

///Request refund screen traveler
class RequestRefund extends StatefulWidget {
  ///Constructor
  const RequestRefund(
      {this.transactionDetails,
      this.paymentDetails,
      this.paymentMode,
      this.activityPackageDetails,
      Key? key})
      : super(key: key);

  final UserTransaction? transactionDetails;

  final dynamic paymentDetails;

  final String? paymentMode;

  final ActivityPackage? activityPackageDetails;

  @override
  _RequestRefundState createState() => _RequestRefundState();
}

class _RequestRefundState extends State<RequestRefund> {
  bool rescheduleBooking = false;
  final User? user = UserSingleton.instance.user.user;

  @override
  void initState() {
    super.initState();
  }

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
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.deepGreen),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  onPressed: _showRescheduleBottomSheet,
                  child: Text(AppTextConstants.reschedule,
                      style: TextStyle(color: AppColors.deepGreen))))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: buildRefundUI()),
    );
  }

  Widget buildRefundUI() => Container(
      padding: EdgeInsets.all(22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppTextConstants.transactionDetails,
            style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12.h),
          buildRefundDetails(),
          SizedBox(height: 34.h),
          CustomRoundedButton(title: AppTextConstants.ok, onpressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/traveller_tab', (Route<dynamic> route) => false);
          }),
          SizedBox(height: 24.h),
          Center(
            child: TextButton(
                onPressed: _showRefundDialog,
                child: Text(
                  AppTextConstants.cancelAndRefund,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                )),
          )
        ],
      ));

  Widget buildRefundDetails({bool isReschedule = false}) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: AppColors.mercury)),
        child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          ListTile(
            leading: CircleAvatar(
              child: ClipOval(
                  child: Image.asset(
                      '${AssetsPath.assetsPNGPath}/student_profile.png')),
            ),
            title: Text('${user?.fullName}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
            subtitle: Text(
                'Transaction Number: ${widget.transactionDetails?.transactionNumber}',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp)),
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
                          fontWeight: FontWeight.w700, fontSize: 16.sp)),
                  SizedBox(height: 20.h),
                  if (!isReschedule)
                    buildPackageDetail(AppTextConstants.headerNumberOfPeople,
                        '${widget.transactionDetails?.numberOfPeople} people')
                  else
                    buildPackageDetailInput(
                        AppTextConstants.headerNumberOfPeople, '0', '', false),
                  if (!isReschedule && widget.transactionDetails?.bookDate != null)
                    buildPackageDetail(
                        AppTextConstants.bookingDate,
                        DateFormat('yyyy.MM.dd').format(DateTime.parse(
                            widget.transactionDetails!.bookDate)))
                  else
                    buildPackageDetailInput(
                        AppTextConstants.bookingDate, '0', '', true),
                  buildPackageDetail(AppTextConstants.price,
                      'CAD ${widget.transactionDetails?.total}'),
                  SizedBox(height: 14.h),
                  Divider(
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 14.h),
                  buildPackageDetail(AppTextConstants.location,
                      widget.activityPackageDetails?.address),
                  if(widget.transactionDetails?.createdDate !=null)
                    buildPackageDetail(
                        AppTextConstants.dateOfTransaction,
                        DateFormat('yyyy.MM.dd').format(DateTime.parse(
                            widget.transactionDetails!.createdDate))),
                  buildPackageDetail(AppTextConstants.travelerLimitAndSchedule,
                      widget.activityPackageDetails?.maxTraveller),
                  buildPackageDetail(
                      AppTextConstants.paymentMethod, widget.paymentMode),
                  if (widget.paymentDetails is CardModel)
                    buildPackageDetail(
                        AppTextConstants.creditCardNumber,
                        GlobalMixin().getFormattedCardNumber(
                            cardNumber: widget.paymentDetails!.cardNo,
                            startingNumber: 0))
                ],
              ))
        ])));
  }

  Widget buildPackageDetail(String label, dynamic data) => Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey)),
          const Spacer(),
          SizedBox(
              width: 100.w,
              child: Text('$data',
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.right,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600))),
        ],
      ));

  Widget buildPackageDetailInput(
          String label, dynamic data, String hint, isDate) =>
      Container(
          margin: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Text(label,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey))),
              // const Spacer(),
              Container(
                  color: Colors.white,
                  height: 30,
                  width: 80,
                  child: TextField(
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(8.w),
                          fillColor: Colors.white,
                          hintText: hint,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.deepGreen, width: 0.0),
                          )))),
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
                    // Text(
                    //   AppTextConstants.refundAndCancellationOfPayment,
                    //   style: TextStyle(
                    //       fontSize: 20.sp,
                    //       fontFamily: 'Gilroy',
                    //       fontWeight: FontWeight.w700),
                    // ),
                    Center(
                      child: Image.asset(
                        '${AssetsPath.assetsPNGPath}/checkmark_red.png',
                        height: 60,
                        width: 60,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Center(
                        child: Text(
                      AppTextConstants.requestForCancelAndRefund,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Gilroy',
                          color: Colors.red,
                          fontWeight: FontWeight.w600),
                    )),
                    SizedBox(height: 15.h),
                    Center(
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                AppTextConstants.travelerReleaseAndWaiverForm,
                                style: TextStyle(
                                    color: AppColors.deepGreen,
                                    decoration: TextDecoration.underline,
                                    fontSize: 12.sp),
                              )),
                          SizedBox(height: 10.h),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                AppTextConstants.cancellationPolicy,
                                style: TextStyle(
                                    color: AppColors.deepGreen,
                                    decoration: TextDecoration.underline,
                                    fontSize: 12.sp),
                              )),
                          SizedBox(height: 10.h),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                AppTextConstants.guidedPaymentPayoutTerms,
                                style: TextStyle(
                                    color: AppColors.deepGreen,
                                    decoration: TextDecoration.underline,
                                    fontSize: 12.sp),
                              )),

                          /* SizedBox(height: 25.h),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.deepGreen),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                              onPressed: null,
                              child: Text(AppTextConstants.ok,
                                  style: TextStyle(color: AppColors.deepGreen)))*/
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                Center(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.deepGreen),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          fixedSize: Size(130, 50),
                        ),
                        onPressed: (){

                        },
                        child: Text(AppTextConstants.ok,
                            style: TextStyle(color: AppColors.deepGreen)))),
                SizedBox(
                  height: 10.h,
                )
              ],
            );
          });
        });
  }

  _showRescheduleBottomSheet() {
    showCupertinoModalBottomSheet(
        context: context,
        isDismissible: true,
        expand: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext ctx) => Material(
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(10.w),
                    child: Container(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                GestureDetector(
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
                                Spacer(),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: AppColors.grey),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(AppTextConstants.cancel,
                                        style:
                                            TextStyle(color: AppColors.grey)))
                              ],
                            ),
                            Text(
                              AppTextConstants.transactionDetails,
                              style: TextStyle(
                                  fontSize: 30.sp, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 12.h),
                            buildRefundDetails(isReschedule: true),
                            SizedBox(height: 34.h),
                            CustomRoundedButton(
                                title: AppTextConstants.reschedule,
                                onpressed: () {}),
                            SizedBox(height: 24.h),
                          ],
                        ))))));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<bool>('rescheduleBooking', rescheduleBooking));
  }
}
