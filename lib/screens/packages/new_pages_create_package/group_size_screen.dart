// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

import '../../../constants/app_routes.dart';

/// Create Package Screen
class GroupSizeScreen extends StatefulWidget {
  /// Constructor
  const GroupSizeScreen({Key? key}) : super(key: key);

  @override
  _GroupSizeScreenState createState() => _GroupSizeScreenState();
}

class _GroupSizeScreenState extends State<GroupSizeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.SCHEDULE_SCREEN,
            _formKey.currentState!.value);
      },
      page: 15,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight("Group Size"),
              AppSizedBox(
                h: 20.h,
              ),
              Text("How many Travellers can you accommodate on your Adventure?  Will it be more fun with a large group?  Or is your Adventure more suited for less people?"),
            ],
          ),
        ),
      ),
    );
  }
}
