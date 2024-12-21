import 'dart:collection';

import 'package:trader_life/models/work_model.dart';

class WorkData {
  static final HashMap<String, Work> works = HashMap<String, Work>.from({
    '1': Work(
      id: '1',
      name: 'Fast Food Worker',
      imageURL: 'assets/images/GraphicCards/Tier1/T1_L1.png',
      reward: 50.0,
      durationInSeconds: 2, // 1 minute
    ),
    '2': Work(
      id: '2',
      name: 'Software Developer',
      imageURL: 'assets/images/GraphicCards/Tier1/T1_L1.png',
      reward: 0.01,
      durationInSeconds: 300, // 5 minutes
    ),
    '3': Work(
      id: '3',
      name: 'Freelance Designer',
      imageURL: 'assets/images/GraphicCards/Tier1/T1_L1.png',
      reward: 0.5,
      durationInSeconds: 180, // 3 minutes
    ),
    '4': Work(
      id: '4',
      name: 'Crypto Trader',
      imageURL: 'assets/images/GraphicCards/Tier1/T1_L1.png',
      reward: 10.0,
      durationInSeconds: 120, // 2 minutes
    ),
  });
}