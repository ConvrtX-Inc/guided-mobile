import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';

/// Notification Screen
class MessageFilterScreen extends StatefulWidget {
  /// Constructor
  const MessageFilterScreen({Key? key}) : super(key: key);

  @override
  _MessageFilterScreenState createState() => _MessageFilterScreenState();
}

class _MessageFilterScreenState extends State<MessageFilterScreen> {
  int _selectedIndex = 0;
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
                  AppTextConstants.messageFilter,
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
                  itemCount: AppListConstants.filterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title:
                          Text(AppListConstants.filterList[index].toString()),
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
