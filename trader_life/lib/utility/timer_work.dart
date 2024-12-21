import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:trader_life/models/user_model.dart';

class TimerWork with ChangeNotifier {
  final Map<String, Timer> _activeTimers = {};
  final Map<String, int> _remainingTimes = {};

  void startTimer(String workId, int duration, double reward, UserModel userModel) {
    // Tüm timer'ları durdur
    stopAllTimers();

    _remainingTimes[workId] = duration;

    _activeTimers[workId] = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTimes[workId]! > 0) {
        _remainingTimes[workId] = _remainingTimes[workId]! - 1;
        notifyListeners();
      } else {
        timer.cancel();
        _activeTimers.remove(workId);
        _remainingTimes.remove(workId);
        print(reward);

        _onTimerFinished(workId, userModel, reward);
        notifyListeners();
      }
    });
  }

  void stopAllTimers() {
    _activeTimers.forEach((key, value) => value.cancel());
    _activeTimers.clear();
    _remainingTimes.clear();
    notifyListeners();
  }

  int getRemainingTime(String workId) {
    return _remainingTimes[workId] ?? 0;
  }

  bool isTimerActive(String workId) {
    return _activeTimers.containsKey(workId);
  }

  void _onTimerFinished(String workId, UserModel userModel, double reward) {
    userModel.addCash(reward);
    print("Timer for work $workId has finished.");
  }

  @override
  void dispose() {
    for (var timer in _activeTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }
}