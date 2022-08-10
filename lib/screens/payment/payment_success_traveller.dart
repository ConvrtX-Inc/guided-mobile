import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/booking_request.dart';
import 'package:guided/models/user_model.dart';

/// Modal Bottom sheet for successful payment
Future<dynamic> showPaymentSuccessFromTraveller(
    {required BuildContext context,

    required dynamic data,
    Function? onBtnPressed,
    String btnText = 'Ok'}) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height - 20,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 42.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.withOpacity(0.2)),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      )),
                  SizedBox(width: 20.w),
                ]),
                SizedBox(
                  height: 40.h,
                ),
                // Center(child: Image.asset(AssetsPath.roundedCheck)),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: buildProfilePicture(
                            data['traveler_profile_picture'])),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Text(
                         data['traveler_name'],
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                            '${AssetsPath.assetsPNGPath}/green_checkmark.png'),
                        SizedBox(width: 8.w),
                        Text(
                          AppTextConstants.paymentSuccessful,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                              padding: EdgeInsets.all(16.w),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColors.gallery,
                                border: Border.all(color: AppColors.mercury),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tour Details',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 4.h),
                                  buildDetail(AppTextConstants.tour,
                                      data['package_name']),
                                  buildDetail(
                                      AppTextConstants.transactionNumber,
                                       data['transaction_number']),
                                  buildDetail(AppTextConstants.service,
                                      'Tourist Service'),
                                  buildDetail('Traveller',
                                      data['traveler_name']),
                                  buildDetail(AppTextConstants.date,
                                      data['booking_date']),
                                  buildDetail(
                                      AppTextConstants.numberOfPeople,
                                       data['number_of_people']),
                                ],
                              ))),
                    ),
                  ],
                )),

                SizedBox(
                  height: 40.h,
                ),
                CustomRoundedButton(
                    title: btnText,
                    onpressed: () {


                      if (onBtnPressed != null) {
                        onBtnPressed();
                      }
                    }),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          );
        });
      });
}

Widget buildProfilePicture(String imageUrl) => Container(
      width: 85.w,
      height: 85.h,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const <BoxShadow>[
          BoxShadow(blurRadius: 3, color: Colors.grey)
        ],
      ),
      child: imageUrl != ''
          ? CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35,
              backgroundImage: NetworkImage(imageUrl))
          : CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35,
              backgroundImage: AssetImage(AssetsPath.defaultProfilePic),
            ),
    );

Widget buildDetail(String label, String value) => Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(color: AppColors.osloGrey, fontSize: 13.sp),
          ),
          Text(
            value,
            style: TextStyle(
                color: AppColors.doveGrey,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
