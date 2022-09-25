// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:guided/common/widgets/duration_picker.dart';
import 'package:guided/common/widgets/modal.dart';
import 'package:guided/common/widgets/package_story_example.dart';
import 'package:guided/common/widgets/package_story_regular_area.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/common/widgets/text_flieds.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants/app_routes.dart';

/// Create Package Screen
class DescribeYourAdventureScreen extends StatefulWidget {
  /// Constructor
  const DescribeYourAdventureScreen({Key? key}) : super(key: key);

  @override
  _DescribeYourAdventureScreenState createState() =>
      _DescribeYourAdventureScreenState();
}

class _DescribeYourAdventureScreenState
    extends State<DescribeYourAdventureScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Continue',
      onButton: () async {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        final result = await showCustomModalBottomSheet(
          context: context,
          builder: (context) => PackageStoryRegularAreaWidget(),
          containerWidget: (_, animation, child) => FloatingModal(
            child: child,
          ),
          expand: true,
        );
        print('result $result');
        if (!(result is String)) {
          return;
        }
        final state = <dynamic, dynamic>{'isRegulated': result}..addAll(_formKey.currentState!.value);
        navigateTo(context, AppRoutes.TELL_TRAVELLERS_AND_US_MORE_ABOUT_YOU, state);
      },
      page: 7,
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight('Describe your Adventure'),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'What will you and your Travellers do?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ListTile(
                dense: true,
                title: Text(
                    "Make your plans clear from start to finish, don't be confusing or jump all over the place"),
                leading: Icon(Icons.fiber_manual_record, size: 16),
                minLeadingWidth: 12,
                style: ListTileStyle.list,
              ),
              ListTile(
                dense: true,
                title: Text(
                    "Tell them what makes your Adventure so awesome, something that Travellers wouldn't do on their own"),
                leading: Icon(Icons.fiber_manual_record, size: 16),
                minLeadingWidth: 12,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                name: 'story',
                hintText:
                    "Tell the story of what they will do on your Adventure.",
                maxLines: 6,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () => showCustomModalBottomSheet(
                  context: context,
                  builder: (context) => PackageStoryExampleWidget(),
                  containerWidget: (_, animation, child) => FloatingModal(
                    child: child,
                  ),
                  expand: true,
                ),
                child: Text(
                  'Show examples',
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'GilRoy',
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                label: 'How long is your Adventure?',
                name: 'duration',
                hintText: "Duration",
                onTap: () async {
                  final result = await showCustomModalBottomSheet(
                    context: context,
                    builder: (context) => DurationModal(),
                    containerWidget: (_, animation, child) => FloatingModal(
                      child: child,
                    ),
                    expand: true,
                  );
                  if (result is String) {
                    _formKey.currentState!.fields['duration']!.didChange(result);
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              AppTextField(
                name: 'customDuration',
                hintText: "Add custom",
                maxLines: 6,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                label: 'Location Description',
                subLabel: 'Optional',
                name: 'locationDescription',
                hintText: "Description",
                maxLines: 6,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
