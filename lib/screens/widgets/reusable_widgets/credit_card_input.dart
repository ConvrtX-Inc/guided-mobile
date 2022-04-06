import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/helpers/hexColor.dart';

///Credit card input
class CreditCardAppInput extends StatelessWidget {
  ///Constructor
  const CreditCardAppInput(
      {Key? key,
        String inputTitleText = '',
        String inputPlaceholder = '',
        required inputFormatters,
        required TextEditingController controller,
        bool isCvv = false,
        required Function onSaved,
        required Function onChanged,
        required Function onValidate})
      : _inputFormatters = inputFormatters,
        _controller = controller,
        _inputPlaceHolder = inputPlaceholder,
        _inputTitleText = inputTitleText,
        _isCVV = isCvv,
        _onChanged = onChanged,
        _onValidate = onValidate,
        _onSaved = onSaved,
        super(key: key);

  final String _inputTitleText;
  final String _inputPlaceHolder;
  final Function _onChanged;
  final Function _onSaved;
  final TextInputFormatter _inputFormatters;
  final TextEditingController _controller;
  final bool _isCVV;
  final Function _onValidate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _inputTitleText,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 15, fontFamily: 'Gilroy'),
        ),
        SizedBox(height: 15.h),
        TextFormField(
          controller: _controller,
          onChanged: (String? val) {
            _onChanged(val);
          },
          onSaved: (String? val) {
            _onSaved(val);
          },
          validator: (String? val) {
            return _onValidate(val);
          },
          obscuringCharacter: AppTextConstants.biggerBullet,
          obscureText: _isCVV,
          decoration: InputDecoration(
               filled: true,
              hintText: _inputPlaceHolder,
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
              errorStyle: const TextStyle(fontSize: 10)),
          keyboardType: TextInputType.number,
          inputFormatters: [_inputFormatters],
        )
      ],
    );
  }
}
