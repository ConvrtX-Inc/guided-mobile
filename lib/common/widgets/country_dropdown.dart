import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/country_model.dart';

/// Widget for Countries dropdown
class DropDownCountry extends StatelessWidget {
  /// Constructor
  const DropDownCountry(
      {required this.list, required this.value, this.setCountry, Key? key})
      : super(key: key);

  /// initialization for list of countries
  final List<CountryModel> list;

  ///initialization for value
  final CountryModel value;

  ///function in setting country
  final dynamic setCountry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.grey.shade400),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CountryModel>(
              value: value,
              isExpanded: true,
              items: list.map((CountryModel item) {
                return DropdownMenuItem<CountryModel>(
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: setCountry,
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.doveGrey),
            ),
          ),
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('setCountry', setCountry))
      ..add(IterableProperty<CountryModel>('list', list))
      ..add(DiagnosticsProperty<CountryModel>('value', value));
  }
}
