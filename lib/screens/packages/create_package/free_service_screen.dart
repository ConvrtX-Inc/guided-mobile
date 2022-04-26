// ignore_for_file: file_names, always_specify_types, non_constant_identifier_names, unnecessary_lambdas, prefer_final_fields, cast_nullable_to_non_nullable, avoid_dynamic_calls

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'dart:convert';

/// Free Service Screen
class FreeServicesScreen extends StatefulWidget {
  /// Constructor
  const FreeServicesScreen({Key? key}) : super(key: key);

  @override
  _FreeServicesScreenState createState() => _FreeServicesScreenState();
}

class _FreeServicesScreenState extends State<FreeServicesScreen> {
  final List<String> services = ['Transport', 'Breakfast', 'Water', 'Snacks'];

  FocusNode _keywordFocus = FocusNode();
  TextEditingController _keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.serviceHeader),
                  SizedBox(
                    height: 30.h,
                  ),
                  SubHeaderText.subHeaderText(AppTextConstants.subHeader),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
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
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
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
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      AppTextConstants.maximumKeyword,
                      style: TextStyle(
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (services.isNotEmpty) _gridKeyword() else const SizedBox(),
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
          child: ElevatedButton(
            onPressed: () =>
                navigatePackagePhotoScreen(context, screenArguments),
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
            child: Text(
              AppTextConstants.next,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
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
              EdgeInsets.only(right: 5.w, left: 5.w, top: 5.h, bottom: 5.h),
          child: Container(
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
                    padding: const EdgeInsets.all(5),
                    child: SingleChildScrollView(
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

  Future<void> navigatePackagePhotoScreen(
      BuildContext context, Map<String, dynamic> data) async {
    final Map<String, dynamic> details = Map<String, dynamic>.from(data);

    details['services'] = services;
    details['services_length'] = services.length.toString();

    await Navigator.pushNamed(context, '/package_photo', arguments: details);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<String>('services', services))
      ..add(DiagnosticsProperty<FocusNode>('keywordFocus', _keywordFocus));
  }
}
