// ignore_for_file: unnecessary_null_comparison
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/models/advertisement_image_model.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Widget for Advertisement feature
class AdvertisementFeature extends StatefulWidget {
  /// Constructor
  const AdvertisementFeature({
    String id = '',
    String title = '',
    String description = '',
    String country = '',
    String address = '',
    String street = '',
    String city = '',
    String province = '',
    String zip_code = '',
    String availability_date = '',
    String date = '',
    String price = '',
    bool isPublished = false,
    Key? key,
  })  : _id = id,
        _title = title,
        _description = description,
        _country = country,
        _address = address,
        _street = street,
        _city = city,
        _province = province,
        _zip_code = zip_code,
        _availability_date = availability_date,
        _date = date,
        _price = price,
        _isPublished = isPublished,
        super(key: key);

  final String _id;
  final String _title;
  final String _description;
  final String _country;
  final String _address;
  final String _street;
  final String _city;
  final String _province;
  final String _zip_code;
  final String _availability_date;
  final String _date;
  final String _price;
  final bool _isPublished;

  @override
  State<AdvertisementFeature> createState() => _AdvertisementFeatureState();
}

class _AdvertisementFeatureState extends State<AdvertisementFeature> {
  @override
  Widget build(BuildContext context) {
    return widget._isPublished
        ? Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder<AdvertisementImageModelData>(
                  future: APIServices().getAdvertisementImageData(widget._id),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    Widget _displayWidget = Container();

                    late AdvertisementImageModelData advertisementImage;

                    if (!snapshot.hasData) {
                      return _displayWidget = Container();
                    } else if (snapshot.hasData) {
                      advertisementImage = snapshot.data;
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    for (AdvertisementImageDetailsModel imageDetails
                        in advertisementImage.advertisementImageDetails) {
                      return GestureDetector(
                        onTap: () => navigateAdvertisementDetails(
                            context, imageDetails.snapshotImg),
                        child: ListTile(
                          title: imageDetails.activityAdvertisementId != null
                              ? SizedBox(
                                  height: 200.h,
                                  child: Image.memory(
                                    base64.decode(
                                      imageDetails.snapshotImg.split(',').last,
                                    ),
                                    fit: BoxFit.cover,
                                    gaplessPlayback: true,
                                  ),
                                )
                              : Container(
                                  height: 10.h,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
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
                                  widget._title,
                                  style: AppTextStyle.blackStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return _displayWidget = Container();
                  },
                )
              ],
            ),
          )
        : Container();
  }

  /// Navigate to Advertisement View
  Future<void> navigateAdvertisementDetails(
      BuildContext context, String snapshotImg) async {
    final Map<String, dynamic> details = {
      'id': widget._id,
      'title': widget._title,
      'country': widget._country,
      'address': widget._address,
      'street': widget._street,
      'city': widget._city,
      'province': widget._province,
      'zip_code': widget._zip_code,
      'date': widget._date,
      'availability_date': widget._availability_date,
      'price': widget._price,
      'description': widget._description,
      'snapshot_img': snapshotImg
    };

    await Navigator.pushNamed(context, '/advertisement_view',
        arguments: details);
  }
}
