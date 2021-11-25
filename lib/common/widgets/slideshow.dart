import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/main_navigation/content/outfitters/outfitters_view.dart';

class SlideShow extends StatelessWidget {
  const SlideShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: ImageSlideshow(
          width: double.infinity,
          height: 200,
          initialPage: 0,
          indicatorColor: Colors.white,
          indicatorBackgroundColor: Colors.grey,
          onPageChanged: (value) {
            debugPrint('Page changed: $value');
          },
          autoPlayInterval: 3000,
          isLoop: true,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OutfitterView())
                );
              },
              child: Image.asset(
                ConstantHelpers.assetSample1,
                fit: BoxFit.fitHeight,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                ConstantHelpers.assetSample3,
                fit: BoxFit.fitHeight,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                ConstantHelpers.assetSample4,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

