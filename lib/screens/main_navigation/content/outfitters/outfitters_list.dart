import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/models/outfitter.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_add.dart';
import 'package:guided/screens/main_navigation/content/outfitters/widget/outfitter_features.dart';
import 'package:guided/utils/outfitter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Outfitter List Screen
class OutfitterList extends StatefulWidget {
  /// Constructor
  const OutfitterList({Key? key}) : super(key: key);

  @override
  _OutfitterListState createState() => _OutfitterListState();
}

class _OutfitterListState extends State<OutfitterList> {
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
                  return OutfitterFeature(
                      title: features[index].featureTitle,
                      imageUrl1: features[index].featureImageUrl1,
                      imageUrl2: features[index].featureImageUrl2,
                      imageUrl3: features[index].featureImageUrl3,
                      price: features[index].featurePrice,
                      date: features[index].featureDate,
                      description: features[index].featureDescription);
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
  List<OutfitterModel> features = OutfitterUtil.getMockFeatures();

  void _settingModalBottomSheet() {
    showAvatarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => const OutfitterAdd(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<OutfitterModel>('features', features));
  }
}
