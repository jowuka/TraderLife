import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TimerService {
  TimerService._privateConstructor();

  static final TimerService _instance = TimerService._privateConstructor();

  factory TimerService() {
    return _instance;
  }

  Timer? _timer;
  final StreamController<void> _controller = StreamController<void>.broadcast();

  Stream<void> get onEvent => _controller.stream;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _performCalculations();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Future<void> _performCalculations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> graphicCards = prefs.getStringList('graphicCards') ?? [];

    for (String graphicCard in graphicCards) {
      int count = prefs.getInt('count_$graphicCard') ?? 0;
      if (count > 0) {
        // Perform calculations for this graphic card
        double calculatedValue = count * 1.5; // Example calculation
        print('Calculated Value for $graphicCard: $calculatedValue');
        // TODO: Add your calculation logic here
      }
    }
  }

  void notifyEvent() {
    _controller.add(null);
  }
}