import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/name_with_bullet.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/home.dart';
import 'package:guided/screens/main_navigation/home/widgets/concat_strings.dart';
import 'package:guided/screens/main_navigation/home/widgets/home_earnings.dart';
import 'package:guided/screens/main_navigation/home/widgets/home_features.dart';
import 'package:guided/screens/main_navigation/home/widgets/overlapping_avatars.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/home.dart';

/// Screen for home
class HomeScreen extends StatefulWidget {
  /// Constructor
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedMenuIndex = 0;
  final double _bulletHeight = 50;
  final double _bulletWidth = 50;
  final Color _bulletColor = AppColors.tropicalRainForest;

  /// Get features items mocked data
  List<HomeModel> features = HomeUtils.getMockFeatures();

  /// Get customer requests mocked data
  List<HomeModel> customerRequests = HomeUtils.getMockCustomerRequests();

  /// Get customer requests mocked data
  List<HomeModel> earnings = HomeUtils.getMockEarnings();

  void setMenuIndexHandler(int value) {
    setState(() {
      _selectedMenuIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppTextConstants.home,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.black,
              fontFamily: 'Gilroy'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2.w)),
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          const MainNavigationScreen(
                                            navIndex: 1,
                                            contentIndex: 0,
                                          )));
                            },
                            child: Text(
                              AppTextConstants.packages,
                              style: AppTextStyle.defaultStyle,
                            ))),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      const MainNavigationScreen(
                                        navIndex: 1,
                                        contentIndex: 1,
                                      )));
                        },
                        child: Text(
                          AppTextConstants.event,
                          style: AppTextStyle.inactive,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      const MainNavigationScreen(
                                        navIndex: 1,
                                        contentIndex: 2,
                                      )));
                        },
                        child: Text(
                          AppTextConstants.outfitter,
                          style: AppTextStyle.inactive,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      const MainNavigationScreen(
                                        navIndex: 1,
                                        contentIndex: 3,
                                      )));
                        },
                        child: Text(
                          AppTextConstants.myads,
                          style: AppTextStyle.inactive,
                        )),
                  ],
                ),
              ),
            ),
            _homeScreenContent(context),
          ],
        ),
      ),
    );
  }

  /// Home Screen Content Screen
  Widget _homeScreenContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.harp,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            height: 270.h,
            child: Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: features.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return HomeFeatures(
                            name: features[index].featureName,
                            imageUrl: features[index].featureImageUrl,
                            numberOfTourist:
                                features[index].featureNumberOfTourists,
                            starRating: features[index].featureStarRating,
                            fee: features[index].featureFee,
                            dateRange: features[index].dateRange,
                          );
                        }))
              ],
            ),
          ),
          MyListWithBullet(
            text: 'Customers Requests',
            width: _bulletWidth,
            height: _bulletHeight,
            color: _bulletColor,
          ),
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 12.h),
                // decoration: BoxDecoration(border: Border.all()),
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.platinum),
                    borderRadius: BorderRadius.circular(8.r),
                    // color: ConstantHelpers.platinum,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            OverlappingAvatars(),
                            SizedBox(width: 15.w),
                            ConcatStrings()
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          AppTextConstants.homeMainHeader,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 9.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: AppColors.lightningYellow),
                  child: Text('${customerRequests.length} Pending request',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          MyListWithBullet(
            text: AppTextConstants.earning,
            width: _bulletWidth,
            height: _bulletHeight,
            color: _bulletColor,
          ),
          HomeEarnings()
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<HomeModel>('features', features));
    properties
        .add(IterableProperty<HomeModel>('customerRequests', customerRequests));
    properties.add(IterableProperty<HomeModel>('earnings', earnings));
  }
}
