import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/common/widgets/bordered_text_field.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/controller/certificate_controller.dart';
import 'package:guided/controller/profile_photos_controller.dart';
import 'package:guided/controller/user_profile_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/certificate.dart';
import 'package:guided/models/profile_data_model.dart';
import 'package:guided/screens/profile/profile_details/certificate/widget/certificate_card.dart';
import 'package:guided/screens/widgets/reusable_widgets/error_dialog.dart';
import 'package:guided/screens/widgets/reusable_widgets/image_picker_bottom_sheet.dart';
import 'package:guided/utils/services/rest_api_service.dart';

///Certificate Screen
class CertificateScreen extends StatefulWidget {
  ///Constructor
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  bool isForPlanet = false;
  bool isFirstAidCertified = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  List<Certificate> certificates = <Certificate>[];
  bool isLoading = false;

  final CertificateController _certificateController =
      Get.put(CertificateController());

  final UserProfileDetailsController _profileDetailsController =
  Get.put(UserProfileDetailsController());


  @override
  void initState() {
    super.initState();
    getCertificates();
    isForPlanet = _profileDetailsController.userProfileDetails.isForThePlanet!;
    isFirstAidCertified = _profileDetailsController.userProfileDetails.isFirstAidTrained!;
  }

  ///Get Certificates
  Future<void> getCertificates() async {
    final List<Certificate> res = await APIServices().getCertificates();

    debugPrint('Certificate ${res.length}');
    await _certificateController.initCertificates(res);
    setState(() {
      certificates = res;
    });
  }

  Future<void> deleteCertificate(Certificate certificate) async {
    final res = await APIServices().deleteCertificate(certificate.id!);
    debugPrint('Response ${res.statusCode}');

    if (res.statusCode == 200) {
      setState(() {
        certificates.remove(certificate);
      });
       Navigator.of(context).pop();
    }
  }

  Future<void> updateProfileCertificate() async {
    final dynamic editProfileParams = {
      'is_first_aid_trained': isFirstAidCertified,
      'is_for_the_planet': isForPlanet
    };

    final APIStandardReturnFormat res =
    await APIServices().updateProfile(editProfileParams);
    debugPrint('Response:: ${res.status}');

    if (res.status == 'success') {
      final ProfileDetailsModel updatedProfile =
      ProfileDetailsModel.fromJson(json.decode(res.successResponse));
      _profileDetailsController.setUserProfileDetails(updatedProfile);

      setState(() {

      });
    }
  }
  Future<dynamic> showAddCertificateModal(
      {required BuildContext context, required Function onAdded}) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          String _tempImage = '';
          return StatefulBuilder(builder: (context, setState) {
            final TextEditingController _certificateNameController =
                TextEditingController();
            final TextEditingController _descriptionController =
                TextEditingController();
            return SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 26.h,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          AppTextConstants.addCertificate,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Image.asset(
                            '${AssetsPath.assetsPNGPath}/close_btn.png',
                            height: 22.h,
                            width: 22.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BorderedTextField(
                      controller: _certificateNameController,
                      labelText: AppTextConstants.certificateName,
                      hintText: AppTextConstants.certificateName,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BorderedTextField(
                      controller: _descriptionController,
                      labelText: AppTextConstants.description,
                      hintText: AppTextConstants.description,
                      minLines: 8,
                      maxLines: 10,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                        onTap: () =>
                            imagePickerBottomSheet(context, (image) async {
                              final Future<Uint8List> image1Bytes =
                                  File(image.path).readAsBytes();
                              final String base64Image =
                                  base64Encode(await image1Bytes);
                              setState(() {
                                _tempImage = base64Image;
                              });
                              debugPrint('Image ${_tempImage}');
                            }),
                        child: buildUploadCertificate(_tempImage)),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomRoundedButton(
                        title: AppTextConstants.addNewCertificate,
                        onpressed: () {
                          if (_tempImage.isEmpty) {
                            ErrorDialog().showErrorDialog(
                                title: '',
                                message: 'Certificate Image is required',
                                context: context);
                          }
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ));
          });
        });
  }

  Widget buildUploadCertificate(String tempImage) {
    return Container(
      height: 310.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.grey, width: 0.2.w),
          image: tempImage.isNotEmpty
              ? DecorationImage(
                  image: MemoryImage(base64Decode(tempImage)),
                  fit: BoxFit.contain)
              : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: SvgPicture.asset(
                  '${AssetsPath.assetsSVGPath}/upload_camera.svg')),
          SizedBox(height: 20.h),
          if (tempImage.isEmpty)
            Text(
              'Upload Certificate',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.deepGreen),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/svg/arrow_back_with_tail.svg',
              height: 29.h, width: 34.w),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed('/add_certificate'),
          backgroundColor: AppColors.mediumGreen,
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 32, top: 19),
                child: Text(
                  AppTextConstants.certificate,
                  style: TextStyle(
                      fontSize: 24, height: 1.2, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 19, left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        AssetsPath.forThePlanet,
                        height: 37,
                        width: 87,
                      ),
                      trailing: CupertinoSwitch(
                        activeColor: Colors.green,
                        value: isForPlanet,
                        onChanged: (bool value) {
                          setState(() {
                            isForPlanet = value;
                          });
                          updateProfileCertificate();
                        },
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        AppTextConstants.firstAidCertified,
                        style: TextStyle(
                            color: AppColors.firstAidTag,
                            fontSize: 14,
                            height: 1.2,
                            fontFamily: 'Gilroy-Light',
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: CupertinoSwitch(
                        activeColor: Colors.green,
                        value: isFirstAidCertified,
                        onChanged: (bool value) {
                          setState(() {
                            isFirstAidCertified = value;
                          });
                          updateProfileCertificate();
                        },
                      ),
                    ),
                    showCertificateList(),
                    SizedBox(height: 12.h)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showCertificateList() {
    return GetBuilder<CertificateController>(
        builder: (CertificateController _controller) {
          certificates = _controller.certificates;
      return Container(
        padding: EdgeInsets.only(top: 19, left: 16, right: 16),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return CertificateCard(
                certificate: certificates[index],
                onDeletePressed: () {
                  _showRemoveDialog(certificates[index]);
                },
                onEditPressed: () {
                  Navigator.of(context).pushNamed('/edit_certificate',
                      arguments: certificates[index]);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 10.0.h, color: Colors.transparent);
            },
            itemCount: certificates.length),
      );
    });
  }

  void _showRemoveDialog(Certificate certificate) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.r))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset(
                        '${AssetsPath.assetsPNGPath}/close_btn.png',
                        height: 22.h,
                        width: 22.w,
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      AssetsPath.warning,
                      height: 38.h,
                      width: 38.w,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Are you sure, do you want to delete ${certificate.certificateName}?',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              actions: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          deleteCertificate(certificate);
                        },
                        child: Container(
                            width: 75.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.red, width: 1.w),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                                child: Text(
                              'Delete',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w700),
                            ))),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: 75.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.w),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w700),
                            ))),
                      ),
                    ]),
                SizedBox(
                  height: 20.h,
                ),
              ],
            );
          });
        });
  }
}
