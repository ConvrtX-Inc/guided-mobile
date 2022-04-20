import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/main_navigation/settings/screens/settings_main.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/become_a_guide_activites_model.dart';

/// Screen for settings contact us
class SettingsBecomeAGuide extends StatefulWidget {
  /// Constructor
  const SettingsBecomeAGuide({Key? key}) : super(key: key);

  @override
  _SettingsBecomeAGuide createState() => _SettingsBecomeAGuide();
}

class _SettingsBecomeAGuide extends State<SettingsBecomeAGuide> {
  final storage = new FlutterSecureStorage();
  String dropdownValue = 'Indeed';
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
  }

  static List<ActivityModel> activities = [
    ActivityModel(
      name: 'Camping',
      imageUrl: 'assets/images/badge-Camping.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Hiking',
      imageUrl: 'assets/images/badge-Hiking.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Hunt',
      imageUrl: 'assets/images/badge-Hunt.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Fishing',
      imageUrl: 'assets/images/badge-Fishing.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Eco Tour',
      imageUrl: 'assets/images/badge-Eco.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Paddle Spot',
      imageUrl: 'assets/images/badge-PaddleSpot.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Discovery',
      imageUrl: 'assets/images/badge-Discovery.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Retreat',
      imageUrl: 'assets/images/badge-Retreat.png',
      isChecked: false
    ),
    ActivityModel(
      name: 'Motor',
      imageUrl: 'assets/images/badge-Motor.png',
      isChecked: false
    ),
  ];

  // List of items in our dropdown menu
  var items = [    
    'Facebook',
    'LinkedIn',
    'Google',
    'Ads',
    'Youtube',
    'Indeed',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/svg/arrow_back_with_tail.svg',
                height: 29.h, width: 34.w),
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppTextConstants.becomeAGuide,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  subTitleWidget(AppTextConstants.basicInfo),
                  textInputWidget('fname', 'First name'),
                  textInputWidget('lname', 'Last name'),
                  textInputWidget('email', 'Email'),
                  textInputWidget('number', 'Number'),
                  textInputWidget('province', 'Province'),
                  textInputWidget('city', 'City'),
                  subTitleWidget('Activities'),
                  Container(
                    child: ListView.builder(
                      itemCount: activities.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext ctx, int index) {
                          if (index == 7) {
                            return Column(
                              children: <Widget> [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                      width: double.maxFinite,
                                      child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 7.h, 0, 7.h),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Color(0xffCCFFD5),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(15.h),
                                          child: Text(
                                            'Discovery Badge will let you host unique activities, tours, or adventures. The possibilities are endless!',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Color(0xff066028),
                                                height: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.fromLTRB(13.h, 16.h, 16.h, 16.h)),
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                            AppColors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        )),
                                        side: MaterialStateProperty.all(BorderSide(color: activities[index].isChecked == true ? AppColors.deepGreen : AppColors.grey, width: activities[index].isChecked == true ? 1.0 : 0.4.w, style: BorderStyle.solid))
                                  ),
                                    child: Row(
                                      children: <Widget> [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Visibility(
                                              visible: true,
                                              child: Image.asset(activities[index].imageUrl,
                                                      height: 55.h,
                                                      width: 55.w,
                                                  ),
                                              ),
                                          ),
                                          SizedBox(width: 25.w),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(activities[index].name,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black
                                              ),
                                              textAlign: TextAlign.left
                                              ),
                                          ),
                                          Spacer(),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child: Visibility(
                                                      visible: activities[index].isChecked == true ? true : false,
                                                      child: SvgPicture.asset('assets/images/svg/check_green_circle.svg',
                                                          height: 60.h, width: 60.w),
                                                  ),
                                              ),
                                          ),
                                      ],
                                    ),
                                    onPressed: (){
                                        setState(() {
                                          activities[index].isChecked = !activities[index].isChecked;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
                            child: OutlinedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.fromLTRB(13.h, 16.h, 16.h, 16.h)),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      AppColors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                                  side: MaterialStateProperty.all(BorderSide(color: activities[index].isChecked == true ? AppColors.deepGreen : AppColors.grey, width: activities[index].isChecked == true ? 1.0 : 0.4.w, style: BorderStyle.solid))
                            ),
                              child: Row(
                                children: <Widget> [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Visibility(
                                        visible: true,
                                        child: Image.asset(activities[index].imageUrl,
                                                height: 55.h,
                                                width: 55.w,
                                            ),
                                        ),
                                    ),
                                    SizedBox(width: 25.w),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(activities[index].name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black
                                        ),
                                        textAlign: TextAlign.left
                                        ),
                                    ),
                                    Spacer(),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Visibility(
                                                visible: activities[index].isChecked == true ? true : false,
                                                child: SvgPicture.asset('assets/images/svg/check_green_circle.svg',
                                                    height: 60.h, width: 60.w),
                                            ),
                                        ),
                                    ),
                                ],
                              ),
                              onPressed: (){
                                setState(() {
                                  activities[index].isChecked = !activities[index].isChecked;
                                });
                              },
                            ),
                          );
                      }),
                  ),
                  subTitleWidget('Tell us a bit about yourself'),
                  descriptionWidget('Why do you think you will be a good Guide ?'),
                  textInputWidget('normal', ''),
                  descriptionWidget('Briefly describe the Adventures you want to host.'),
                  textInputWidget('message', ''),
                  descriptionWidget('What locations will you be running your Adventures?'),
                  textInputWidget('normal', ''),
                  descriptionWidget('What will make your Adventures stand-out?'),
                  textInputWidget('normal', ''),
                  descriptionWidget('Why do you want to work with Guided?'),
                  textInputWidget('message', ''),
                  descriptionWidget('How did you hear about us?'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 7.h, 0, 7.h),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.4.w,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(25.h, 10.h, 10.h, 10.h),
                            child: DropdownButton(
                              underline: SizedBox(),
                              isExpanded: true,
                              value: dropdownValue,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff000000),
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),  
                              items: items.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                              }).toList(),
                              onChanged: (String? newValue) { 
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  descriptionWidget("If you selected 'Individual' or 'Other' please let us know who referred you:"),
                  textInputWidget('normal', ''),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
                        child: Row(
                          children: <Widget> [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                value: _isActive,
                                activeColor: Color(0xff4CD964),
                                onChanged: (bool value) {
                                  setState(() {
                                    _isActive = value;
                                  });
                                  print('_isActive $_isActive');
                                }
                              ),
                            ),
                            SizedBox(width: 25.w),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('First Aid',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff979B9B)
                                ),
                                textAlign: TextAlign.left
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  textInputWidget('normal', 'Certifcate Name'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget> [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset('assets/images/uploadPhoto.png',
                                height: 100.h,
                                width: 100.w,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('assets/images/uploadPhoto.png',
                                height: 100.h,
                                width: 100.w,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset('assets/images/uploadPhoto.png',
                                height: 100.h,
                                width: 100.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 15.h, 0, 0),
                            child: Text(
                                "Minimum 3 images should be uploaded",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xffADB1B1),
                                ),
                            ),
                        ),
                    ),
                  ),
                  descriptionWidget('Description'),
                  textInputWidget('message', ''),
                  SizedBox(
                    width: double.maxFinite, // set width to maxFinite
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 60.h, 0, 25.h),
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
                        child: Text('Apply',
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

Widget descriptionWidget(desc) {
  return Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 30.h, 0, 20.h),
            child: Text(desc,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xffADB1B1),
                ),
            ),
        ),
    ),
  );
}


Widget subTitleWidget(subTitle) {
  return Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 25.h, 0, 0),
            child: Text(subTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                ),
            ),
        ),
    ),
  );
}

Widget textInputWidget(type, placeholder) {
  if (type == 'message') {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: TextField(
              // controller: _message,
              // focusNode: _messageFocus,
              minLines:
                  6, // any number you need (It works as the rows for the textarea)
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.4.w),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.4.w),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  hintText: placeholder),
            )
          ),
      ),
    );
  }
  return Align(
    alignment: Alignment.centerLeft,
      child: SizedBox(
      // width: double.maxFinite, // set width to maxFinite
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
        child: TextField(
            // controller: _emailController,
            // focusNode: _emailFocus,
            decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide:
                    BorderSide(color: Colors.grey, width: 0.4.w),
            ),
          ),
        ),
      ),
    ),
  );
}