import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/badge_model.dart';
import 'package:guided/screens/main_navigation/content/content_main.dart';
import 'package:guided/screens/main_navigation/main_navigation.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widget for home features
class HomeFeatures extends StatefulWidget {
  /// Constructor
  const HomeFeatures({
    String id = '',
    String mainBadgeId = '',
    String subBadgeId = '',
    String description = '',
    String services = '',
    String country = '',
    String address = '',
    String extraCost = '',
    String name = '',
    String imageUrl = '',
    int numberOfTourist = 0,
    double starRating = 0.0,
    double fee = 0.0,
    String dateRange = '',
    bool isPublished = false,
    Key? key,
  })  : _id = id,
        _mainBadgeId = mainBadgeId,
        _subBadgeId = subBadgeId,
        _description = description,
        _services = services,
        _country = country,
        _address = address,
        _extraCost = extraCost,
        _name = name,
        _imageUrl = imageUrl,
        _numberOfTourist = numberOfTourist,
        _fee = fee,
        _starRating = starRating,
        _dateRange = dateRange,
        _isPublished = isPublished,
        super(key: key);
  final String _id;
  final String _mainBadgeId;
  final String _subBadgeId;
  final String _description;
  final String _services;
  final String _country;
  final String _address;
  final String _extraCost;
  final String _name;
  final String _imageUrl;
  final int _numberOfTourist;
  final double _starRating;
  final double _fee;
  final String _dateRange;
  final bool _isPublished;

  @override
  State<HomeFeatures> createState() => _HomeFeaturesState();
}

