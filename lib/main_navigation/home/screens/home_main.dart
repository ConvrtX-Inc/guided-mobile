import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guided/common/widgets/name_with_bullet.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/main_navigation/home/widgets/concat_strings.dart';
import 'package:guided/main_navigation/home/widgets/home_earnings.dart';
import 'package:guided/main_navigation/home/widgets/home_features.dart';
import 'package:guided/main_navigation/home/widgets/home_menu_titles.dart';
import 'package:guided/main_navigation/home/widgets/overlapping_avatars.dart';
import 'package:guided/models/home.dart';
import 'package:guided/utils/home.dart';

/// Screen for home
class HomeScreen extends StatefulWidget {
  /// Constructor
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedMenuIndex = 1;
  final double _bulletHeight = 50;
  final double _bulletWidth = 50;
  final Color _bulletColor = ConstantHelpers.tropicalRainForest;

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
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ConstantHelpers.harp,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        HomeMenuTitles(
                            keyNumber: 0,
                            title: 'Packages',
                            isBordered: _selectedMenuIndex == 0 ? true : false,
                            setMenuIndex: setMenuIndexHandler),
                        HomeMenuTitles(
                            keyNumber: 1,
                            title: 'Events',
                            isBordered: _selectedMenuIndex == 1 ? true : false,
                            setMenuIndex: setMenuIndexHandler),
                        HomeMenuTitles(
                            keyNumber: 2,
                            title: 'Outfitters',
                            isBordered: _selectedMenuIndex == 2 ? true : false,
                            setMenuIndex: setMenuIndexHandler),
                        HomeMenuTitles(
                            keyNumber: 3,
                            title: 'My Ads',
                            isBordered: _selectedMenuIndex == 3 ? true : false,
                            setMenuIndex: setMenuIndexHandler),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 270,
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
                                    starRating:
                                        features[index].featureStarRating,
                                    fee: features[index].featureFee);
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
                      padding: const EdgeInsets.only(top: 12),
                      // decoration: BoxDecoration(border: Border.all()),
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ConstantHelpers.platinum),
                          borderRadius: BorderRadius.circular(8),
                          // color: ConstantHelpers.platinum,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  OverlappingAvatars(),
                                  const SizedBox(width: 15),
                                  ConcatStrings()
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Great news! You have got three requests from your clients. Please check these out',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ConstantHelpers.grey),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 9),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: ConstantHelpers.lightningYellow),
                        child: Text(
                            '${customerRequests.length} Pending request',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                MyListWithBullet(
                  text: 'Earnings',
                  width: _bulletWidth,
                  height: _bulletHeight,
                  color: _bulletColor,
                ),
                HomeEarnings()
              ],
            ),
          ),
        ),
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
