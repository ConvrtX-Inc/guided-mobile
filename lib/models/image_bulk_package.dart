// ignore_for_file: public_member_api_docs, always_specify_types, prefer_final_locals

import 'dart:io';

/// Image List Package
class ImageListPackage {
  /// Constructor
  ImageListPackage(
      {required this.id, required this.firebaseImg});

  /// id variable
  String id;


  /// firebase variable
  String firebaseImg;

  Map<String, dynamic> toJson() => {
        'activity_package_destination_id': id,
        'firebase_snapshot_img': firebaseImg
      };
}

List encodeToJson(List<ImageListPackage> list) {
  List jsonList = [];
  list.map((item) => jsonList.add(item.toJson())).toList();
  return jsonList;
}
