import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/helpers/constant.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:guided/main_navigation/content/outfitters/outfitters_view.dart';

/// Widget for home features
class OutfitterFeature extends StatelessWidget {
  /// Constructor
  const OutfitterFeature({
    String title = '',
    String imageUrl1 = '',
    String imageUrl2 = '',
    String imageUrl3 = '',
    String price = '',
    String date = '',
    String description = '',
    Key? key,
  })  : _title = title,
        _imageUrl1 = imageUrl1,
        _imageUrl2 = imageUrl2,
        _imageUrl3 = imageUrl3,
        _price = price,
        _date = date,
        _description = description,
        super(key: key);

  final String _title;
  final String _imageUrl1;
  final String _imageUrl2;
  final String _imageUrl3;
  final String _price;
  final String _date;
  final String _description;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
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
                      _imageUrl1,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OutfitterView())
                      );
                    },
                    child: Image.asset(
                      _imageUrl2,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OutfitterView())
                      );
                    },
                    child: Image.asset(
                      _imageUrl3,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _title,
                  style: ConstantHelpers.txtStyle,
                ),
                Text(
                  '\$$_price',
                  style: ConstantHelpers.txtStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 15,
                  color: ConstantHelpers.osloGrey,
                ),
                const SizedBox(width: 5,),
                Text(
                    _date,
                    style: ConstantHelpers.dateStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              _description,
              style: ConstantHelpers.descrStyle,
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ConstantHelpers.lightRed),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Colors.red)))),
                child: Text(
                  ConstantHelpers.visitShop,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
