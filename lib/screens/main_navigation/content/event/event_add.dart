// ignore_for_file: file_names, unused_element, always_declare_return_types, prefer_const_literals_to_create_immutables, avoid_print, diagnostic_describe_all_properties, curly_braces_in_flow_control_structures, always_specify_types, avoid_dynamic_calls, avoid_redundant_argument_values, avoid_catches_without_on_clauses, unnecessary_lambdas, use_named_constants
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guided/common/widgets/country_dropdown.dart';
import 'package:guided/common/widgets/decimal_text_input_formatter.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/constants/payment_config.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/country_model.dart';
import 'package:guided/models/image_bulk.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/screens/payments/confirm_payment.dart';
import 'package:guided/screens/payments/payment_failed.dart';
import 'package:guided/screens/payments/payment_method.dart';
import 'package:guided/screens/payments/payment_set_date.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/screens/widgets/reusable_widgets/payment_details.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Adding Advertisement Screen
class EventAdd extends StatefulWidget {
  /// Constructor
  const EventAdd({Key? key}) : super(key: key);

  @override
  _EventAddState createState() => _EventAddState();
}

class _EventAddState extends State<EventAdd> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _fee = TextEditingController();
  final TextEditingController _useCurrentLocation = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _feeFocus = FocusNode();
  final FocusNode _useCurrentLocationFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _postalCodeFocus = FocusNode();
  final FocusNode _dateFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  File? image1;
  File? image2;
  File? image3;

  int _uploadCount = 0;
  int count = 0;
  DateTime _selectedDate = DateTime.now();

  bool _enabledImgHolder2 = false;
  bool showLimitNote = false;
  bool showMainActivityChoices = false;
  bool showSubActivityChoices = false;

  Position? _currentPosition;

  dynamic mainActivity;
  dynamic subActivities1;
  dynamic subActivities2;
  dynamic subActivities3;

  String mainActivityTitle = '';
  String subActivities1Txt = '';
  String subActivities2Txt = '';
  String subActivities3Txt = '';
  String _currentAddress = '';
  final List<String> services = ['Transport', 'Breakfast', 'Water', 'Snacks'];
  FocusNode _keywordFocus = FocusNode();
  TextEditingController _keyword = TextEditingController();

  late Future<BadgeModelData> _loadingData;
  late List<CountryModel> listCountry;
  late CountryModel _countryDropdown;
  bool isLocationBtnClicked = false;
  bool _isSubmit = false;
  final String _storagePathEventImg = 'eventImg';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  void initState() {
    super.initState();
    _loadingData = APIServices().getBadgesModel();
    listCountry = <CountryModel>[CountryModel()];
    _countryDropdown = listCountry[0];

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final List<CountryModel> resCountries =
          await APIServices().getCountries();

      setState(() {
        listCountry = resCountries;
        _countryDropdown = listCountry[38];
      });
    });
  }

  void setCountry(dynamic value) {
    setState(() {
      _countryDropdown = value;
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _fee.dispose();
    _useCurrentLocation.dispose();
    _country.dispose();
    _street.dispose();
    _city.dispose();
    _province.dispose();
    _postalCode.dispose();
    _date.dispose();
    _description.dispose();
    super.dispose();
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
              if (mainActivity != null) {
                if (showSubActivityChoices) {
                  showSubActivityChoices = false;
                } else {
                  showSubActivityChoices = true;
                }
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
      title: Text(badges.name,
          style: TextStyle(
            fontSize: 12.sp,
          )),
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
      title: Text(badges.name,
          style: TextStyle(
            fontSize: 12.sp,
          )),
    );
  }

  GridView _gridKeyword() {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      children: List.generate(services.length, (int index) {
        return Padding(
          padding:
              EdgeInsets.only(right: 5.w, left: 5.w, top: 10.h, bottom: 10.h),
          child: Container(
            width: 15.w,
            height: 25.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.grey,
                  spreadRadius: 0.8,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      services[index],
                      style: TextStyle(
                        fontSize: RegExp(r"\w+(\'\w+)?")
                                    .allMatches(services[index])
                                    .length >
                                10
                            ? 10.sp
                            : 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        services.removeAt(index);
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                    ))
              ],
            ),
          ),
        );
      }),
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

    Widget image1Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () => showMaterialModalBottomSheet(
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
                    ],
                  ),
                ))),
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

    Widget image2Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () => _uploadCount == 2

            /// changed to 2 to temporary disable the next image.
            ? showMaterialModalBottomSheet(
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
                                  final XFile? image2 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.camera,
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);

                                  if (image2 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image2.path);
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
                                    this.image2 = imageTemporary;
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
                                  final XFile? image2 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery,
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);
                                  if (image2 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image2.path);
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
                                    this.image2 = imageTemporary;
                                    _uploadCount += 1;
                                    _enabledImgHolder2 = true;
                                  });
                                } on PlatformException catch (e) {
                                  print('Failed to pick image: $e');
                                }
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    )))
            : null,
        child: image2 != null
            ? Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image2!,
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
                            image2 = null;
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

    Widget image3Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () => _uploadCount == 3

            /// changed to 3 to temporary disable the next image.
            ? showMaterialModalBottomSheet(
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
                                  final XFile? image3 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.camera,
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);

                                  if (image3 == null) {
                                    return;
                                  }
                                  final File imageTemporary = File(image3.path);
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
                                    this.image3 = imageTemporary;
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
                                  final XFile? image3 = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery,
                                          maxHeight: 800.h,
                                          maxWidth: 800.w,
                                          imageQuality: 25);

                                  if (image3 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image3.path);
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
                                    this.image3 = imageTemporary;
                                    _uploadCount += 1;
                                  });
                                } on PlatformException catch (e) {
                                  print('Failed to pick image: $e');
                                }
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    )))
            : null,
        child: image3 != null
            ? Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image3!,
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
                            image3 = null;
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
              padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
              child: FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HeaderText.headerText(AppTextConstants.addNewEvent),
                    SizedBox(
                      height: 30.h,
                    ),
                    _mainActivityDropdown(width),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      AppTextConstants.addMultipleSubActivities,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(height: 15.h),
                    _subActivityDropdown(width),
                    SizedBox(height: 15.h),
                    Text(
                      AppTextConstants.uploadImages,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.osloGrey),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        image1Placeholder(context),
                        image2Placeholder(context),
                        image3Placeholder(context)
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    FormBuilderTextField(
                      textAlign: TextAlign.left,
                      controller: _title,
                      focusNode: _titleFocus,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.w),
                        hintText: AppTextConstants.title,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      name: 'title',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    FormBuilderTextField(
                      textAlign: TextAlign.left,
                      controller: _fee,
                      focusNode: _feeFocus,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.w),
                        hintText: AppTextConstants.fee,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      name: 'fee',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
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
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ElevatedButton(
                      onPressed: () => _getCurrentLocation(),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                side: BorderSide(color: AppColors.osloGrey)),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all<double>(0)),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.pin_drop,
                            color: Colors.black,
                          ),
                          if (isLocationBtnClicked)
                            Text(
                              AppTextConstants.removeCurrentLocation,
                              style: const TextStyle(color: Colors.black),
                            )
                          else
                            Text(
                              AppTextConstants.useCurrentLocation,
                              style: const TextStyle(color: Colors.black),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    if (isLocationBtnClicked)
                      TextField(
                        textAlign: TextAlign.left,
                        controller: _country,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10.w),
                          hintText: AppTextConstants.country,
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.2.w),
                          ),
                        ),
                      )
                    else
                      DropDownCountry(
                        value: _countryDropdown,
                        setCountry: setCountry,
                        list: listCountry,
                      ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      controller: _street,
                      focusNode: _streetFocus,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.w),
                        hintText: AppTextConstants.street,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        AppTextConstants.streetHint,
                        style: AppTextStyle.greyStyle,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      textAlign: TextAlign.left,
                      controller: _city,
                      focusNode: _cityFocus,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.w),
                        hintText: AppTextConstants.city,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      textAlign: TextAlign.left,
                      controller: _province,
                      focusNode: _provinceFocus,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.w),
                        hintText: AppTextConstants.provinceState,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      textAlign: TextAlign.left,
                      controller: _postalCode,
                      focusNode: _postalCodeFocus,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.w),
                        hintText: AppTextConstants.postalCode,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () => _showDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          textAlign: TextAlign.left,
                          controller: _date,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10.w),
                            hintText: AppTextConstants.date,
                            hintStyle: TextStyle(
                              color: AppColors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.r),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.2.w),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    FormBuilderTextField(
                      textAlign: TextAlign.left,
                      controller: _description,
                      focusNode: _descriptionFocus,
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.w, top: 20.h),
                        hintText: AppTextConstants.description,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      name: 'description',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextField(
                      textAlign: TextAlign.left,
                      onSubmitted: (text) {
                        if (services.length != 10) {
                          if (text != '') {
                            services.add(text);
                          }
                          setState(() {
                            _keyword.clear();
                            _keywordFocus.requestFocus();
                          });
                        } else {
                          AdvanceSnackBar(
                                  message: ErrorMessageConstants.maximumKeyword)
                              .show(context);
                        }
                      },
                      controller: _keyword,
                      focusNode: _keywordFocus,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.w),
                        hintText: AppTextConstants.addNewService,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.2.w),
                        ),
                      ),
                      maxLength: 20,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    if (services.isNotEmpty)
                      _gridKeyword()
                    else
                      const SizedBox(),
                  ],
                ),
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
          child: LoadingElevatedButton(
            onPressed: () {
              _formKey.currentState?.save();
              if (_formKey.currentState!.validate()) {
                _isSubmit
                    ? null
                    : PaymentConfig.isPaymentEnabled
                        ? handlePayment()
                        : eventsDetail();
              } else {
                print('validation failed');
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.silver,
                ),
                borderRadius: BorderRadius.circular(18.r),
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
              AppTextConstants.createEvent,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
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
      final String formattedDate =
          '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      setState(() {
        _selectedDate = picked;
        _date.value = TextEditingValue(text: formattedDate.toString());
      });
    }
  }

  Future<void> saveImage(String id) async {
    /// Save image to firebase
    String ImgUrl = '';

    ImgUrl = await FirebaseServices()
        .uploadImageToFirebase(image1!, _storagePathEventImg);

    final Map<String, dynamic> image = {
      'activity_event_id': id,
      'snapshot_img': '',
      'firebase_snapshot_img': ImgUrl
    };

    await APIServices().request(AppAPIPath.eventImageUrl, RequestType.POST,
        needAccessToken: true, data: image);
  }

  Future<void> save2Image(String id) async {
    /// Save image to firebase
    String coverImgUrl1 = '';
    String coverImgUrl2 = '';

    coverImgUrl1 = await FirebaseServices()
        .uploadImageToFirebase(image1!, _storagePathEventImg);
    coverImgUrl2 = await FirebaseServices()
        .uploadImageToFirebase(image2!, _storagePathEventImg);

    final EventImageList objImg1 = EventImageList(id: id, img: coverImgUrl1);
    final EventImageList objImg2 = EventImageList(id: id, img: coverImgUrl2);

    final List<EventImageList> list = [objImg1, objImg2];

    final Map<String, List<dynamic>> finalJson = {
      'bulk': encodeToJsonEvent(list)
    };

    await APIServices().request(AppAPIPath.bulkImageUrl, RequestType.POST,
        needAccessToken: true, data: finalJson);
  }

  Future<void> saveBulkImage(String id) async {
    /// Save image to firebase
    String coverImgUrl1 = '';
    String coverImgUrl2 = '';
    String coverImgUrl3 = '';

    coverImgUrl1 = await FirebaseServices()
        .uploadImageToFirebase(image1!, _storagePathEventImg);
    coverImgUrl2 = await FirebaseServices()
        .uploadImageToFirebase(image2!, _storagePathEventImg);
    coverImgUrl3 = await FirebaseServices()
        .uploadImageToFirebase(image3!, _storagePathEventImg);

    final EventImageList objImg1 = EventImageList(id: id, img: coverImgUrl1);
    final EventImageList objImg2 = EventImageList(id: id, img: coverImgUrl2);
    final EventImageList objImg3 = EventImageList(id: id, img: coverImgUrl3);

    final List<EventImageList> list = [objImg1, objImg2, objImg3];

    final Map<String, List<dynamic>> finalJson = {
      'bulk': encodeToJsonEvent(list)
    };

    await APIServices().request(AppAPIPath.bulkImageUrl, RequestType.POST,
        needAccessToken: true, data: finalJson);
  }

  Future<void> eventsDetail(
      {double? price,
      String? serviceName,
      String? transactionNumber,
      String? mode}) async {
    String countryFinal = '';
    String subBadges = '';

    if (isLocationBtnClicked) {
      countryFinal = _country.text;
    } else {
      countryFinal = _countryDropdown.name;
    }

    if (mainActivity == null) {
      AdvanceSnackBar(message: ErrorMessageConstants.mainActivityEmpty)
          .show(context);
    } else if (subActivities1 == null) {
      AdvanceSnackBar(message: ErrorMessageConstants.subActivityEmpty)
          .show(context);
    } else if (image1 == null) {
      AdvanceSnackBar(message: ErrorMessageConstants.eventImageEmpty)
          .show(context);
    } else if (_date.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.dateEmpty).show(context);
    } else if (services.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.serviceEmpty)
          .show(context);
    } else if (_street.text.isEmpty ||
        _city.text.isEmpty ||
        _province.text.isEmpty ||
        _postalCode.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.locationEmpty)
          .show(context);
    } else {
      setState(() {
        _isSubmit = true;
      });

      if (subActivities1 != null) {
        subBadges = subActivities1.id;
      }
      if (subActivities2 != null) {
        subBadges = '$subBadges,${subActivities2.id}';
      }
      if (subActivities3 != null) {
        subBadges = '$subBadges,${subActivities3.id}';
      }

      final String? userId = UserSingleton.instance.user.user!.id;

      final Map<String, dynamic> eventDetails = {
        'user_id': userId,
        'badge_id': mainActivity.id,
        'title': _title.text,
        'free_service': services.join(','),
        'main_activities': mainActivity.name,
        'sub_activities': subBadges,
        'country': countryFinal,
        'address':
            '${_street.text},${_city.text},${_province.text},${_postalCode.text}',
        'description': _description.text,
        'price': double.parse(_fee.text),
        'event_date': _date.text,
        'is_published': true
      };

      final dynamic response = await APIServices().request(
          AppAPIPath.activityEventUrl, RequestType.POST,
          needAccessToken: true, data: eventDetails);

      final String activityOutfitterId = response['id'];
      if (_uploadCount == 1) {
        await saveImage(activityOutfitterId);
      } else if (_uploadCount == 2) {
        await save2Image(activityOutfitterId);
      } else if (_uploadCount == 3) {
        await saveBulkImage(activityOutfitterId);
      }

      if (PaymentConfig.isPaymentEnabled) {
        //Display payment successful when event is created
        await paymentSuccessful(
            context: context,
            onOkBtnPressed: () async {
              int count = 0;
              Navigator.popUntil(context, (route) {
                return count++ == 3;
              });

              await Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const MainNavigationScreen(
                            navIndex: 1,
                            contentIndex: 1,
                          )),
                  (Route<dynamic> route) => false);
            },
            paymentDetails: PaymentDetails(
                serviceName: serviceName!,
                price: price!.toStringAsFixed(2),
                transactionNumber: transactionNumber!),
            paymentMethod: mode!);
      } else {
        await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const MainNavigationScreen(
                      navIndex: 1,
                      contentIndex: 1,
                    )),
            (Route<dynamic> route) => false);
      }
    }
  }

  _getCurrentLocation() {
    Geolocator.checkPermission();
    Geolocator.requestPermission();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];

      setState(() {
        if (isLocationBtnClicked) {
          isLocationBtnClicked = false;
          _currentAddress = '';

          _country = TextEditingController(text: '');
          _postalCode = TextEditingController(text: '');
          _city = TextEditingController(text: '');
          _street = TextEditingController(text: '');
          _province = TextEditingController(text: '');
        } else {
          isLocationBtnClicked = true;
          _currentAddress =
              '${place.locality}, ${place.postalCode}, ${place.country}';

          _country = TextEditingController(text: place.country);
          _postalCode = TextEditingController(text: place.postalCode);
          _city = TextEditingController(text: place.locality);
          _street = TextEditingController(text: place.street);
          _province = TextEditingController(text: place.administrativeArea);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  ///Payment integration
  void handlePayment() {
    paymentSetDate(
        context: context,
        onContinueBtnPressed: (data) {
          paymentMethod(
              context: context,
              onContinueBtnPressed: (paymentData) {
                Navigator.of(context).pop();

                final double price = data['amount'];
                const String serviceName = 'Create Event';

                String mode = '';
                if (paymentData is CardModel) {
                  mode = 'Credit Card';
                } else {
                  mode = Platform.isAndroid ? 'Google Pay' : 'Apple Pay';
                }

                debugPrint('Mode $mode');
                final String transactionNumber =
                    GlobalMixin().generateTransactionNumber();
                confirmPaymentModal(
                    context: context,
                    serviceName: serviceName,
                    paymentMethod: paymentData,
                    paymentMode: mode,
                    price: price,
                    onPaymentSuccessful: () {
                      // API Integration for create event..
                      eventsDetail(
                          price: price,
                          serviceName: serviceName,
                          transactionNumber: transactionNumber,
                          mode: mode);
                    },
                    onPaymentFailed: () {
                      paymentFailed(
                          context: context,
                          paymentDetails: PaymentDetails(
                              serviceName: serviceName,
                              price: price.toStringAsFixed(2),
                              transactionNumber: transactionNumber),
                          paymentMethod: mode);
                    },
                    paymentDetails: PaymentDetails(
                        serviceName: serviceName,
                        price: price.toStringAsFixed(2),
                        transactionNumber: transactionNumber));
              },
              price: data['amount']);
        });
  }
}
