import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';
import 'package:guided/constants/app_colors.dart';

class PackageWidgetLayout extends StatefulWidget {
  final Widget child;
  final String buttonText;
  final VoidCallback onButton;
  final int page;
  final bool disableSpacer;

  const PackageWidgetLayout({
    Key? key,
    required this.buttonText,
    required this.onButton,
    required this.page,
    required this.child,
    this.disableSpacer = false,
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
              CustomPackageCreationAppBar(page: widget.page),
              widget.child,
              if (!widget.disableSpacer) Spacer(),
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

class CustomPackageCreationAppBar extends StatelessWidget {
  final int page;

  const CustomPackageCreationAppBar({Key? key, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButtonWidget(),
        const Spacer(),
        if (page > 0) Text('${page}/21'),
        if (page > 0)
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
    );
  }
}
