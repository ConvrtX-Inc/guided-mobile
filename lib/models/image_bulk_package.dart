// ignore_for_file: public_member_api_docs, always_specify_types, prefer_final_locals

/// Image List Package
class ImageListPackage {
  /// Constructor
  ImageListPackage({required this.id, required this.img});

  /// id variable
  String id;

  /// image variable
  String img;

  Map<String, dynamic> toJson() =>
      {'activity_package_destination_id': id, 'snapshot_img': img};
}

List encodeToJson(List<ImageListPackage> list) {
  List jsonList = [];
  list.map((item) => jsonList.add(item.toJson())).toList();
  return jsonList;
}

