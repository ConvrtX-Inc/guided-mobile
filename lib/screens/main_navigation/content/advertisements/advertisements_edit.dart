// ignore_for_file: unnecessary_raw_strings, always_specify_types, curly_braces_in_flow_control_structures, cast_nullable_to_non_nullable, avoid_dynamic_calls, avoid_catches_without_on_clauses, always_put_control_body_on_new_line

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/decimal_text_input_formatter.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/content/content_main.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Edit Advertisement Screen
class AdvertisementEdit extends StatefulWidget {
  /// Constructor
  const AdvertisementEdit({Key? key}) : super(key: key);

  @override
  _AdvertisementEditState createState() => _AdvertisementEditState();
}

class _AdvertisementEditState extends State<AdvertisementEdit> {
  bool isChecked = false;

  bool _isEnabledTitle = false;
  bool _isEnabledLocation = false;
  bool _isEnabledCountry = false;
  bool _isEnabledStreet = false;
  bool _isEnabledCity = false;
  bool _isEnabledProvince = false;
  bool _isEnabledPostalCode = false;
  bool _isEnabledDate = false;
  bool _isEnabledDescription = false;
  bool _isEnabledPrice = false;
  bool _isEnabledImage = false;
  bool _didClickedImage = false;
  bool _isSubmit = false;
  bool _isEnabledSubActivity = false;
  bool _isSubActivityEdited = false;
  bool showSubActivityChoices = false;
  bool _didClickedSubActivity = false;
  bool showLimitNote = false;

  TextEditingController _title = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _activities = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _postalCodeFocus = FocusNode();
  final FocusNode _dateFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _activitiesFocus = FocusNode();
  DateTime _selectedDate = DateTime.now();
  final TextStyle txtStyle = TextStyle(fontSize: 14.sp, fontFamily: 'Poppins');

  File? image1;

  int _uploadCount = 0;
  int count = 0;
  dynamic subActivities1;
  dynamic subActivities2;
  dynamic subActivities3;
  String subActivities1Txt = '';
  String subActivities2Txt = '';
  String subActivities3Txt = '';

  late Future<BadgeModelData> _loadingData;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final String removedDollar =
          screenArguments['price'].toString().substring(0);

