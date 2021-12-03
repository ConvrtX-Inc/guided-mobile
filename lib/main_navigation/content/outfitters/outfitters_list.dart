import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/slideshow.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/main_navigation/content/outfitters/widget/outfitter_features.dart';
import 'package:guided/models/outfitter.dart';
import 'package:guided/utils/outfitter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:guided/main_navigation/content/outfitters/outfitters_add.dart';

class OutfitterList extends StatefulWidget {
  const OutfitterList({Key? key}) : super(key: key);

  @override
  _OutfitterListState createState() => _OutfitterListState();
}

class _OutfitterListState extends State<OutfitterList> {

  final TextStyle txtStyle = TextStyle(
    color: Colors.black,
    fontFamily: ConstantHelpers.fontGilroy,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  final TextStyle dateStyle = TextStyle(
      color: ConstantHelpers.osloGrey,
      fontFamily: ConstantHelpers.fontGilroy,
      fontWeight: FontWeight.w200,
      fontSize: 12
  );

  final TextStyle descrStyle = TextStyle(
      color: Colors.black,
      fontFamily: ConstantHelpers.fontGilroy,
      fontSize: 14,
      height: 2
  );

  /// Get features items mocked data
  List<OutfitterModel> features = OutfitterUtil.getMockFeatures();

  void _settingModalBottomSheet() {
    showAvatarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => OutfitterAdd(),
    );
  }

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
            backgroundColor: ConstantHelpers.green,
            onPressed: _settingModalBottomSheet,
            child: const Icon(Icons.add),
          ),
        ),
      designSize: const Size(375, 812),
    );
  }
}
