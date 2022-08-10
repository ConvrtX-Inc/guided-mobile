import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/user_model.dart';

/// Modal Bottom sheet for successful payment
Future<dynamic> showPaymentSuccess(
    {required BuildContext context,
    required Widget paymentDetails,
    required String paymentMethod,
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
          return ScreenUtilInit(
            builder: () => Container(
              height: 726.h,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 42.h),
              child: SingleChildScrollView(
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
                    Center(child: buildProfilePicture()),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Text(
                        UserSingleton.instance.user.user!.fullName!,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Center(
                      child: Text(
                        AppTextConstants.paymentSuccessful,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20.sp),
                      ),
                    ),

                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height / 1.5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(16),
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
                              paymentDetails,
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomRoundedButton(
                        title: btnText,
                        onpressed: () {
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });

                          if (onBtnPressed != null) {
                            onBtnPressed();
                          }
                        }),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ),
            designSize: const Size(375, 812),
          );
        });
      });
}

Widget buildProfilePicture() => Container(
        child: Stack(
      children: <Widget>[
        Container(
          width: 85.w,
          height: 85.h,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: const <BoxShadow>[
              BoxShadow(blurRadius: 3, color: Colors.grey)
            ],
          ),
          child: UserSingleton.instance.user.user!.firebaseProfilePicUrl != null
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  backgroundImage: NetworkImage(
                      UserSingleton.instance.user.user!.firebaseProfilePicUrl!))
              : CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  backgroundImage: AssetImage(AssetsPath.defaultProfilePic),
                ),
        ),
        Positioned(
            top: 8,
            right: 4,
            child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(

                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: Image.asset(
                  AssetsPath.greenCheck,
                  height: 25,
                  width: 25,
                )))
      ],
    ));
