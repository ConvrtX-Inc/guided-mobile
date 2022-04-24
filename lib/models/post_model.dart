import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Transaction Model
class PostModelData{
  /// Constructor
  PostModelData({required this.posts});
  /// Transactions
  late List<Post> posts = <Post>[];
  /// Mapping
  PostModelData.fromJSON(List<dynamic> parseJson) : posts = parseJson.map((i)=>Post.fromJson(i)).toList();
}

class Post {

  static const String COMPLETED = "6e9ee3f9-e5c5-4820-a93f-76622c41b94e";
  static const String PENDING   = "e860cd28-cf9a-4525-aed6-fa9ad930e957";
  static const String REJECTED  = "a36819dc-d54c-4cc2-b4dc-8bbc776c240d";

  final String id,userId,postId,title;
  final int categoryType,views;
  final bool isPublished;
  final DateTime? createdDate, updatedDate;



  ///Constructor
  Post({
    this.id = '',
    this.userId = '',
    this.postId = '',
    this.title = '',
    this.categoryType = 0,
    this.views = 0,
    this.isPublished = false,
    this.createdDate = null,
    this.updatedDate = null
  });

  Post.fromJson(Map<String,dynamic> parseJson)
        :id = parseJson['id'],
        userId = parseJson['user_id'],
        postId = parseJson['user_id'],
        title = parseJson['user_id'],
        categoryType = parseJson['category_ype'],
        views = parseJson['views'],
        isPublished = parseJson['is_published'],
        createdDate = parseJson['created_date'],
    updatedDate = parseJson['updated_date'];


  static Color indicatorColor(status)
  {
    switch(status)
    {
      case 0:
        return Colors.black;
      case 1:
        return AppColors.completedText;
      case 2:
        return AppColors.pendingText;
      case 3:
        return AppColors.rejectedText;
    }
    return Colors.black;
  }


}
