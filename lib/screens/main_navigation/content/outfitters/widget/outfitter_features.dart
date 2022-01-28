import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/activity_outfitter/activity_outfitter_model.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_view.dart';
import 'package:http/http.dart' as http;

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
    return Column(
      children: <Widget>[
        Padding(
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
                    Navigator.of(context).pushNamed('/outfitter_view');
                  },
                  child: Image.asset(
                    _imageUrl1,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/outfitter_view');
                  },
                  child: Image.asset(
                    _imageUrl2,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/outfitter_view');
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
        SizedBox(
          height: 20.h
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _title,
                style: AppTextStyle.txtStyle,
              ),
              Text(
                '\$$_price',
                style: AppTextStyle.txtStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.calendar_today_outlined,
                size: 15,
                color: AppColors.osloGrey,
              ),
              SizedBox(
                width: 5.w
              ),
              Text(
                  _date,
                  style: AppTextStyle.dateStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            _description,
            style: AppTextStyle.descrStyle,
          ),
        ),
        SizedBox(
            height: 10.h
        ),
        Row(
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.lightRed
                  ),
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          side: const BorderSide(
                              color: Colors.red
                          )
                      )
                  )
              ),
              child: Text(
                AppTextConstants.visitShop,
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
    );
  }

}
