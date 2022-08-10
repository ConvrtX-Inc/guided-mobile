import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/stripe_card.dart';

///Stripe Card controller
class StripeCardController extends GetxController {
  /// Cards
  RxList<StripeCardModel> cards = RxList<StripeCardModel>([]);

  ///Default Card
  StripeCardModel defaultCard = StripeCardModel();

  /// add card function
  void addCard(StripeCardModel card) {
    cards.add(card);
    update();
  }

  /// update card
  void updateCard(StripeCardModel data) {
    final int index = cards.indexWhere((StripeCardModel card) => card.id == data.id);
    cards[index] = data;
    update();
  }

  /// remove card
  void remove(StripeCardModel data) {

    cards.remove(data);
    update();
  }

  ///Set Default Card
  void setDefaultCard (StripeCardModel card){
    debugPrint('default $card');
    defaultCard = card;
    update();
  }

  ///initialize cards
  Future<void> initCards(List<StripeCardModel> data) async {
    cards.value = data;
  }
}
