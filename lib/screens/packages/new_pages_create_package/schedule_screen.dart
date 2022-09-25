// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/data/option_data.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/common/widgets/text_flieds.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

import '../../../constants/app_routes.dart';

const _scheduleRepeat = [
  OptionData('d', "Repeat Everyday"),
  OptionData('w', "Repeat Every Week"),
  OptionData('m', "Repeat event every month"),
];

/// Create Package Screen
class ScheduleScreen extends StatefulWidget {
  /// Constructor
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(
            context, AppRoutes.TRAVELLER_PRICING, _formKey.currentState!.value);
      },
      page: 16,
      child: Expanded(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight("Schedule"),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "What day & time will you start your Adventure?",
                style: AppTextStyle.blackStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              _DateInterval(
                title: "Adventure start date & time",
                namePrefix: "start",
              ),
              SizedBox(
                height: 20.h,
              ),
              _DateInterval(
                title: "Adventure end date & time",
                namePrefix: "end",
              ),
              const AppSizedBox(h: 20),
              FormBuilderCheckboxGroup(
                name: 'driving_on_adventure',
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: AppColors.grey,
                  ),
                  enabledBorder: InputBorder.none,
                ),
                options: _scheduleRepeat
                    .map(
                      (e) => FormBuilderFieldOption(
                        value: e.value,
                        child: Text(e.label),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateInterval extends StatelessWidget {
  final String namePrefix;
  final String title;

  const _DateInterval({Key? key, required this.namePrefix, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.blackStyle,
        ),
        const AppSizedBox(h: 10),
        Row(
          children: [
            Expanded(
              child: FormBuilderDateTimePicker(
                name: '${namePrefix}Date',
                decoration: InputDecoration(
                  hintText: 'YYYY/MM/DD',
                  hintStyle: TextStyle(
                    color: AppColors.grey,
                  ),
                  suffixIcon: Icon(Icons.date_range),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(color: Colors.grey, width: 0.2.w),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
