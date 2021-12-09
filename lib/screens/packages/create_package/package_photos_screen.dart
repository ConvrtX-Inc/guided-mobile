// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/packages/create_package/guide_rules_screen.dart';

/// Package photo screen
class PackagePhotosScreen extends StatefulWidget {

  /// Constructor
  const PackagePhotosScreen({Key? key}) : super(key: key);

  @override
  _PackagePhotosScreenState createState() => _PackagePhotosScreenState();
}

class _PackagePhotosScreenState extends State<PackagePhotosScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    Stack _imagePreview() {
      return Stack(
        children: <Widget>[
          Container(
            width: 100.w,
            height: 87.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.gallery,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.gallery,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    AssetsPath.imagePrey,
                    height: 50.h,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 3.w,
            top: 3.h,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.grey,
              ),
            ),
          )
        ],
      );
    }

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
                  HeaderText.headerText(
                      AppTextConstants.headerUploadPhoto
                  ),
                  SizedBox(
                    height: 30.h
                  ),
                  SubHeaderText.subHeaderText(
                     AppTextConstants.subheaderUploadPhoto
                  ),
                  SizedBox(
                      height: 20.h
                  ),
                  Text(
                    AppTextConstants.destination1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
                  ),
                  SizedBox(
                      height: 20.h
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _imagePreview(),
                      _imagePreview(),
                      _imagePreview(),
                    ],
                  ),
                  SizedBox(
                      height: 20.h
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.placeNameHint,
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
                      height: 20.h
                  ),
                  TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
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
                      height: 20.h
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          AppTextConstants.addNewDescription,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.primaryGreen,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: AppColors.primaryGreen,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 23,
                        ),
                      ),
                      SizedBox(
                          height: 20.h
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/guide_rule');
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
      ),
    );
  }
}
