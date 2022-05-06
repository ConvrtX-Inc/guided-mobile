// ignore_for_file: sort_constructors_first

/// Package Model
class NewsFeedModel {
  /// Constructor
  NewsFeedModel({required this.newsfeedDetails});

  /// advertisement details
  late List<NewsFeedDetailsModel> newsfeedDetails = <NewsFeedDetailsModel>[];

  /// mapping

  NewsFeedModel.fromJson(List<dynamic> parseJson)
      : newsfeedDetails =
            parseJson.map((i) => NewsFeedDetailsModel.fromJson(i)).toList();
}

/// Package Details model
class NewsFeedDetailsModel {
  /// Contructor
  NewsFeedDetailsModel({
    this.id = '',
    this.userId = '',
    this.mainBadgeId = '',
    this.subBadgeId = '',
    this.title = '',
    this.newsDate,
    this.description = '',
    this.isPremium = false,
    this.isPublished = false,
    this.isPost = false,
    this.firebaseImg = '',
  });

  /// String property initialization
  final String id,
      userId,
      mainBadgeId,
      subBadgeId,
      title,
      description,
      firebaseImg;

  /// boolean initialization
  final bool isPublished, isPremium, isPost;

  final DateTime? newsDate;

  /// mapping
  NewsFeedDetailsModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'] ?? '',
        userId = parseJson['user_id'] ?? '',
        mainBadgeId = parseJson['main_badge_id'] ?? '',
        subBadgeId = parseJson['sub_badge_ids'] ?? '',
        title = parseJson['title'] ?? '',
        newsDate = DateTime.parse(parseJson['news_date']),
        description = parseJson['description'] ?? '',
        isPremium = parseJson['premium_user'] ?? false,
        isPublished = parseJson['is_published'] ?? false,
        isPost = parseJson['is_post'] ?? false,
        firebaseImg = parseJson['firebase_snapshot_img'] ?? '';
}
