import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/models/package_model.dart';

///Package Details controller
class PackagesController extends GetxController {
  /// Packages
  RxList<PackageDetailsModel> packages = RxList<PackageDetailsModel>([]);

  /// add card function
  void addPackage(PackageDetailsModel card) {
    packages.add(card);
    update();
  }

  /// update package
  void updatePackage(PackageDetailsModel data) {
    final int index = packages.indexWhere((PackageDetailsModel p) => p.id == data.id);
    packages[index] = data;
    update();
  }

  /// remove package
  void remove(PackageDetailsModel data) {
    final int index = packages.indexWhere((PackageDetailsModel p) => p.id == data.id);
    debugPrint(data.id);
    packages.removeAt(index);
    update();
  }

  ///initialize packages
  Future<void> initPackages(List<PackageDetailsModel> data) async {
    debugPrint('PACKAGES: ${data.length}');
    packages.value = data;
  }
}
