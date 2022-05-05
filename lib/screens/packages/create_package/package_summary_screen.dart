// ignore_for_file: file_names, cast_nullable_to_non_nullable, unused_local_variable, avoid_dynamic_calls, always_specify_types, unused_field
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/activity_destination_model.dart';
import 'package:guided/models/address.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/image_bulk_package.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:guided/models/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Package Summary Screen
class PackageSummaryScreen extends StatefulWidget {
  /// Constructor
  const PackageSummaryScreen({Key? key}) : super(key: key);

  @override
  _PackageSummaryScreenState createState() => _PackageSummaryScreenState();
}

class _PackageSummaryScreenState extends State<PackageSummaryScreen> {
  bool isChecked = false;
  bool _isSubmit = false;
  bool _isEnabledMainActivity = false;
  bool _isEnabledSubActivity = false;
  bool showMainActivityChoices = false;
  bool showSubActivityChoices = false;
  bool _isMainActivityEdited = false;
  bool _isSubActivityEdited = false;
  bool _didClickedSubActivity = false;
  bool showLimitNote = false;
  bool _isEnabledNumberofTraveler = false;
  bool _isEnabledCountry = false;
  bool _isEnabledStreet = false;
  bool _isEnabledCity = false;
  bool _isEnabledProvince = false;
  bool _isEnabledPostalCode = false;
  bool _isEnabledServices = false;
  bool _isEnabledImage = false;
  bool _isBasePrice = false;
  bool _didClickedImage = false;
  bool _isEnabledLocation = false;
  bool _isEnabledPackageDescription = false;
  bool _isEnabledNotIncludedServices = false;

  dynamic mainActivity;
  dynamic subActivities1;
  dynamic subActivities2;
  dynamic subActivities3;

  dynamic preMainActivity;
  dynamic preSubActivities1;
  dynamic preSubActivities2;
  dynamic preSubActivities3;

  String mainActivityTitle = '';
  String subActivities1Txt = '';
  String subActivities2Txt = '';
  String subActivities3Txt = '';
  File? image1;
  int count = 0;
  int _uploadCount = 0;
  late Future<BadgeModelData> _loadingData;

  final FocusNode _packageNameFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _numberTravelerFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _postalCodeFocus = FocusNode();
  final FocusNode _servicesFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _extraCostFocus = FocusNode();
  final FocusNode _notIncludedServicesFocus = FocusNode();
  final TextStyle txtStyle = TextStyle(fontSize: 14.sp, fontFamily: 'Poppins');

  TextEditingController _packageName = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _numberTraveler = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _services = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _extraCost = TextEditingController();
  TextEditingController _notIncludedServices = TextEditingController();

