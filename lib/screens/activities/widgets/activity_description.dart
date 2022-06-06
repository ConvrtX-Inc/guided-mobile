import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/activity_package.dart';
import 'package:guided/models/user_model.dart';
import 'package:intl/intl.dart';

class Activity {
  Widget buildDescription(
      {required ActivityPackage activityPackage,
      required User userGuideDetails,
      Marker? marker,
      int minDescriptionLength = 200,
      required bool showMoreDescription,
      Function? onReadMoreCallBack,
      required Completer<GoogleMapController> mapController,
      required Function? onMapCreated,
      required BuildContext context,
      required Function getMessageHistory,
      required List<ActivityPackage> otherPackages,
      required mapWidget}) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                    contentPadding: EdgeInsets.all(2.w),
                    leading: Container(
                        padding: EdgeInsets.all(2.w),
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
                        child: userGuideDetails.firebaseProfilePicUrl != ''
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    userGuideDetails.firebaseProfilePicUrl!),
                              )
                            : const CircleAvatar(
                                backgroundImage: AssetImage(
                                    '${AssetsPath.assetsPNGPath}/default_profile_pic.png'),
                              )),
                    title: Text(
                      userGuideDetails.fullName!,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.sp),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                            '${AssetsPath.assetsSVGPath}/star.svg'),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text('0 review',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ))
                      ],
                    )),
                SizedBox(height: 12.h),
                Row(
                  children: <Widget>[],
                ),
                Text(
                  'Description',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 16.h),
                if (activityPackage.description!.length > minDescriptionLength)
                  Text(
                    showMoreDescription
                        ? activityPackage.description!
                        : '${activityPackage.description!.substring(0, minDescriptionLength)}...',
                    textAlign: TextAlign.justify,
                  )
                else
                  Text(
                    activityPackage.description!,
                    textAlign: TextAlign.justify,
                  ),
                SizedBox(height: 16.h),
                if (activityPackage.description!.length > minDescriptionLength)
                  GestureDetector(
                    onTap: () {
                      onReadMoreCallBack!();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          showMoreDescription ? 'Read Less' : 'Read More',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12.sp,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 20.h),
                const Divider(color: Colors.grey),
                Text(
                  'Location',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 16.h),
                buildLocationDetails(activityPackage),
                SizedBox(height: 16.h),
                mapWidget,
                SizedBox(height: 16.h),
                ListTile(
                    contentPadding: EdgeInsets.all(2.w),
                    leading: Container(
                        padding: EdgeInsets.all(2.w),
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
                        child: userGuideDetails.firebaseProfilePicUrl != ''
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    userGuideDetails.firebaseProfilePicUrl!),
                              )
                            : const CircleAvatar(
                                backgroundImage: AssetImage(
                                    '${AssetsPath.assetsPNGPath}/default_profile_pic.png'),
                              )),
                    title: Text(
                      userGuideDetails.fullName!,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.sp),
                    ),
                    subtitle: Text(
                        'Joined in ${DateFormat("MMM yyy").format(DateTime.parse(activityPackage.createdDate!))}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Colors.grey))),
                Row(
                  children: <Widget>[
                    Image.asset(
                      AssetsPath.iconVerified,
                      width: 20.w,
                      height: 20.h,
                    ),
                    Text(
                      'Identity verified',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                  child: Text(
                    'During Your Activity',
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                  child: Text(
                    "I'm available over phone 24/7 for Traveller",
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                  child: Text(
                    'Response rate: 80%',
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                  child: Text(
                    'Response rate: A few minutes or hours or more',
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0.h),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(color: AppColors.tealGreen),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r))),
                      ),
                      onPressed: () {
                        getMessageHistory();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: Text('Contact Guide',
                            style: TextStyle(
                                color: AppColors.tealGreen,
                                fontSize: 14,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'To protect your payment, never transfer money or communicate outside off the guided website or app',
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Image.asset(
                        AssetsPath.logoSmall,
                        width: 25.w,
                        height: 25.h,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                buildActivityListButtonItem(
                    title: AppTextConstants.availability,
                    subtitle: 'Add your travel date for exact pricing'),
                buildActivityListButtonItem(
                    title: 'Guide Rules & What To Bring',
                    subtitle: 'Follow the guide rules for safety'),
                buildActivityListButtonItem(
                    title: 'Health & safety',
                    subtitle: 'We  care about your health & safety'),
                buildActivityListButtonItem(
                    title: 'Traveler Release Waiver form',
                    subtitle: 'Lorem Ipsum',
                    showDivider: false),
              ],
            )),
        Divider(
          color: AppColors.gallery,
          thickness: 14.w,
        ),
        if (otherPackages.isNotEmpty) buildOtherOffering(otherPackages)
      ],
    ));
  }

  Widget buildOtherOffering(List<ActivityPackage> otherPackages) => Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.h),
          const Text(
            'Other Offering',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: otherPackages.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(right: 5.w),
                  height: 110,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // checkAvailability(
                          //     context, snapshot.data![index]);
                          Navigator.of(context).pushNamed(
                              '/activity_package_info',
                              arguments: otherPackages[index]);
                        },
                        child: Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            border: Border.all(color: AppColors.galleryWhite),
                            image: DecorationImage(
                                image: NetworkImage(
                                  otherPackages[index].firebaseCoverImg!,
                                ),
                                fit: BoxFit.cover),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                bottom: 10,
                                left: 20,
                                child: Image.memory(
                                  base64.decode(otherPackages[index]
                                      .mainBadge!
                                      .imgIcon!
                                      .split(',')
                                      .last),
                                  width: 30,
                                  height: 30,
                                  gaplessPlayback: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        otherPackages[index].name!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 10.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/png/clock.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            // snapshot.data![index].timeToTravel!,
                            '0.0 hour drive',
                            style: TextStyle(
                                color: HexColor('#696D6D'),
                                fontSize: 11.sp,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ));

  Widget buildLocationDetails(ActivityPackage _activityPackage) => Row(
        children: <Widget>[
          SvgPicture.asset('${AssetsPath.assetsSVGPath}/location.svg'),
          SizedBox(width: 4.w),
          Expanded(
              child: Text(
            _activityPackage.address!,
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 15.sp),
          ))
        ],
      );

  Widget buildActivityListButtonItem(
          {String title = '', String subtitle = '', showDivider: true}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
            ),
            subtitle: Text(subtitle,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: Colors.grey)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
            ),
          ),
          if (showDivider)
            const Divider(
              color: Colors.grey,
            ),
        ],
      );
}
