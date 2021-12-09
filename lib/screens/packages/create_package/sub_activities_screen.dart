// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/screens/packages/create_package/package_info_screen.dart';

/// Sub Activities Screen
class SubActivitiesScreen extends StatefulWidget {
  /// Constructor
  const SubActivitiesScreen({Key? key, required this.mainActivity})
      : super(key: key);

  /// Main Activity
  final BadgesModel mainActivity;

  @override
  _SubActivitiesScreenState createState() => _SubActivitiesScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BadgesModel>('mainActivity', mainActivity));
  }
}

class _SubActivitiesScreenState extends State<SubActivitiesScreen> {
  bool showMainActivityChoices = false;
  bool showSubActivityChoices = false;
  dynamic mainActivity;
  dynamic subActivities = [];

  @override
  void initState() {
    super.initState();

    mainActivity = widget.mainActivity;
  }

  GridView _choicesGridMainActivity() {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      children: List.generate(AppListConstants.badges.length, (int index) {
        return SizedBox(
          height: 10.h,
          width: 100.w,
          child: _choicesMainActivity(AppListConstants.badges[index]),
        );
      }),
    );
  }

  ListTile _choicesMainActivity(BadgesModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          mainActivity = badges;
        });
      },
      minLeadingWidth: 20,
      leading: Image.asset(
        badges.imageUrl,
        width: 25.w,
      ),
      title: Text(
        badges.title,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  ListTile _chosenMainActivity(BadgesModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          mainActivity = badges;
        });
      },
      minLeadingWidth: 20,
      leading: Image.asset(
        badges.imageUrl,
        width: 25.w,
      ),
      title: Text(
        badges.title,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  GridView _choicesGridSubActivity() {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      children: List.generate(AppListConstants.badges.length, (int index) {
        return SizedBox(
          height: 10.h,
          width: 100.w,
          child: _choicesSubActivities(AppListConstants.badges[index]),
        );
      }),
    );
  }

  ListTile _choicesSubActivities(BadgesModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          mainActivity = badges;
        });
      },
      minLeadingWidth: 20,
      leading: Image.asset(
        badges.imageUrl,
        width: 25.w,
      ),
      title: Text(badges.title),
    );
  }

  Padding _chosenSubActivities(BadgesModel badges) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Align(
        child: InkWell(
          onTap: () {
            setState(() {
              mainActivity = badges;
            });
          },
          child: Container(
            height: 35.h,
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
                        padding: EdgeInsets.fromLTRB(30.w, 0, 0, 0),
                        child: SizedBox(
                          width: 70.w,
                          height: 30.h,
                          child: Align(
                            child: Text(
                              badges.title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                mainActivity = null;
                              });
                            },
                            child: const Icon(
                              Icons.close_rounded,
                            )),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    bottom: 2.h,
                    child: Image.asset(
                      badges.imageUrl,
                      width: 28.w,
                    ),
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
          onTap: () {
            setState(() {
              if (showMainActivityChoices) {
                showMainActivityChoices = false;
              } else {
                showMainActivityChoices = true;
              }
            });
          },
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
                if (mainActivity == null) SizedBox(
                        width: 150.w,
                        height: 100.h,
                      ) else SizedBox(
                        width: 150.w,
                        height: 100.h,
                        child: _chosenMainActivity(mainActivity),
                      ),
                SizedBox(
                  width: 150.w,
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
        if (showMainActivityChoices) Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  height: 200.h,
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15.w, 10.h, 10.w, 20.h),
                    child: _choicesGridMainActivity(),
                  ),
                ),
              ) else const SizedBox(),
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
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            width: width,
            height: 65.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (mainActivity == null) SizedBox(
                        width: 300.w,
                        height: 100.h,
                      ) else Align(
                        child: SizedBox(
                          width: width / 1.4,
                          height: 55.h,
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                _chosenSubActivities(mainActivity),
                                _chosenSubActivities(mainActivity),
                                _chosenSubActivities(mainActivity),
                              ]),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          mainActivity = null;
                        });
                      },
                      child: const Icon(
                        Icons.close_rounded,
                      )),
                ),
              ],
            ),
          ),
        ),
        if (showSubActivityChoices) Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  height: 200.h,
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15.w, 10.h, 10.w, 20.h),
                    child: _choicesGridSubActivity(),
                  ),
                ),
              ) else const SizedBox(),
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
                    HeaderText.headerText(
                      AppTextConstants.headerSubActivities
                    ),
                    SizedBox(
                      height: 30.h
                    ),
                    _mainActivityDropdown(width),
                    SizedBox(
                        height: 30.h
                    ),
                    Text(
                      AppTextConstants.addMultipleSubActivities,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15
                      ),
                    ),
                    SizedBox(
                        height: 15.h
                    ),
                    _subActivityDropdown(width),
                    SizedBox(
                        height: 30.h
                    ),
                    SizedBox(
                      width: width,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/package_info');
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
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 20.h
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('showMainActivityChoices', showMainActivityChoices));
    properties.add(DiagnosticsProperty<bool>('showSubActivityChoices', showSubActivityChoices));
    properties.add(DiagnosticsProperty('mainActivity', mainActivity));
    properties.add(DiagnosticsProperty('subActivities', subActivities));
  }
}
