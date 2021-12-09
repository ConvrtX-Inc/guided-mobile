import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';

/// Screen for settings contact us
class SettingsContactUs extends StatefulWidget {
  /// Constructor
  const SettingsContactUs({Key? key}) : super(key: key);

  @override
  _SettingsContactUsState createState() => _SettingsContactUsState();
}

class _SettingsContactUsState extends State<SettingsContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/svg/arrow_back_with_tail.svg',
                height: 29.h,
                width: 34.w
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 5.h
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppTextConstants.contactUS,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.h, 0, 15.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          AppTextConstants.contactUsMessage,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.grey)),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.nobel,
                            fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        filled: true,
                        hintText: 'Name',
                        contentPadding: const EdgeInsets.all(25),
                        fillColor: Colors.white70),
                  ),
                  SizedBox(height: 25.h),
                  TextField(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.nobel,
                            fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        filled: true,
                        hintText: 'Email',
                        contentPadding: const EdgeInsets.all(25),
                        fillColor: Colors.white70),
                  ),
                  SizedBox(height: 25.h),
                  TextField(
                    minLines:
                        6, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        hintText: AppTextConstants.messages),
                  ),
                  SizedBox(
                    width: double.maxFinite, // set width to maxFinite
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 25.h, 0, 25.h),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.spruce),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ))),
                        child: Text(
                          AppTextConstants.send,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
