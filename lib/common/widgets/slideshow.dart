import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_view.dart';

/// Slideshow Class
class SlideShow extends StatelessWidget {

  /// Constructor
  const SlideShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.r))
        ),
        child: ImageSlideshow(
          height: 200.h,
          indicatorColor: Colors.white,
          onPageChanged: (int value) {
          },
          autoPlayInterval: 3000,
          isLoop: true,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) => const OutfitterView())
                );
              },
              child: Image.asset(
                AssetsPath.vest1,
                fit: BoxFit.fitHeight,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                AssetsPath.vest2,
                fit: BoxFit.fitHeight,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                AssetsPath.vest3,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