  final String _storagePathCoverImg = 'coverImg';
  final String _storagePathDestinationImg = 'destinationImg';
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      _packageName =
          TextEditingController(text: screenArguments['package_name']);
      _description =
          TextEditingController(text: screenArguments['description']);
      _numberTraveler = TextEditingController(text: screenArguments['maximum']);
      _country = TextEditingController(text: screenArguments['country']);
      _street = TextEditingController(text: screenArguments['street']);
      _city = TextEditingController(text: screenArguments['city']);
      _province = TextEditingController(text: screenArguments['state']);
      _postalCode = TextEditingController(text: screenArguments['zip_code']);
      _services =
          TextEditingController(text: screenArguments['services'].join(','));
      _price = TextEditingController(text: screenArguments['base_price']);
      _extraCost = TextEditingController(text: screenArguments['extra_cost']);
      _notIncludedServices = TextEditingController(
          text: screenArguments['not_included_services'].join(','));
    });
    _loadingData = APIServices().getBadgesModel();
  }

  ListTile _choicesMainActivity(BadgeDetailsModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          mainActivity = badges;
          showMainActivityChoices = false;
          mainActivityTitle = badges.name;
          subActivities1 = null;
          subActivities2 = null;
          subActivities3 = null;
          subActivities1Txt = '';
          subActivities2Txt = '';
          subActivities3Txt = '';
          count = 0;
          _isMainActivityEdited = true;
        });
      },
      minLeadingWidth: 20,
      leading: Image.memory(
        base64.decode(badges.imgIcon.split(',').last),
        gaplessPlayback: true,
        width: 30,
        height: 30,
      ),
      title: Text(badges.name, style: TextStyle(fontSize: 12.sp)),
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
                color: Colors.grey,
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
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      width: 160.w,
                      child: _choicesMainActivity(mainActivity),
                    ),
                  ),
                SizedBox(
                  width: 90.w,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          mainActivity = null;
                          subActivities1 = null;
                          subActivities2 = null;
                          subActivities3 = null;
                          mainActivityTitle = '';
                          subActivities1Txt = '';
                          subActivities2Txt = '';
                          subActivities3Txt = '';
                          count = 0;
                        });
                      },
                      child: mainActivity == null
                          ? const Icon(
                              Icons.arrow_drop_down_outlined,
                            )
                          : const Icon(Icons.close_rounded)),
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
                          return SizedBox(
                            height: 10.h,
                            width: 100.w,
                            child: _choicesMainActivity(badgeDetails),
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
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SizedBox(
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
                                style: TextStyle(fontSize: 13.sp),
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
                                style: TextStyle(fontSize: 13.sp),
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
      title: Text(badges.name, style: TextStyle(fontSize: 12.sp)),
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
        style: TextStyle(fontSize: 12.sp),
      ),
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

  // Format File Size
  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    preMainActivity = screenArguments['main_activity'];
    preSubActivities1 = screenArguments['sub_activity_1'];
    preSubActivities2 = screenArguments['sub_activity_2'];
    preSubActivities3 = screenArguments['sub_activity_3'];

    Widget image1Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () {
          if (_isEnabledImage) {
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
                                          imageQuality: 25,
                                          maxHeight: 800.h,
                                          maxWidth: 800.w);
                                  if (image1 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image1.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  if (file.contains('KB')) {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('K')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2000) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  } else {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('M')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  }
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
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);

                                  if (image1 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image1.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  if (file.contains('KB')) {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('K')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2000) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  } else {
                                    fileSize = int.parse(
                                        file.substring(0, file.indexOf('M')));
                                    debugPrint('Filesize:: $fileSize');
                                    if (fileSize >= 2) {
                                      Navigator.pop(context);
                                      AdvanceSnackBar(
                                              message: ErrorMessageConstants
                                                  .imageFileToSize,
                                              bgColor: Colors.red)
                                          .show(context);
                                      return;
                                    }
                                  }
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
              base64.decode(screenArguments['cover_img'].split(',').last),
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

    Card _widgetActivity() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.activity,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledMainActivity) {
                            _isEnabledMainActivity = false;
                            showMainActivityChoices = false;
                          } else {
                            _isEnabledMainActivity = true;
                            showMainActivityChoices = true;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledMainActivity
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
                    if (_isEnabledMainActivity)
                      _mainActivityDropdown(width)
                    else if (_isMainActivityEdited && mainActivity != null)
                      ListTile(
                        onTap: () {},
                        minLeadingWidth: 20,
                        leading: Image.memory(
                          base64.decode(mainActivity.imgIcon.split(',').last),
                          gaplessPlayback: true,
                          width: 30,
                          height: 30,
                        ),
                        title: Text(mainActivity.name),
                      )
                    else
                      ListTile(
                        onTap: () {},
                        minLeadingWidth: 20,
                        leading: Image.memory(
                          base64
                              .decode(preMainActivity.imgIcon.split(',').last),
                          gaplessPlayback: true,
                          width: 30,
                          height: 30,
                        ),
                        title: Text(preMainActivity.name),
                      )
                  ],
                ),
              ),
            ],
          ),
        );

    Card _widgetSubActivity() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SingleChildScrollView(
                child: ListTile(
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
                                                color: AppColors.nobel,
                                                fontSize: 12.sp)),
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
                                                color: AppColors.nobel,
                                                fontSize: 12.sp)),
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
                                                color: AppColors.nobel,
                                                fontSize: 12.sp)),
                                      ),
                                    )
                                  else
                                    Container(),
                                ],
                              )
                            : Row(
                                children: <Widget>[
                                  if (preSubActivities1 != null)
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
                                            preSubActivities1.name.toString(),
                                            style: TextStyle(
                                                color: AppColors.nobel,
                                                fontSize: 12.sp)),
                                      ),
                                    )
                                  else
                                    Container(),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  if (preSubActivities2 != null)
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
                                            preSubActivities2.name.toString(),
                                            style: TextStyle(
                                                color: AppColors.nobel,
                                                fontSize: 12.sp)),
                                      ),
                                    )
                                  else
                                    Container(),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  if (preSubActivities3 != null)
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
                                            preSubActivities3.name.toString(),
                                            style: TextStyle(
                                                color: AppColors.nobel,
                                                fontSize: 12.sp)),
                                      ),
                                    )
                                  else
                                    Container(),
                                ],
                              )),
              ),
            ],
          ),
        );

    Card _widgetPackageNameDescription() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.packageNameandDescr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      if (_isEnabledPackageDescription) {
                        _isEnabledPackageDescription = false;
                      } else {
                        _isEnabledPackageDescription = true;
                      }
                    },
                    child: Text(
                      _isEnabledPackageDescription
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
                    enabled: _isEnabledPackageDescription,
                    controller: _packageName,
                    focusNode: _packageNameFocus,
                    decoration: InputDecoration(
                      hintText: screenArguments['package_name'],
                      hintStyle: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextField(
                    enabled: _isEnabledPackageDescription,
                    controller: _description,
                    focusNode: _descriptionFocus,
                    decoration: InputDecoration(
                      hintText: screenArguments['description'],
                      hintStyle: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    style: txtStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _numberOfTraveler() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.numberOfTraveler,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      if (_isEnabledNumberofTraveler) {
                        _isEnabledNumberofTraveler = false;
                      } else {
                        _isEnabledNumberofTraveler = true;
                      }
                    },
                    child: Text(
                      _isEnabledNumberofTraveler
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
                    enabled: _isEnabledNumberofTraveler,
                    controller: _numberTraveler,
                    focusNode: _numberTravelerFocus,
                    decoration: InputDecoration(
                      hintText: screenArguments['maximum'],
                      hintStyle: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    style: txtStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _currentLocation() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.currentLocation,
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
                          _isEnabledProvince = false;
                          _isEnabledCity = false;
                          _isEnabledPostalCode = false;
                        } else {
                          _isEnabledLocation = true;
                          _isEnabledCountry = true;
                          _isEnabledStreet = true;
                          _isEnabledProvince = true;
                          _isEnabledCity = true;
                          _isEnabledPostalCode = true;
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
                    enabled: _isEnabledProvince,
                    controller: _province,
                    focusNode: _provinceFocus,
                    decoration: InputDecoration(
                      hintText: 'State/Province: ${screenArguments['state']}',
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
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextField(
                    enabled: _isEnabledPostalCode,
                    controller: _postalCode,
                    focusNode: _postalCodeFocus,
                    decoration: InputDecoration(
                      hintText: 'Postal Code: ${screenArguments['zip_code']}',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    style: txtStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _offeredAmenities() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.offeredAmenities,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_isEnabledServices) {
                          _isEnabledServices = false;
                        } else {
                          _isEnabledServices = true;
                        }
                      });
                    },
                    child: Text(
                      _isEnabledServices
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
                    enabled: _isEnabledServices,
                    controller: _services,
                    focusNode: _servicesFocus,
                    decoration: InputDecoration(
                      hintText: screenArguments['services'].join(', '),
                      hintStyle: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    style: txtStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _notOfferedAmenities() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.notOfferedAmenities,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_isEnabledNotIncludedServices) {
                          _isEnabledNotIncludedServices = false;
                        } else {
                          _isEnabledNotIncludedServices = true;
                        }
                      });
                    },
                    child: Text(
                      _isEnabledNotIncludedServices
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
                    enabled: _isEnabledNotIncludedServices,
                    controller: _notIncludedServices,
                    focusNode: _notIncludedServicesFocus,
                    decoration: InputDecoration(
                      hintText:
                          screenArguments['not_included_services'].join(', '),
                      hintStyle: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    style: txtStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Card _attachedPhotos() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.attachedPhotos,
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
    }

    Card _basePrice() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppTextConstants.basePrice,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_isBasePrice) {
                          _isBasePrice = false;
                        } else {
                          _isBasePrice = true;
                        }
                      });
                    },
                    child: Text(
                      _isBasePrice
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
                    enabled: _isBasePrice,
                    controller: _price,
                    focusNode: _priceFocus,
                    decoration: InputDecoration(
                      hintText:
                          '${AppTextConstants.basePrice}: \$${screenArguments['base_price']}',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextField(
                    enabled: _isBasePrice,
                    controller: _extraCost,
                    focusNode: _extraCostFocus,
                    decoration: InputDecoration(
                      hintText:
                          '${AppTextConstants.extraCost}: \$${screenArguments['extra_cost']}',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: txtStyle,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

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
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.headerSummary),
                  SizedBox(height: 30.h),
                  _widgetActivity(),
                  SizedBox(height: 15.h),
                  _widgetSubActivity(),
                  SizedBox(height: 15.h),
                  _widgetPackageNameDescription(),
                  SizedBox(height: 15.h),
                  _numberOfTraveler(),
                  SizedBox(height: 15.h),
                  _currentLocation(),
                  SizedBox(height: 15.h),
                  _offeredAmenities(),
                  SizedBox(height: 15.h),
                  _notOfferedAmenities(),
                  SizedBox(height: 15.h),
                  _attachedPhotos(),
                  SizedBox(height: 15.h),
                  _basePrice(),
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
          height: 60,
          child: LoadingElevatedButton(
            onPressed: () async => _isSubmit ? null : packageDetail(),
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
            isLoading: _isSubmit,
            loadingChild: const Text(
              'Loading',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            child: Text(
              AppTextConstants.submit,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> packageDetail() async {
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String? userId = UserSingleton.instance.user.user!.id;
    List<String> list = screenArguments['services'];
    List<String> notIncludedList = screenArguments['not_included_services'];
    dynamic mainBadge;
    String subBadges = '';

    setState(() {
      _isSubmit = true;
    });

    if (_isMainActivityEdited) {
      mainBadge = mainActivity;
    } else {
      mainBadge = preMainActivity;
    }

    if (_isSubActivityEdited) {
      if (subActivities1 != null) {
        subBadges = subActivities1.id;
      }
      if (subActivities2 != null) {
        subBadges = '$subBadges,${subActivities2.id}';
      }
      if (subActivities3 != null) {
        subBadges = '$subBadges,${subActivities3.id}';
      }
    } else {
      if (preSubActivities1 != null) {
        subBadges = preSubActivities1.id;
      }
      if (preSubActivities2 != null) {
        subBadges = '$subBadges,${preSubActivities2.id}';
      }
      if (preSubActivities3 != null) {
        subBadges = '$subBadges,${preSubActivities3.id}';
      }
    }

    /// Save image to firebase
    String coverImgUrl = '';
    if (image1 == null) {
      coverImgUrl = await FirebaseServices().uploadImageToFirebase(
          screenArguments['firebase_cover_img']!, _storagePathCoverImg);
    } else {
      coverImgUrl = await FirebaseServices()
          .uploadImageToFirebase(image1!, _storagePathCoverImg);
    }

    Map<String, dynamic> packageDetails = {
      'user_id': userId,
      'main_badge_id': mainBadge.id,
      'sub_badge_ids': subBadges,
      'package_note': screenArguments['note'].toString(),
      'name': _packageName.text,
      'description': _description.text,
      'cover_img': '',
      'max_traveller': int.parse(screenArguments['maximum'].toString()),
      'min_traveller': int.parse(screenArguments['minimum'].toString()),
      'country': screenArguments['country'].toString(),
      'address':
          '${screenArguments['street']}, ${screenArguments['city']}, ${screenArguments['state']}, ${screenArguments['zip_code']}',
      'services': _services.text,
      'base_price': screenArguments['base_price'].toString(),
      'extra_cost_per_person': screenArguments['extra_cost'].toString(),
      'max_extra_person': int.parse(screenArguments['max_person'].toString()),
      'currency_id': screenArguments['currency_id'].toString(),
      'price_note': screenArguments['additional_notes'].toString(),
      'is_published': true,
      'firebase_cover_img': coverImgUrl,
      'included': _services.text,
      'not_included': _notIncludedServices.text
    };

    /// Activity Package Details API
    final dynamic response = await APIServices().request(
        AppAPIPath.activityPackagesUrl, RequestType.POST,
        needAccessToken: true, data: packageDetails);

    /// Get the activity package id
    final String activityPackageId = response['id'];

    List<ActivityDestinationModel> item = screenArguments['destination_list'];

    /// Loop through the destination list
    for (var i = 0; i < item.length; i++) {
      /// Destination Details
      final Map<String, dynamic> destinationDetails = {
        'activity_package_id': activityPackageId,
        'place_name': item[i].placeName,
        'place_description': item[i].placeDescription,
        'latitude': item[i].latitude,
        'longitude': item[i].longitude,
        'code': screenArguments['country_code']
      };

      final dynamic response1 = await APIServices().request(
          AppAPIPath.activityDestinationDetails, RequestType.POST,
          needAccessToken: true, data: destinationDetails);

      /// Get the activity package destination id
      final String activityPackageDestinationId = response1['id'];

      /// Destination Image API
      if (item[i].uploadCount == 1) {
        final Map<String, dynamic> image = {
          'activity_package_destination_id': activityPackageDestinationId,
          'firebase_snapshot_img': item[i].img1FirebaseHolder
        };

        /// Activity Package Destination Image API
        await APIServices().request(
            AppAPIPath.activityDestinationImage, RequestType.POST,
            needAccessToken: true, data: image);
      } else if (item[i].uploadCount == 2) {
        final ImageListPackage objImg1 = ImageListPackage(
            id: activityPackageDestinationId,
            firebaseImg: item[i].img1FirebaseHolder);
        final ImageListPackage objImg2 = ImageListPackage(
            id: activityPackageDestinationId,
            firebaseImg: item[i].img2FirebaseHolder);

        final List<ImageListPackage> list = [objImg1, objImg2];

        final Map<String, List<dynamic>> finalJson = {
          'bulk': encodeToJson(list)
        };

        /// Activity Package Destination Image Bulk API
        await APIServices().request(
            AppAPIPath.activityDestinationImageBulk, RequestType.POST,
            needAccessToken: true, data: finalJson);
      } else if (item[i].uploadCount == 3) {
        final ImageListPackage objImg1 = ImageListPackage(
            id: activityPackageDestinationId,
            firebaseImg: item[i].img1FirebaseHolder);
        final ImageListPackage objImg2 = ImageListPackage(
            id: activityPackageDestinationId,
            firebaseImg: item[i].img2FirebaseHolder);
        final ImageListPackage objImg3 = ImageListPackage(
            id: activityPackageDestinationId,
            firebaseImg: item[i].img3FirebaseHolder);

        final List<ImageListPackage> list = [objImg1, objImg2, objImg3];

        final Map<String, List<dynamic>> finalJson = {
          'bulk': encodeToJson(list)
        };

        /// Activity Package Destination Image Bulk API
        await APIServices().request(
            AppAPIPath.activityDestinationImageBulk, RequestType.POST,
            needAccessToken: true, data: finalJson);
      }
    }

    final Map<String, dynamic> guideRuleDetails = {
      'user_id': userId,
      'description': screenArguments['guide_rule']
    };

    /// Guide Rules and What to Bring Details API
    final dynamic response2 = await APIServices().request(
        AppAPIPath.guideRules, RequestType.POST,
        needAccessToken: true, data: guideRuleDetails);

    final Map<String, dynamic> localLawDetails = {
      'description': screenArguments['local_law_and_taxes']
    };

    /// Local Laws and Taxes Details API
    final dynamic response3 = await APIServices().request(
        '${AppAPIPath.termsAndCondition}/${screenArguments['preset_local_law_id']}',
        RequestType.PATCH,
        needAccessToken: true,
        data: localLawDetails);

    final Map<String, dynamic> waiverDetails = {
      'description': screenArguments['waiver']
    };

    /// Waiver Details API
    final dynamic response4 = await APIServices().request(
        '${AppAPIPath.termsAndCondition}/${screenArguments['preset_waiver_id']}',
        RequestType.PATCH,
        needAccessToken: true,
        data: waiverDetails);

    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const MainNavigationScreen(
                  navIndex: 1,
                  contentIndex: 0,
                )),
        (Route<dynamic> route) => false);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isChecked', isChecked));
  }
}
