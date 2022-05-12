// ignore_for_file: file_names, always_specify_types, avoid_bool_literals_in_conditional_expressions, avoid_dynamic_calls, always_put_required_named_parameters_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Sub Activities Screen
class SubActivitiesScreen extends StatefulWidget {
  /// Constructor
  const SubActivitiesScreen({Key? key, required this.mainActivity})
      : super(key: key);

  /// Main Activity
  final BadgeDetailsModel mainActivity;

  @override
  _SubActivitiesScreenState createState() => _SubActivitiesScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<BadgeDetailsModel>('mainActivity', mainActivity));
  }
}

class _SubActivitiesScreenState extends State<SubActivitiesScreen> {
  bool showMainActivityChoices = false;
  bool showSubActivityChoices = false;
  bool showLimitNote = false;
  dynamic mainActivity;
  dynamic subActivities1;
  dynamic subActivities2;
  dynamic subActivities3;
  int count = 0;

  String mainActivityTxt = '';
  String subActivities1Txt = '';
  String subActivities2Txt = '';
  String subActivities3Txt = '';

  final TextEditingController _note = TextEditingController();
  late Future<BadgeModelData> _loadingData;

  @override
  void initState() {
    super.initState();
    mainActivity = widget.mainActivity;
    mainActivityTxt = widget.mainActivity.name;
    _loadingData = APIServices().getBadgesModel();
  }

