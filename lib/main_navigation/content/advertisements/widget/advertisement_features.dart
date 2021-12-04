import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/main_navigation/content/advertisements/advertisements_view.dart';

/// Widget for home features
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdvertisementView())
                );
              },
              child: Image.asset(
                _imageUrl,
                fit: BoxFit.fitWidth,
                height: 200,
              ),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _title,
                    style: ConstantHelpers.blackStyle,
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
