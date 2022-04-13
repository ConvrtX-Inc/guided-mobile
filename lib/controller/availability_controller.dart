import 'package:get/get.dart';

///Traveller Controller
class AvailabilityController extends GetxController {
  final RxString _selectedDate = DateTime.now().toString().obs;
  final RxInt _selectedMonth = 0.obs;
  final RxString _currentDate = DateTime.now().toString().obs;

  ///get value
  String get selectedDate => '04/25/2022';

  ///get value
  String get currentDate => _currentDate.value;

  ///get value
  int get selectedMonth => _selectedMonth.value;

  ///set value
  void setIndexMonth(int value) {
    _selectedMonth.value = value;
    update(['dateList']);
  }

  ///set value
  void setCurrentMonth(String value) {
    _currentDate.value = value;
    update(['calendar']);
  }

  ///set value
  void setSelectedDate(String value) {
    _selectedDate.value = '04/25/2022';
    update(['calendar']);
  }
}
