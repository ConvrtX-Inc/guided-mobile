import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/models/certificate.dart';

///Certificate controller
class CertificateController extends GetxController {
  /// certificates
  RxList<Certificate> certificates = RxList<Certificate>([]);

  /// add Certificate function
  void addCertificate(Certificate data) {
    certificates.add(data);
    update();
  }

  /// update Certificate
  void updateCertificate(Certificate data) {
    debugPrint('Cerrtificate data ${data.id}');
    final int index =
        certificates.indexWhere((Certificate cert) => cert.id == data.id);
    certificates[index] = data;
    update();
  }

  /// remove Certificate
  void remove(Certificate data) {
    final int index =
        certificates.indexWhere((Certificate cert) => data.id == data.id);
    debugPrint(data.id);
    certificates.removeAt(index);
    update();
  }

  ///initialize certificates
  Future<void> initCertificates(List<Certificate> data) async {
    debugPrint('Data ${data.length}');
    certificates.value = data;
  }
}
