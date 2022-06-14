import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';

///Home Button
class AppHomeButton extends StatelessWidget {
  ///Constructor
  const AppHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15.r),
        ),
          boxShadow:   <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
             // changes position of shadow
            ),
          ]
      ),
      child: IconButton(
        onPressed: () => Navigator.of(context).pushReplacementNamed('/traveller_tab'),
        icon: SvgPicture.asset(
          '${AssetsPath.assetsSVGPath}/home_outlined.svg',
        ),
      ),
    );
  }
}

