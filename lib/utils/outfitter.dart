import 'package:flutter/material.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/home.dart';
import 'package:guided/models/outfitter.dart';

/// Settings items data generator
class OutfitterUtil {
  static List<OutfitterModel> getMockFeatures() {
    return [
      OutfitterModel(
        featureTitle: 'Travel Vest',
        featureImageUrl1: AssetsPath.vest1,
        featureImageUrl2: AssetsPath.vest2,
        featureImageUrl3: AssetsPath.vest3,
        featurePrice: '45',
        featureDate: '21.10.2021',
        featureDescription: AppTextConstants.loremIpsum,
      ),
      OutfitterModel(
        featureTitle: 'Hiking Shoes',
        featureImageUrl1: AssetsPath.hikingShoes1,
        featureImageUrl2: AssetsPath.hikingShoes2,
        featureImageUrl3: AssetsPath.hikingShoes3,
        featurePrice: '63',
        featureDate: '21.10.2021',
        featureDescription: AppTextConstants.loremIpsum,
      ),
    ];
  }
}