  ListTile _choicesMainActivity(BadgeDetailsModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          mainActivity = badges;
        });
      },
      minLeadingWidth: 20,
      leading: Image.memory(
        base64.decode(badges.imgIcon.split(',').last),
        gaplessPlayback: true,
        width: 30,
        height: 30,
      ),
      title: Text(
        badges.name,
        style: TextStyle(
          fontSize: 12.sp,
        ),
      ),
    );
  }

  ListTile _chosenMainActivity(BadgeDetailsModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          mainActivity = badges;
        });
      },
      minLeadingWidth: 20,
      leading: Image.memory(
        base64.decode(badges.imgIcon.split(',').last),
        gaplessPlayback: true,
        width: 30,
        height: 30,
      ),
      title: Text(
        badges.name,
        style: TextStyle(
          fontSize: 12.sp,
        ),
      ),
    );
  }

  ListTile _disabledSubActivities(BadgeDetailsModel badges) {
    return ListTile(
      enabled: false,
      onTap: () {
        setState(() {
          switch (count) {
            case 0:
              subActivities1 = badges;
              subActivities1Txt = badges.name;
              count++;
              showSubActivityChoices = true;
              break;
            case 1:
              subActivities2 = badges;
              subActivities2Txt = badges.name;
              count++;
              showSubActivityChoices = true;
              break;
            case 2:
              subActivities3 = badges;
              subActivities3Txt = badges.name;
              count++;
              showSubActivityChoices = false;
              break;
            default:
              count = 0;
          }
        });
      },
      minLeadingWidth: 20,
      leading: Image.memory(
        base64.decode(badges.imgIcon.split(',').last),
        gaplessPlayback: true,
        width: 30,
        height: 30,
      ),
      title: Text(
        badges.name,
        style: TextStyle(
            fontSize: 12.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
      ),
    );
  }

  ListTile _enabledSubActivities(BadgeDetailsModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          switch (count) {
            case 0:
              subActivities1 = badges;
              subActivities1Txt = badges.name;
              count++;
              showSubActivityChoices = true;
              showLimitNote = false;
              break;
            case 1:
              subActivities2 = badges;
              subActivities2Txt = badges.name;
              count++;
              showSubActivityChoices = true;
              showLimitNote = false;
              break;
            case 2:
              subActivities3 = badges;
              subActivities3Txt = badges.name;
              count++;
              showSubActivityChoices = false;
              showLimitNote = true;
              break;
            case 3:
              showSubActivityChoices = false;
              showLimitNote = true;
              break;
            default:
              count = 0;
          }
        });
      },
      minLeadingWidth: 20,
      leading: Image.memory(
        base64.decode(badges.imgIcon.split(',').last),
        gaplessPlayback: true,
        width: 30,
        height: 30,
      ),
      title: Text(
        badges.name,
        style: TextStyle(
            fontSize: 12.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
      ),
    );
  }

  ListTile _choicesSubActivities(BadgeDetailsModel badges) {
    if (badges.name == mainActivity.name) {
      return _disabledSubActivities(badges);
    }
    if (subActivities1 == badges) {
      return _disabledSubActivities(badges);
    }
    if (subActivities2 == badges) {
      return _disabledSubActivities(badges);
    }
    if (subActivities3 == badges) {
      return _disabledSubActivities(badges);
    }

    return _enabledSubActivities(badges);
  }

  Padding _chosenSubActivities1(BadgeDetailsModel badges) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Align(
        child: InkWell(
          onTap: () {
            setState(() {
              subActivities1 = badges;
              subActivities1Txt = badges.name;
              count++;
            });
          },
          child: Container(
            height: 42.h,
            decoration: BoxDecoration(
                color: AppColors.platinum.withOpacity(0.8),
                border: Border.all(
                  color: AppColors.platinum.withOpacity(0.8),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20.r))),
            child: Align(
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                        child: Image.memory(
                          base64.decode(badges.imgIcon.split(',').last),
                          gaplessPlayback: true,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SizedBox(
                            // width: 70.w,
                            height: 30.h,
                            child: Align(
                              child: Text(
                                badges.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                if (subActivities2 != null) {
                                  subActivities1 = subActivities2;
                                  subActivities2 = null;
                                } else {
                                  subActivities1 = null;
                                }
                                if (subActivities3 != null) {
                                  subActivities2 = subActivities3;
                                  subActivities3 = null;
                                }

                                count--;
                                showLimitNote = false;
                              });
                            },
                            child: const Icon(
                              Icons.close_rounded,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _chosenSubActivities2(BadgeDetailsModel badges) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Align(
        child: InkWell(
          onTap: () {
            setState(() {
              subActivities2 = badges;
              subActivities2Txt = badges.name;
              count++;
            });
          },
          child: Container(
            height: 40.h,
            decoration: BoxDecoration(
                color: AppColors.platinum.withOpacity(0.8),
                border: Border.all(
                  color: AppColors.platinum.withOpacity(0.8),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20.r))),
            child: Align(
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                        child: Image.memory(
                          base64.decode(badges.imgIcon.split(',').last),
                          gaplessPlayback: true,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SizedBox(
                            height: 30.h,
                            child: Align(
                              child: Text(
                                badges.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                if (subActivities3 != null) {
                                  subActivities2 = subActivities3;
                                  subActivities3 = null;
                                } else {
                                  subActivities2 = null;
                                }
                                count--;
                                showLimitNote = false;
                              });
                            },
                            child: const Icon(
                              Icons.close_rounded,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _chosenSubActivities3(BadgeDetailsModel badges) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Align(
        child: InkWell(
          onTap: () {
            setState(() {
              subActivities3 = badges;
              subActivities3Txt = badges.name;
              count++;
            });
          },
          child: Container(
            height: 40.h,
            width: 155.w,
            decoration: BoxDecoration(
                color: AppColors.platinum.withOpacity(0.8),
                border: Border.all(
                  color: AppColors.platinum.withOpacity(0.8),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20.r))),
            child: Align(
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                        child: Image.memory(
                          base64.decode(badges.imgIcon.split(',').last),
                          gaplessPlayback: true,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            height: 30.h,
                            child: Align(
                              child: Text(
                                badges.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                subActivities3 = null;
                                count--;
                                showLimitNote = false;
                              });
                            },
                            child: const Icon(
                              Icons.close_rounded,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _mainActivityDropdown(double width) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: AppColors.grey,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            width: width,
            height: 65.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (mainActivity == null)
                  SizedBox(
                    width: 150.w,
                    height: 100.h,
                  )
                else
                  Expanded(
                    child: _chosenMainActivity(mainActivity),
                  ),
                SizedBox(
                  width: 110.w,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close_rounded,
                      )),
                ),
              ],
            ),
          ),
        ),
        if (showMainActivityChoices)
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(12.r),
            child: SizedBox(
              height: 200.h,
              width: width,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.w, 10.h, 10.w, 20.h),
                child: FutureBuilder<BadgeModelData>(
                  future: _loadingData,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      final BadgeModelData badgeData = snapshot.data;
                      final int length = badgeData.badgeDetails.length;
                      return GridView.count(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        children: List.generate(length, (int index) {
                          final BadgeDetailsModel badgeDetails =
                              badgeData.badgeDetails[index];
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              height: 10.h,
                              width: 100.w,
                              child: _choicesMainActivity(badgeDetails),
                            ),
                          );
                        }),
                      );
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Container();
                  },
                ),
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }

  Column _subActivityDropdown(double width) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              if (showSubActivityChoices) {
                showSubActivityChoices = false;
              } else {
                showSubActivityChoices = true;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: AppColors.grey,
                // width: 1.w,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      child: SizedBox(
                        height: 50.h,
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              if (subActivities1 == null)
                                SizedBox(
                                  height: 100.h,
                                )
                              else
                                _chosenSubActivities1(subActivities1),
                              if (subActivities2 == null)
                                SizedBox(
                                  height: 100.h,
                                )
                              else
                                _chosenSubActivities2(subActivities2),
                            ]),
                      ),
                    ),
                  ],
                ),
                if (subActivities3 == null)
                  SizedBox(
                    height: 100.h,
                  )
                else
                  _chosenSubActivities3(subActivities3),
              ],
            ),
          ),
        ),
        if (showSubActivityChoices)
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(12.r),
            child: SizedBox(
              height: 200.h,
              width: width,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.w, 10.h, 10.w, 20.h),
                // child: _choicesGridSubActivity(),
                child: FutureBuilder<BadgeModelData>(
                  future: _loadingData,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      final BadgeModelData badgeData = snapshot.data;
                      final int length = badgeData.badgeDetails.length;
                      return GridView.count(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        children: List.generate(length, (int index) {
                          final BadgeDetailsModel badgeDetails =
                              badgeData.badgeDetails[index];
                          return _choicesSubActivities(badgeDetails);
                        }),
                      );
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Container();
                  },
                ),
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          onTap: () {
            setState(() {
              showMainActivityChoices = false;
              showSubActivityChoices = false;
            });
          },
          child: SizedBox(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HeaderText.headerText(AppTextConstants.headerSubActivities),
                    SizedBox(height: 30.h),
                    _mainActivityDropdown(width),
                    SizedBox(height: 30.h),
                    Text(
                      AppTextConstants.addMultipleSubActivities,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(height: 15.h),
                    _subActivityDropdown(width),
                    SizedBox(height: 10.h),
                    if (showLimitNote == true)
                      Text(
                        AppTextConstants.maximumActivity,
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'Gilroy',
                            color: AppColors.osloGrey),
                      )
                    else
                      const Text(''),
                    SizedBox(height: 30.h),
                    TextField(
                      controller: _note,
                      decoration: InputDecoration(
                        hintText: AppTextConstants.addANote,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      width: width,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (subActivities1 != null) {
                            navigatePackageInfoScreen(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColors.silver,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          primary: AppColors.primaryGreen,
                          onPrimary: Colors.white,
                        ),
                        child: Text(
                          AppTextConstants.next,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigate to Package Info
  Future<void> navigatePackageInfoScreen(BuildContext context) async {
    final Map<String, dynamic> details = {
      'main_activity': mainActivity,
      'sub_activity_1': subActivities1,
      'sub_activity_2': subActivities2,
      'sub_activity_3': subActivities3,
      'note': _note.text,
      'activity_package_id': ''
    };

    print('Details: $details');
    await Navigator.pushNamed(context, '/package_info', arguments: details);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>(
          'showMainActivityChoices', showMainActivityChoices))
      ..add(DiagnosticsProperty<bool>(
          'showSubActivityChoices', showSubActivityChoices))
      ..add(DiagnosticsProperty('mainActivity', mainActivity))
      ..add(DiagnosticsProperty('subActivities3', subActivities3))
      ..add(DiagnosticsProperty('subActivities2', subActivities2))
      ..add(DiagnosticsProperty('subActivities1', subActivities1));
  }
}
