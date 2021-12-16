import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/asset_path.dart';

/// Profile Screen
class ProfileScreen extends StatefulWidget {

  /// Constructor
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: Colors.grey.withOpacity(0.2)),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          elevation: 0.2,
          backgroundColor: Colors.white,
        ),
        body: getBody(context),
        backgroundColor: Colors.white,
        //resizeToAvoidBottomPadding: false,
      );
  }
}

/// Body of profile screen
Widget getBody(BuildContext context) {
  return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Profile',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 14.h,
          ),
          getProfile(context),
          SizedBox(
            height: 9.h,
          ),
          Text(
            'About Me',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 9.h,
          ),
          Text(
            'above the Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. ',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14.sp),
          ),
          getAboutMe(context),
          getProfileSetting(context)
        ],
          ),
        ),
      ));
}

/// profile image
Widget getProfile(BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        Container(
          width: 101.w,
          height: 101.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: const <BoxShadow>[
              BoxShadow(blurRadius: 3, color: Colors.grey)
            ],
          ),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35,
              backgroundImage: const NetworkImage(
                  'https://www.vhv.rs/dpng/d/164-1645859_selfie-clipart-groucho-glass-good-profile-hd-png.png'),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                    width: 33.3.w,
                    height: 33.3.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.grey,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(55)),
                    child: Icon(
                      Icons.edit,
                      size: 15.sp,
                      color: Colors.black,
                    )),
              )),
        ),
        SizedBox(
          height: 13.h,
        ),
        Text(
          'Edit',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          'Ethan Hunt',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

/// widget for about me
Widget getAboutMe(BuildContext context) {
  return GridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 20,
    shrinkWrap: true,
    children: <Widget>[
      Container(
        margin: const EdgeInsets.fromLTRB(0,23,0,23),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(AssetsPath.image2),
                fit: BoxFit.cover)    
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(0,23,0,23),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage(AssetsPath.image1),
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                fit: BoxFit.cover)),
        child: Center(
          child: Text(
            '4+', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24.sp
            ),
          ),
        ),
      )
    ],
  );
}

/// widget for profile settings
Widget getProfileSetting(BuildContext context) {
  return Column(children: <Widget>[
    ListTile(
        leading: Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.lock_outline)),
        title: Text(
          'Change Password',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 17.sp)),
    ListTile(
        leading: Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.tablet_android_outlined)),
        title: Text(
          'Change Mobile Number',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 17.sp)),
    ListTile(
        leading: Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            child: Image.asset(AssetsPath.certificateIcon)),
        title: Text(
          'Certificates',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 17.sp)),
    ListTile(
        leading: Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.lock_outline)),
        title: Text(
          'About Me',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 17.sp)),
  ]);
}