import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/widgets/reusable_widgets/app_calendar_picker.dart';
import 'package:guided/screens/widgets/reusable_widgets/app_dropdown.dart';

/// Notification Screen
class MessageCustomOffer extends StatefulWidget {
  /// Constructor
  const MessageCustomOffer({Key? key}) : super(key: key);

  @override
  _MessageCustomOfferState createState() => _MessageCustomOfferState();
}

class _MessageCustomOfferState extends State<MessageCustomOffer> {
  /// Get no of kids list
  final List<String> _packages = AppListConstants.packages;
  DateTime _selectedDate = DateTime.now();
  String _selectedPackage = 'Basic';
  String _selectedNumberOfPeople = '1';
  String _selectedCurrency = 'CAD';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                child: IconButton(
                  icon: SvgPicture.asset(
                      'assets/images/svg/arrow_back_with_tail.svg',
                      height: 40.h,
                      width: 40.w),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: const Text(
                  'Custom Offer',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Select a package',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    DropdownAppDropdown(
                      value: _selectedPackage,
                      inputTitleText: 'Select package',
                      items: _packages,
                      onChange: (val) {
                        setState(() {
                          _selectedPackage = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 108.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.novel,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 25.w, top: 25.h, bottom: 20.h, right: 20.w),
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Description about the custom package',
                            hintStyle: TextStyle(
                                fontSize: 12.sp, color: AppColors.novel),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Number of People',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    DropdownAppDropdown(
                      value: _selectedNumberOfPeople,
                      inputTitleText: 'Number of People',
                      items: AppListConstants.people,
                      onChange: (val) {
                        setState(() {
                          _selectedNumberOfPeople = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Set date',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    CalendarAppCalendar(
                      date: _selectedDate,
                      titleText: 'YYYY.MM.DD',
                      onChangeDate: (date) {
                        setState(() {
                          _selectedDate = DateTime.parse(date);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Price',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.novel,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 23.w, top: 23.h, bottom: 20.h, right: 20.w),
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: 'Price',
                            hintStyle: TextStyle(
                                fontSize: 12.sp, color: AppColors.novel),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Currency',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    DropdownAppDropdown(
                      value: _selectedCurrency,
                      inputTitleText: 'Currency',
                      items: AppListConstants.currency,
                      onChange: (val) {
                        setState(() {
                          _selectedCurrency = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 119.h,
                    ),
                    TextButton(
                      onPressed: null,
                      child: Container(
                        width: 315.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: AppColors.deepGreen,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Send offer',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
