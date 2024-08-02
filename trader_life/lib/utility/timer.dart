import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader_life/models/user_model.dart';

class TimerService {
  TimerService._privateConstructor();

  static final TimerService _instance = TimerService._privateConstructor();
  UserModel? user;
  factory TimerService() {
    return _instance;
  }

  Timer? _timer;
  final StreamController<void> _controller = StreamController<void>.broadcast();

  Stream<void> get onEvent => _controller.stream;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      print('Timer tick: ${DateTime.now()}'); // Debugging timer tick
      _performCalculations();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Future<void> _performCalculations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> graphicCards = prefs.getStringList('graphicCards') ?? [];
    print('Retrieved graphic cards: $graphicCards'); // Debugging retrieved data

    for (String graphicCard in graphicCards) {
      int count = prefs.getInt('count_$graphicCard') ?? 0;
      print('Count for $graphicCard: $count'); // Debugging count retrieval
      if (count > 0) {
        // Perform calculations for this graphic card
        double calculatedValue = count * 1.5; // Example calculation
        print('Calculated Value for $graphicCard: $calculatedValue');
        user!.userExperience++;
      }
    }
  }

  void notifyEvent() {
    _controller.add(null);
  }
}
