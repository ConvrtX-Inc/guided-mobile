import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';

/// Request filter Screen
class RequestFilterScreen extends StatefulWidget {
  /// Constructor
  const RequestFilterScreen({Key? key, this.selectedFilter}) : super(key: key);

  final String? selectedFilter;

  @override
  _RequestFilterScreenState createState() => _RequestFilterScreenState();
}

class _RequestFilterScreenState extends State<RequestFilterScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = AppListConstants.requestFilterList.indexOf(widget.selectedFilter!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: SvgPicture.asset(
                    'assets/images/svg/arrow_back_with_tail.svg',
                    height: 40.h,
                    width: 40.w),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  AppTextConstants.requestFilter,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: AppListConstants.requestFilterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        AppListConstants.requestFilterList[index].toString(),
                        style: TextStyle(
                            color: index == _selectedIndex
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: index == _selectedIndex
                                ? FontWeight.w600
                                : FontWeight.w400),
                      ),
                      trailing: Icon(
                        Icons.check,
                        size: 20.h,
                        color: (index == _selectedIndex)
                            ? Colors.black
                            : Colors.transparent,
                      ),
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });

                        Navigator.pop(context,AppListConstants.requestFilterList[index]);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
