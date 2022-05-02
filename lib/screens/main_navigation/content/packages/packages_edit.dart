// ignore_for_file: file_names, cast_nullable_to_non_nullable, unused_local_variable, avoid_dynamic_calls, always_specify_types
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:advance_notification/advance_notification.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/country_dropdown.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Package Summary Screen
class PackageEdit extends StatefulWidget {
  /// Constructor
  const PackageEdit({Key? key}) : super(key: key);

  @override
  _PackageEditState createState() => _PackageEditState();
}

class _PackageEditState extends State<PackageEdit> {
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

  dynamic mainActivity;
  dynamic subActivities1;
  dynamic subActivities2;
  dynamic subActivities3;

  dynamic preMainActivity;

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
  final TextStyle txtStyle = TextStyle(fontSize: 14.sp, fontFamily: 'Poppins');
  late List<String> subActivityId;

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

  late CountryModel _countryDropdown;
  late List<CountryModel> listCountry;
  final String _storagePathCoverImg = 'coverImg';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final List<CountryModel> resCountries =
          await APIServices().getCountries();
      _packageName = TextEditingController(text: screenArguments['name']);
      _description =
          TextEditingController(text: screenArguments['description']);
      _numberTraveler = TextEditingController(
          text: screenArguments['number_of_tourist'].toString());
      _country = TextEditingController(text: screenArguments['country']);
      _street = TextEditingController(text: screenArguments['address'][0]);
      _city = TextEditingController(text: screenArguments['address'][1]);
      _province = TextEditingController(text: screenArguments['address'][2]);
      _postalCode = TextEditingController(text: screenArguments['address'][3]);
      _services = TextEditingController(text: screenArguments['services']);
      _price = TextEditingController(text: screenArguments['fee'].toString());
      _extraCost = TextEditingController(text: screenArguments['extra_cost']);

      setState(() {
        listCountry = resCountries;
        _countryDropdown = listCountry[38];
      });
    });
    _loadingData = APIServices().getBadgesModel();
  }

  void setCountry(dynamic value) {
    setState(() {
      _countryDropdown = value;
      _country = TextEditingController(text: _countryDropdown.name);
    });
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
      title: Text(
        badges.name,
        style: TextStyle(
          fontSize: 12.sp,
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
                color: Colors.grey.shade400,
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
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 160.w,
                      height: 100.h,
                      child: _choicesMainActivity(mainActivity),
                    ),
                  ),
                SizedBox(
                  width: 80.w,
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
                      return const SkeletonText(
                        width: 100,
                        height: 10,
                        radius: 10,
                      );
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
      title: Text(
        badges.name,
        style: TextStyle(fontSize: 12.sp),
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
            padding: const EdgeInsets.all(5),
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

    late List<String> splitAddress;
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    splitAddress = screenArguments['address'];

    preMainActivity = screenArguments['main_badge_id'];
    subActivityId = screenArguments['sub_badge_id'];
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
              child: ExtendedImage.network(
                screenArguments['image_url'],
                fit: BoxFit.cover,
                gaplessPlayback: true,
                width: 100,
                height: 100,
              )),
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
                      FutureBuilder<BadgeModelData>(
                        future: APIServices().getBadgesModelById(
                            screenArguments['main_badge_id']),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            final BadgeModelData badgeData = snapshot.data;
                            final int length = badgeData.badgeDetails.length;
                            return ListTile(
                              onTap: () {},
                              leading: Image.memory(
                                base64.decode(badgeData.badgeDetails[0].imgIcon
                                    .split(',')
                                    .last),
                                gaplessPlayback: true,
                                width: 30,
                                height: 30,
                              ),
                              title: Text(badgeData.badgeDetails[0].name),
                            );
                          }
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const SkeletonText(
                              width: 100,
                              height: 30,
                              radius: 10,
                            );
                          }
                          return Container();
                        },
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
                                        itemCount: subActivityId.length,
                                        itemBuilder:
                                            (BuildContext ctx, int index) {
                                          return FutureBuilder<BadgeModelData>(
                                            future: APIServices()
                                                .getBadgesModelById(
                                                    subActivityId[index]),
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
                                                      const SkeletonText(
                                                        width: 100,
                                                        height: 30,
                                                        radius: 10,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }
                                              return Container();
                                            },
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            )),
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
                      setState(() {
                        if (_isEnabledPackageDescription) {
                          _isEnabledPackageDescription = false;
                        } else {
                          _isEnabledPackageDescription = true;
                        }
                      });
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
                      hintText: screenArguments['name'],
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
                      setState(() {
                        if (_isEnabledNumberofTraveler) {
                          _isEnabledNumberofTraveler = false;
                        } else {
                          _isEnabledNumberofTraveler = true;
                        }
                      });
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
                      hintText: screenArguments['number_of_tourist'].toString(),
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
                  if (_isEnabledLocation)
                    DropDownCountry(
                      value: _countryDropdown,
                      setCountry: setCountry,
                      list: listCountry,
                    )
                  else
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
                      hintText: 'Street: ${splitAddress[0]}',
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
                      hintText: 'State/Province: ${splitAddress[1]}',
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
                      hintText: 'City: ${splitAddress[2]}',
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
                      hintText: 'Postal Code: ${splitAddress[3]}',
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
                      hintText: screenArguments['services'],
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
                          '${AppTextConstants.basePrice}: \$${screenArguments['fee'].toString()}',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: txtStyle,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
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
              padding: const EdgeInsets.all(10),
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

    String mainBadge;
    String subBadges = '';
    String imageByte;

    if (_street.text.isEmpty ||
        _city.text.isEmpty ||
        _province.text.isEmpty ||
        _postalCode.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.locationEmpty)
          .show(context);
    } else {
      setState(() {
        _isSubmit = true;
      });

      if (_isMainActivityEdited) {
        mainBadge = mainActivity.id;
      } else {
        mainBadge = screenArguments['main_badge_id'];
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
        if (subActivityId[0] != '') {
          subBadges = subActivityId[0];
        }
        if (subActivityId[1] != '') {
          subBadges = '$subBadges,${subActivityId[1]}';
        }
        if (subActivityId[2] != '') {
          subBadges = '$subBadges,${subActivityId[2]}';
        }
      }

      /// Save image to firebase
      String coverImgUrl = '';
      if (image1 == null) {
        coverImgUrl = screenArguments['image_url'];
      } else {
        coverImgUrl = await FirebaseServices()
            .uploadImageToFirebase(image1!, _storagePathCoverImg);
      }

      Map<String, dynamic> packageDetails = {
        'user_id': userId,
        'main_badge_id': mainBadge,
        'sub_badge_ids': subBadges,
        'name': _packageName.text,
        'description': _description.text,
        'max_traveller': int.parse(_numberTraveler.text),
        'country': _country.text,
        'address':
            '${_street.text}, ${_city.text}, ${_province.text}, ${_postalCode.text}',
        'services': _services.text,
        'base_price': _price.text,
        'extra_cost_per_person': _extraCost.text,
        'is_published': true,
        'cover_img': '',
        'firebase_cover_img': coverImgUrl
      };

      /// Activity Package Details API
      final dynamic response = await APIServices().request(
          '${AppAPIPath.activityPackagesUrl}/${screenArguments['id']}',
          RequestType.PATCH,
          needAccessToken: true,
          data: packageDetails);

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const MainNavigationScreen(
                    navIndex: 1,
                    contentIndex: 0,
                  )));
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isChecked', isChecked));
  }
}
