// ignore_for_file: always_specify_types, cast_nullable_to_non_nullable, unnecessary_raw_strings, curly_braces_in_flow_control_structures, avoid_dynamic_calls, non_constant_identifier_names, unused_element, unnecessary_string_interpolations, avoid_print
import 'dart:convert';
import 'dart:io';
import 'dart:math';
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
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';

/// Edit Outfitter Screen
class OutfitterEdit extends StatefulWidget {
  /// Constructor
  const OutfitterEdit({Key? key}) : super(key: key);

  @override
  _OutfitterEditState createState() => _OutfitterEditState();
}

class _OutfitterEditState extends State<OutfitterEdit>
    with AutomaticKeepAliveClientMixin<OutfitterEdit> {
  @override
  bool get wantKeepAlive => true;
  bool isChecked = false;
  bool _isEnabledTitle = false;
  bool _isEnabledPrice = false;
  bool _isEnabledProductLink = false;
  bool _isEnabledDescription = false;
  bool _isEnabledLocation = false;
  bool _isEnabledCountry = false;
  bool _isEnabledStreet = false;
  bool _isEnabledCity = false;
  bool _isEnabledProvince = false;
  bool _isEnabledPostalCode = false;
  bool _isEnabledDate = false;

  TextEditingController _title = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _productLink = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _date = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _productLinkFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _postalCodeFocus = FocusNode();
  final FocusNode _dateFocus = FocusNode();

  DateTime _selectedDate = DateTime.now();
  final TextStyle txtStyle = TextStyle(fontSize: 14.sp, fontFamily: 'Poppins');
  bool _didClickedImage1 = false;
  bool _didClickedImage2 = false;
  bool _didClickedImage3 = false;
  bool _isEnabledImage = false;
  File? image1;
  File? image2;
  File? image3;
  bool _enabledImgHolder2 = false;
  int _uploadCount = 0;

  String img1Id = '';
  String img2Id = '';
  String img3Id = '';

  bool _isSubmit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      String dir = (await getApplicationDocumentsDirectory()).path;

      final String removedDollar =
          screenArguments['price'].toString().substring(0);

      _title = TextEditingController(text: screenArguments['title']);
      _price = TextEditingController(text: removedDollar);
      _productLink =
          TextEditingController(text: screenArguments['product_link']);
      _description =
          TextEditingController(text: screenArguments['description']);
      _country = TextEditingController(text: screenArguments['country']);
      _street = TextEditingController(text: screenArguments['street']);
      _city = TextEditingController(text: screenArguments['city']);
      _province = TextEditingController(text: screenArguments['province']);
      _postalCode = TextEditingController(text: screenArguments['zip_code']);
      _date = TextEditingController(
          text: screenArguments['availability_date'].toString());
    });
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
    super.build(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Widget image1Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () {
          if (_isEnabledImage) {
            showMaterialModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Color.fromARGB(0, 61, 56, 56),
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
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  fileSize = int.parse(
                                      file.substring(0, file.indexOf('K')));

                                  if (fileSize >= 100) {
                                    AdvanceSnackBar(
                                            message: ErrorMessageConstants
                                                .imageFileToSize)
                                        .show(context);
                                        Navigator.pop(context);
                                    return;
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
                                          imageQuality: 10);

                                  if (image1 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image1.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  fileSize = int.parse(
                                      file.substring(0, file.indexOf('K')));
                                  print('Filesize: $fileSize');
                                  if (fileSize >= 100) {
                                    AdvanceSnackBar(
                                            message: ErrorMessageConstants
                                                .imageFileToSize)
                                        .show(context);
                                        Navigator.pop(context);
                                    return;
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

    Widget image2Placeholder(BuildContext context) {
      return GestureDetector(
        onTap: () => _isEnabledImage
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
                                          imageQuality: 25);

                                  if (image2 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image2.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  fileSize = int.parse(
                                      file.substring(0, file.indexOf('K')));
                                  if (fileSize >= 100) {
                                    AdvanceSnackBar(
                                            message: ErrorMessageConstants
                                                .imageFileToSize)
                                        .show(context);
                                        Navigator.pop(context);
                                    return;
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
                                          imageQuality: 10);
                                  if (image2 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image2.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  fileSize = int.parse(
                                      file.substring(0, file.indexOf('K')));
                                  if (fileSize >= 100) {
                                    AdvanceSnackBar(
                                            message: ErrorMessageConstants
                                                .imageFileToSize)
                                        .show(context);
                                        Navigator.pop(context);
                                    return;
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
        onTap: () => _isEnabledImage
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
                                          imageQuality: 25);

                                  if (image3 == null) {
                                    return;
                                  }
                                  final File imageTemporary = File(image3.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  fileSize = int.parse(
                                      file.substring(0, file.indexOf('K')));
                                  if (fileSize >= 100) {
                                    AdvanceSnackBar(
                                            message: ErrorMessageConstants
                                                .imageFileToSize)
                                        .show(context);
                                        Navigator.pop(context);
                                    return;
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
                                          imageQuality: 10);

                                  if (image3 == null) {
                                    return;
                                  }

                                  final File imageTemporary = File(image3.path);
                                  String file;
                                  int fileSize;
                                  file = getFileSizeString(
                                      bytes: imageTemporary.lengthSync());
                                  fileSize = int.parse(
                                      file.substring(0, file.indexOf('K')));
                                  if (fileSize >= 100) {
                                    AdvanceSnackBar(
                                            message: ErrorMessageConstants
                                                .imageFileToSize)
                                        .show(context);
                                        Navigator.pop(context);
                                    return;
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

    Stack _presetDefault1() {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              base64.decode(screenArguments['image_list'][0].split(',').last),
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
                      _didClickedImage1 = true;
                      img1Id = screenArguments['image_id_list'][0];
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

    Stack _presetDefault2() {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              base64.decode(screenArguments['image_list'][1].split(',').last),
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
                      image2 = null;
                      _uploadCount -= 1;
                      _didClickedImage2 = true;
                      img2Id = screenArguments['image_id_list'][1];
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

    Stack _presetDefault3() {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              base64.decode(screenArguments['image_list'][2].split(',').last),
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
                      image3 = null;
                      _uploadCount -= 1;
                      _didClickedImage3 = true;
                      img3Id = screenArguments['image_id_list'][2];
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

    Row _3rowImage() {
      return Row(
        children: <Widget>[
          if (_didClickedImage1)
            image1Placeholder(context)
          else
            _presetDefault1(),
          if (_didClickedImage2)
            image2Placeholder(context)
          else
            _presetDefault2(),
          if (_didClickedImage3)
            image3Placeholder(context)
          else
            _presetDefault3(),
        ],
      );
    }

    Row _2rowImage() {
      return Row(
        children: <Widget>[
          if (_didClickedImage1)
            image1Placeholder(context)
          else
            _presetDefault1(),
          if (_didClickedImage2)
            image2Placeholder(context)
          else
            _presetDefault2(),
          image3Placeholder(context)
        ],
      );
    }

    Row _1rowImage() {
      return Row(
        children: <Widget>[
          if (_didClickedImage1)
            image1Placeholder(context)
          else
            _presetDefault1(),
          image2Placeholder(context),
          image3Placeholder(context)
        ],
      );
    }

    Row _0rowImage() {
      return Row(
        children: <Widget>[
          image1Placeholder(context),
          image2Placeholder(context),
          image3Placeholder(context)
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: <Widget>[
                        if (screenArguments['image_count'] == 3) _3rowImage(),
                        if (screenArguments['image_count'] == 2) _2rowImage(),
                        if (screenArguments['image_count'] == 1) _1rowImage(),
                        if (screenArguments['image_count'] == 0) _0rowImage(),
                      ],
                    )
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

    /// Product Link card widget
    Card _widgetProductLink() => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      AppTextConstants.productLink,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isEnabledProductLink) {
                            _isEnabledProductLink = false;
                          } else {
                            _isEnabledProductLink = true;
                          }
                        });
                      },
                      child: Text(
                        _isEnabledProductLink
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
                      enabled: _isEnabledProductLink,
                      controller: _productLink,
                      focusNode: _productLinkFocus,
                      decoration: InputDecoration(
                        hintText: screenArguments['product_link'],
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
                        fontWeight: FontWeight.bold,
                      ),
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
                  SizedBox(height: 30.h),
                  _widgetImagesList(),
                  _widgetTitle(),
                  _widgetPrice(),
                  _widgetProductLink(),
                  _widgetDescription(),
                  _widgetLocation(),
                  _widgetProvince(),
                  _widgetPostalCode(),
                  _widgetDate(),
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
            onPressed: () async => _isSubmit ? null : outfitterEditDetail(),
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
                    AppTextConstants.post,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> outfitterEditDetail() async {
    if (_street.text.isEmpty ||
        _city.text.isEmpty ||
        _province.text.isEmpty ||
        _postalCode.text.isEmpty) {
      AdvanceSnackBar(message: ErrorMessageConstants.locationEmpty)
          .show(context);
    } else if (_didClickedImage1) {
      if (image1 == null) {
        AdvanceSnackBar(message: ErrorMessageConstants.outfitterImageEmpty)
            .show(context);
      } else {
        setState(() {
          _isSubmit = true;
        });
        final Map<String, dynamic> screenArguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

        final String? userId = UserSingleton.instance.user.user!.id;

        final Map<String, dynamic> outfitterEditDetails = {
          'title': _title.text,
          'price': double.parse(_price.text),
          'product_link': _productLink.text,
          'country': _country.text,
          'address':
              '${_street.text}, ${_city.text}, ${_province.text}, ${_postalCode.text}, ${_country.text}',
          'street': _street.text,
          'city': _city.text,
          'province': _province.text,
          'zip_code': _postalCode.text,
          'availability_date': _date.text,
          'description': _description.text
        };

        final dynamic response = await APIServices().request(
            '${AppAPIPath.outfitterUrl}/${screenArguments['id']}',
            RequestType.PATCH,
            needAccessToken: true,
            data: outfitterEditDetails);

        _imageUpdate(screenArguments['id'], screenArguments['image_count']);

        await Navigator.pushReplacement(
            context,
            MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const MainNavigationScreen(
                      navIndex: 1,
                      contentIndex: 2,
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

      final String? userId = UserSingleton.instance.user.user!.id;

      final Map<String, dynamic> outfitterEditDetails = {
        'title': _title.text,
        'price': double.parse(_price.text),
        'product_link': _productLink.text,
        'country': _country.text,
        'address':
            '${_street.text}, ${_city.text}, ${_province.text}, ${_postalCode.text}, ${_country.text}',
        'street': _street.text,
        'city': _city.text,
        'province': _province.text,
        'zip_code': _postalCode.text,
        'availability_date': _date.text,
        'description': _description.text
      };

      final dynamic response = await APIServices().request(
          '${AppAPIPath.outfitterUrl}/${screenArguments['id']}',
          RequestType.PATCH,
          needAccessToken: true,
          data: outfitterEditDetails);

      _imageUpdate(screenArguments['id'], screenArguments['image_count']);

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const MainNavigationScreen(
                    navIndex: 1,
                    contentIndex: 2,
                  )));
    }
  }

  void _imageUpdate(String id, int imageCount) {
    if (imageCount == 3) {
      _3image(id);
    }
    if (imageCount == 2) {
      _2image(id);
    }
    if (imageCount == 1) {
      _1image(id);
    }
    if (imageCount == 0) {
      _0image(id);
    }
  }

  Future<void> _3image(String id) async {
    if (_didClickedImage3) {
      if (image3 != null) {
        final Future<Uint8List> image3Bytes = File(image3!.path).readAsBytes();
        final String base64Image3 = base64Encode(await image3Bytes);
        final Map<String, dynamic> img3Details = {
          'activity_outfitter_id': id,
          'snapshot_img': base64Image3
        };
        final dynamic img3response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img3Id', RequestType.PATCH,
            needAccessToken: true, data: img3Details);
      } else {
        /// Delete the outfitter image
        final dynamic img3response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img3Id', RequestType.DELETE,
            needAccessToken: true);
      }
    }
    if (_didClickedImage2) {
      if (image2 != null) {
        final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
        final String base64Image2 = base64Encode(await image2Bytes);
        final Map<String, dynamic> img2Details = {
          'activity_outfitter_id': id,
          'snapshot_img': base64Image2
        };
        final dynamic img2response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img2Id', RequestType.PATCH,
            needAccessToken: true, data: img2Details);
      } else {
        /// Delete the outfitter image
        final dynamic img2response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img2Id', RequestType.DELETE,
            needAccessToken: true);
      }
    }
    if (_didClickedImage1) {
      if (image1 != null) {
        final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
        final String base64Image1 = base64Encode(await image1Bytes);
        final Map<String, dynamic> img1Details = {
          'activity_outfitter_id': id,
          'snapshot_img': base64Image1
        };
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img1Id', RequestType.PATCH,
            needAccessToken: true, data: img1Details);
      } else {
        /// Delete the outfitter image
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img1Id', RequestType.DELETE,
            needAccessToken: true);
      }
    }
  }

  Future<void> _2image(String id) async {
    if (image3 != null) {
      final Future<Uint8List> image3Bytes = File(image3!.path).readAsBytes();
      final String base64Image3 = base64Encode(await image3Bytes);
      final Map<String, dynamic> img3Details = {
        'activity_outfitter_id': id,
        'snapshot_img': base64Image3
      };
      final dynamic img3response = await APIServices().request(
          '${AppAPIPath.outfitterImageUrl}', RequestType.POST,
          needAccessToken: true, data: img3Details);
    }
    if (_didClickedImage2) {
      if (image2 != null) {
        final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
        final String base64Image2 = base64Encode(await image2Bytes);
        final Map<String, dynamic> img2Details = {
          'activity_outfitter_id': id,
          'snapshot_img': base64Image2
        };
        final dynamic img2response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img2Id', RequestType.PATCH,
            needAccessToken: true, data: img2Details);
      } else {
        /// Delete the outfitter image
        final dynamic img2response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img2Id', RequestType.DELETE,
            needAccessToken: true);
      }
    }
    if (_didClickedImage1) {
      if (image1 != null) {
        final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
        final String base64Image1 = base64Encode(await image1Bytes);
        final Map<String, dynamic> img1Details = {
          'activity_outfitter_id': id,
          'snapshot_img': base64Image1
        };
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img1Id', RequestType.PATCH,
            needAccessToken: true, data: img1Details);
      } else {
        /// Delete the outfitter image
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img1Id', RequestType.DELETE,
            needAccessToken: true);
      }
    }
  }

  Future<void> _1image(String id) async {
    if (image3 != null) {
      final Future<Uint8List> image3Bytes = File(image3!.path).readAsBytes();
      final String base64Image3 = base64Encode(await image3Bytes);
      final Map<String, dynamic> img3Details = {
        'activity_outfitter_id': id,
        'snapshot_img': base64Image3
      };
      final dynamic img3response = await APIServices().request(
          '${AppAPIPath.outfitterImageUrl}', RequestType.POST,
          needAccessToken: true, data: img3Details);
    }
    if (image2 != null) {
      final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
      final String base64Image2 = base64Encode(await image2Bytes);
      final Map<String, dynamic> img2Details = {
        'activity_outfitter_id': id,
        'snapshot_img': base64Image2
      };
      final dynamic img2response = await APIServices().request(
          '${AppAPIPath.outfitterImageUrl}', RequestType.POST,
          needAccessToken: true, data: img2Details);
    }
    if (_didClickedImage1) {
      if (image1 != null) {
        final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
        final String base64Image1 = base64Encode(await image1Bytes);
        final Map<String, dynamic> img1Details = {
          'activity_outfitter_id': id,
          'snapshot_img': base64Image1
        };
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img1Id', RequestType.PATCH,
            needAccessToken: true, data: img1Details);
      } else {
        /// Delete the outfitter image
        final dynamic img1response = await APIServices().request(
            '${AppAPIPath.outfitterImageUrl}/$img1Id', RequestType.DELETE,
            needAccessToken: true);
      }
    }
  }

  Future<void> _0image(String id) async {
    if (image3 != null) {
      final Future<Uint8List> image3Bytes = File(image3!.path).readAsBytes();
      final String base64Image3 = base64Encode(await image3Bytes);
      final Map<String, dynamic> img3Details = {
        'activity_outfitter_id': id,
        'snapshot_img': base64Image3
      };
      final dynamic img3response = await APIServices().request(
          '${AppAPIPath.outfitterImageUrl}', RequestType.POST,
          needAccessToken: true, data: img3Details);
    }
    if (image2 != null) {
      final Future<Uint8List> image2Bytes = File(image2!.path).readAsBytes();
      final String base64Image2 = base64Encode(await image2Bytes);
      final Map<String, dynamic> img2Details = {
        'activity_outfitter_id': id,
        'snapshot_img': base64Image2
      };
      final dynamic img2response = await APIServices().request(
          '${AppAPIPath.outfitterImageUrl}', RequestType.POST,
          needAccessToken: true, data: img2Details);
    }
    if (image1 != null) {
      final Future<Uint8List> image1Bytes = File(image1!.path).readAsBytes();
      final String base64Image1 = base64Encode(await image1Bytes);
      final Map<String, dynamic> img1Details = {
        'activity_outfitter_id': id,
        'snapshot_img': base64Image1
      };
      final dynamic img1response = await APIServices().request(
          '${AppAPIPath.outfitterImageUrl}', RequestType.POST,
          needAccessToken: true, data: img1Details);
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
    properties
      ..add(DiagnosticsProperty<bool>('isChecked', isChecked))
      ..add(DiagnosticsProperty<TextStyle>('txtStyle', txtStyle));
  }
}
