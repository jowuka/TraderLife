import 'dart:collection';
import 'package:trader_life/utility/shared_preferences.dart';

import 'package:trader_life/models/model_graphic_card.dart';

class GraphicCardData {
  static final HashMap<String, GraphicCard> graphicCards = HashMap<String, GraphicCard>.from({
    '0': GraphicCard(id: 0, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/T1_L1.png", assignedValue: SharedPreferencesUtil.getGraphicCardData(0)!.split(";").first, price: 500, userAmount:  int.parse(SharedPreferencesUtil.getGraphicCardData(0)!.split(";").last)),
    '1': GraphicCard(id: 1, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/T1_L2.png", assignedValue: SharedPreferencesUtil.getGraphicCardData(1)!.split(";").first, price: 1000, userAmount: int.parse(SharedPreferencesUtil.getGraphicCardData(1)!.split(";").last)),
    '2': GraphicCard(id: 2, model: 'Mdivia 950M', power: 320, imageURL: "assets/images/T1_L3.png", assignedValue: SharedPreferencesUtil.getGraphicCardData(2)!.split(";").first, price: 1500, userAmount: int.parse(SharedPreferencesUtil.getGraphicCardData(2)!.split(";").last))

  });

}
