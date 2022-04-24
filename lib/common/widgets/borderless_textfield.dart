import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guided/helpers/hexColor.dart';

/// Custom Textfield without border
class BorderlessTextField extends StatelessWidget {
  /// Constructor
  const BorderlessTextField(
      {required this.title,
      Key? key,
      this.hint,
      this.onChanged,
      this.description,
      this.controller,
      this.onSaved,
      this.onValidate,
      this.textInputType = TextInputType.text
      })
      : super(key: key);

  /// Title of the textfield
  final String title;

  /// Textfield hint text
  final String? hint;

  /// This textfield controller
  final TextEditingController? controller;

  /// The onchange function with string value parameter
  final Function(String)? onChanged;

  /// The onSaved function with string value parameter
  final Function? onSaved;

  /// The onValidate function with string value parameter
  final Function? onValidate;

  /// This textfield description
  final String? description;

  ///Text input type
  final TextInputType  textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 15, fontFamily: 'Gilroy'),
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              description!,
              style: const TextStyle(
                  fontWeight: FontWeight.normal, fontSize: 12.5),
            ),
          )
        else
          const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          keyboardType: textInputType,

          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          onChanged: onChanged,
          // onSaved: onSaved,
          validator: (String? val) {
            if(onValidate != null){
              return onValidate!(val);
            }
          },
          onSaved: (String? val) {
            if(onSaved != null){
              return onSaved!(val);
            }

          },

          decoration: InputDecoration(
              filled: true,
              hintText: hint,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.normal),
              fillColor: HexColor('#F2F2F2'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                // ignore: use_named_constants
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
          errorStyle: const TextStyle(fontSize: 10)

          ),
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('hint', hint))
      ..add(
          DiagnosticsProperty<TextEditingController?>('controller', controller))
      ..add(ObjectFlagProperty<Function(String p1)>.has('onChanged', onChanged))
      ..add(StringProperty('description', description));
  }
}
