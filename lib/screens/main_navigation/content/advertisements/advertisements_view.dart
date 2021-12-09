import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_edit.dart';

/// Advertisement View Screen
class AdvertisementView extends StatefulWidget {

  /// Constructor
  const AdvertisementView({Key? key}) : super(key: key);

  @override
  _AdvertisementViewState createState() => _AdvertisementViewState();
}

class _AdvertisementViewState extends State<AdvertisementView> {

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
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
                            Navigator.of(context).pushNamed('/advertisement_edit');
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
                image: AssetImage(AssetsPath.ads1),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 25.w, top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          AppTextConstants.sportGloves,
                          style: AppTextStyle.txtStyle
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.w, top: 15.h, right: 25.w),
                  child: Text(
                    AppTextConstants.sampleDescr,
                    style: AppTextStyle.descrStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 25.w),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 40.w),
                        child: Text(
                            AppTextConstants.activities,
                            style: AppTextStyle.semiBoldStyle
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.harp,
                          border: Border.all(
                            color: AppColors.harp),
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.r)
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            AppTextConstants.camping,
                            style: TextStyle(color: AppColors.nobel)
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 10.w
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.harp,
                            border: Border.all(
                                color: AppColors.harp),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.r)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                              AppTextConstants.hiking,
                              style: TextStyle(
                                  color: AppColors.nobel
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 10.w
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.harp,
                            border: Border.all(
                                color: AppColors.harp),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.r)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                              AppTextConstants.hunt,
                              style: TextStyle(color: AppColors.nobel)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 25.w),
                  child: Row(
                    children: <Widget>[
                      Text(
                          AppTextConstants.location,
                          style: AppTextStyle.semiBoldStyle
                      ),
                      SizedBox(
                          width: 55.w
                      ),
                      Text(
                        '${AppTextConstants.country} : ${AppTextConstants.canada}',
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
                      SizedBox(
                          width: 105.w
                      ),
                      Text(
                        '${AppTextConstants.street} : ${AppTextConstants.modaca}',
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
                      SizedBox(
                          width: 105.w
                      ),
                      Text(
                        '${AppTextConstants.city} : ${AppTextConstants.tonado}',
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
                      SizedBox(
                          width: 55.w
                      ),
                      Text(
                        AppTextConstants.west,
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
                      SizedBox(
                          width: 75.w
                      ),
                      Text(
                        AppTextConstants.constDate,
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
                      SizedBox(
                          width: 75.w
                      ),
                      Text(
                        AppTextConstants.priceTag,
                        style: AppTextStyle.greyStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
