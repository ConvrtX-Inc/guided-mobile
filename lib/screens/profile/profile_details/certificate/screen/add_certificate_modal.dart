import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
import 'package:guided/models/certificate.dart';
import 'package:guided/screens/widgets/reusable_widgets/error_dialog.dart';
import 'package:guided/screens/widgets/reusable_widgets/image_picker_bottom_sheet.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:guided/utils/services/rest_api_service.dart';

///Add Certificate
class AddCertificate extends StatefulWidget {
  ///Constructor
  const AddCertificate({Key? key}) : super(key: key);

  @override
  _AddCertificateState createState() => _AddCertificateState();
}

class _AddCertificateState extends State<AddCertificate> {
  String _tempImage = '';
  final TextEditingController _certificateNameController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _addCertificateFormKey =
      new GlobalKey<FormState>();
  File? _photo;
  bool isLoading = false;

  final CertificateController _certificateController =
  Get.put(CertificateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Form(
          key: _addCertificateFormKey,
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
                  onValidate: (String val) {
                    if (val.trim().isEmpty) {
                      return '${AppTextConstants.certificateName} is required';
                    }
                    return null;
                  },
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
                  onValidate: (String val) {
                    if (val.trim().isEmpty) {
                      return '${AppTextConstants.description} is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                    onTap: () => imagePickerBottomSheet(context, (image) async {
                          final Future<Uint8List> image1Bytes =
                              File(image.path).readAsBytes();
                          final String base64Image =
                              base64Encode(await image1Bytes);
                          setState(() {
                            _tempImage = base64Image;
                            _photo = image;
                          });
                          debugPrint('Image ${_tempImage}');
                        }),
                    child: buildUploadCertificate()),
                SizedBox(
                  height: 20.h,
                ),
                CustomRoundedButton(
                    title: AppTextConstants.addNewCertificate,
                    isLoading: isLoading,
                    onpressed: () {
                      if (validateAndSave()) {
                        if (_tempImage.isEmpty) {
                          ErrorDialog().showErrorDialog(
                              title: '',
                              message: 'Certificate Image is required',
                              context: context);
                          return;
                        }

                        addCertificate();
                      }
                    }),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget buildUploadCertificate() {
    return Container(
      height: 310.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.grey, width: 0.2.w),
          image: _tempImage.isNotEmpty
              ? DecorationImage(
                  image: MemoryImage(base64Decode(_tempImage)),
                  fit: BoxFit.contain)
              : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: SvgPicture.asset(
                  '${AssetsPath.assetsSVGPath}/upload_camera.svg')),
          SizedBox(height: 20.h),
          if (_tempImage.isEmpty)
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

  bool validateAndSave() {
    final FormState? form = _addCertificateFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> addCertificate() async {
    setState(() {
      isLoading = true;
    });
    debugPrint(
        'data ${_certificateNameController.text} ${_descriptionController.text}');
    String firebaseUrl = '';
    if (_photo != null) {
      firebaseUrl = await FirebaseServices()
          .uploadImageToFirebase(_photo!, '/certificates');
    }

    final Certificate params = Certificate(
        certificateName: _certificateNameController.text,
        certificateDescription: _descriptionController.text,
        certificatePhotoFirebaseUrl: firebaseUrl);
    final Certificate res = await APIServices().addCertificate(params);
    if (res.id != null) {
      debugPrint('Response ${res.id}');
      setState(() {
        isLoading = false;
      });

      _certificateController.addCertificate(res);
      Navigator.of(context).pop();
    }
  }
}
