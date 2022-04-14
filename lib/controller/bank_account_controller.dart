import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/models/bank_account_model.dart';
import 'package:guided/models/card_model.dart';

///Bank Account controller
class BankAccountController extends GetxController {
  /// Cards
  RxList<BankAccountModel> bankAccounts = RxList<BankAccountModel>([]);

  /// add bank account function
  void addBankAccount(BankAccountModel data) {
    bankAccounts.add(data);
    update();
  }

  /// update bank account
  void updateBankAccount(BankAccountModel data) {
    final int index = bankAccounts
        .indexWhere((BankAccountModel account) => account.id == data.id);
    bankAccounts[index] = data;
    update();
  }

  /// remove bank account
  void remove(BankAccountModel data) {
    final int index = bankAccounts
        .indexWhere((BankAccountModel account) => account.id == data.id);
    debugPrint(data.id);
    bankAccounts.removeAt(index);
    update();
  }

  ///initialize bank Accounts
  Future<void> initBankAccounts(List<BankAccountModel> data) async {
    bankAccounts.value = data;
  }
}
