import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/advertisement.dart';

/// Settings items data generator
class AdvertisementUtil {
  /// List <>
  static List<AdvertisementModel> getMockFeatures() {
    return [
      AdvertisementModel(
        featureTitle: AppTextConstants.sportGloves,
        featureImageUrl: AssetsPath.ads1,
      ),
      AdvertisementModel(
        featureTitle: AppTextConstants.lakeCleaning,
        featureImageUrl: AssetsPath.ads2,
      ),
      AdvertisementModel(
        featureTitle: AppTextConstants.adventureTime,
        featureImageUrl: AssetsPath.ads3,
      ),
    ];
  }
}
