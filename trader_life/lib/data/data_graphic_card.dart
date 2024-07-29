import 'dart:collection';
import 'package:trader_life/utility/shared_preferences.dart';

import 'package:trader_life/models/model_graphic_card.dart';

class GraphicCardData {
  static final HashMap<String, GraphicCard> graphicCards = HashMap<String, GraphicCard>.from({
    '001': GraphicCard(id: 001, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/T1_L1.png", assignedValue: SharedPreferencesUtil.getAssignedValueOfGraphicCard().toString(), price: 500),
    '002': GraphicCard(id: 002, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/T1_L2.png", assignedValue: SharedPreferencesUtil.getAssignedValueOfGraphicCard().toString(), price: 1000),
    '003': GraphicCard(id: 003, model: 'Mdivia 950M', power: 320, imageURL: "assets/images/T1_L3.png", assignedValue: SharedPreferencesUtil.getAssignedValueOfGraphicCard().toString(), price: 1500),
    '004': GraphicCard(id: 004, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/T1_L1.png", assignedValue: SharedPreferencesUtil.getAssignedValueOfGraphicCard().toString(), price: 500),

  });

}
