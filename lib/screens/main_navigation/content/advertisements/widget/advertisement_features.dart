import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_view.dart';

/// Widget for Advertisement feature
class AdvertisementFeature extends StatelessWidget {
  /// Constructor
  const AdvertisementFeature({
    String title = '',
    String imageUrl = '',
    Key? key,
  })  : _title = title,
        _imageUrl = imageUrl,
        super(key: key);

  final String _title;
  final String _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/advertisement_view');
              },
              child: Image.asset(
                _imageUrl,
                fit: BoxFit.fitWidth,
                height: 200.h,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    _title,
                    style: AppTextStyle.blackStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
