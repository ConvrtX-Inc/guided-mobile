// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:guided/common/data/option_data.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/common/widgets/simple_text_modal.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';

/// Create Package Screen
class AFewMoreThingsScreen extends StatefulWidget {
  /// Constructor
  const AFewMoreThingsScreen({Key? key}) : super(key: key);

  @override
  _AFewMoreThingsScreenState createState() => _AFewMoreThingsScreenState();
}

class _AFewMoreThingsScreenState extends State<AFewMoreThingsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _allLawyersModals = [
    [
      "Local laws",
      "Your Adventure must comply with all applicable local laws. Make sure to check with your local government to see what's required in your area."
    ],
    [
      "Guiding",
      "Your Adventure must comply with all local tourism laws.  Providing a guided tour service may require licenses, permits, or other permissions.  Be responsible and make sure you check!"
    ],
    [
      "Public lands",
      "Guiding an Adventure in a National or Provincial Park, or any government-controlled lands, may require a license, permits or other permissions. Check first!"
    ],
    [
      "Food",
      "Your experience must follow all local food laws, including any regulations or registration requirements for handling, service, and/or selling food.\n\n When preparing food for your Adventure, it is important that you practice safe food handling .  It is also important that you have the proper knowledge of the foods you are preparing so your Travellers will have a fantastic experience and love every bite.  Don't over-do it, be creative but keep it simple. Take the time to learn new culinary techniques to wow your Travellers again and again.   It's a good idea to ask if any of your Travellers have any food allergies before heading out on your Adventure.  Also, be mindful of the environment; pack out what you pack in! Leave no trace. Bon Appetit!"
    ],
  ].map(
    (l) {
      return OptionData<WidgetBuilder>(
          (context) => ShowTextModal(title: l.first, content: l.last), l.first);
    },
  ).toList();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Continue',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.SUMMARY_1, _formKey.currentState!.value);
      },
      page: 21,
      child: Expanded(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: ListView(
            children: <Widget>[
              HeaderText.headerTextLight("A few more things....."),
              Text(
                'You may be required to have specific licenses, permits or permissions to carry out your Adventure.',
              ),
              const AppSizedBox(h: 20),
              for (final m in _allLawyersModals)
                OutlinedButton(
                  onPressed: () => showFloatingModal(
                    context: context,
                    builder: m.value,
                  ),
                  child: Text(m.label),
                ),
              const AppSizedBox(h: 20),
              FormBuilderCheckbox(
                name: 'accept',
                title: ListTile(
                  title: Text(
                      "By checking this box, I attest that I have read, understand, and agree to comply with each of the application requirements presented above.  I may be required to provide proof if requested by GuidED."),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
