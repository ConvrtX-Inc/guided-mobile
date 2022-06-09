// ignore_for_file: non_constant_identifier_names, unused_field, prefer_final_fields, cast_nullable_to_non_nullable, prefer_final_locals, always_specify_types, unused_local_variable

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/user_terms_and_condition_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Cancellation Policy Screen
class CancellationPolicy extends StatefulWidget {
  /// Constructor
  const CancellationPolicy({Key? key}) : super(key: key);

  @override
  _CancellationPolicyState createState() => _CancellationPolicyState();
}

class _CancellationPolicyState extends State<CancellationPolicy> {
  bool _isChecked = false;
  bool _btnStatus = true;
  bool _isSubmit = false;
  String _id = '';
  bool _isEnabledEdit = false;
  String _cancellation_policy = '';
  @override
  void initState() {
    super.initState();
    // getTermsAndConditionStatus();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> screenArguments =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      setState(() {
        _cancellation_policy = screenArguments['cancellation_policy'];
      });
    });
  }

  Future<void> getTermsAndConditionStatus() async {
    final List<UsersTermsAndConditionModel> resForm =
    await APIServices().getUsersTermsAndCondition();

    setState(() {
      _btnStatus = resForm[0].is_cancellation_policy;
      _id = resForm[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:  IconButton(
          icon: Image.asset(
            '${AssetsPath.assetsPNGPath}/chevron_back_button.png',
          ),
          iconSize: 44.h,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          AppTextConstants.cancellationPolicy,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: SizedBox(
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Text(
                      _cancellation_policy,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          height: 2,
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
