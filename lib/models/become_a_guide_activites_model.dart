///Activity Model
class ActivityModel {
  ///Constructor
  ActivityModel(
      {this.name = '',
      this.imageUrl = '',
      this.isChecked = false});

  ///Initialization for name
  final String name;

  ///initialization for imageUrl
  final String imageUrl;

  ///Initialization for isChecked
  bool isChecked;
}
