import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/buttons.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/modal.dart';

final _options = [
  "I will be operating the vehicle",
  "Someone on my team will do the driving",
  "Motorcycle",
  "We provide the vehicle and the Traveller will do the driving",
  "Travellers will be transported by a third-party licensed operator (Taxi, Uber, Shuttle Service, etc)",
];

class VehicleOperatorModal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VehicleOperatorModalState();
  }

  const VehicleOperatorModal();
}

class _VehicleOperatorModalState extends State<VehicleOperatorModal> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(30.w),
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: ListView(
            children: [
              const ModalTitle(
                  title: "Who will operate the vehicle when driving?"),
              const AppSizedBox(h: 10),
              FormBuilderCheckboxGroup(
                name: 'options',
                options: _options
                    .map(
                      (e) => FormBuilderFieldOption(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
              ),
              const AppSizedBox(h: 10),
              SimpleMainButton(
                text: 'Looks Good',
                onPressed: () {
                  if (_formKey.currentState?.validate() != true) {
                    return;
                  }
                  final result = VehicleOperator(_formKey.currentState?.value['options']);
                  Navigator.pop(
                      context, result);
                },
              ),
              const AppSizedBox(h: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class VehicleOperator {
  final List<String> options;

  VehicleOperator(this.options);
}
