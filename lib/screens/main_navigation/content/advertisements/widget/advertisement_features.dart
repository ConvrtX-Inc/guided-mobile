import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_view.dart';

/// Widget for Advertisement feature
class AdvertisementFeature extends StatelessWidget {
  /// Constructor
  const AdvertisementFeature({
    String id = '',
    String title = '',
    String imageUrl = '',
    String description = '',
    String country = '',
    String address = '',
    String date = '',
    String price = '',
    Key? key,
  })  : _id = id,
        _title = title,
        _imageUrl = imageUrl,
        _description = description,
        _country = country,
        _address = address,
        _date = date,
        _price = price,
        super(key: key);

  final String _id;
  final String _title;
  final String _imageUrl;
  final String _description;
  final String _country;
  final String _address;
  final String _date;
  final String _price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateAdvertisementDetails(context),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Image.asset(
                _imageUrl,
                fit: BoxFit.fitWidth,
                height: 200.h,
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
      ),
    );
  }

  /// Navigate to Advertisement View
  Future<void> navigateAdvertisementDetails(BuildContext context) async {
    final Map<String, dynamic> details = {
      'id': _id,
      'title': _title,
      'price': _price,
      'country': _country,
      'description': _description,
      'date': _date,
      'address': _address
    };

    await Navigator.pushNamed(context, '/advertisement_view', arguments: details);
  }
}
