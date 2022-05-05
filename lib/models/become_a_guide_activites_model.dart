///Activity Model
class ActivityModel {
  ///Constructor
  ActivityModel(
      {this.name = '',
        this.id = '',
      this.imageUrl = '',
      this.isChecked = false});
  ///Initialization for ID
  late final String id;

  ///Initialization for name
  late final String name;

  ///initialization for imageUrl
  late final String imageUrl;

  ///Initialization for isChecked
  bool isChecked = false;

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['badge_name'];
    imageUrl = json['img_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['badge_name'] = name;
    data['img_icon'] = imageUrl;
    return data;
  }
}