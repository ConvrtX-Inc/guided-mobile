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

  List<String> numberOfGuestOptions = ['1', '2', '3', '4',' 5', '6', '7',' 8', '9', '10'];

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
            context, AppRoutes.SCHEDULE_SCREEN, _formKey.currentState!.value);
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
              Text(
                  "How many Travellers can you accommodate on your Adventure?  Will it be more fun with a large group?  Or is your Adventure more suited for less people?"),
              AppSizedBox(h: 20.h),
              Text('Public groups', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              FormBuilderDropdown<String>(
                name: 'numberOfMinGuests',
                decoration: InputDecoration(
                  labelText: 'Minimum group size',
                  suffix: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _formKey.currentState!.fields['numberOfMinGuests']?.reset();
                    },
                  ),
                  hintText: 'Choose a number of guests',
                ),
                items: numberOfGuestOptions
                    .map((numberOption) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: numberOption,
                          child: Text(numberOption),
                        ))
                    .toList(),
              ),
              FormBuilderDropdown<String>(
                name: 'numberOfMaxGuests',
                decoration: InputDecoration(
                  labelText: 'Maximum group size',
                  suffix: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _formKey.currentState!.fields['numberOfMaxGuests']?.reset();
                    },
                  ),
                  hintText: 'Choose a number of guests',
                ),
                items: numberOfGuestOptions
                    .map((numberOption) => DropdownMenuItem(
                  alignment: AlignmentDirectional.center,
                  value: numberOption,
                  child: Text(numberOption),
                ))
                    .toList(),
              ),
              AppSizedBox(h: 30.h,),
              Text(
                  'You can lead whatever group size you wish, but remember Travellers who book may or may not know each other.',
                style: TextStyle(fontSize: 12),
              ),
              AppSizedBox(h: 30.h,),
              ListTile(
                leading: Icon(Icons.info_outlined),
                title: Text(
                    'If you want a private tour, please message your guide directly.',
                    style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
