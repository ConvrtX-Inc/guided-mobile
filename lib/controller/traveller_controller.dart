import 'package:get/get.dart';

///Traveller Controller
class TravellerMonthController extends GetxController {
  final RxInt _selectedDate = 0.obs;
  final RxString _currentDate = DateTime.now().toString().obs;
  final RxList<DateTime> _selectedDates = <DateTime>[].obs;

  ///get value
  int get selectedDate => _selectedDate.value;

  ///get value
  List<DateTime> get selectedDates => _selectedDates.value;

  ///get value
  String get currentDate => _currentDate.value;

  ///set value
  void setSelectedDate(int value) {
    _selectedDate.value = value;
    update(['dateList']);
  }

  ///set value
  void setSelectedDates(List<DateTime> value) {
    _selectedDates.addAll(value);
    print(selectedDates);
    update(['selectedDates']);
  }

  ///set value
  void setCurrentMonth(String value) {
    _currentDate.value = value;
    update(['calendar']);
  }
}
