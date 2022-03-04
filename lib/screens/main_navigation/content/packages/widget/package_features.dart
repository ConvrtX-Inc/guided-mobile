import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';

/// Widget for home features
class PackageFeatures extends StatelessWidget {
  /// Constructor
  const PackageFeatures({
    String name = '',
    String imageUrl = '',
    int numberOfTourist = 0,
    double starRating = 0.0,
    double fee = 0.0,
    String dateRange = '',
    Key? key,
  })  : _name = name,
        _imageUrl = imageUrl,
        _numberOfTourist = numberOfTourist,
        _fee = fee,
        _starRating = starRating,
        _dateRange = dateRange,
        super(key: key);

  final String _name;
  final String _imageUrl;
  final int _numberOfTourist;
  final double _starRating;
  final double _fee;
  final String _dateRange;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
        height: 200,
        width: 290,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                _imageUrl,
                fit: BoxFit.cover,
              ),
            )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            Colors.black.withOpacity(0.5),
                            Colors.transparent
                          ])),
                )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          Text('$_numberOfTourist Tourists')
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.star_rate, size: 18),
                          Expanded(
                            child: Text(
                              _starRating.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          Text(
                            '\$$_fee',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 15,
              top: 70,
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(3),
                  child: Image.asset(AssetsPath.homeFeatureHikingIcon),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.duckEggBlue,
                      border: Border.all(
                        color: AppColors.duckEggBlue,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          AssetsPath.homeFeatureCalendarIcon,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          _dateRange,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.tropicalRainForest,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        primary: Colors.white, // <-- Button color
                        onPrimary: Colors.grey, // <-- Splash color
                      ),
                      child: Icon(Icons.edit,
                          size: 20, color: AppColors.tropicalRainForest),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}