import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/main_navigation/content/advertisements/widget/advertisement_features.dart';
import 'package:guided/models/advertisement.dart';
import 'package:guided/utils/advertisement.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:guided/main_navigation/content/advertisements/advertisements_add.dart';

class AdvertisementList extends StatefulWidget {
  const AdvertisementList({Key? key}) : super(key: key);

  @override
  _AdvertisementListState createState() => _AdvertisementListState();
}

class _AdvertisementListState extends State<AdvertisementList> {

  void _settingModalBottomSheet() {
    showAvatarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AdvertisementAdd(),
    );
  }

  /// Get features items mocked data
  List<AdvertisementModel> features = AdvertisementUtil.getMockFeatures();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () =>
        Scaffold(
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
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
            backgroundColor: ConstantHelpers.green,
            onPressed: _settingModalBottomSheet,
            child: const Icon(Icons.add),
          ),
        ),
      designSize: const Size(375, 812),
    );
  }
}
