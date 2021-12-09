// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/packages/create_package/number_of_traveler_screen.dart';

/// Package info screen
class PackageInfoScreen extends StatefulWidget {

  /// Constructor
  const PackageInfoScreen({Key? key}) : super(key: key);

  @override
  _PackageInfoScreenState createState() => _PackageInfoScreenState();
}

class _PackageInfoScreenState extends State<PackageInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderText.headerText(AppTextConstants.packageNameandDescr),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppTextConstants.packageName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: AppTextConstants.myPackageHint,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.2.w
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: AppTextConstants.description,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.2.w
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppTextConstants.coverPhoto,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    width: width,
                    height: 87,
                    color: AppColors.gallery,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25.w, 20.h, 30.w, 20.h),
                      child: Image.asset(
                        AssetsPath.imagePrey,
                        height: 36.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h
                  ),
                  SizedBox(
                    width: width,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/number_of_traveler');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.silver,
                          ),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        primary: AppColors.primaryGreen,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        AppTextConstants.next,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
