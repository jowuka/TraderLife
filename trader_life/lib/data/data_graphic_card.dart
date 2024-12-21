import 'dart:collection';
import 'package:trader_life/utility/shared_preferences.dart';

import 'package:trader_life/models/model_graphic_card.dart';

class GraphicCardData {
  static final HashMap<String, GraphicCard> graphicCards = HashMap<String, GraphicCard>.from({
    '0': GraphicCard(id: 0, model: 'Graphonix Lite 150', power: 2, imageURL: "assets/images/GraphicCards/Tier1/T1_L1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(0), price: 30, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(0)),
    '1': GraphicCard(id: 1, model: 'PixelForce Quantum 170', power: 4, imageURL: "assets/images/GraphicCards/Tier1/T1_L2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(1), price: 200, userAmount: SharedPreferencesUtil.getAmountGraphicCard(1)),
    '2': GraphicCard(id: 2, model: 'BitFusion Nova 180', power: 8, imageURL: "assets/images/GraphicCards/Tier1/T1_L3.png", assignedValue: SharedPreferencesUtil.getAssignedValue(2), price: 3000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(2)),
    '3': GraphicCard(id: 3, model: 'CoreShift Spark 185', power: 16, imageURL: "assets/images/GraphicCards/Tier2/Tier2_L1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(3), price: 15000, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(3)),
    '4': GraphicCard(id: 4, model: 'Virex Prime 130', power: 32, imageURL: "assets/images/GraphicCards/Tier2/Tier2_L2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(4), price: 50000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(4)),
    '5': GraphicCard(id: 5, model: 'Graphonix Volt 220', power: 64, imageURL: "assets/images/GraphicCards/Tier2/Tier2_L3.png", assignedValue: SharedPreferencesUtil.getAssignedValue(5), price: 250000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(5)),
    '6': GraphicCard(id: 6, model: 'PixelForce Prism 210', power: 128, imageURL: "assets/images/GraphicCards/Tier3/Tier3_l1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(6), price: 1300000, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(6)),
    '7': GraphicCard(id: 7, model: 'BitFusion Flux 240', power: 256, imageURL: "assets/images/GraphicCards/Tier3/Tier3_l2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(7), price: 9000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(7)),
    '8': GraphicCard(id: 8, model: 'CoreShift Ignite 225', power: 512, imageURL: "assets/images/GraphicCards/Tier3/Tier3_l3.png", assignedValue: SharedPreferencesUtil.getAssignedValue(8), price: 120000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(8)),
    '9': GraphicCard(id: 9, model: 'Graphonix Quantum 360', power: 1024, imageURL: "assets/images/GraphicCards/Tier3/Tier3_l4.png", assignedValue: SharedPreferencesUtil.getAssignedValue(9), price: 2000000000, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(9)),
    '10': GraphicCard(id: 10, model: 'PixelForce Blaze 350', power: 2048, imageURL: "assets/images/GraphicCards/Tier4/Tier4_l1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(10), price: 90000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(10)),
    '11': GraphicCard(id: 11, model: 'BitFusion Nova-X 380', power: 4096, imageURL: "assets/images/GraphicCards/Tier4/Tier4_l2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(11), price: 100000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(11)),
    '12': GraphicCard(id: 12, model: 'CoreShift Cyclone 365', power: 8192, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(12), price: 300000000000, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(12)),
    '13': GraphicCard(id: 13, model: 'Virex Cyclone 370', power: 16384, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(13), price: 6000000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(13)),
    '14': GraphicCard(id: 14, model: 'Graphonix Zenith 400', power: 32768, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l3.png", assignedValue: SharedPreferencesUtil.getAssignedValue(14), price: 60000000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(14)),
    '15': GraphicCard(id: 15, model: 'PixelForce Infinity 470', power: 65536, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l4.png", assignedValue: SharedPreferencesUtil.getAssignedValue(15), price: 600000000000000, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(15)),
    '16': GraphicCard(id: 16, model: 'BitFusion Blaze-X 480', power: 131072, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l5.png", assignedValue: SharedPreferencesUtil.getAssignedValue(16), price: 6000000000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(16)),
    '17': GraphicCard(id: 17, model: 'CoreShift Omega 465', power: 262144, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l6.png", assignedValue: SharedPreferencesUtil.getAssignedValue(17), price: 60000000000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(17)),
    '18': GraphicCard(id: 18, model: 'Virex Apex-X 490', power: 524288, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l7.png", assignedValue: SharedPreferencesUtil.getAssignedValue(18), price: 600000000000000000, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(18)),
    '19': GraphicCard(id: 19, model: 'Virex Hypernova-X 530', power: 1048576, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l8.png", assignedValue: SharedPreferencesUtil.getAssignedValue(19), price: 6000000000000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(19)),
    '20': GraphicCard(id: 20, model: 'Graphonix Eclipse-X 550', power: 2097152, imageURL: "assets/images/GraphicCards/Tier5/Tier5_l9.png", assignedValue: SharedPreferencesUtil.getAssignedValue(20), price: 6000000000000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(20)),
    '21': GraphicCard(id: 21, model: 'CoreShift Vortex-Z 570', power: 4194304, imageURL: "assets/images/GraphicCards/Tier6/Tier6_l1.png", assignedValue: SharedPreferencesUtil.getAssignedValue(21), price: 600000000000000, userAmount:  SharedPreferencesUtil.getAmountGraphicCard(21)),
    '22': GraphicCard(id: 22, model: 'BitFusion Nebula 580', power: 8388608, imageURL: "assets/images/GraphicCards/Tier6/Tier6_l2.png", assignedValue: SharedPreferencesUtil.getAssignedValue(22), price: 600000000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(22)),
    '23': GraphicCard(id: 23, model: 'PixelForce Infinity-X 590', power: 16777216, imageURL: "assets/images/GraphicCards/Tier6/Tier6_l3.png", assignedValue: SharedPreferencesUtil.getAssignedValue(23), price: 600000000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(23)),
    '24': GraphicCard(id: 24, model: 'Graphonix Alien-X 600', power: 33554432, imageURL: "assets/images/GraphicCards/Tier6/Tier6_l4.png", assignedValue: SharedPreferencesUtil.getAssignedValue(24), price: 600000000000000, userAmount: SharedPreferencesUtil.getAmountGraphicCard(24)),

  });

}
