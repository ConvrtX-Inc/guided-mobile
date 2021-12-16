import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/models/advertisement.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_add.dart';
import 'package:guided/screens/main_navigation/content/advertisements/widget/advertisement_features.dart';
import 'package:guided/utils/advertisement.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Advertisement List Screen
class AdvertisementList extends StatefulWidget {

  /// Constructor
  const AdvertisementList({Key? key}) : super(key: key);

  @override
  _AdvertisementListState createState() => _AdvertisementListState();
}

class _AdvertisementListState extends State<AdvertisementList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: <Widget>[
              ListView.builder(
                  itemCount: features.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, int index) {
                    return AdvertisementFeature(
                        title: features[index].featureTitle,
                        imageUrl: features[index].featureImageUrl);
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.chateauGreen,
          onPressed: _settingModalBottomSheet,
          child: const Icon(Icons.add),
        ),
      );
  }

  /// Get features items mocked data
  List<AdvertisementModel> features = AdvertisementUtil.getMockFeatures();

  void _settingModalBottomSheet() {
    showAvatarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => const AdvertisementAdd(),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<AdvertisementModel>('features', features));
  }
}
