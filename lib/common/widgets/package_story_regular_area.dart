import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:guided/common/widgets/modal.dart';
import 'package:guided/constants/app_colors.dart';

class PackageStoryRegularAreaWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(30.w),
        child: FormBuilder(
          onChanged: () {
            _formKey.currentState!.save();
          },
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ModalTitle(title: 'Regulated Areas'),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'Does your experience take a place in a National or Provincial Park, or on Government controlled land?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              FormBuilderRadioGroup(
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                name: 'isRegulated',
                options: ['Yes', 'No']
                    .map((e) => FormBuilderFieldOption(value: e))
                    .toList(),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: width,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() != true) {
                      return;
                    }
                    Navigator.pop(
                        context, _formKey.currentState?.value['isRegulated']);
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
              SizedBox(height: 10.h),
              SizedBox(
                width: width,
                height: 60.h,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
