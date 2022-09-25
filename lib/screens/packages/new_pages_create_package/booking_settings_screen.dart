// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

/// Create Package Screen
class BookingSettingsScreen extends StatefulWidget {
  /// Constructor
  const BookingSettingsScreen({Key? key}) : super(key: key);

  @override
  _BookingSettingsScreenState createState() => _BookingSettingsScreenState();
}

class _BookingSettingsScreenState extends State<BookingSettingsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  List<String> numberOfGuestOptions = ['1', '2', '3', '4',' 5'];

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      disableSpacer: true,
      buttonText: 'Next',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.GUIDED_CANCELLATION_POLICY,
            _formKey.currentState!.value);
      },
      page: 19,
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Expanded(
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight("Booking Settings"),
              AppSizedBox(h: 20),
              Text(
                "Think about how much time you need to prepare for your Adventure.  If you have lots to prepare, and need more time, we recommend setting a longer cut off time.  If you are ready to go and don't have much to prepare, then go shorter.",
                style: TextStyle(fontSize: 16),
              ),
              AppSizedBox(h: 40),
              Text(
                "Cutoff time",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "If an Adventure is booked, this is how much time you need to prepare.",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              FormBuilderDropdown<String>(
                name: 'cutoffTime',
                decoration: InputDecoration(
                  labelText: 'Choose a cutoff time',
                  suffix: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _formKey.currentState!.fields['cutoffTime']?.reset();
                    },
                  ),
                  hintText: 'Choose a cutoff time',
                ),
                items: numberOfGuestOptions
                    .map((numberOption) => DropdownMenuItem(
                  alignment: AlignmentDirectional.center,
                  value: numberOption,
                  child: Text(numberOption + " hour(s) before start time"),
                ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
