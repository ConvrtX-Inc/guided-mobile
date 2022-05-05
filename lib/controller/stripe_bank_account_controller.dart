import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/models/bank_account_model.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/stripe_bank_account_model.dart';

///Stripe Bank Account controller
class StripeBankAccountController extends GetxController {
  /// Cards
  RxList<StripeBankAccountModel> bankAccounts = RxList<StripeBankAccountModel>([]);

  /// add bank account function
  void addBankAccount(StripeBankAccountModel data) {
    bankAccounts.add(data);
    update();
  }

  /// update bank account
  void updateBankAccount(StripeBankAccountModel data) {
    final int index = bankAccounts
        .indexWhere((StripeBankAccountModel account) => account.id == data.id);
    bankAccounts[index] = data;
    update();
  }

  /// remove bank account
  void remove(StripeBankAccountModel data) {
    final int index = bankAccounts
        .indexWhere((StripeBankAccountModel account) => account.id == data.id);
    debugPrint(data.id);
    bankAccounts.removeAt(index);
    update();
  }

  ///initialize bank Accounts
  Future<void> initBankAccounts(List<StripeBankAccountModel> data) async {
    debugPrint('Bank account count ${data.length}');
    bankAccounts.value = data;
  }
}
