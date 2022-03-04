/// Model for Wishlist
class Wishlist {
  /// Constructor
  Wishlist({
    this.id = '',
    this.title = '',
    this.reviewScore = '',
    this.price = '',
    this.packageCategory = '',
    this.featureImage1 = '',
    this.featureImage2 = '',
    this.featureImage3 = '',
  });

  /// String initialziation
  final String id,
      title,
      reviewScore,
      price,
      packageCategory,
      featureImage1,
      featureImage2,
      featureImage3;
}
