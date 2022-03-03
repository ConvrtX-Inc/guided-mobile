import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/screens/main_navigation/home/widgets/flutter_expanded_tile.dart';

/// FrequentlyAskQuestion Screen
class FrequentlyAskQuestion extends StatefulWidget {
  /// Constructor
  const FrequentlyAskQuestion({Key? key}) : super(key: key);

  @override
  _FrequentlyAskQuestionState createState() => _FrequentlyAskQuestionState();
}

class _FrequentlyAskQuestionState extends State<FrequentlyAskQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/svg/arrow_back_with_tail.svg',
                  ),
                  iconSize: 44.h,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Text(
                  AppTextConstants.faq,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Text(
                  AppTextConstants.howCanWeHelp,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              ExpandedTileList.builder(
                itemCount: AppListConstants.faqDummyContent.length,
                maxOpened: AppListConstants.faqDummyContent.length,
                itemBuilder: (BuildContext context, int index,
                    ExpandedTileController controller) {
                  return ExpandedTile(
                    theme: const ExpandedTileThemeData(
                      // headerPadding: EdgeInsets.all(24.0),
                      headerColor: Colors.transparent,
                      headerSplashColor: Colors.transparent,
                      contentBackgroundColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(24),
                      // contentRadius: 12.0,
                    ),
                    controller: controller,
                    title: Text(
                      AppListConstants.faqDummyContent[index].title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                    content: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              AppListConstants.faqDummyContent[index].content,
                              style: TextStyle(
                                color: AppColors.dustyGrey,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      debugPrint('tapped!!');
                    },
                    onLongTap: () {
                      debugPrint('looooooooooong tapped!!');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