class _HomeFeaturesState extends State<HomeFeatures>
    with AutomaticKeepAliveClientMixin<HomeFeatures> {
  @override
  bool get wantKeepAlive => true;
  
  bool isDateRangeClicked = false;

  @override
  Widget build(BuildContext context) {
    return widget._isPublished
        ? Container(
            margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
            height: 200,
            width: 290,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: GestureDetector(
                  onTap: () {
                    // navigatePackageDetails(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      base64.decode(
                        widget._imageUrl.split(',').last,
                      ),
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    ),
                  ),
                )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // navigatePackageDetails(context);
                      },
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
                      ),
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
                                  widget._name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Text('${widget._numberOfTourist} Tourists')
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
                                  widget._starRating.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Text(
                                '\$${widget._fee}',
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
                FutureBuilder<BadgeModelData>(
                  future: APIServices().getBadgesModelById(widget._mainBadgeId),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      final BadgeModelData badgeData = snapshot.data;
                      final int length = badgeData.badgeDetails.length;
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.memory(
                              base64.decode(badgeData.badgeDetails[0].imgIcon
                                  .split(',')
                                  .last),
                              gaplessPlayback: true,
                            )
                          ],
                        ),
                      );
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.w,
                            ),
                            const CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                Positioned(
                  top: 10,
                  right: 0,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isDateRangeClicked) {
                              setState(() {
                                isDateRangeClicked = false;
                              });
                            } else {
                              isDateRangeClicked = true;
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.duckEggBlue,
                            border: Border.all(
                              color: AppColors.duckEggBlue,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                AssetsPath.homeFeatureCalendarIcon,
                                height: 15,
                                width: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget._dateRange,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.tropicalRainForest,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            // navigateEditPackageDetails(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            primary: Colors.white, // <-- Button color
                            onPrimary: Colors.grey, // <-- Splash color
                          ),
                          child: Icon(Icons.edit,
                              size: 15, color: AppColors.tropicalRainForest),
                        ),
                      )
                    ],
                  ),
                ),
                if (isDateRangeClicked)
                  Positioned(
                    top: 50,
                    right: 20,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/calendar_availability');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              children: const <Widget>[
                                Text(
                                  'Edit Availability',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(),
              ],
            ))
        : Container();
    // return Container(
    //     margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
    //     height: 250,
    //     width: 290,
    //     child: Stack(
    //       children: <Widget>[
    //         Positioned.fill(
    //             child: ClipRRect(
    //           borderRadius: BorderRadius.circular(8),
    //           child: GestureDetector(
    //             onTap: () {
    //               Navigator.pushReplacement(
    //                   context,
    //                   MaterialPageRoute<dynamic>(
    //                       builder: (BuildContext context) =>
    //                           const MainNavigationScreen(
    //                             navIndex: 1,
    //                             contentIndex: 0,
    //                           )));
    //             },
    //             child: Image.memory(
    //               base64.decode(widget._imageUrl.split(',').last),
    //               gaplessPlayback: true,
    //               width: 20,
    //               height: 20,
    //             ),
    //           ),
    //         )),
    //         Positioned(
    //             bottom: 0,
    //             left: 0,
    //             right: 0,
    //             child: Container(
    //               height: 120,
    //               decoration: BoxDecoration(
    //                   borderRadius: const BorderRadius.only(
    //                     bottomLeft: Radius.circular(8),
    //                     bottomRight: Radius.circular(8),
    //                   ),
    //                   gradient: LinearGradient(
    //                       begin: Alignment.bottomCenter,
    //                       end: Alignment.topCenter,
    //                       colors: <Color>[
    //                         Colors.black.withOpacity(0.5),
    //                         Colors.transparent
    //                       ])),
    //             )),
    //         Positioned(
    //           bottom: 0,
    //           left: 0,
    //           right: 0,
    //           child: Column(
    //             children: <Widget>[
    //               Container(
    //                 decoration: const BoxDecoration(
    //                   color: Colors.white,
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Row(
    //                     children: <Widget>[
    //                       Expanded(
    //                         child: Text(
    //                           widget._name,
    //                           style: const TextStyle(
    //                               fontWeight: FontWeight.w600, fontSize: 14),
    //                         ),
    //                       ),
    //                       Text('${widget._numberOfTourist} Tourists')
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 decoration: const BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.only(
    //                     bottomLeft: Radius.circular(8),
    //                     bottomRight: Radius.circular(8),
    //                   ),
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Row(
    //                     children: <Widget>[
    //                       const Icon(Icons.star_rate, size: 18),
    //                       Expanded(
    //                         child: Text(
    //                           widget._starRating.toString(),
    //                           style: const TextStyle(
    //                               fontWeight: FontWeight.w600, fontSize: 14),
    //                         ),
    //                       ),
    //                       Text(
    //                         '\$${widget._fee}',
    //                         style: const TextStyle(
    //                             fontWeight: FontWeight.w700, fontSize: 14),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Positioned(
    //           left: 15,
    //           top: 70,
    //           child: ClipOval(
    //             child: Container(
    //               color: Colors.white,
    //               padding: const EdgeInsets.all(3),
    //               child: Image.asset(AssetsPath.homeFeatureHikingIcon),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           top: 10,
    //           right: 0,
    //           child: Row(
    //             children: <Widget>[
    //               GestureDetector(
    //                 onTap: () {
    //                   setState(() {
    //                     if (isDateRangeClicked) {
    //                       setState(() {
    //                         isDateRangeClicked = false;
    //                       });
    //                     } else {
    //                       isDateRangeClicked = true;
    //                     }
    //                   });
    //                 },
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     color: AppColors.duckEggBlue,
    //                     border: Border.all(
    //                       color: AppColors.duckEggBlue,
    //                     ),
    //                     borderRadius: BorderRadius.circular(18),
    //                   ),
    //                   padding: const EdgeInsets.symmetric(
    //                       vertical: 5, horizontal: 10),
    //                   child: Row(
    //                     children: <Widget>[
    //                       SvgPicture.asset(
    //                         AssetsPath.homeFeatureCalendarIcon,
    //                         height: 15,
    //                         width: 15,
    //                       ),
    //                       const SizedBox(
    //                         width: 5,
    //                       ),
    //                       Text(
    //                         widget._dateRange,
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.w500,
    //                             color: AppColors.tropicalRainForest,
    //                             fontSize: 12),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: 50,
    //                 height: 30,
    //                 child: ElevatedButton(
    //                   onPressed: () {},
    //                   style: ElevatedButton.styleFrom(
    //                     shape: const CircleBorder(),
    //                     primary: Colors.white, // <-- Button color
    //                     onPrimary: Colors.grey, // <-- Splash color
    //                   ),
    //                   child: Icon(Icons.edit,
    //                       size: 15, color: AppColors.tropicalRainForest),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //         if (isDateRangeClicked)
    //           Positioned(
    //             top: 50,
    //             right: 20,
    //             child: Row(
    //               children: <Widget>[
    //                 GestureDetector(
    //                   onTap: () {
    //                     Navigator.pushNamed(context, '/calendar_availability');
    //                   },
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       border: Border.all(
    //                         color: Colors.white,
    //                       ),
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 5, horizontal: 10),
    //                     child: Row(
    //                       children: const <Widget>[
    //                         Text(
    //                           'Edit Availability',
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.w500,
    //                               color: Colors.black,
    //                               fontSize: 11),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           )
    //         else
    //           Container(),
    //       ],
    //     ));
  }
}
