import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_edit.dart';

/// Outfitter View Screen
class OutfitterView extends StatefulWidget {
  /// Constructor
  const OutfitterView({Key? key}) : super(key: key);

  @override
  _OutfitterViewState createState() => _OutfitterViewState();
}

class _OutfitterViewState extends State<OutfitterView> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> screenArguments =
        // ignore: cast_nullable_to_non_nullable
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Transform.scale(
            scale: 0.8,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                width: 40.w,
                height: 40.h,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: AppColors.harp,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.black,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              /// Share Icon
              Transform.scale(
                scale: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AppColors.harp,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),

              /// Edit Icon
              Transform.scale(
                scale: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AppColors.harp,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/outfitter_edit');
                      },
                    ),
                  ),
                ),
              ),

              /// Delete icon
              Transform.scale(
                scale: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AppColors.harp,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          flexibleSpace: Image(
            image: AssetImage(AssetsPath.vest1),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(screenArguments['title'], style: AppTextStyle.txtStyle),
                  Text(
                    screenArguments['price'],
                    style: AppTextStyle.txtStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: Row(
                children: <Widget>[
                  Text(
                    AppTextConstants.companyName,
                    style: AppTextStyle.semiBoldStyle,
                  ),
                  SizedBox(width: 15.w),
                  Text(AppTextConstants.visitOurStore,
                      style: AppTextStyle.underlinedLinkStyle),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w, top: 15.h, right: 25.w),
              child: Text(
                screenArguments['description'],
                style: AppTextStyle.descrStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  Text(AppTextConstants.productLink,
                      style: AppTextStyle.semiBoldStyle),
                  SizedBox(width: 35.w),
                  Text(
                    screenArguments['product_link'],
                    style: AppTextStyle.greyStyle,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  Text(AppTextConstants.location,
                      style: AppTextStyle.semiBoldStyle),
                  SizedBox(width: 55.w),
                  Text(
                    '${AppTextConstants.country} : ${screenArguments['country']}',
                    style: AppTextStyle.greyStyle,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  const Text(''),
                  SizedBox(width: 105.w),
                  Text(
                    '${AppTextConstants.street} : ${screenArguments['address']}',
                    style: AppTextStyle.greyStyle,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  const Text(''),
                  SizedBox(width: 105.w),
                  Text(
                    '${AppTextConstants.city} : ${screenArguments['address']}',
                    style: AppTextStyle.greyStyle,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  Text(
                    AppTextConstants.province,
                    style: AppTextStyle.semiBoldStyle,
                  ),
                  SizedBox(width: 60.w),
                  Text(
                    screenArguments['address'],
                    style: AppTextStyle.greyStyle,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  Text(
                    AppTextConstants.date,
                    style: AppTextStyle.semiBoldStyle,
                  ),
                  SizedBox(width: 80.w),
                  Text(
                    screenArguments['date'],
                    style: AppTextStyle.greyStyle,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 25.w),
              child: Row(
                children: <Widget>[
                  Text(
                    AppTextConstants.price,
                    style: AppTextStyle.semiBoldStyle,
                  ),
                  SizedBox(width: 80.w),
                  Text(
                    'USD ${screenArguments['price'].toString().substring(1, 6)}',
                    style: AppTextStyle.greyStyle,
                  )
                ],
              ),
            ),
            SizedBox(height: 50.w),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () {},
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
                    AppTextConstants.visitShop,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
