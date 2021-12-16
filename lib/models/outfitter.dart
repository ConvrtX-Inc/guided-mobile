import 'dart:ui';


/// Class for home features
class OutfitterModel {
  /// Constructor
  OutfitterModel({
    /// Features models
    this.featureTitle = '',
    this.featureImageUrl1 = '',
    this.featureImageUrl2 = '',
    this.featureImageUrl3 = '',
    this.featurePrice = '',
    this.featureDate = '',
    this.featureDescription = '',
  });

  /// feature name
  final String featureTitle;

  /// feature image 1 name
  final String featureImageUrl1;

  /// feature image 2 name
  final String featureImageUrl2;

  /// feature image 3 name
  final String featureImageUrl3;

  /// feature price
  final String featurePrice;

  /// feature number of tourists
  final String featureDate;

  /// feature description
  final String featureDescription;
}
