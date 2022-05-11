///Certificate Model
class Certificate {
  ///Constructor
  Certificate(
      {this.id,
      this.userId,
      this.certificateName,
      this.certificateDescription,
      this.certificatePhotoFirebaseUrl});
/// Initialization
  String? id,
      userId,
      certificateName,
      certificateDescription,
      certificatePhotoFirebaseUrl;

  ///Mapping
  Certificate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    certificateName = json['certificate_name'];
    certificateDescription = json['certificate_description'];
    certificatePhotoFirebaseUrl = json['certificate_photo_firebase_url'];
  }

  ///Encode  to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['certificate_name'] = certificateName;
    data['certificate_description'] = certificateDescription;
    data['certificate_photo_firebase_url'] = certificatePhotoFirebaseUrl;
    return data;
  }
}
