import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/models/home.dart';
import 'package:guided/models/outfitter.dart';

/// Settings items data generator
class OutfitterUtil {
  static List<OutfitterModel> getMockFeatures() {
    return [
      OutfitterModel(
        featureTitle: 'Travel Vest',
        featureImageUrl1: ConstantHelpers.assetSample1,
        featureImageUrl2: ConstantHelpers.assetSample3,
        featureImageUrl3: ConstantHelpers.assetSample4,
        featurePrice: '45',
        featureDate: '21.10.2021',
        featureDescription: ConstantHelpers.loremIpsum,
      ),
      OutfitterModel(
        featureTitle: 'Hiking Shoes',
        featureImageUrl1: ConstantHelpers.assetSample2,
        featureImageUrl2: ConstantHelpers.assetSample5,
        featureImageUrl3: ConstantHelpers.assetSample6,
        featurePrice: '63',
        featureDate: '21.10.2021',
        featureDescription: ConstantHelpers.loremIpsum,
      ),
    ];
  }
}
