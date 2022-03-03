import 'package:get/get.dart';

///Traveller Controller
class TravellerMonthController extends GetxController {
  final RxInt _selectedDate = 0.obs;
  final RxString _currentDate = DateTime.now().toString().obs;

  ///get value
  int get selectedDate => _selectedDate.value;

  ///get value
  String get currentDate => _currentDate.value;

  ///set value
  void setSelectedDate(int value) {
    _selectedDate.value = value;
    update(['dateList']);
  }

  ///set value
  void setCurrentMonth(String value) {
    _currentDate.value = value;
    update(['calendar']);
  }
}
