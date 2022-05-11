// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, always_specify_types
/// Wishlist Activity model
class WishlistActivityModel {
  /// Constructor
  WishlistActivityModel({required this.wishlistActivityDetails});

  /// outfitter details
  late List<WishlistActivityDetailsModel> wishlistActivityDetails =
      <WishlistActivityDetailsModel>[];

  /// mapping
  WishlistActivityModel.fromJson(List<dynamic> parseJson)
      : wishlistActivityDetails = parseJson
            .map((i) => WishlistActivityDetailsModel.fromJson(i))
            .toList();
}

/// Wishlist Activity details model
class WishlistActivityDetailsModel {
  /// Constructor
  WishlistActivityDetailsModel(
      {this.id = '', this.userId = '', this.activityPackageId = ''});

  /// String property initialization
  final String id, userId, activityPackageId;

  /// mapping
  WishlistActivityDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        userId = parseJson['user_id'],
        activityPackageId = parseJson['activity_package_id'] ?? '';
}
