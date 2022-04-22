import 'package:get/get.dart';
import 'package:guided/models/activities_model.dart';

///Traveller Controller
class NearbyActivitiesController extends GetxController {
  Rx<Activity> _activity = Activity().obs;

  ///get selected value
  Rx<Activity> get activity => _activity;

  ///set value
  void setActivity(Activity value) {
    _activity = value.obs;
    update(['nearbyrResult']);
  }
}
