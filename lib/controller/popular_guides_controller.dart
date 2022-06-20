import 'package:get/get.dart';

///Traveller Controller
class PopularGuidesController extends GetxController {
  final RxString _searchKey = ''.obs;

  ///get value
  String get searchKey => _searchKey.value;

  ///set value
  void setSearchKey(String value) {
    _searchKey.value = value;
    update();
  }
}