      _title = TextEditingController(text: screenArguments['title']);
      _price = TextEditingController(text: removedDollar);
      _description =
          TextEditingController(text: screenArguments['description']);
      _country = TextEditingController(text: screenArguments['country']);
      _street = TextEditingController(text: screenArguments['street']);
      _city = TextEditingController(text: screenArguments['city']);
      _province = TextEditingController(text: screenArguments['province']);
      _postalCode = TextEditingController(text: screenArguments['zip_code']);
      _date = TextEditingController(
          text: screenArguments['availability_date'].toString());
      _activities =
          TextEditingController(text: screenArguments['activities'].join(','));
    });
    _loadingData = APIServices().getBadgesModel();
  }

  Column _subActivityDropdown(double width) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              if (showSubActivityChoices) {
                showSubActivityChoices = false;
                _didClickedSubActivity = true;
              } else {
                showSubActivityChoices = true;
                _isSubActivityEdited = true;
                _didClickedSubActivity = true;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.grey.shade400,
                // width: 1.w,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          return SizedBox(
                            height: 10.h,
                            width: 100.w,
                            child: _choicesSubActivities(badgeDetails),
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

  Padding _chosenSubActivities1(BadgeDetailsModel badges) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Align(
        child: InkWell(
          onTap: () {
            setState(() {
              subActivities1 = badges;
              subActivities1Txt = badges.name;
              _isSubActivityEdited = true;
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
                        child: SizedBox(
                          width: 70.w,
                          height: 30.h,
                          child: Align(
                            child: Text(
                              badges.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13.sp),
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
                        child: SizedBox(
                          width: 70.w,
                          height: 30.h,
                          child: Align(
                            child: Text(
                              badges.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13.sp),
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
            width: 140.w,
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
                        child: SizedBox(
                          width: 70.w,
                          height: 30.h,
                          child: Align(
                            child: Text(
                              badges.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13.sp),
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

  ListTile _choicesSubActivities(BadgeDetailsModel badges) {
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
      title: Text(badges.name),
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
      title: Text(badges.name),
    );
  }

  Stack _default() {
    return Stack(
      children: <Widget>[
        Container(
          width: 100.w,
          height: 87.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.gallery,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.gallery,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: <Widget>[
                Image.asset(
                  AssetsPath.imagePrey,
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 3.w,
          top: 3.h,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(
              Icons.add,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Widget image1Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () {
          if (_isEnabledImage && _didClickedImage) {
            showMaterialModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) => SafeArea(
                    top: false,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              leading: const Icon(Icons.photo_camera),
                              title: const Text('Camera'),
                              onTap: () async {
                                try {
                                  final XFile? image1 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 25);
                                  if (image1 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image1.path);
                                  setState(() {
                                    this.image1 = imageTemporary;
                                    _uploadCount += 1;
                                  });
                                } on PlatformException catch (e) {
                                  print('Failed to pick image: $e');
                                }
                                Navigator.of(context).pop();
                              }),
                          ListTile(
                              leading: const Icon(Icons.photo_album),
                              title: const Text('Photo Gallery'),
                              onTap: () async {
                                try {
                                  final XFile? image1 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 10);

                                  if (image1 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image1.path);
                                  setState(() {
                                    this.image1 = imageTemporary;
                                    _uploadCount += 1;
                                  });
                                } on PlatformException catch (e) {
                                  print('Failed to pick image: $e');
                                }
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    )));
          }
        },
        child: image1 != null
            ? Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image1!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            image1 = null;
                            _uploadCount -= 1;
                          });
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 14.r,
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.close, color: Colors.black),
                          ),
                        ),
                      ))
                ],
              )
            : _default(),
      );
    }

    Stack _presetDefault() {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              base64.decode(screenArguments['snapshot_img'].split(',').last),
              fit: BoxFit.cover,
              gaplessPlayback: true,
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isEnabledImage) {
                      image1 = null;
                      _uploadCount -= 1;
                      _didClickedImage = true;
                    }
                  });
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.close, color: Colors.black),
                  ),
                ),
              ))
        ],
      );
    }

    /// Image List card widget
    Card _widgetImagesList() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.images,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledImage) {
                            _isEnabledImage = false;
                          } else {
                            _isEnabledImage = true;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledImage
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    if (_didClickedImage)
                      image1Placeholder(context)
                    else
                      _presetDefault(),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

    /// Title card widget
    Card _widgetTitle() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledTitle) {
                            _isEnabledTitle = false;
                          } else {
                            _isEnabledTitle = true;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledTitle
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledTitle,
                      controller: _title,
                      focusNode: _titleFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['title'],
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Activity card widget
    Card _widgetSubActivity() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        AppTextConstants.subActivities,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_isEnabledSubActivity) {
                              _isEnabledSubActivity = false;
                            } else {
                              _isEnabledSubActivity = true;
                              _isSubActivityEdited = true;
                            }
                          });
                        },
                        child: Text(
                          _isEnabledSubActivity
                              ? AppTextConstants.done
                              : AppTextConstants.edit,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            color: AppColors.primaryGreen,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  subtitle: _isEnabledSubActivity
                      ? _subActivityDropdown(width)
                      : _isSubActivityEdited
                          ? Row(
                              children: <Widget>[
                                if (subActivities1 != null)
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.harp,
                                        border:
                                            Border.all(color: AppColors.harp),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.r))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          subActivities1.name.toString(),
                                          style: TextStyle(
                                              color: AppColors.nobel)),
                                    ),
                                  )
                                else
                                  Container(),
                                SizedBox(
                                  width: 5.w,
                                ),
                                if (subActivities2 != null)
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.harp,
                                        border:
                                            Border.all(color: AppColors.harp),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.r))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          subActivities2.name.toString(),
                                          style: TextStyle(
                                              color: AppColors.nobel)),
                                    ),
                                  )
                                else
                                  Container(),
                                SizedBox(
                                  width: 5.w,
                                ),
                                if (subActivities3 != null)
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.harp,
                                        border:
                                            Border.all(color: AppColors.harp),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.r))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          subActivities3.name.toString(),
                                          style: TextStyle(
                                              color: AppColors.nobel)),
                                    ),
                                  )
                                else
                                  Container(),
                              ],
                            )
                          : SizedBox(
                              height: 50.h,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: screenArguments['activities']
                                            .length,
                                        itemBuilder:
                                            (BuildContext ctx, int index) {
                                          return FutureBuilder<BadgeModelData>(
                                            future: APIServices()
                                                .getBadgesModelById(
                                                    screenArguments[
                                                        'activities'][index]),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<dynamic>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                final BadgeModelData badgeData =
                                                    snapshot.data;
                                                final int length = badgeData
                                                    .badgeDetails.length;
                                                return Row(
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColors.harp,
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .harp),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.r))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Text(
                                                            badgeData
                                                                .badgeDetails[0]
                                                                .name
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .nobel)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    )
                                                  ],
                                                );
                                              }
                                              if (snapshot.connectionState !=
                                                  ConnectionState.done) {
                                                return Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      const CircularProgressIndicator(),
                                                    ],
                                                  ),
                                                );
                                              }
                                              return Container();
                                            },
                                          );
                                        }),
                                  )
                                ],
                              ),
                            )),
            ],
          ),
        );

    /// Price card widget
    Card _widgetPrice() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledPrice) {
                            _isEnabledPrice = false;
                          } else {
                            _isEnabledPrice = true;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledPrice
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledPrice,
                      controller: _price,
                      focusNode: _priceFocus,
                      decoration: InputDecoration(
                        hintText: '\$${screenArguments['price']}',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2),
                        FilteringTextInputFormatter.allow(RegExp('[0-9.0-9]')),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {}
                          return oldValue;
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Description card widget
    Card _widgetDescription() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.description,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, height: 1.5),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledDescription) {
                            _isEnabledDescription = false;
                          } else {
                            _isEnabledDescription = true;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledDescription
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledDescription,
                      controller: _description,
                      focusNode: _descriptionFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['description'],
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Location card widget
    Card _widgetLocation() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.location,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledLocation) {
                            _isEnabledLocation = false;
                            _isEnabledCountry = false;
                            _isEnabledStreet = false;
                            _isEnabledCity = false;
                          } else {
                            _isEnabledLocation = true;
                            _isEnabledCountry = true;
                            _isEnabledStreet = true;
                            _isEnabledCity = true;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledLocation
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 2.h,
                    ),
                    TextField(
                      enabled: _isEnabledCountry,
                      controller: _country,
                      focusNode: _countryFocus,
                      decoration: InputDecoration(
                        hintText: 'Country: ${screenArguments['country']}',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextField(
                      enabled: _isEnabledStreet,
                      controller: _street,
                      focusNode: _streetFocus,
                      decoration: InputDecoration(
                        hintText: 'Street: ${screenArguments['street']}',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextField(
                      enabled: _isEnabledCity,
                      controller: _city,
                      focusNode: _cityFocus,
                      decoration: InputDecoration(
                        hintText: 'City: ${screenArguments['city']}',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Province card widget
    Card _widgetProvince() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.province,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledProvince) {
                            _isEnabledProvince = false;
                          } else {
                            _isEnabledProvince = true;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledProvince
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledProvince,
                      controller: _province,
                      focusNode: _provinceFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['province'],
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Postal Code card widget
    Card _widgetPostalCode() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.postalCode,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledPostalCode) {
                            _isEnabledPostalCode = false;
                          } else {
                            _isEnabledPostalCode = true;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledPostalCode
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      enabled: _isEnabledPostalCode,
                      controller: _postalCode,
                      focusNode: _postalCodeFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['zip_code'],
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: txtStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    /// Date card widget
    Card _widgetDate() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.date,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledDate) {
                            _isEnabledDate = false;
                          } else {
                            _isEnabledDate = true;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledDate
                            ? AppTextConstants.done
                            : AppTextConstants.edit,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryGreen,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () => _isEnabledDate ? _showDate(context) : null,
                      child: AbsorbPointer(
                        child: TextField(
                          enabled: _isEnabledDate,
                          keyboardType: TextInputType.datetime,
                          controller: _date,
                          focusNode: _dateFocus,
                          decoration: InputDecoration(
                            hintText: screenArguments['date'],
                            hintStyle: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          ),
                          style: txtStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Transform.scale(
          scale: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 40.w,
              height: 40.h,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: AppColors.harp,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.editsummaryTitle),
                  SizedBox(
                    height: 30.h,
                  ),
                  _widgetImagesList(),
                  _widgetTitle(),
                  _widgetSubActivity(),
                  _widgetLocation(),
                  _widgetProvince(),
                  _widgetPostalCode(),
                  _widgetDate(),
                  _widgetDescription(),
                  _widgetPrice(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: 60.h,
          child: ElevatedButton(
            onPressed: () async => _isSubmit ? null : advertisementEditDetail(),
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
            child: _isSubmit
                ? const Center(child: CircularProgressIndicator())
                : Text(
                    AppTextConstants.postEvent,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> saveImage(String activityAdId, String imageId) async {
    final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
    final String base64Image1 = base64Encode(await image1Bytes);

    final Map<String, dynamic> image = {
      'activity_event_id': activityAdId,
      'snapshot_img': base64Image1
    };

    await APIServices().request(
        '${AppAPIPath.imageUrl}/$imageId', RequestType.PATCH,
        needAccessToken: true, data: image);
  }

  Future<void> advertisementEditDetail() async {
    if (_street.text.isEmpty ||
        _city.text.isEmpty ||
        _province.text.isEmpty ||
        _postalCode.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.locationEmpty)
          .show(context);
    } else if (_didClickedImage) {
      if (image1 == null) {
        AdvanceSnackBar(message: ErrorMessageConstants.eventImageEmpty)
            .show(context);
      } else {
        setState(() {
          _isSubmit = true;
        });
        final Map<String, dynamic> screenArguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

        String subActivity = '';

        if (_didClickedSubActivity) {
          if (subActivities1 != null) {
            subActivity = subActivities1.id.toString();
          }
          if (subActivities2 != null) {
            subActivity = '$subActivity,${subActivities2.id.toString()}';
          }
          if (subActivities3 != null) {
            subActivity = '$subActivity,${subActivities3.id.toString()}';
          }
        } else {
          subActivity = _activities.text;
        }

        final Map<String, dynamic> advertisementEditDetails = {
          'title': _title.text,
          'country': _country.text,
          'address':
              '${_street.text}, ${_city.text}, ${_province.text}, ${_postalCode.text}, ${_country.text}',
          'activities': subActivity,
          'street': _street.text,
          'city': _city.text,
          'province': _province.text,
          'zip_code': _postalCode.text,
          'ad_date': _date.text,
          'description': _description.text,
          'price': double.parse(_price.text)
        };

        final dynamic response = await APIServices().request(
            '${AppAPIPath.getAdvertisementDetail}/${screenArguments['id']}',
            RequestType.PATCH,
            needAccessToken: true,
            data: advertisementEditDetails);

        if (_didClickedImage) {
          if (image1 != null) {
            await saveImage(screenArguments['id'], screenArguments['image_id']);
          }
        }
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const MainNavigationScreen(
                      navIndex: 1,
                      contentIndex: 3,
                    )));
      }
    } else if (_date.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.dateEmpty).show(context);
    } else {
      setState(() {
        _isSubmit = true;
      });
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      String subActivity = '';

      if (_didClickedSubActivity) {
        if (subActivities1 != null) {
          subActivity = subActivities1.id.toString();
        }
        if (subActivities2 != null) {
          subActivity = '$subActivity,${subActivities2.id.toString()}';
        }
        if (subActivities3 != null) {
          subActivity = '$subActivity,${subActivities3.id.toString()}';
        }
      } else {
        subActivity = _activities.text;
      }

      final Map<String, dynamic> advertisementEditDetails = {
        'title': _title.text,
        'country': _country.text,
        'address':
            '${_street.text}, ${_city.text}, ${_province.text}, ${_postalCode.text}, ${_country.text}',
        'activities': subActivity,
        'street': _street.text,
        'city': _city.text,
        'province': _province.text,
        'zip_code': _postalCode.text,
        'ad_date': _date.text,
        'description': _description.text,
        'price': double.parse(_price.text)
      };

      final dynamic response = await APIServices().request(
          '${AppAPIPath.getAdvertisementDetail}/${screenArguments['id']}',
          RequestType.PATCH,
          needAccessToken: true,
          data: advertisementEditDetails);

      if (_didClickedImage) {
        if (image1 != null) {
          await saveImage(screenArguments['id'], screenArguments['image_id']);
        }
      }
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const MainNavigationScreen(
                    navIndex: 1,
                    contentIndex: 3,
                  )));
    }
  }

  Future<void> _showDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1901),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.green,
            splashColor: AppColors.primaryGreen,
          ),
          child: child ?? const Text(''),
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      final String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        _selectedDate = picked;
        _date = TextEditingController(text: formattedDate.toString());
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isChecked', isChecked));
  }
}
