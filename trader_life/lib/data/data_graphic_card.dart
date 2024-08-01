import 'dart:collection';
import 'package:trader_life/utility/shared_preferences.dart';

import 'package:trader_life/models/model_graphic_card.dart';

class GraphicCardData {
  static final HashMap<String, GraphicCard> graphicCards = HashMap<String, GraphicCard>.from({
    '0': GraphicCard(id: 0, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/GraphicCards/Tier1/T1_L1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(0), price: 500, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(0)),
    '1': GraphicCard(id: 1, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier1/T1_L2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(1), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(1)),
    '2': GraphicCard(id: 2, model: 'Mdivia 950M', power: 320, imageURL: "assets/images/GraphicCards/Tier1/T1_L3.png", assignedValue: SharedPreferencesUtil.getAssignedValue(2), price: 1500, userAmount: SharedPreferencesUtil.getAmountGraphicCard(2)),
    '3': GraphicCard(id: 3, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/GraphicCards/Tier2/Tier2_L1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(3), price: 500, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(3)),
    '4': GraphicCard(id: 4, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier2/Tier2_L2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(4), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(4)),
    '5': GraphicCard(id: 5, model: 'Mdivia 950M', power: 320, imageURL: "assets/images/GraphicCards/Tier2/Tier2_L3.png", assignedValue: SharedPreferencesUtil.getAssignedValue(5), price: 1500, userAmount: SharedPreferencesUtil.getAmountGraphicCard(5)),
    '6': GraphicCard(id: 6, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/GraphicCards/Tier3/Tier3_l1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(6), price: 500, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(6)),
    '7': GraphicCard(id: 7, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier3/Tier3_l2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(7), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(7)),
    '8': GraphicCard(id: 8, model: 'Mdivia 950M', power: 320, imageURL: "assets/images/GraphicCards/Tier3/Tier3_l3.png", assignedValue: SharedPreferencesUtil.getAssignedValue(8), price: 1500, userAmount: SharedPreferencesUtil.getAmountGraphicCard(8)),
    '9': GraphicCard(id: 9, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/GraphicCards/Tier3/Tier3_l4.png", assignedValue: SharedPreferencesUtil.getAssignedValue(9), price: 500, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(9)),
    '10': GraphicCard(id: 10, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier4/Tier4_l1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(10), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(10)),
    '11': GraphicCard(id: 11, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier4/Tier4_l2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(11), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(11)),
    '12': GraphicCard(id: 12, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(12), price: 500, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(12)),
    '13': GraphicCard(id: 13, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(13), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(13)),
    '14': GraphicCard(id: 14, model: 'Mdivia 950M', power: 320, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l3.png", assignedValue: SharedPreferencesUtil.getAssignedValue(14), price: 1500, userAmount: SharedPreferencesUtil.getAmountGraphicCard(14)),
    '15': GraphicCard(id: 15, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l4.png", assignedValue: SharedPreferencesUtil.getAssignedValue(15), price: 500, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(15)),
    '16': GraphicCard(id: 16, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l5.png", assignedValue: SharedPreferencesUtil.getAssignedValue(16), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(16)),
    '17': GraphicCard(id: 17, model: 'Mdivia 950M', power: 320, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l6.png", assignedValue: SharedPreferencesUtil.getAssignedValue(17), price: 1500, userAmount: SharedPreferencesUtil.getAmountGraphicCard(17)),
    '18': GraphicCard(id: 18, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l7.png", assignedValue: SharedPreferencesUtil.getAssignedValue(18), price: 500, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(18)),
    '19': GraphicCard(id: 19, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l8.png", assignedValue: SharedPreferencesUtil.getAssignedValue(19), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(19)),
    '20': GraphicCard(id: 20, model: 'Mdivia 950M', power: 320, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l9.png", assignedValue: SharedPreferencesUtil.getAssignedValue(20), price: 1500, userAmount: SharedPreferencesUtil.getAmountGraphicCard(20)),
    '21': GraphicCard(id: 21, model: 'Mdivia 750M', power: 120, imageURL: "assets/images/GraphicCards/Tier6/Tier6_l1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(21), price: 500, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(21)),
    '22': GraphicCard(id: 22, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier6/Tier6_l2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(22), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(22)),
    '23': GraphicCard(id: 23, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier6/Tier6_l3.png", assignedValue: SharedPreferencesUtil.getAssignedValue(23), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(23)),
    '24': GraphicCard(id: 24, model: 'Mdivia 850M', power: 220, imageURL: "assets/images/GraphicCards/Tier6/Tier6_l4.png", assignedValue: SharedPreferencesUtil.getAssignedValue(24), price: 1000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(24)),

  });

}
