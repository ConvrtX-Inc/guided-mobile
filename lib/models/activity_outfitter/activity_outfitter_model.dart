// To parse this JSON data, do
//
//     final activityOutfitterModel = activityOutfitterModelFromJson(jsonString);

import 'dart:convert';

/// Json Decode
ActivityOutfitterModel activityOutfitterModelFromJson(String str) => ActivityOutfitterModel.fromJson(json.decode(str));

/// Json Encode
String activityOutfitterModelToJson(ActivityOutfitterModel data) => json.encode(data.toJson());

/// Activity Outfitter
class ActivityOutfitterModel {
  /// Model
    ActivityOutfitterModel({
        required this.data,
        required this.count,
        required this.total,
        required this.page,
        required this.pageCount,
    });

    /// Data
    List<OutfitterDetail> data;
    /// Count
    int count;
    /// Total
    int total;
    /// Page
    int page;
    /// Page count
    int pageCount;

    /// Activity Outfitter
    // ignore: sort_constructors_first, always_specify_types
    factory ActivityOutfitterModel.fromJson(json) {
      return ActivityOutfitterModel(
        // ignore: avoid_dynamic_calls, always_specify_types
        data: List<OutfitterDetail>.from(json['data'].map((x) => OutfitterDetail.fromJson(x))),
        // ignore: avoid_dynamic_calls
        count: json['count'],
        // ignore: avoid_dynamic_calls
        total: json['total'],
        // ignore: avoid_dynamic_calls
        page: json['page'],
        // ignore: avoid_dynamic_calls
        pageCount: json['pageCount'],
    );
    }

    /// Mapping
    Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((OutfitterDetail x) => x.toJson())),
        'count': count,
        'total': total,
        'page': page,
        'pageCount': pageCount,
    };
}

/// Activity Outfitter details
class OutfitterDetail {
  /// Model
    OutfitterDetail({
        required this.userId,
        required this.title,
        required this.price,
        required this.productLink,
        required this.country,
        required this.address,
        required this.availabilityDate,
        required this.description,
        required this.isPublished,
    });

    /// User Id
    String userId;
    /// Title
    String title;
    /// Price
    int price;
    /// Product Link
    String productLink;
    /// Country
    String country;
    /// Address
    String address;
    /// Availability Date
    DateTime availabilityDate;
    /// Description
    String description;
    /// Published
    bool isPublished;

    /// Activity Outfitter
    // ignore: sort_constructors_first
    factory OutfitterDetail.fromJson(Map<String, dynamic> json) => OutfitterDetail(
        userId: json['user_id'],
        title: json['title'],
        price: json['price'],
        productLink: json['product_link'],
        country: json['country'],
        address: json['address'],
        availabilityDate: DateTime.parse(json['availability_date']),
        description: json['description'],
        isPublished: json['is_published'],
    );

    /// Mapping
    // ignore: always_specify_types
    Map<String, dynamic> toJson() => {
        'user_id': userId,
        'title': title,
        'price': price,
        'product_link': productLink,
        'country': country,
        'address': address,
        'availability_date': "${availabilityDate.year.toString().padLeft(4, '0')}-${availabilityDate.month.toString().padLeft(2, '0')}-${availabilityDate.day.toString().padLeft(2, '0')}",
        'description': description,
        'is_published': isPublished,
    };
}
