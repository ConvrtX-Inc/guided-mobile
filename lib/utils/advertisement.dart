import 'package:guided/helpers/constant.dart';
import 'package:guided/models/advertisement.dart';

/// Settings items data generator
class AdvertisementUtil {
  static List<AdvertisementModel> getMockFeatures() {
    return [
      AdvertisementModel(
        featureTitle: ConstantHelpers.sportGloves,
        featureImageUrl: ConstantHelpers.assetAds1,
      ),
      AdvertisementModel(
        featureTitle: ConstantHelpers.lakeCleaning,
        featureImageUrl: ConstantHelpers.assetAds2,
      ),
      AdvertisementModel(
        featureTitle: ConstantHelpers.adventureTime,
        featureImageUrl: ConstantHelpers.assetAds3,
      ),
    ];
  }
}
