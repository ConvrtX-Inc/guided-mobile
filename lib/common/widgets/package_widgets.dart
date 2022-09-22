import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';
import 'package:guided/constants/app_colors.dart';

class PackageWidgetLayout extends StatefulWidget {
  final Widget child;
  final String buttonText;
  final VoidCallback onButton;
  final int page;

  const PackageWidgetLayout({
    Key? key,
    required this.buttonText,
    required this.onButton,
    required this.child,
    required this.page,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PackageWidgetLayoutState();
}

class _PackageWidgetLayoutState extends State<PackageWidgetLayout> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackButtonWidget(),
                  const Spacer(),
                  Text('${widget.page}/21'),
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      //TODO
                      print('Open menu');
                    },
                  )
                ],
              ),
              widget.child,
              Spacer(),
              SizedBox(
                width: width,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: widget.onButton,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.silver),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    primary: AppColors.primaryGreen,
                    onPrimary: Colors.white,
                  ),
                  child: Text(
                    widget.buttonText,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
