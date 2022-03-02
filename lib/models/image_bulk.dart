/// Image List
// ignore_for_file: always_specify_types

class ImageList {
  /// Id variable
  String id;
  /// image variable
  String img;

  /// Constructor
  // ignore: sort_constructors_first
  ImageList({required this.id, required this.img});

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => {'activity_advertisement_id': id, 'snapshot_img': img};
}

// ignore: public_member_api_docs,
List encondeToJson(List<ImageList> list) {
  // ignore: prefer_final_locals
  List jsonList = [];
  list.map((item) => jsonList.add(item.toJson())).toList();
  return jsonList;
}

/// Outfitter Image list
class OutfitterImageList {
  // ignore: public_member_api_docs
  String id;
  // ignore: public_member_api_docs
  String img;

  /// Constructor
  // ignore: sort_constructors_first
  OutfitterImageList({required this.id, required this.img});

  // ignore: public_member_api_docs
  Map<String, dynamic> toJsonOutfitter() => {'activity_outfitter_id': id, 'snapshot_img': img};
}

// ignore: public_member_api_docs
List encodeToJsonOutfitter(List<OutfitterImageList> list){
  // ignore: prefer_final_locals
  List jsonListOutfitter = [];
  list.map((item) => jsonListOutfitter.add(item.toJsonOutfitter())).toList();
  return jsonListOutfitter;
}
