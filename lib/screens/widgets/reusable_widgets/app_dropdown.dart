import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';

/// Global widget for app dropdown
class DropdownAppDropdown extends StatelessWidget {
  /// Constructor
  const DropdownAppDropdown(
      {required List<String> items,
      String value = '',
      String inputTitleText = '',
      required this.onChange,
      Key? key})
      : _value = value,
        _items = items,
        _inputTitleText = inputTitleText,
        super(key: key);

  final String _value;
  final List<String> _items;
  final String _inputTitleText;
  final dynamic onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _inputTitleText,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        SizedBox(height: 5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 2.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.novel,
            ),
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.transparent,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                value: _value,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppColors.novel),
                items: _items.map(buildMenuItem).toList(),
                onChanged: onChange),
          ),
        )
      ],
    );
  }

  /// Add item of the dropdown
  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem<String>(value: item, child: Text(item));
}
