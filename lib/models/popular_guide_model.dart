/// Class for home features
class PopularGuideModel {
  /// Constructor
  PopularGuideModel({
    /// Features models
    this.id = '',
    this.name = '',
    this.mainBadgeId = '',
    this.location = '',
    this.coverImg = '',
    this.starRating = '',
    this.profileImg = '',
    this.isFirstAid = false,
  });

  /// initialization for String
  String id, name, mainBadgeId, location, coverImg, starRating, profileImg;

  /// initialization for bool
  bool isFirstAid;
}
