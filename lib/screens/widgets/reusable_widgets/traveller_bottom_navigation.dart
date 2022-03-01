// ignore_for_file: public_member_api_docs, diagnostic_describe_all_properties, sort_constructors_first

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:io' show Platform;

/// Traveller Bottom Navigation
class TravellerBottomNavigation extends StatelessWidget {
  final List<String> itemIcons;
  final String centerIcon;
  final String centerIconSelected;
  final int selectedIndex;
  final Function(int) onItemPressed;
  final double? height;
  final Color selectedColor;
  final Color selectedLightColor;
  final Color unselectedColor;

  ///Constructor
  const TravellerBottomNavigation({
    Key? key,
    required this.itemIcons,
    required this.centerIcon,
    required this.centerIconSelected,
    required this.selectedIndex,
    required this.onItemPressed,
    this.height,
    this.selectedColor = const Color(0xff066028),
    this.unselectedColor = const Color(0xff979B9B),
    this.selectedLightColor = const Color(0xff77E2FE),
  })  : assert(itemIcons.length == 4 || itemIcons.length == 2,
            "Item must equal 4 or 2"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    final height = this.height ?? getRelativeHeight(0.076);

    return SizedBox(
      height: height + getRelativeHeight(0.025),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height,
              color: Colors.white,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getRelativeWidth(0.02)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: itemIcons.length == 4
                            ? MainAxisAlignment.spaceAround
                            : MainAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: selectedColor.withOpacity(0.5),
                              onTap: () {
                                onItemPressed(0);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.asset(
                                      itemIcons[0],
                                      height: 30.0,
                                      width: 30.0,
                                      color: selectedIndex == 0
                                          ? selectedColor
                                          : unselectedColor,
                                    ),
                                    // child: Icon(
                                    //   itemIcons[0],
                                    //   color: selectedIndex == 0
                                    //       ? selectedColor
                                    //       : unselectedColor,
                                    // ),
                                  ),
                                  Text(
                                    'Discovery Hub',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: selectedIndex == 0
                                          ? selectedColor
                                          : unselectedColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (itemIcons.length == 4)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  customBorder: const CircleBorder(),
                                  splashColor: selectedColor.withOpacity(0.5),
                                  onTap: () {
                                    onItemPressed(1);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.asset(
                                          itemIcons[1],
                                          height: 30.0,
                                          width: 30.0,
                                          color: selectedIndex == 1
                                              ? selectedColor
                                              : unselectedColor,
                                        ),
                                        // child: Icon(
                                        //   itemIcons[1],
                                        //   color: selectedIndex == 1
                                        //       ? selectedColor
                                        //       : unselectedColor,
                                        // ),
                                      ),
                                      Text(
                                        'Wishlist',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: selectedIndex == 1
                                              ? selectedColor
                                              : unselectedColor,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: itemIcons.length == 4
                            ? MainAxisAlignment.spaceAround
                            : MainAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                                customBorder: const CircleBorder(),
                                splashColor: selectedColor.withOpacity(0.5),
                                onTap: () {
                                  onItemPressed(itemIcons.length == 4 ? 3 : 2);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      // child: Icon(
                                      //   itemIcons[itemIcons.length == 4 ? 2 : 1],
                                      //   color: selectedIndex ==
                                      //           (itemIcons.length == 4 ? 3 : 2)
                                      //       ? selectedColor
                                      //       : unselectedColor,
                                      // ),
                                      child: Image.asset(
                                        itemIcons[
                                            itemIcons.length == 4 ? 2 : 1],
                                        height: 30.0,
                                        width: 30.0,
                                        color: selectedIndex ==
                                                (itemIcons.length == 4 ? 3 : 2)
                                            ? selectedColor
                                            : unselectedColor,
                                      ),
                                    ),
                                    Text(
                                      'Inbox',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: selectedIndex == 3
                                            ? selectedColor
                                            : unselectedColor,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          if (itemIcons.length == 4)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  customBorder: const CircleBorder(),
                                  splashColor: selectedColor.withOpacity(0.5),
                                  onTap: () {
                                    onItemPressed(4);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        // child: Icon(
                                        //   itemIcons[3],
                                        //   color: selectedIndex == 4
                                        //       ? selectedColor
                                        //       : unselectedColor,
                                        child: Image.asset(
                                          itemIcons[3],
                                          height: 30.0,
                                          width: 30.0,
                                          color: selectedIndex == 4
                                              ? selectedColor
                                              : unselectedColor,
                                        ),
                                      ),
                                      Text(
                                        'Profile',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: selectedIndex == 4
                                              ? selectedColor
                                              : unselectedColor,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                transform: Platform.isAndroid == true
                    ? Matrix4.translationValues(0.0, -4.0, 0.0)
                    : Matrix4.translationValues(0.0, -1.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          onItemPressed(2);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: selectedIndex == 2
                                  ? AssetImage(centerIconSelected)
                                  : AssetImage(centerIcon),
                              fit: BoxFit.contain,
                            ),
                            color: Colors.transparent,
                            // color: selectedIndex == 5
                            //     ? selectedColor
                            //     : Colors.transparent,

                            // boxShadow: [
                            //   BoxShadow(
                            //     blurRadius: 25,
                            //     offset: const Offset(0, 5),
                            //     color: selectedColor.withOpacity(0.75),
                            //   )
                            // ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            // gradient: LinearGradient(
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            //   colors: [
                            //     selectedLightColor,
                            //     selectedColor,
                            //   ],
                            // ),
                          ),
                          height: 80,
                          width: 80,
                          // child: Center(
                          //   child: Transform.rotate(
                          //     angle: math.pi / 4,
                          //     child: Image.asset(
                          //       centerIcon,
                          //       height: 60.0,
                          //       width: 60.0,
                          //       color: selectedIndex == 4
                          //           ? selectedColor
                          //           : unselectedColor,
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    Text(
                      'Map',
                      style: TextStyle(
                        fontSize: 11,
                        color: selectedIndex == 2
                            ? selectedColor
                            : unselectedColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static initSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }
}

double getRelativeHeight(double percentage) {
  return percentage * SizeConfig.screenHeight;
}

double getRelativeWidth(double percentage) {
  return percentage * SizeConfig.screenWidth;
}

double getDiamondSize() {
  var width = SizeConfig.screenWidth;
  if (width > 1000) {
    return 0.045 * SizeConfig.screenWidth;
  } else if (width > 900) {
    return 0.055 * SizeConfig.screenWidth;
  } else if (width > 700) {
    return 0.065 * SizeConfig.screenWidth;
  } else if (width > 500) {
    return 0.075 * SizeConfig.screenWidth;
  } else {
    return 0.135 * SizeConfig.screenWidth;
  }
}
