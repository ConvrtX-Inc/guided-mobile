import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guided/models/card_model.dart';

///Card controller
class CardController extends GetxController {
  /// Cards
  RxList<CardModel> cards = RxList<CardModel>([]);

  ///Default Card
  CardModel defaultCard = CardModel();

  /// add card function
  void addCard(CardModel card) {
    cards.add(card);
    update();
  }

  /// update card
  void updateCard(CardModel data) {
    final int index = cards.indexWhere((CardModel card) => card.id == data.id);
    cards[index] = data;
    update();
  }

  /// remove card
  void remove(CardModel data) {
    final int index = cards.indexWhere((CardModel card) => card.id == data.id);
    debugPrint(data.id);
    cards.removeAt(index);
    update();
  }

  ///Set Default Card
  void setDefaultCard (CardModel card){
    debugPrint('default $card');
    defaultCard = card;
    update();
  }

  ///initialize cards
  Future<void> initCards(List<CardModel> data) async {
    cards.value = data;
  }
}
