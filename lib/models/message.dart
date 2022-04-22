/// Class for settings items
class Message {
  /// Constructor
  Message({
    required this.id,
    required this.name,
    required this.message,
    required this.imgUrl,
  });

  /// property for name
  late int id;

  /// property for name
  late String name;

  /// property for icon
  late String message;

  /// property for image url
  late String imgUrl;

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    message = json['message'] ?? '';
    imgUrl = json['imgUrl'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['message'] = message;
    data['imgUrl'] = imgUrl;

    return data;
  }
}
