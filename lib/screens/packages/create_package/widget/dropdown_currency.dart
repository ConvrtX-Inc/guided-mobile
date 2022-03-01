import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/currencies_model.dart';

/// Widget for dropdown currency
class DropDownCurrency extends StatelessWidget {
  /// Constructor
  const DropDownCurrency(
      {Key? key, required this.list, required this.value, this.setCurrency})
      : super(key: key);

  final List<Currency> list;
  final Currency value;

  /// fucntion to call for navigation between screens
  final dynamic setCurrency;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppTextConstants.currency,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        SizedBox(height: 5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Currency>(
              value: value,
              isExpanded: true,
              items: list.map((Currency item) {
                return DropdownMenuItem<Currency>(
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: setCurrency,
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.osloGrey),
            ),
          ),
        )
      ],
    );
  }
}
