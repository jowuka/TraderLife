import 'dart:collection';

import 'package:trader_life/models/model_graphic_card.dart';

class GraphicCardData {
  static final HashMap<String, GraphicCard> graphicCards = HashMap<String, GraphicCard>.from({
    '001': GraphicCard(id: 001, model: 'NVIDIA RTX 3080', power: 320, imageURL: "assets/images/T1_L1.png"),
    '002': GraphicCard(id: 002, model: 'NVIDIA RTX 3080', power: 320, imageURL: "assets/images/T1_L2.png")
  });

  static GraphicCard? getGraphicCard(String id) {
    return graphicCards[id];
  }

  static void printAllGraphicCards() {
    graphicCards.forEach((id, graphicCard) {
      print(graphicCard);
    });
  }
}
