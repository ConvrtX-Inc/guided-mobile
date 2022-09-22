import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:guided/common/widgets/modal.dart';
import 'package:guided/common/widgets/text_flieds.dart';
import 'package:guided/constants/app_colors.dart';

class ConfirmMeetingPointModal extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(30.w),
            child: Column(
              children: [
                const ModalTitle(title: 'Confirm Meeting Point Address'),
                SizedBox(height: 20.h),
                Expanded(child: ListView(children: [AppTextField(
                  name: 'street',
                  hintText: 'Street Address',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    name: 'suite',
                    hintText: 'Apt, Suite, Bldg(Optional)',
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    name: 'city',
                    hintText: 'City',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    name: 'state',
                    hintText: 'State',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    name: 'zip',
                    hintText: 'Postal Code',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    name: 'country',
                    hintText: 'Country',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  SizedBox(height: 10.h),
                  const Text(
                    'We will only share this address with Traveller who are booked with you',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GilRoy',
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  AppTextField(
                    name: 'pointName',
                    hintText: 'Meeting point name (optional)',
                  ),],),),
                SizedBox(height: 20.h),
                SizedBox(
                  width: width,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() != true) {
                        return;
                      }

                      Navigator.pop(context, _formKey.currentState?.value);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.silver),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      primary: AppColors.primaryGreen,
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      'Save',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
